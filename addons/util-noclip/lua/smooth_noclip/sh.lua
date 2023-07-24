local FrameTime, MOVETYPE_NOCLIP, UpVec, mathMin, ACT_MP_SWIM = FrameTime, MOVETYPE_NOCLIP, Vector(0, 0, 1), math.min, ACT_MP_SWIM
local CMoveData, Player, Entity, Vector, ConVar, Angle = FindMetaTable("CMoveData"), FindMetaTable("Player"), FindMetaTable("Entity"), FindMetaTable("Vector"), FindMetaTable("ConVar"), FindMetaTable("Angle")
local GetMoveAngles, GetVelocity, SetVelocity, SetOrigin, GetForwardSpeed, GetSideSpeed, GetUpSpeed, GetOrigin = CMoveData.GetMoveAngles, CMoveData.GetVelocity, CMoveData.SetVelocity, CMoveData.SetOrigin, CMoveData.GetForwardSpeed, CMoveData.GetSideSpeed, CMoveData.GetUpSpeed, CMoveData.GetOrigin
local GetNormal, Length = Vector.GetNormal, Vector.Length
local GetMaxSpeed, GetInfoNum, InVehicle = Player.GetMaxSpeed, Player.GetInfoNum, Player.InVehicle
local GetMoveType = Entity.GetMoveType
local GetInt, GetBool = ConVar.GetInt, ConVar.GetBool
local Forward, Right = Angle.Forward, Angle.Right
local sv_noclipspeed, sv_noclipaccelerate = GetConVar("sv_noclipspeed"), GetConVar("sv_noclipaccelerate")

CreateConVar("smooth_noclip_customanim", "1", {FCVAR_ARCHIVE, FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_SERVER_CAN_EXECUTE}, "Changes noclip animation.")

local smooth_noclip_customanim = GetConVar("smooth_noclip_customanim")

hook.Add("Move", "SmoothNoclip", function(ply, mv)
	if GetMoveType(ply) ~= MOVETYPE_NOCLIP then return end
	if GetInfoNum(ply, "smooth_noclip", 0) < 1 then return end

	local sv_noclipspeed, sv_noclipaccelerate = GetInt(sv_noclipspeed), GetInt(sv_noclipaccelerate)
	local FrameTime, mvang = FrameTime(), GetMoveAngles(mv)

	local accel = Forward(mvang)*GetForwardSpeed(mv) + (Right(mvang) * GetSideSpeed(mv)) + (UpVec * GetUpSpeed(mv))
	local dir, speed = GetNormal(accel), mathMin(Length(accel), GetMaxSpeed(ply))
	accel = dir * speed * sv_noclipspeed
	
	local newvel = (GetVelocity(mv) + accel * sv_noclipaccelerate * FrameTime) * (0.95 - FrameTime * 4)
	local newor = GetOrigin(mv) + newvel * FrameTime

	SetVelocity(mv, newvel)
	SetOrigin(mv, newor)
	return true
end)

hook.Add("CalcMainActivity", "SmoothNoclip/Animation", function(ply, vel)
	if GetBool(smooth_noclip_customanim) and GetMoveType(ply) == MOVETYPE_NOCLIP and InVehicle(ply) == false then
		return ACT_HL2MP_SWIM, -1
	end
end)