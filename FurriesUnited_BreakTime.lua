BreakTime = {}
BreakTime.NUM_IMAGES = 25
BreakTime.CountdownTimer = nil
BreakTime.ADDON_MESSAGE_PREFIX = "FUBT"
BreakTime.ADDON_NAME = "FurriesUnited_BreakTime"

C_ChatInfo.RegisterAddonMessagePrefix(BreakTime.ADDON_MESSAGE_PREFIX)

function BreakTime.Broadcast(index, seconds)
    local channel = nil
    if IsInRaid() then
        channel = "RAID"
    elseif IsInGroup() then
        channel = "PARTY"
    end

    if channel then
        local player = BreakTime.GetFullPlayerName()
        local message = table.concat({
            player,
            index,
            "BT",
            seconds,
            channel,
        }, "\t")

        BreakTime.ShowBreakImage(index, seconds) -- We don't listen to our own messages, so let the sender show it immediately
        C_ChatInfo.SendAddonMessage(BreakTime.ADDON_MESSAGE_PREFIX, message, channel)
    end
end

function BreakTime.GetFullPlayerName()
    local name = GetUnitName("player", true)
    if not name:find("-") then
        local realm = GetRealmName():gsub("%s", "")
        name = name .. "-" .. realm
    end
    return name
end