//
SWEP.Base = "leafy_base"

SWEP.AdminSpawnable = true

SWEP.AutoSwitchTo = false
SWEP.Slot = 3
SWEP.PrintName = "Воинское приветствие"
SWEP.Author = "<color=190,0,0>Никита</color>"
SWEP.Spawnable = true
SWEP.AutoSwitchFrom = false
SWEP.Weight = 5
SWEP.DrawCrosshair = true
SWEP.CustomCrosshair = true
SWEP.CrossColor = Color( 0, 255, 0, 150 )
SWEP.Category = "Other"
SWEP.DrawWeaponInfoBox = false
SWEP.SlotPos = 1
SWEP.DrawAmmo = false
SWEP.HoldType = "normal"
SWEP.ViewModelFOV = 113
SWEP.ViewModelFlip = false
SWEP.ViewModel = "models/weapons/c_smg1.mdl"
SWEP.WorldModel = "models/weapons/c_pistol.mdl"
SWEP.UseHands = true
SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false
SWEP.LaserSight = 0
SWEP.Dissolve = 1

SWEP.IronsightTime = 0.1
SWEP.DisableMuzzle = 1
SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_R_Finger31"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 72.222, 0) },
	["ValveBiped.Bip01_R_Finger11"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 43.333, 0) },
	["ValveBiped.Bip01_L_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(0, -30, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_R_Finger42"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(18.888, 103.333, 0) },
	["ValveBiped.Bip01_R_Finger2"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(3.332, 25.555, 16.666) },
	["ValveBiped.Bip01_R_Finger22"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 47.777, -16.667) },
	["ValveBiped.Bip01_R_Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0.555, 0), angle = Angle(45.666, -12.667, 2.5332) },
	["ValveBiped.Bip01_R_Finger41"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 32.222, 7.777) },
	["ValveBiped.Bip01_R_Finger1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-10, 7.777, 1.11) },
	["ValveBiped.Bip01_R_Finger21"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(10, 101.111, 0) },
	["ValveBiped.base"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_R_Finger4"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(7.777, 23.333, 0) },
	["ValveBiped.Bip01_R_Forearm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-3.333, -15, 36.666) },
	["ValveBiped.Bip01_R_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(-15, 0.555, -7.223), angle = Angle(52.222, -76.667, -30) },
	["ValveBiped.Bip01_R_Finger12"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 61.111, 0) },
	["ValveBiped.Bip01_R_Finger32"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 63.333, 0) },
	["ValveBiped.Bip01"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_R_Finger3"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(7.777, 25.555, 18.888) },
	["ValveBiped.Bip01_R_Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(16.666, -12.223, -14.445) }
}

SWEP.IronSightsPos = Vector(-0, -7, 1.629)
SWEP.IronSightsAng = Vector(-1, 0, 0)

//SWEP.PrimaryReloadSound = Sound("Weapon_SMG1.Reload")
SWEP.PrimarySound = Sound("weapons/ar1/ar1_dist2.wav")

SWEP.Primary.Damage = 20
SWEP.Primary.TakeAmmo = 1
SWEP.Primary.ClipSize = -1
SWEP.Primary.Ammo = "ar2"
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Spread = 15
SWEP.Primary.Cone = 0.3
SWEP.IronCone = 0.1
SWEP.DefaultCone = 0.3
SWEP.Primary.NumberofShots = 1
SWEP.Primary.Automatic = true
SWEP.Primary.Recoil = 1.2
SWEP.Primary.Delay = 0.1
SWEP.Primary.Force = 3
SWEP.Tracer = 10
SWEP.CustomTracerName = "blu_pulse_tracer"
SWEP.ShotEffect = "blupulse_light"

SWEP.IronFOV = 70

--if CLIENT then

function SWEP:DoBones()
local FT = FrameTime()

local ply = self.Owner
local ang1 = ply:GetNWFloat("ang1")
local ang2 = ply:GetNWFloat("ang2")

	if IsValid(ply) then
		self.ViewModelBoneMods["ValveBiped.Bip01_R_UpperArm"].angle = Angle(75.222, -120.667*ang1, -100)
		self.ViewModelBoneMods["ValveBiped.Bip01_R_UpperArm"].pos = Vector(-9, -1.5*ang1, -5.223)
	end
end

--end

function SWEP:SecondThink()

local ply = self.Owner
local FT = FrameTime()

local ang1 = ply:GetNWFloat("ang1")
local ang2 = ply:GetNWFloat("ang2")

if self.Owner:KeyDown(IN_ATTACK) then
ply:SetNWFloat("ang1", Lerp(FT*15, ang1, 1) )
ply:SetNWFloat("ang2", Lerp(FT*15, ang1, 45) )
else
ply:SetNWFloat("ang1", Lerp(FT*5, ang1, 0) )
ply:SetNWFloat("ang2", Lerp(FT*5, ang2, 0) )
end

	if IsValid(ply) and SERVER then

		local bone = ply:LookupBone("ValveBiped.Bip01_R_UpperArm")
		if bone then
			ply:ManipulateBoneAngles( bone, Angle(80*ang1,-95*ang1,-77.5*ang1) )
		end

		local bone = ply:LookupBone("ValveBiped.Bip01_R_Forearm")
		if bone then
			ply:ManipulateBoneAngles( bone, Angle(35*ang1,-125*ang1,-5*ang1) )
		end

	end

end



function SWEP:Holster()
local ply = self.Owner
	if IsValid(ply) then

	if SERVER then
		self.ViewModelBoneMods["ValveBiped.Bip01_R_UpperArm"].angle = Angle(0, 0, 0)
		self.ViewModelBoneMods["ValveBiped.Bip01_L_UpperArm"].angle = Angle(0, 0, 0)

		local bone = ply:LookupBone("ValveBiped.Bip01_L_UpperArm")
		if bone then
			ply:ManipulateBoneAngles( bone, Angle(0,0,0) )
		end
		local bone = ply:LookupBone("ValveBiped.Bip01_Head1")
		if bone then
			ply:ManipulateBoneAngles( bone, Angle(0,0,0) )
		end
		local bone = ply:LookupBone("ValveBiped.Bip01_R_UpperArm")
		if bone then
			ply:ManipulateBoneAngles( bone, Angle(0,0,0) )
		end
		local bone = ply:LookupBone("ValveBiped.Bip01_R_Forearm")
		if bone then
			ply:ManipulateBoneAngles( bone, Angle(0,0,0) )
		end
	end
	end

	if CLIENT and IsValid(self.Owner) and self.Owner:IsPlayer() then
		local vm = self.Owner:GetViewModel()
		if IsValid(vm) then
			self:ResetBonePositions(vm)
		end
	end

return true
end


function SWEP:PrimaryAttack()

end

function SWEP:Reload()

end

SWEP.NxtSec = 0

function SWEP:SecondaryAttack()

local randomsounds = {
  	"grandprix/rec_1serro.mp3",
  	"grandprix/rec_2serro.mp3",
	"grandprix/rec_1svenner.mp3",
	"grandprix/rec_2svenner.mp3",
	"grandprix/rec_1smaza.mp3",
	"grandprix/rec_2smaza.mp3"
}
local random = math.random(1, #randomsounds)
self.Weapon:EmitSound(randomsounds[random])
end

function SWEP:QuadsHere()
end

SWEP.VElements = {
}
SWEP.WElements = {
}
