function onKill(cid, target, lastHit)
local t = {
	["Demon"] = {s = 3000},
	["Juggernaut"] = {s = 3001},
	["Giant Spider"] = {s = 3002}

}
local name = getCreatureName(target)
local v = t[name]
	if v then
		if getCreatureName(target) then
			setPlayerStorageValue(cid, v.s, getPlayerStorageValue(cid, v.s)+1)
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "You have killed a " .. getCreatureName(target) .. ".")
			if getPlayerStorageValue(cid, v.s) >= 100 then
				doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_RED, "You have killed the required number.")
			end
		end
	end
	return true
end