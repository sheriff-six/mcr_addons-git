--[[
Server Name: Доберман [&]
Server IP:   202.165.126.235:7004
File Path:   addons/core_weapons/lua/weapons/weapon_octo_xm1014.lua
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
SWEP.PrintName = 'XM1014'
SWEP.Author = ''

SWEP.Passive = 'passive'
SWEP.Active = 'ar2'

SWEP.Primary.Sound = Sound( 'weapons/xm1014/xm1014-1.wav' )
SWEP.Primary.Damage = math.random(9, 12)
SWEP.Primary.RPM = 210
SWEP.Primary.ClipSize = 7
SWEP.Primary.DefaultClip = 0
SWEP.Primary.NumShots = 5
SWEP.Primary.KickUp = 3
SWEP.Primary.KickDown = 3
SWEP.ReloadTime = 2.6
SWEP.Primary.KickHorizontal = 4
SWEP.Primary.Spread = 0.03
SWEP.Primary.Ammo = 'buckshot'
SWEP.Primary.Automatic = false

SWEP.WorldModel = 'models/weapons/w_shot_xm1014.mdl'
SWEP.AimPos = Vector(-5, -0.8, 4.2)
SWEP.AimAng = Angle(-9, 0, 0)


SWEP.Slot = 3
SWEP.SlotPos = 1

SWEP.Icon = "octoteam/icons/weapon_xm1014.png"
SWEP.Volume = 6.5