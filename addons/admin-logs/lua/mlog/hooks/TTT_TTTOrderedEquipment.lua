--[[
	mLogs (M4D Logs)
	Created by M4D | http://m4d.one/ | http://steamcommunity.com/id/m4dhead | legal@m4d.one
	Copyright © 2016 M4D.one All Rights Reserved
	All 3rd party content is public domain or used with permission
	M4D.one is the copyright holder of all code below. Do not distribute in any circumstances.
--]]

HOOK.Name = "Equipment Purchases"
HOOK.Description = "Shows when someone has bought equipment"
HOOK.hook_name = mLog.prefix .. HOOK.Name
HOOK.hook_tag = "TTTOrderedEquipment"
HOOK.enableCheck = function() return string.lower( gmod.GetGamemode( ).Name ) == "trouble in terrorist town" end

hook.Add("TTTOrderedEquipment", HOOK.hook_name, function(ply, equipment)
	if not IsValid(ply) then return end
	local plS = mLog.getInfoLine(ply)
	
	mLog.Log("TTTOrderedEquipment", plS .. " has bought a " .. equipment)
end)