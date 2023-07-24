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
ENT.PrintName		= "MI-24D"
ENT.Author			= "Veter"
ENT.Category		= "Вертолёты"
ENT.Spawnable		= true
ENT.AdminSpawnable	= true
ENT.Model			= "models/mi24DV/mi24d.mdl"
ENT.SmokePos		= Vector(-1,-5,60)
ENT.FirePos			= Vector(-1,-5,60)
ENT.WheelStabilize	=-150
ENT.EngineForce			= 29
ENT.Weight				= 50000
ENT.MaxEnterDistance	= 100
ENT.RotorWidth	= 400



ENT.Wheels = {
	{
		mdl="models/mi24DV/wheell.mdl",
		pos=Vector(-49,60,-70),
		friction=150,
		mass=2500,
	},
	{
		mdl="models/mi24DV/wheelr.mdl",
		pos=Vector(-49,-60.4,-70),
		friction=150,
		mass=2500,
	},
	{
		mdl="models/mi24DV/wheelf.mdl",
		pos=Vector(124,0,-88),
		friction=100,
		mass=1500,
	},
}

ENT.thirdPerson = {
	distance = 650
}

ENT.TopRotor = {
	dir = -1,
	pos = Vector(-1,-5,79),
	angles = Angle(3,0,0),
	model = "models/mi24DV/rotortop.mdl"
}

ENT.BackRotor = {
	dir = -1,
	pos = Vector(-445,24,84),
	model = "models/mi24DV/rotorback.mdl"
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
	AngleDrag = Vector(0.04, 0.02, 0.02),
}


