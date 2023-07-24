esc 	= esc 		or {}
esc.cfg = esc.cfg 	or {}

local include_sv = (SERVER) and include or function() end
local include_cl = (SERVER) and AddCSLuaFile or include
local include_sh = function(path)
	include_sv(path)
	include_cl(path)
end

include_cl('esc/main.lua')
include_cl('esc_config.lua')
include_cl('esc/util.lua')