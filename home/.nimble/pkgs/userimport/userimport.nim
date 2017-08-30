import sequtils,strutils
import httpclient
import os,times


template main*(body:untyped):untyped =
  import sequtils,strutils,strscans,algorithm,math,future,sets,queues,tables
  import templates
  body

template withFile*(f:untyped,fn:string = "hoge",mode:string = "r",action: untyped): untyped =
  block:
    var f: File
    var fmMode = fmRead
    case mode
    of "w": fmMode = fmWrite
    of "rw": fmMode = fmReadWrite
    of "a": fmMode = fmAppend
    of "w+": fmMode = fmAppend
    if open(f, fn, fmMode):
      defer: close(f)
      action
    else: quit("cannot open: " & fn)