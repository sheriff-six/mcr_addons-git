if not wac then return end
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

ENT.Base 				= "wac_hc_base"
ENT.Type 				= "anim"
ENT.PrintName			= "KA-226"
ENT.Author				= "Veter"
ENT.Category			= "Вертолёты"
ENT.Spawnable			= true
ENT.AdminSpawnable		= true

ENT.Model			= "models/ka226/ka226.mdl"
ENT.EngineForce	= 36
ENT.Weight		= 12000
ENT.SmokePos	= Vector(28,0,108.48)
ENT.FirePos		= Vector(28,0,108.48)

ENT.thirdPerson = {
	distance = 680
}

ENT.TopRotor = {
	dir = 1,
	pos = Vector(-2,3,140),
	model = "models/ka226/rotorTOP1.mdl"
}

ENT.TopRotor2 = {
	dir = -1,
	pos = Vector(0.1,4,180),
	angles = Angle(0,0,0),
	model = "models/ka226/rotorTOP2.mdl"
}

ENT.BackRotor = {
	dir = 1,
	pos = Vector(-265,0,118),
	model = "models/mm1/box.mdl"
}
ENT.Seats = {
	{
		pos=Vector(66, 21, 47),
		exit=Vector(94,105,5),
	},
	{
		pos=Vector(66,-14, 47),
		exit=Vector(94,-105,5),
	},
	{
		pos=Vector(-44, 22, 37),
		ang=Angle(0,0,0),
		exit=Vector(50, 75, 5),
	},
	{
		pos=Vector(-44, 3, 37),
		ang=Angle(0,0,0),
		exit=Vector(50, 75, 5),
	},
	{
		pos=Vector(-44, -17, 37),
		ang=Angle(0,0,0),
		exit=Vector(50, 75, 5),
	},
	{
		pos=Vector(26, -17, 37),
		ang=Angle(0,180,0),
		exit=Vector(50, 75, 5),
	},
	{
		pos=Vector(26, 3, 37),
		ang=Angle(0,180,0),
		exit=Vector(50, 75, 5),
	},
	{
		pos=Vector(26, 22, 37),
		ang=Angle(0,180,0),
		exit=Vector(50, 75, 5),
	}
}

ENT.Wheels={
	{
		mdl="models/ka226/WheelFL.mdl",
		pos=Vector(106,22.5,8),
		friction=100,
		mass=250,
	},
	{
		mdl="models/ka226/WheelFR.mdl",
		pos=Vector(106,-16.5,8),
		friction=100,
		mass=250,
	},
	{
		mdl="models/ka226/WheelL.mdl",
		pos=Vector(-51,56,15),
		friction=100,
		mass=550
	},
	{
		mdl="models/ka226/WheelR.mdl",
		pos=Vector(-51,-49.5,15),
		friction=100,
		mass=550,
	},

}

ENT.Camera = {
	model = "models/ka226/Camera.mdl",
	pos = Vector(138,3,32),
	offset = Vector(0,0,0),
	viewPos = Vector(10, 0, 0),
	maxAng = Angle(45, 90, 0),
	minAng = Angle(-2, -90, 0),
	seat = 2
}
ENT.WeaponAttachments = {
	CameraMount = {
		model = "models/ka226/podgun.mdl",
		pos = Vector(135,3,34),
		restrictPitch = true,
	},
}
ENT.Sounds={
	Start="ka226/start.wav",
	Blades="ka226/external.wav",
	MissileAlert="WAC/Heli/heatseeker_track_warning.wav",
	MissileShoot="HelicopterVehicle/MissileShoot.mp3",
	MinorAlarm="WAC/Heli/fire_alarm_tank.wav",
	LowHealth="WAC/Heli/fire_alarm.wav",
	CrashAlarm="WAC/Heli/laser_warning.wav"
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

	cam.Start3D2D(self:LocalToWorld(Vector(18,4,37.75)+spos), ang,0.015)
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
	surface.DrawText("СКР  "..math.floor(self:GetVelocity():Length()*0.1) .."км/ч")
	surface.SetTextPos(30, 445)
	local tr=util.QuickTrace(pos+self:GetUp()*10,Vector(0,0,-999999),self.Entity)
	surface.DrawText("ВЫС  "..math.ceil((pos.z-tr.HitPos.z)*0.01905).."м")
	
	cam.End3D2D()
end

function ENT:DrawWeaponSelection() end
