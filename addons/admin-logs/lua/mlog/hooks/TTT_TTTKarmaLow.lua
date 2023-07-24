--[[
	mLogs (M4D Logs)
	Created by M4D | http://m4d.one/ | http://steamcommunity.com/id/m4dhead | legal@m4d.one
	Copyright © 2016 M4D.one All Rights Reserved
	All 3rd party content is public domain or used with permission
	M4D.one is the copyright holder of all code below. Do not distribute in any circumstances.
--]]

HOOK.Name = "Karma Kicks"
HOOK.Description = "Shows whenever someone has been kicked for low karma"
HOOK.hook_name = mLog.prefix .. HOOK.Name
HOOK.hook_tag = "TTTKarmaLow"
HOOK.enableCheck = function() return string.lower( gmod.GetGamemode( ).Name ) == "trouble in terrorist town" end

hook.Add("TTTKarmaLow", HOOK.hook_name, function(ply)
	if not IsValid(ply) then return end
	local plS = mLog.getInfoLine(ply)
	
	mLog.Log("TTTKarmaLow", plS .. " has been kicked/banned for low karma")
end)