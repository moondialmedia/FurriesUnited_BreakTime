C_ChatInfo.RegisterAddonMessagePrefix(BreakTime.ADDON_MESSAGE_PREFIX)

local breakTimeFrame = CreateFrame("Frame")
breakTimeFrame:RegisterEvent("CHAT_MSG_ADDON")
breakTimeFrame:SetScript("OnEvent", function(self, event, prefix, message, channel, sender)
    if prefix == BreakTime.ADDON_MESSAGE_PREFIX then

        local parts = { strsplit("\t", message) }

        if parts[3] == "BT" then
            local index = tonumber(parts[2]) or 0
            local seconds = tonumber(parts[4]) or 0

            -- Don't show if we already showed it from the DBM message
            if parts[1] ~= BreakTime.GetFullPlayerName() then
                BreakTime.ShowBreakImage(index, seconds)
            end
        end
    end
end)