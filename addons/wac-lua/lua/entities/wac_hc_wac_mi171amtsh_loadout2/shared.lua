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
ENT.Category = wac.aircraft.spawnCategory
ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.Category = "Вертолёты"
ENT.PrintName		= "MI-8AMTSH Loadout2"
ENT.Model		= "models/Mi8V/mi8v.mdl"
ENT.IgnoreDamage = true
ENT.UsePhysRotor = true
ENT.Submersible	= false
ENT.CrRotorWash	= true
ENT.RotorWidth	= 200
ENT.EngineForce	= 40
ENT.BrakeMul = 1
ENT.AngBrakeMul	= 0.01
ENT.Weight = 25000
ENT.SmokePos	= Vector(-84,0,110)
ENT.FirePos		= Vector(-86,0,110)

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
	pos = Vector(13,-1,180),
	model = "models/Mi8V/mi8_rotor.mdl"
}

ENT.BackRotor = {
	dir = -1,
	pos = Vector(-624.5,28,216),
	model = "models/Mi8V/mi8_rotorz.mdl"
}

ENT.Wheels={
	{
		mdl="models/Mi8V/mi8wf.mdl",
		pos=Vector(163,-0.7,-7),
		friction=160,
		mass=400,
	},
	{
		mdl="models/Mi8V/mi8wl.mdl",
		pos=Vector(-49,110,12),
		friction=160,
		mass=600,
	},
	{
		mdl="models/Mi8V/mi8wr.mdl",
		pos=Vector(-49,-110,12),
		friction=160,
		mass=600,
	},

}

ENT.Weapons = {
	["С-13 №1"] = {
		class = "wac_pod_grocket_s13",
		info = {
			Pods = {
				Vector(32,107,40),
				Vector(32,-108,40),
			},
			Sequential = true,
			Ammo = 10,
			kind = "rocket_s13",
			FireRate = 300,
		}
	},
	["С-13 №2"] = {
		class = "wac_pod_grocket_s13",
		info = {
			Pods = {
				Vector(32,139,40),
				Vector(32,-141,40),
			},
			Sequential = true,
			Ammo = 10,
			kind = "rocket_s13",
			FireRate = 300,
		}
	},
}

ENT.Seats = {
	{
		pos=Vector(210,28,57),
		exit=Vector(147.5,120,50),
		weapons = {"С-13 №1","С-13 №2"}
	},
	{
		pos=Vector(210,-30,57),
		exit=Vector(147.5,-120,50),
	},
	{
		pos=Vector(110,34,55),
		ang=Angle(0,-90,0),
		exit=Vector(-230,55,10),
	},
	{
		pos=Vector(70,34,55),
		ang=Angle(0,-90,0),
		exit=Vector(-230,-55,10),
	},
	{
		pos=Vector(110,-34,55),
		ang=Angle(0,90,0),
		exit=Vector(-230,55,10),
	},
	{
		pos=Vector(70,-34,55),
		ang=Angle(0,90,0),
		exit=Vector(-230,-55,10),
	},
	{
		pos=Vector(30,-34,55),
		ang=Angle(0,90,0),
		exit=Vector(-230,55,10),
	},
	{
		pos=Vector(0,-34,55),
		ang=Angle(0,90,0),
		exit=Vector(-230,-55,10),
	},
	{
		pos=Vector(30,34,55),
		ang=Angle(0,-90,0),
		exit=Vector(-230,55,10),
	},
	{
		pos=Vector(0,34,55),
		ang=Angle(0,-90,0),
		exit=Vector(-230,-55,10),
	},
	{
		pos=Vector(-40,34,55),
		ang=Angle(0,-90,0),
		exit=Vector(-230,55,10),
	},
	{
		pos=Vector(-70,34,55),
		ang=Angle(0,-90,0),
		exit=Vector(-230,-55,10),
	},
	{
		pos=Vector(-40,-34,55),
		ang=Angle(0,90,0),
		exit=Vector(-230,55,10),
	},
	{
		pos=Vector(-70,-34,55),
		ang=Angle(0,90,0),
		exit=Vector(-230,-55,10),
	},
}

ENT.WeaponAttachments = {
	b8v20_2 = {
		model = "models/sw/avia/bombs/b13.mdl",
		pos = Vector(32,107,40),
		restrictPitch = true,
		restrictYaw = true,
	},
	b8v20_1 = {
		model = "models/sw/avia/bombs/b13.mdl",
		pos = Vector(32,-108,40),
		restrictPitch = true,
		restrictYaw = true,
	},
	b8v20_3 = {
		model = "models/sw/avia/bombs/b13.mdl",
		pos = Vector(32,-141,40),
		restrictPitch = true,
		restrictYaw = true,
	},
	b8v20_4 = {
		model = "models/sw/avia/bombs/b13.mdl",
		pos = Vector(32,139,40),
		restrictPitch = true,
		restrictYaw = true,
	},
}

ENT.Sounds={
	Start="WAC/mi171/engine_start.wav",
	Blades="WAC/mi171/engine_idle.wav",
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

	cam.Start3D2D(self:LocalToWorld(Vector(22,3.75,37.4)+spos), ang,0.015)
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
	
	surface.SetTextPos(400, 410) 
	surface.DrawText("СКР  "..math.floor(self:GetVelocity():Length()*0.1) .."Км/Ч")
	surface.SetTextPos(400, 445)
	local tr=util.QuickTrace(pos+self:GetUp()*10,Vector(0,0,-999999),self.Entity)
	surface.DrawText("ВЫС  "..math.ceil((pos.z-tr.HitPos.z)*0.01905).."М")
	
	if self:GetNWInt("seat_2_actwep") == 1 and self.weapons["С-13 №1"] then
		surface.SetTextPos(400,300)
		local n = self.weapons["С-13 №1"]:GetAmmo()
		surface.DrawText("С-13 №1" .. getspaces(n))
	end
	if self:GetNWInt("seat_1_actwep") == 1 and self.weapons["С-13 №1"] then
		surface.SetTextPos(150,420)
		local n = self.weapons["С-13 №1"]:GetAmmo()
		surface.DrawText("Оружие:С-13 №1" .. getspaces(n))
	end
	if self:GetNWInt("seat_2_actwep") == 1 and self.weapons["С-13 №2"] then
		surface.SetTextPos(400,320)
		local n = self.weapons["С-13 №2"]:GetAmmo()
		surface.DrawText("С-13 №2" .. getspaces(n))
	end
	if self:GetNWInt("seat_1_actwep") == 2 and self.weapons["С-13 №2"] then
		surface.SetTextPos(150,420)
		local n = self.weapons["С-13 №2"]:GetAmmo()
		surface.DrawText("Оружие:С-13 №2" .. getspaces(n))
	end

	cam.End3D2D()
end
function ENT:DrawWeaponSelection() end