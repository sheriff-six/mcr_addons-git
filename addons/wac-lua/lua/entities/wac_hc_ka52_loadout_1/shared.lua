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
ENT.PrintName			= "KA-52 Loadout 1"
ENT.Author				= "Veter"
ENT.Category			= "Вертолёты"
ENT.Spawnable			= true
ENT.AdminSpawnable		= true
ENT.Model			= "models/ka52/ka52.mdl"
ENT.EngineForce	= 36
ENT.Weight		= 50000
ENT.Ammo = 1
ENT.SmokePos	= Vector(-50,0,0)
ENT.FirePos		= Vector(-50,0,108.48)

ENT.thirdPerson = {
	distance = 680
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
	AngleDrag = Vector(0.02, 0.01, 0.02),
}



ENT.TopRotor = {
	dir = 1,
	pos = Vector(-20,1.68,53),
	angles = Angle(2,0,0),
	model = "models/ka52/rotor_bottom.mdl"
}
ENT.TopRotor2 = {
	dir = -1,
	pos = Vector(-16,1.3,105),
	angles = Angle(2,0,0),
	model = "models/ka52/rotor_top.mdl"
}
ENT.BackRotor = {
	dir = 1,
	pos = Vector(-246,0,0),
	model = "models/props_junk/PopCan01a.mdl"
}
ENT.Seats = {
	{
		pos=Vector(79, 15.5, -31),
		exit=Vector(94,105,5),
		weapons = {"2A42","С-8"}
	},
	{
		pos=Vector(79,-14.5, -31),
		exit=Vector(94,-105,5),
		weapons = {"Вихрь","9М39"}
	},
}
ENT.Wheels={
	{
		mdl="models/ka52/WheelFL.mdl",
		pos=Vector(97,7,-69.4),
		friction=50,
		mass=1200,
	},
	{
		mdl="models/ka52/WheelFR.mdl",
		pos=Vector(97,-5,-69.4),
		friction=50,
		mass=1200,
	},
	{
		mdl="models/ka52/WheelR.mdl",
		pos=Vector(-68,-50,-66.5),
		friction=100,
		mass=2500
	},
	{
		mdl="models/ka52/WheelL.mdl",
		pos=Vector(-68,51.5,-66.5),
		friction=100,
		mass=2500,
	},

}
ENT.Weapons = {
	["С-8"] = {
		class = "wac_pod_grocket_s8",
		info = {
			Pods = {
				Vector(3.22,72.94,-29.5),
				Vector(3.22,-72.94,-29.5),
			},
			Sequential = true,
			Ammo = 40,
			kind = "rocket_s8",
			FireRate = 300,
		}
	},
	["Вихрь"] = {
		class = "sw_pod_vyihr_wac",
		info = {
			Pods = {
				Vector(4,-105,-34),
				Vector(4,105,-34),
			},
			Sequential = true,
			FireRate = 18,
			Ammo = 12
		}
	},
	["2A42"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(87,-35,-37)
			},
			Sounds = {
				shoot = "ka52/2a42_loop.wav",
				stop = "ka52/2a42_lastshot.wav"
			},
			FireRate = 800,
			BulletType = "wac_base_30mm",
			TracerColor = "Green",
			Ammo = 460
		}
	},
	["9М39"] = {
		class = "wac_pod_vrocket_9m39",
		info = {
			Pods = {
				Vector(700,-123,-27),
				Vector(700,126.5,-27),
			},
			Ammo = 4,
			FaF = false,
			FireRate = 20,
			kind = "rocket_9m39"
		}
	},
}


ENT.Camera = {
	model = "models/ka52/Camera.mdl",
	pos = Vector(152.2,0.5,-53.5),
	offset = Vector(0,0,0),
	viewPos = Vector(10, 0, 0),
	maxAng = Angle(45, 90, 0),
	minAng = Angle(-2, -90, 0),
	seat = 2
}
ENT.WeaponAttachments = {
	CameraMount = {
		model = "models/ka52/camera_mount.mdl",
		pos = Vector(144,0.5,-50),
		restrictPitch = true,
	},
	b8v20_1 = {
		model = "models/sw/avia/bombs/b8v20.mdl",
		pos = Vector(-3,-76.3,-29.5),
		restrictPitch = true,
		restrictYaw = true,
	},
	b8v20_2 = {
		model = "models/sw/avia/bombs/b8v20.mdl",
		pos = Vector(-3,78.6,-29.5),
		restrictPitch = true,
		restrictYaw = true,
	},
	vyihr_launcher_1 = {
		model = "models/sw/avia/bombs/vyihr_launcher.mdl",
		pos = Vector(-6,106.5,-34),
		restrictPitch = true,
		restrictYaw = true,
	},
	vyihr_launcher_2 = {
		model = "models/sw/avia/bombs/vyihr_launcher.mdl",
		pos = Vector(-6,-104.7,-34),
		restrictPitch = true,
		restrictYaw = true,
	},
	z9m39_launcher_1 = {
		model = "models/ka52/9m39_launcher.mdl",
		pos = Vector(-4,-123,-27),
		restrictPitch = true,
		restrictYaw = true,
	},
	z9m39_launcher_2 = {
		model = "models/ka52/9m39_launcher.mdl",
		pos = Vector(-4,126.5,-27),
		restrictPitch = true,
		restrictYaw = true,
	},
}
ENT.Sounds={
	Start="ka52/start.wav",
	Blades="ka52/external.wav",
	Engine="ka52/exhaust.wav",
	MissileAlert="HelicopterVehicle/MissileNearby.mp3",
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

	cam.Start3D2D(self:LocalToWorld(Vector(20,3.8,37.75)+spos), ang,0.015)
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
	
	
	if self:GetNWInt("seat_2_actwep") == 1 and self.weapons["2A42"] then
		surface.SetTextPos(20,300)
		local n = self.weapons["2A42"]:GetAmmo()
		surface.DrawText("2A42" .. getspaces(n))
	end
	if self:GetNWInt("seat_1_actwep") == 1 and self.weapons["2A42"] then
		surface.SetTextPos(170,400)
		local n = self.weapons["2A42"]:GetAmmo()
		surface.DrawText("Оружие:2A42" .. getspaces(n))
	end
	if self:GetNWInt("seat_2_actwep") == 1 and self.weapons["С-8"] then
		surface.SetTextPos(20,320)
		local n = self.weapons["С-8"]:GetAmmo()
		surface.DrawText("С-8" .. getspaces(n))
	end
	if self:GetNWInt("seat_1_actwep") == 2 and self.weapons["С-8"] then
		surface.SetTextPos(170,400)
		local n = self.weapons["С-8"]:GetAmmo()
		surface.DrawText("Оружие:С-8" .. getspaces(n))
	end
	cam.End3D2D()
end

function ENT:DrawWeaponSelection() end
