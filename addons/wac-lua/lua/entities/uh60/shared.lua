function ENT:MovePlayerView(k,p,md)
	if p.wac_air_resetview then md:SetViewAngles(Angle(0,90,0)) p.wac_air_resetview=false end
	local freeView = md:GetViewAngles()
	if !self.Seats or !self.Seats[k] then return end
	if (k==1 and p:GetInfo("wac_cl_air_mouse")=="1" and !p.wac.viewFree) then
		freeView.p = freeView.p-freeView.p*FrameTime()*6
		freeView.y = freeView.y-(freeView.y-90)*FrameTime()*6
	else
		freeView.p = math.Clamp(freeView.p,-90,90)
	end
	freeView.y = (freeView.y)
	md:SetViewAngles(freeView)
end

ENT.Base 			= "wac_hc_base"
ENT.Type 			= "anim"
ENT.PrintName		= "UH-60"
ENT.Author			= "Veter"
ENT.Category		= "Вертолёты"
ENT.Spawnable		= true
ENT.AdminSpawnable	= true
ENT.Model			= "models/uh60/uh60.mdl"
ENT.SmokePos		= Vector(-8,0,130)
ENT.FirePos			= Vector(-8,0,135)
ENT.WheelStabilize	=-150
ENT.EngineForce			= 40
ENT.Weight				= 50000
ENT.MaxEnterDistance	= 100
ENT.RotorWidth	= 400

ENT.Wheels = {
	{
		mdl="models/uh60/wheelL.mdl",
		pos=Vector(111,54,12.7),
		friction=100,
		mass=1200,
	},
	{
		mdl="models/uh60/wheelR.mdl",
		pos=Vector(111,-54,12.7),
		friction=100,
		mass=1200,
	},
	{
		mdl="models/uh60/wheelB.mdl",
		pos=Vector(-225,0,7),
		friction=100,
		mass=1000,
	},
}

ENT.Aerodynamics = {
	Rotation = {
		Front = Vector(0, 0.5, 0),
		Right = Vector(0, 0, 30), -- Rotate towards flying direction
		Top = Vector(0, -5, 0)
	},
	Lift = {
		Front = Vector(0, 0, 3), -- Go up when flying forward
		Right = Vector(0, 0, 0),
		Top = Vector(0, 0, -0.5)
	},
	Rail = Vector(0.3, 3, 2),
	RailRotor = 1, -- like Z rail but only active when moving and the rotor is turning
	AngleDrag = Vector(0.03, 0.03, 0.02),
}


ENT.thirdPerson = {
	distance = 650
}

ENT.TopRotor = {
	dir = 1,
	pos = Vector(72,0,134),
	model = "models/uh60/Rotor_top.mdl"
}

ENT.BackRotor = {
	dir = -1,
	pos = Vector(-309,-21.5,126),
	model = "models/uh60/Rotor_tail.mdl"
}

ENT.Seats = {
	{
		pos=Vector(169, -25, 42),
		exit=Vector(150, -80, 5),
	},
	{
		pos=Vector(169, 25, 42),
		exit=Vector(150, 80, 5),
	},
	{
		pos=Vector(120, -15, 42),
		ang=Angle(0,-90,0),
		exit=Vector(30, -80, 5),
		weapons={"M134 Minigun"}
	},
	{
		pos=Vector(120, 15, 42),
		ang=Angle(0,90,0),
		exit=Vector(30, 80, 5),
	},
	{
		pos=Vector(28, -29, 42),
		exit=Vector(30, -80, 5),
	},
	{
		pos=Vector(28, -10, 42),
		exit=Vector(30, -80, 5),
	},
	{
		pos=Vector(28, 9, 42),
		exit=Vector(30, 80, 5),
	},
	{
		pos=Vector(28, 28, 42),
		exit=Vector(30, 80, 5),
	},
	{
		pos=Vector(78, -29, 42),
		ang=Angle(0,-180,0),
		exit=Vector(30, -80, 5),
	},
	{
		pos=Vector(78, -10, 42),
		ang=Angle(0,-180,0),
		exit=Vector(30, -80, 5),
	},
	{
		pos=Vector(78, 9, 42),
		ang=Angle(0,-180,0),
		exit=Vector(30, 80, 5),
	},
	{
		pos=Vector(120, 0, 42),
		ang=Angle(0,-180,0),
		exit=Vector(30, 80, 5),
	},
}
ENT.Weapons = {
	["M134 Minigun"] = {
		class = "wac_pod_gunner",
		info = {
			ShootPos = Vector(123.5,-51.5,59),
			ShootOffset = Vector(0,0,0),
			FireRate = 3000,
			Ammo = 2000,
			BulletType = "wac_base_7mm",
			TracerColor = "Yellow",
			Sounds = {
				spin = "uh60/mg_rotor_loop.wav",
				shoot1p = "uh60/m134_shoot.wav",
				shoot3p = "",
			}
		}
	},
}

