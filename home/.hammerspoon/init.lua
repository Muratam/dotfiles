local prefix = {"ctrl","cmd"}

function moveWindow(rect_percent)
    local window = hs.window.focusedWindow()
    local frame = window:frame()
    local screen = window:screen():frame()
    frame.x = screen.x + rect_percent[1] * screen.w
    frame.y = screen.y + rect_percent[2] * screen.h
    frame.w = rect_percent[3] * screen.w
    frame.h = rect_percent[4] * screen.h
    window:setFrame(frame)
end

function execApps(command)
    os.execute("osascript ~/.hammerspoon/mv_window.js " .. tostring(command))
end

-- hキーが壊れて二回入力される(チャタリングされる)ので
-- 0.2秒程度以内に二回以上押されると無視するようにする
local hPressed = false
function blockDoublePressedHKey(e)
    -- h キーは 4 番なのでそれ以外は無視
    if e:getKeyCode() ~= 4 then return false end
    if not hPressed then
        hPressed = true
        hs.timer.doAfter(0.18,function() hPressed = false end)
        return false
    else
        -- print("blocked H Key !!")
        return true
    end
end

-- ↑ : フルスクリーン
hs.hotkey.bind(prefix, "Up", function() moveWindow({0,0,1,1}) end)
-- ← : ウィンドウ左寄せ
hs.hotkey.bind(prefix, "Left", function() moveWindow({0,0,0.5,1}) end)
-- → : ウィンドウ右寄せ
hs.hotkey.bind(prefix, "Right", function() moveWindow({0.5,0,0.5,1}) end)
-- ↓ : iTunes起動
hs.hotkey.bind(prefix, "Down", function() execApps("") end)
-- 1 ~ 0 : Dockから起動
hs.hotkey.bind(prefix, "1", function() execApps("0") end)
hs.hotkey.bind(prefix, "2", function() execApps("1") end)
hs.hotkey.bind(prefix, "3", function() execApps("2") end)
hs.hotkey.bind(prefix, "4", function() execApps("3") end)
hs.hotkey.bind(prefix, "5", function() execApps("4") end)
hs.hotkey.bind(prefix, "6", function() execApps("5") end)
hs.hotkey.bind(prefix, "7", function() execApps("6") end)
hs.hotkey.bind(prefix, "8", function() execApps("7") end)
hs.hotkey.bind(prefix, "9", function() execApps("8") end)
hs.hotkey.bind(prefix, "0", function() execApps("9") end)
-- hキーのチャタリング防止
hs.eventtap.new(
    {hs.eventtap.event.types.keyDown, hs.eventtap.event.types.keyUp},
    blockDoublePressedHKey
):start()

