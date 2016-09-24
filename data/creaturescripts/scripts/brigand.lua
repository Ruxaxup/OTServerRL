local teleportPosition = {x = 1020, y = 699, z =7}
local tpID = 1387


function onKill(cid, target, lastHit)

	local name = string.lower(getCreatureName(target))
	if (name == "brigand") then	
		local tpPosition	= getClosestFreeTile(cid, getCreaturePosition(cid), true, false)
		tpPosition.stackpos = 1
		teleport = doCreateTeleport(tpID, teleportPosition, tpPosition)
		doSendAnimatedText(tpPosition, "Secret...",TEXTCOLOR_YELLOW)
		addEvent(removeBrigandTeleport, 30 * 1000, tpPosition)
	end
	return true
end

function removeBrigandTeleport(tpPosition)
	if getThingfromPos(tpPosition).itemid == 1387 then
		doRemoveItem(getThingfromPos(tpPosition).uid,1)
		doSendMagicEffect(tpPosition, CONST_ME_POFF)	
		return TRUE
	end

end