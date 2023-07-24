AddCSLuaFile("smooth_noclip/sh.lua")
AddCSLuaFile("smooth_noclip/cl.lua")

include("smooth_noclip/sh.lua")
if CLIENT then
	include("smooth_noclip/cl.lua")
end