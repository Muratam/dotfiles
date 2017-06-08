from twitter import Api
from requests_oauthlib import OAuth1Session
import requests
from pprint import pprint
import os
import json


def fav_word(c_key, c_secret, a_key, a_secret,query):
    api = Api(c_key,c_secret,a_key,a_secret)
    founds = api.GetSearch(query, result_type="recent")
    for found in founds:
        tw_id = found.AsDict()["id_str"]
        print("favorite :" + str(tw_id))
        try:
            api.CreateFavorite(status_id=tw_id)
        except:
            pass

def tweet(c_key, c_secret, a_key, a_secret, word,media=None):
    twitter = OAuth1Session(c_key, c_secret, a_key, a_secret)
    params = {"status": word}
    if media and media.endswith(".mp4"):
        total_bytes = os.path.getsize(media)
        req_init = twitter.post(
            "https://upload.twitter.com/1.1/media/upload.json",
            params = {
                "command":"INIT",
                "media_type":"video/mp4",
                "total_bytes": total_bytes
            }
        )
        media_id = json.loads(req_init.text)["media_id_string"]
        with open(media,"rb") as f:
            media_content = f.read()
        buffer_len = 4096 * 1024 # 一度に4MBまで
        for i in range(20):
            req_append = twitter.post(
                "https://upload.twitter.com/1.1/media/upload.json",
                params = {
                    "command":"APPEND",
                    "media_id": media_id,
                    "segment_index":i
                },
                files = {"media":media_content[i*buffer_len:(i+1)*buffer_len]}
            )
            if req_append.status_code < 200 or req_append.status_code >= 300:
                print("failed upload...")
                return ""
            print("post " + str((i+1) * buffer_len) + "bytes")
            if (i+1) * buffer_len > total_bytes:
                break
        req_final = twitter.post(
            "https://upload.twitter.com/1.1/media/upload.json",
            params = {
                "command":"FINALIZE",
                "media_id": media_id,
            }
        )
        print(req_final.text)
        params["media_ids"] = [media_id]
    elif media:
        req_media = twitter.post(
            "https://upload.twitter.com/1.1/media/upload.json",
            files = {"media":open(media,"rb")}
        )
        if req_media.status_code != 200:
            print("media upload failed")
            print(req_media.text)
            return False
        media_id = json.loads(req_media.text)["media_id"]
        params["media_ids"] = [media_id]

    req = twitter.post(
        "https://api.twitter.com/1.1/statuses/update.json",
        params=params
    )
    if media and media.endswith(".mp4"):
        url = json.loads(req.text)
        print(url)
        return url["entities"]["media"][0]["expanded_url"]
    elif media :
        url = json.loads(req.text)
        print(url)
        return url["entities"]["media"][0]["media_url"]
    else:
        return ""

