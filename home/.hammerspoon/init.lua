local prefix = {"alt"}

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



-- ↑ : フルスクリーン
hs.hotkey.bind(prefix, "Up", function() moveWindow({0,0,1,1}) end)
-- ← : ウィンドウ左寄せ
hs.hotkey.bind(prefix, "Left", function() moveWindow({0,0,0.5,1}) end)
-- → : ウィンドウ右寄せ
hs.hotkey.bind(prefix, "Right", function() moveWindow({0.5,0,0.5,1}) end)
-- ↓ : iTunes起動
hs.hotkey.bind(prefix, "Down", function() execApps("") end)
-- 1 ~ 0 : Dockから起動
-- TODO: 二回目のタッチのがうまくいかない問題(hammerspoonで頑張れる？)
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

--[[
xyzzy = hs.hotkey.bind({}, "7",
    function()
        if hs.eventtap.checkKeyboardModifiers().fn then
            hs.alert.show("FN is DOWN!!!")はしはし
        else
            xyzzy:disable()
            hs.eventtap.keyStroke({}, "7")
            xyzzy:enable()
        end
    end
)
module.modifierListener = hs.eventtap.new({hs.eventtap.event.types.flagsChanged}, function(event)
    local fnKey = 8388608
    local releasedFlag   = 256
    if event:getKeyCode() == fnKey then
        local eventData = event:getRawEventData().NSEventData
        if (eventData.modifierFlags & rightCommandFlag) == rightCommandFlag then
            module.keyListener = hs.eventtap.new({hs.eventtap.event.types.keyDown, hs.eventtap.event.types.keyUp}, rightCommandHandler):start()
        elseif module.keyListener and (eventData.modifierFlags & releasedFlag) == releasedFlag then
            module.keyListener:stop()
            module.keyListener = nil
        end
    end
  end):start()
--]]
