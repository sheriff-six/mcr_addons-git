if not wac then return end
if SERVER then AddCSLuaFile('shared.lua') end
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

ENT.Base 				= "wac_pl_base"
ENT.Type 				= "anim"
ENT.Category			= "Самолёты"
ENT.PrintName			= "Su-25 Loadout 7"
ENT.Author				= "Vetrov"

ENT.Spawnable			= true
ENT.AdminSpawnable		= true

ENT.Model	    = "models/su25WAC/su25wac.mdl"
ENT.RotorModel	= "models/su25WAC/rotor.mdl"
ENT.RotorModel2	= "models/su25WAC/rotor.mdl"

ENT.rotorPos	= Vector(32,32,68)
ENT.rotorPos2	= Vector(32,-32,68)

ENT.TopRotorDir	= 1
ENT.MaxEnterDistance 	= 100
ENT.EngineForce        = 10000
ENT.Weight            = 18825
ENT.SeatSwitcherPos	= Vector(0,0,0)
ENT.AngBrakeMul	= 0.02
ENT.SmokePos	= Vector(-149.5,57.4,129)
ENT.FirePos	    = Vector(-50,0,100)

if CLIENT then
	ENT.thirdPerson = {
		distance = 700
	}
end
ENT.Agility = {
	Thrust = 18
}
ENT.Wheels={
	{
		mdl="models/su25WAC/WheelF.mdl",
		pos=Vector(87,0,13),
		friction=10,
		mass=4000,
	},
	{
		mdl="models/su25WAC/WheelL.mdl",
		pos=Vector(-35,46,12.5),
		friction=10,
		mass=1200,
	},
	{
		mdl="models/su25WAC/WheelR.mdl",
		pos=Vector(-35,-42,12.5),
		friction=10,
		mass=1200,

	},
}

ENT.Seats = {
	{
		pos=Vector(117,0,64),
		exit=Vector(125,145,45),
		weapons = {"ГШ-30-2","ФАБ-500М-62","ФАБ-250М-62","Р-60",}
	},
}

ENT.Weapons = {
	["ГШ-30-2"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(205,15,42),
				Vector(205,13,43),
			},
			Ammo = 250,
			BulletType = "wac_base_30mm",
			FireRate = 3000,
			Sounds = {
				shoot = "su25lfs/gun_loop.wav",
				stop = "su25lfs/gun_lastshot.wav"
			}
		}
	},
	["ФАБ-250М-62"] = {
		class = "wac_pod_gbomb",
		info = {
			Sequential = true,
			Pods = {
				Vector(-38, 139.3, 57),
				Vector(-38, -139.3, 57),
				Vector(-46, 170, 56),
				Vector(-46, -170, 56),

			},
			FireRate = 500,
			Kind = "bomb_fab250m62_wac"
		},
	},
	["ФАБ-500М-62"] = {
		class = "wac_pod_gbomb",
		info = {
			Sequential = true,
			Pods = {
				Vector(-40, 108.4, 56.4),
				Vector(-30, -77.5, 57	),
				Vector(-40, -108.4, 56.4),
				Vector(-30, 77.5, 57),

			},
			FireRate = 500,
			Kind = "bomb_fab500m62_wac"
		},
	},

	["Р-60"] = {
		class = "sw_pod_r60_wac",
		info = {
			Sequential = true,
			FaF = false,
			Pods = {
				Vector (-52, 200.3, 58),
				Vector(-52, -200.3, 58),
			},
			Ammo = 2,
			FireRate = 60,	
		},
	},
}

ENT.WeaponAttachments = {
	R_60_1 = {
		model = "models/sw/avia/bombs/r60.mdl",
		pos = Vector(-52, -200.3, 58),
		restrictPitch = true,
		restrictYaw = true,
	},
	R_60_2 = {
		model = "models/sw/avia/bombs/r60.mdl",
		pos = Vector(-52, 200.3, 58),
		restrictPitch = true,
		restrictYaw = true,
	},
}



