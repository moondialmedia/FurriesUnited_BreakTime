C_ChatInfo.RegisterAddonMessagePrefix("D5")
C_ChatInfo.RegisterAddonMessagePrefix("DBM")
C_ChatInfo.RegisterAddonMessagePrefix("DBM-Core")

local dbmFrame = CreateFrame("Frame")
dbmFrame:RegisterEvent("CHAT_MSG_ADDON")
dbmFrame:SetScript("OnEvent", function(self, event, prefix, message, channel, sender)
    if prefix == "D5" then
        local parts = { strsplit("\t", message) }
        if parts[3] == "BT" then
            if parts[1] == BreakTime.GetFullPlayerName() then
                local seconds = tonumber(parts[4]) or 0
                local index = math.random(1, BreakTime.NUM_IMAGES)
                BreakTime.Broadcast(index, seconds)
            end
        end
    end
end)