-- Creat the frame
local frame = CreateFrame("Frame", BreakTime.ADDON_NAME .. "Frame", UIParent, "InsetFrameTemplate")
frame:SetSize(300, 300)
frame:SetPoint("CENTER")
frame:SetFrameStrata("DIALOG")
frame:Hide()
frame:SetMovable(true)
frame:EnableMouse(true)
frame:RegisterForDrag("LeftButton")
frame:SetScript("OnDragStart", frame.StartMoving)
frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
frame:SetResizable(true)
frame:SetResizeBounds(200, 200, 800, 800)

-- Resize grip in the bottom right
local resizeGrip = CreateFrame("Button", nil, frame)
resizeGrip:SetSize(16, 16)
resizeGrip:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -4, 4)
resizeGrip:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
resizeGrip:SetHighlightTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
resizeGrip:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down")

-- Close button (bottom right)
local closeBtn = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
closeBtn:SetSize(80, 22)
closeBtn:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 7, 6)
closeBtn:SetText("Close")
closeBtn:SetScript("OnClick", function() frame:Hide() end)

-- Add the images
local tex = frame:CreateTexture(nil, "ARTWORK")
tex:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, -30)
tex:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -12, 31)

-- Timer display text
local timerText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
timerText:SetPoint("TOP", frame, "TOP", 0, -8)
timerText:SetTextColor(1, 1, 0) -- yellow

-- Fill the portrait
--local portrait = _G[frame:GetName() .. "Portrait"] or _G[BreakTime.ADDON_NAME .. "FramePortrait"]
--if portrait then
--    portrait:SetTexture(string.format("Interface\\AddOns\\%s\\Icons\\logo.tga", BreakTime.ADDON_NAME))
--end

resizeGrip:SetScript("OnMouseDown", function(self, button)
    if button == "LeftButton" then
        frame:StartSizing("BOTTOMRIGHT")
    end
end)

resizeGrip:SetScript("OnMouseUp", function(self, button)
    frame:StopMovingOrSizing()
end)
 
local function StopCountdown()
    if BreakTime.CountdownTimer then
        BreakTime.CountdownTimer:Cancel()
        BreakTime.CountdownTimer = nil
    end
    
    timerText:SetText("")
end

local function StartCountdown(seconds)
    StopCountdown()

    local totalSeconds = seconds
    local secondsLeft = totalSeconds

    local function Tick()
        if secondsLeft <= 0 then
            timerText:SetText("Break over!")
            return
        end

        local mins = math.floor(secondsLeft / 60)
        local secs = secondsLeft % 60
        local timeStr = string.format("%d:%02d", mins, secs)

        local mins = math.floor(secondsLeft / 60)
        local secs = secondsLeft % 60
        timerText:SetText(string.format("Break ends in: %d:%02d", mins, secs))

        secondsLeft = secondsLeft - 1
    end

    Tick()
    BreakTime.CountdownTimer = C_Timer.NewTicker(1, Tick, secondsLeft + 1)
end

function BreakTime.ShowBreakImage(imageIndex, seconds)
    local path = string.format("Interface\\AddOns\\%s\\Images\\Break%d.tga", BreakTime.ADDON_NAME, imageIndex)
    tex:SetTexture(path)
    frame:Show()

    if seconds and seconds > 0 then
        StartCountdown(seconds)
    else
        StopCountdown()
    end
end