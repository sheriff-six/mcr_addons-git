--[[
Server Name: Доберман [&]
Server IP:   202.165.126.235:7004
File Path:   addons/core_weapons/lua/weapons/weapon_octo_awp.lua
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
SWEP.PrintName = 'AWP'
SWEP.Author = ''

SWEP.Passive = 'passive'
SWEP.Active = 'ar2'

SWEP.ReloadTime = 2.5
SWEP.Primary.Sound = Sound( 'weapons/awp/awp1.wav' )
SWEP.Primary.Damage = 103
SWEP.Primary.RPM = 60
SWEP.Primary.ClipSize = 10
SWEP.Primary.DefaultClip = 0
SWEP.Primary.KickUp = 2.3
SWEP.Primary.KickDown = 2.3
SWEP.Primary.KickHorizontal = 1.5
SWEP.Primary.Spread = 0.0001
SWEP.Primary.Ammo = 'smg1'
SWEP.Primary.Automatic = false

SWEP.WorldModel = 'models/weapons/w_rif_sks.mdl'

SWEP.Slot = 3
SWEP.SlotPos = 1

SWEP.AimPos = Vector(-3, -0.8, 6.5)
SWEP.AimAng = Angle(-11, 0, 0)
SWEP.SightPos = Vector(-0.52, -0.78, 6.88)
SWEP.SightAng = Angle(0, -90, 100)
SWEP.SightSize = 1.5
SWEP.SightFOV = 10
SWEP.SightZNear = 50

SWEP.Icon = 'octoteam/icons/weapon_awp.png'
SWEP.Volume = 0