ENT.WeaponAttachments={
	
	MODEL1 = {
		model = "models/uh60/Turret_r.mdl",
		pos = Vector(123.5,-53,54),
		restrictPitch = true,
		restrictYaw = false,
	},
	MODEL2 = {
		model = "models/uh60/Gun_r.mdl",
		pos = Vector(123.5,-51.5,59),
		restrictPitch = false,
		restrictYaw = false,
	},
}

ENT.Camera = {
	model = "models/mm1/box.mdl" ,
	pos = Vector(120,-80,68.7),
	offset = Vector(-1,0,0),
	viewPos = Vector(30, 0, 3.5),
	maxAng = Angle(80, 0, 10),
	minAng = Angle(-10, -170, 0),
	seat = 3
}

ENT.Sounds={
	Start="uh60/engine_start.wav",
	Blades="uh60/engine_idle.wav",
	Engine="uh60/exhaust.wav",
	MissileAlert="HelicopterVehicle/MissileNearby.mp3",
	MissileShoot="HelicopterVehicle/MissileShoot.mp3",
	MinorAlarm="WAC/Heli/fire_alarm_tank.wav",
	LowHealth="WAC/Heli/fire_alarm.wav",
	CrashAlarm="WAC/Heli/FireSmoke.wav",
}

local function DrawLine(v1,v2)
	surface.DrawLine(v1.y,v1.z,v2.y,v2.z)
end

local mHorizon0 = Material("WeltEnSTurm/WAC/Helicopter/hud_line_0")
local HudCol = Color(70,199,50,150)
local Black = Color(0,0,0,200)

local mat = {
	Material("WeltEnSTurm/WAC/Helicopter/hud_line_0"),
	Material("WeltEnSTurm/WAC/Helicopter/hud_line_high"),
	Material("WeltEnSTurm/WAC/Helicopter/hud_line_low"),
}

local function getspaces(n)
	if n<10 then
		n="      "..n
	elseif n<100 then
		n="    "..n
	elseif n<1000 then
		n="  "..n
	end
	return n
end

function ENT:DrawPilotHud()
	local pos = self:GetPos()
	local ang = self:GetAngles()
	ang:RotateAroundAxis(self:GetRight(), 90)
	ang:RotateAroundAxis(self:GetForward(), 90)
	
	local uptm = self.SmoothVal
	local upm = self.SmoothUp
	local spos=self.Seats[1].pos

	cam.Start3D2D(self:LocalToWorld(Vector(15,3.75,37.75)+spos), ang,0.015)
	surface.SetDrawColor(HudCol)
	surface.DrawRect(234, 247, 10, 4)
	surface.DrawRect(254, 247, 10, 4)
	surface.DrawRect(247, 234, 4, 10)
	surface.DrawRect(247, 254, 4, 10)
	
	local a=self:GetAngles()
	a.y=0
	local up=a:Up()
	up.x=0
	up=up:GetNormal()
	
	local size=180
	local dist=10
	local step=12
	for p=-180,180,step do
		if a.p+p>-size/dist and a.p+p<size/dist then
			if p==0 then
				surface.SetMaterial(mat[1])
			elseif p>0 then
				surface.SetMaterial(mat[2])
			else
				surface.SetMaterial(mat[3])
			end
			surface.DrawTexturedRectRotated(250+up.y*(a.p+p)*dist,250-up.z*(a.p+p)*dist,300,300,a.r)
		end
	end
	surface.SetTextColor(HudCol)
	surface.SetFont("wac_heli_small")
	
	surface.SetTextPos(30, 410) 
	surface.DrawText("SPD  "..math.floor(self:GetVelocity():Length()*0.1) .."kn")
	surface.SetTextPos(30, 445)
	local tr=util.QuickTrace(pos+self:GetUp()*10,Vector(0,0,-999999),self.Entity)
	surface.DrawText("ALT  "..math.ceil((pos.z-tr.HitPos.z)*0.01905).."m")
	

	cam.End3D2D()
end
function ENT:DrawWeaponSelection() end