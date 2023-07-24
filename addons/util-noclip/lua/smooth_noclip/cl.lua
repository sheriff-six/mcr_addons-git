local CUserCmd, Player, Entity, ConVar = FindMetaTable("CUserCmd"), FindMetaTable("Player"), FindMetaTable("Entity"), FindMetaTable("ConVar")
local KeyDown, SetUpMove, SetForwardMove, SetSideMove = CUserCmd.KeyDown, CUserCmd.SetUpMove, CUserCmd.SetForwardMove, CUserCmd.SetSideMove
local GetMaxSpeed = Player.GetMaxSpeed
local GetMoveType = Entity.GetMoveType
local GetBool = ConVar.GetBool
local LocalPlayer, IsValid = LocalPlayer, IsValid
local MOVETYPE_NOCLIP, IN_JUMP, IN_DUCK, IN_FORWARD, IN_BACK, IN_MOVERIGHT, IN_MOVELEFT = MOVETYPE_NOCLIP, IN_JUMP, IN_DUCK, IN_FORWARD, IN_BACK, IN_MOVERIGHT, IN_MOVELEFT

local enable = CreateConVar("smooth_noclip", "1", FCVAR_USERINFO)
local smooth_noclip_crouch_default = CreateConVar("smooth_noclip_crouch_default", "0", FCVAR_ARCHIVE)

hook.Add("CreateMove", "SmoothNoclip", function(cmd)
	if GetBool(enable) == false then return end
	local ply = LocalPlayer()
	if IsValid(ply) == false or GetMoveType(ply) ~= MOVETYPE_NOCLIP then return end

	local Up, Right, Forard = 0, 0, 0
	local MaxSpeed = GetMaxSpeed(ply)

	if KeyDown(cmd, IN_FORWARD) then
		Forard = Forard + MaxSpeed;
	end
	if KeyDown(cmd, IN_BACK) then
		Forard = Forard - MaxSpeed
	end

	if KeyDown(cmd, IN_MOVERIGHT) then
		Right = Right + MaxSpeed
	end
	if KeyDown(cmd, IN_MOVELEFT) then
		Right = Right - MaxSpeed
	end

	if KeyDown(cmd, IN_JUMP) then
		Up = Up + MaxSpeed
	end
	if KeyDown(cmd, IN_DUCK) then
		if GetBool(smooth_noclip_crouch_default) then
			Up 		= Up * 0.25
			Forard 	= Forard * 0.25
			Right 	= Right * 0.25
		else
			Up = Up - MaxSpeed
		end
	end
				
	SetUpMove(cmd, Up)
	SetForwardMove(cmd, Forard)
	SetSideMove(cmd, Right)
end)