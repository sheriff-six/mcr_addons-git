if SERVER then
	AddCSLuaFile()
end

SWEP.Base 			= 'weapon_base'
SWEP.Category		= 'Junk'
SWEP.PrintName		= 'Рация'
SWEP.Instructions 	= ''
SWEP.Slot			= 1
SWEP.SlotPos		= 9
SWEP.DrawAmmo		= false
SWEP.DrawCrosshair	= true
SWEP.ViewModelFlip	= false
SWEP.ViewModelFOV	= 62
SWEP.ViewModel		= ''
SWEP.WorldModel		= 'models/realistic_police/radio/w_radio.mdl'
SWEP.HoldType		= 'normal'
SWEP.UseHands	   = true
SWEP.AutoSwitchTo	= false
SWEP.AutoSwitchFrom	= false
SWEP.Spawnable		= true
SWEP.AdminOnly		= true
SWEP.Author			= 'Junk'
SWEP.Contact		= ''
SWEP.Purpose		= ''

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ''

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ''

function SWEP:Holster()
	return true
end

function SWEP:Initialize()
	self:SetHoldType('normal')
end

function SWEP:Equip(ply)
	ply:ConnectRadio()
end

function SWEP:PrimaryAttack()
end

function SWEP:SecondaryAttack()
end

function SWEP:DrawWorldModel()
end