local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_ENERGYAREA)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ENERGY)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, -1, -10, -1, -20, 5, 5, 1.4, 2.1)

function onCastSpell(cid, var)
	local healthAfter
	local target = variantToNumber(var)
	local maxHealth = getCreatureHealth(target)
	local ret = doCombat(cid, combat, var)
	print("You've hit a : " .. getCreatureName(target) .. " -- "..getCreatureName(cid))
	if(ret == false) then
		return false
	end

	if (variantToNumber(var) == 0) then
		healthAfter = maxHealth
	else
		healthAfter = getCreatureHealth(target)	
	end
	local lifeSteal = getPlayerStorageValue(cid, LIFE_STEAL_PERC)
	

	-- chance to heal
	local chanceHeal = math.random(0, 100)
	local damage = math.abs((maxHealth - healthAfter))
	if(chanceHeal > (100 - getPlayerLifeStealChancePoints(cid)) and damage ~= 0 )  then
		local healing = math.ceil(damage * lifeSteal)
		doCreatureAddHealth(cid,healing)
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_DEFAULT, "Life Steal: You were healed by " .. healing .. " hitpoints.")
		doSendMagicEffect(getCreaturePosition(cid), CONST_ME_MAGIC_GREEN)
		doSendAnimatedText(getCreaturePosition(cid), ""..healing, TEXTCOLOR_LIGHTGREEN)
	end

	-- chance to manaHeal
	local chanceMana = math.random(0, 100)
	local manaLeech = getPlayerStorageValue(cid, MANA_LEECH_PERC)
	if(chanceMana > (100 - getPlayerManaLeechChancePoints(cid))) then
		local mana = math.ceil(damage * manaLeech)
		doCreatureAddMana(cid,mana)
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_DEFAULT, "Mana Leech: You were healed by " .. mana .. " manapoints.")
		doSendMagicEffect(getCreaturePosition(cid), CONST_ME_MAGIC_GREEN)
		doSendAnimatedText(getCreaturePosition(cid), ""..mana, TEXTCOLOR_LIGHTBLUE)
	end
end
