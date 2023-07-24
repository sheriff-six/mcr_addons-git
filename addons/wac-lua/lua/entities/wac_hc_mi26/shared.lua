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

ENT.Base = "wac_hc_base"
ENT.Type = "anim"
ENT.Author = Veter
ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.Category = "Вертолёты"
ENT.PrintName		= "MI-26"
ENT.Model		= "models/mi26/mi26.mdl"
ENT.IgnoreDamage = true
ENT.UsePhysRotor = true
ENT.Submersible	= false
ENT.CrRotorWash	= true
ENT.RotorWidth	= 200
ENT.EngineForce	= 40
ENT.BrakeMul = 1
ENT.AngBrakeMul	= 0.01
ENT.Weight = 40000
ENT.SmokePos	= Vector(185,0,300)
ENT.FirePos		= Vector(185,0,300)

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
	AngleDrag = Vector(0.06, 0.01, 0.02),
}



ENT.TopRotor = {
	dir = -1,
	pos = Vector(174,0,320),
	angles = Angle(1.93,0,0),
	model = "models/mi26/Rotor_top.mdl"
}

ENT.BackRotor = {
	dir = -1,
	pos = Vector(-690,-73,333),
	model = "models/mi26/Rotor_tail.mdl"
}

ENT.Wheels={
	{
		mdl="models/mi26/WheelF.mdl",
		pos=Vector(487,0,20),
		friction=60,
		mass=400,
	},
	{
		mdl="models/mi26/WheelL.mdl",
		pos=Vector(103,103,25),
		friction=60,
		mass=2500,
	},
	{
		mdl="models/mi26/WheelR.mdl",
		pos=Vector(103,-103,25),
		friction=60,
		mass=2500,
	},

}
ENT.Seats = {
	{
		pos=Vector(590,22,120),
		exit=Vector(440,30,90),
	},
	{
		pos=Vector(590,-22,120),
		exit=Vector(460,-30,90),
	},
	{
		pos=Vector(540,22,120),
		exit=Vector(440,-0,90),
	},
	{
		pos=Vector(540,-22,120),
		exit=Vector(450,-30,90),
	},
	{
		pos=Vector(500,-57,110),
		ang=Angle(0,0,0),
		exit=Vector(460,30,90),
	},
	{
		pos=Vector(500,45,110),
		ang=Angle(0,0,0),
		exit=Vector(440,-30,90),
	},
	{
		pos=Vector(500,20,110),
		ang=Angle(0,0,0),
		exit=Vector(460,-30,90),
	},
	{
		pos=Vector(473,0,90),
		ang=Angle(0,180,0),
		exit=Vector(470,30,90),
	},
}

ENT.Camera = {
	model = "models/mm1/box.mdl",
	pos = Vector(590,0,40),
	offset = Vector(-1,0,0),
	viewPos = Vector(2,0,0),
	minAng = Angle(0, -180, 0),
	maxAng = Angle(80, 180, 0),
	seat = 2
}

ENT.Sounds={
	Start="mi26/engine_start.wav",
	Blades="mi26/engine_idle.wav",
	Engine = "mi26/exhaust.wav",
	MissileAlert="HelicopterVehicle/MissileNearby.mp3",
	MissileShoot="HelicopterVehicle/MissileShoot.mp3",
	MinorAlarm="WAC/Heli/fire_alarm_tank.wav",
	LowHealth="WAC/Heli/fire_alarm.wav",
	CrashAlarm="WAC/Heli/FireSmoke.wav",
	RampRotate = "/mi26/ramp.wav",
    RampStop = "wac/mi26/ramp_end.wav",
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

	cam.Start3D2D(self:LocalToWorld(Vector(30,3.75,37.75)+spos), ang,0.015)
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
	surface.DrawText("СКР  "..math.floor(self:GetVelocity():Length()*0.1) .."Км/Ч")
	surface.SetTextPos(30, 445)
	local tr=util.QuickTrace(pos+self:GetUp()*10,Vector(0,0,-999999),self.Entity)
	surface.DrawText("ВЫС  "..math.ceil((pos.z-tr.HitPos.z)*0.01905).."М")
	
	cam.End3D2D()
end
function ENT:DrawWeaponSelection() end