ENT.Seats = {
	{
		pos=Vector(127, 0.9, -26),
		exit=Vector(125, -75, -70),
		weapons={"С-8"}
	},
	{
		pos=Vector(185, 1,-50),
		exit=Vector(180, 75, -70),
		weapons={"9М17M","Р-60","УСПУ-24"}
	},
	{
		pos=Vector(54, 2, -33),
		ang=Angle(0,90,0),
		exit=Vector(50, 75, -70),
	},
	{
		pos=Vector(54, -2, -33),
		ang=Angle(0,-90,0),
		exit=Vector(50, -75, -70),
	},
	{
		pos=Vector(27, 2, -33),
		ang=Angle(0,90,0),
		exit=Vector(50, 75, -70),
	},
	{
		pos=Vector(27, -2, -33),
		ang=Angle(0,-90,0),
		exit=Vector(50, -75, -70),
	},
	{
		pos=Vector(7, 2, -33),
		ang=Angle(0,90,0),
		exit=Vector(50, 75, -70),
	},
	{
		pos=Vector(-13, 2, -33),
		ang=Angle(0,90,0),
		exit=Vector(50, 75, -70),
	},
	{
		pos=Vector(7, -2, -33),
		ang=Angle(0,-90,0),
		exit=Vector(50, -75, -70),
	},
	{
		pos=Vector(-13, -2, -33),
		ang=Angle(0,-90,0),
		exit=Vector(50, -75, -70),
	},
}
ENT.Weapons = {
	["С-8"] = {
		class = "wac_pod_grocket_s8",
		info = {
			Pods = {
				Vector(-37,71,-32),
				Vector(-37,71,-32),
				Vector(-37,-95,-44),
			},
			Sequential = true,
			Ammo = 80,
			FireRate = 400,
		}
	},
	["9М17M"] = {
		class = "zv_pod_9m17m_wac",
		info = {
			Pods = {
				Vector(200,200,10),
				Vector(200,-200,10),
			},
			Sequential = true,
			Ammo = 4,
			FaF = false,
			FireRate = 10,
		}
	},
		["Р-60"] = {
			class = "sw_pod_r60_wac",
			info = {
				Pods = {
					Vector(-42.3,94.4,-36),
				},
				Sequential = true,
				Ammo = 2,
				FaF = false,
				FireRate = 10,
			}
	},
	["УСПУ-24"] = {
		class = "wac_pod_gunner",
		info = {
			ShootPos = Vector(247.8, 0.8,-54),
			ShootOffset = Vector(25,0,0),
			FireRate = 900,
			Ammo = 1470,
			BulletType = "wac_base_12mm",
			TracerColor = "Green",
			Sounds = {
				shoot1p = "mi24/mi35m_23mm_gun_loop.wav",
				spin = "",
				shoot3p = "mi35m_23mm_gun_shot"
			},
		}
	},
}
ENT.WeaponAttachments = {
	gunup = {
		model = "models/mi24DV/gunup.mdl",
		pos = Vector(217.8, 0.8,-54),
		restrictPitch = true,
		restrictYaw = false,
	},
	gun = {
		model = "models/mi24DV/gun.mdl",
		pos = Vector(217.8, 0.8,-54),
		restrictPitch = false,
		restrictYaw = false,
	},
	falanga_launcher = {
		model = "models/mi24DV/falanga_launcher.mdl",
		pos = Vector(0, 0,0),
		restrictPitch = true,
		restrictYaw = true	,
	},
	ub32_1 = {
		model = "models/sw/avia/bombs/b8v20.mdl",
		pos = Vector(-37,71,-32),
		restrictPitch = true,
		restrictYaw = true	,
	},
	ub32_2 = {
		model = "models/sw/avia/bombs/b8v20.mdl",
		pos = Vector(-37,-71,-32),
		restrictPitch = true,
		restrictYaw = true	,
	},
	ub32_3 = {
		model = "models/sw/avia/bombs/b8v20.mdl",
		pos = Vector(-37,-95,-44),
		restrictPitch = true,
		restrictYaw = true	,
	},
	apu60 = {
		model = "models/sw/avia/bombs/apu60r.mdl",
		pos = Vector(-42.3,94.4,-28),
		restrictPitch = true,
		restrictYaw = true	,
	},
	r60_1 = {
		model = "models/sw/avia/bombs/r60.mdl",
		pos = Vector(-42.3,94.4,-36),
		restrictPitch = true,
		restrictYaw = true	,
	},
	r60_2 = {
		model = "models/sw/avia/bombs/r60.mdl",
		pos = Vector(-42.3,102,-26.7),
		restrictPitch = true,
		restrictYaw = true	,
	},
	falanga_1 = {
		model = "models/sw/avia/bombs/9m17m.mdl",
		pos = Vector(-54,119.3,-32.6),
		restrictPitch = true,
		restrictYaw = true	,
	},
	falanga_2 = {
		model = "models/sw/avia/bombs/9m17m.mdl",
		pos = Vector(-54,144.4,-32),
		restrictPitch = true,
		restrictYaw = true	,
	},
	falanga_3 = {
		model = "models/sw/avia/bombs/9m17m.mdl",
		pos = Vector(-54,-119.3,-43.5),
		restrictPitch = true,
		restrictYaw = true	,
	},
	falanga_4 = {
		model = "models/sw/avia/bombs/9m17m.mdl",
		pos = Vector(-54,-144.4,-44.2),
		restrictPitch = true,
		restrictYaw = true	,
	},

}

ENT.Camera = {
	model = "models/mm1/box.mdl",
	pos = Vector(210,-20,-70),
	offset = Vector(2,0,0),
	viewPos = Vector(0,0,0),
	maxAng = Angle(40, 70, 20),
	minAng = Angle(-20, -70, 0),
	seat = 2
}

ENT.Sounds={
	Start="mi24/start.mp3",
	Engine="mi24/engien_idle.mp3",
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

	cam.Start3D2D(self:LocalToWorld(Vector(18,3.7,37.5)+spos), ang,0.015)
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
	
	if self:GetNWInt("seat_2_actwep") == 1 and self.weapons["С-8"] then
		surface.SetTextPos(20,320)
		local n = self.weapons["С-8"]:GetAmmo()
		surface.DrawText("С-8" .. getspaces(n))
	end
	if self:GetNWInt("seat_1_actwep") == 2 and self.weapons["С-8"] then
		surface.SetTextPos(170,450)
		local n = self.weapons["С-8"]:GetAmmo()
		surface.DrawText("Оружие:С-8" .. getspaces(n))
	end
	cam.End3D2D()
end

function ENT:DrawWeaponSelection() end
