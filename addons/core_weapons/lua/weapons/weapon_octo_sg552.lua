--[[
Server Name: Доберман [&]
Server IP:   202.165.126.235:7004
File Path:   addons/core_weapons/lua/weapons/weapon_octo_sg552.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

DEFINE_BASECLASS( 'weapon_octo_base' )
SWEP.Category = 'Оружие'
SWEP.Spawnable = true
SWEP.DrawCrosshair		= false
SWEP.PrintName = 'SG552'
SWEP.Author = ''

SWEP.Passive = 'passive'
SWEP.Active = 'ar2'

SWEP.ReloadTime = 2.1
SWEP.Primary.Sound = Sound( 'weapons/sg552/sg552-1.wav' )
SWEP.Primary.Damage = 33
SWEP.Primary.RPM = 750
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 0
SWEP.Primary.KickUp = 1
SWEP.Primary.KickDown = 1
SWEP.Primary.KickHorizontal = 1
SWEP.Primary.Spread = 0.0005
SWEP.Primary.Ammo = 'smg1'

SWEP.WorldModel = 'models/weapons/w_rif_sg552.mdl'

SWEP.Slot = 3
SWEP.SlotPos = 1

SWEP.AimPos = Vector(-4, -0.89, 5.6)
SWEP.AimAng = Angle(-9, 0, 0)
SWEP.SightPos = Vector(-0.1, -0.89, 6.35)
SWEP.SightAng = Angle(0, -90, 100)
SWEP.SightSize = 1.5
SWEP.SightFOV = 14
SWEP.SightZNear = 50

SWEP.Icon = "octoteam/icons/weapon_sg552.png"
SWEP.Volume = 10