ENT.Sounds={
	Start="su25lfs/start.wav",
	Blades="su25lfs/jet_engine_far.wav",
	Engine="su25lfs/jet_engine_2rpm.wav",
	MissileAlert="HelicopterVehicle/MissileNearby.mp3",
	MissileShoot="HelicopterVehicle/MissileShoot.mp3",
	MinorAlarm="WAC/Heli/fire_alarm_tank.wav",
	LowHealth="WAC/Heli/fire_alarm.wav",
	CrashAlarm="WAC/Heli/laser_warning.wav"
}

ENT.Camera = {
	model = "models/mm1/box.mdl",
	pos = Vector(250,0,44),
	offset = Vector(-1,0,0),
	viewPos = Vector(2,0,0),
	minAng = Angle(0, -45, 0),
	maxAng = Angle(80, 45, 0),
	seat = 1
}

//hud
function ENT:DrawWeaponSelection()
	local fwd = self:GetForward()
	local ri = self:GetRight()
	local ang = self:GetAngles()
	local Black = Color( 0, 0, 0, 200 )
	ang:RotateAroundAxis(ri, 90)
	ang:RotateAroundAxis(fwd, 90)
	for k, t in pairs(self.Seats) do
		if k != "BaseClass" and self:getWeapon(k) then
			cam.Start3D2D(self:LocalToWorld(Vector(17,5,25)*self.Scale + t.pos), ang, 0.02*self.Scale)
			surface.DrawRect(-10, 0, 500, 30)
			surface.DrawRect(-10, 30, 10, 20)
			local weapon = self:getWeapon(k)
			local lastshot = weapon:GetLastShot()
			local nextshot = weapon:GetNextShot()
			local ammo = weapon:GetAmmo()
			draw.SimpleText(k.." "..t.weapons[self:GetNWInt("seat_"..k.."_actwep")], "wac_heli_big", 0, -2.5, Black, 0)
			draw.SimpleText(ammo, "wac_heli_big", 480, -2.5, Black, 2)
			cam.End3D2D()
		end
	end
end
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

	cam.Start3D2D(self:LocalToWorld(Vector(29,3.75,35)+spos), ang,0.015)
	surface.SetDrawColor(HudCol)
	surface.DrawRect(234, 110, 10, 4)
	surface.DrawRect(247, 95, 4, 10)
	surface.DrawRect(247, 117, 4, 10)
	surface.DrawRect(254, 110, 10, 4)

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

	surface.SetTextPos(110, 410) 
	surface.DrawText("Скорость"..math.floor(self:GetVelocity():Length()*0.1) .."kn")
	surface.SetTextPos(300, 410)
	local tr=util.QuickTrace(pos+self:GetUp()*10,Vector(0,0,-999999),self.Entity)
	surface.DrawText("Высота"..math.ceil((pos.z-tr.HitPos.z)*0.01905).."m")

	if self:GetNWInt("seat_1_actwep") == 1 and self.weapons["ГШ-30-2"] then
		surface.SetTextPos(170,450)
		local n = self.weapons["ГШ-30-2"]:GetAmmo()
		surface.DrawText("Оружие:ГШ-30-2" .. getspaces(n))
	end

	if self:GetNWInt("seat_1_actwep") == 3 and self.weapons["ФАБ-250М-62"] then
		surface.SetTextPos(150,450)
		local n = self.weapons["ФАБ-250М-62"]:GetAmmo()
		surface.DrawText("Оружие:ФАБ-250М-62" .. getspaces(n))
	end

	if self:GetNWInt("seat_1_actwep") == 2 and self.weapons["ФАБ-500М-62"] then
		surface.SetTextPos(170,450)
		local n = self.weapons["ФАБ-500М-62"]:GetAmmo()
		surface.DrawText("Оружие:ФАБ-500М-62" .. getspaces(n))
	end

	if self:GetNWInt("seat_1_actwep") == 4 and self.weapons["Р-60"] then
		surface.SetTextPos(170,450)
		local n = self.weapons["Р-60"]:GetAmmo()
		surface.DrawText("Оружие:Р-60" .. getspaces(n))
	end

	cam.End3D2D()
end

function ENT:DrawWeaponSelection() end
