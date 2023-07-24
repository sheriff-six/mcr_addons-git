--[[
Server Name: Доберман [&]
Server IP:   202.165.126.235:7004
File Path:   addons/core_weapons/lua/weapons/weapon_octo_beanbag.lua
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
SWEP.PrintName = 'Bean Bag'
SWEP.Author = ''

SWEP.Passive = 'passive'
SWEP.Active = 'ar2'

SWEP.Primary.Sound = Sound( 'weapons/mortar/mortar_fire1.wav' )
SWEP.Primary.Damage = 1
SWEP.Primary.RPM = 310
SWEP.Primary.ClipSize = 7
SWEP.Primary.DefaultClip = 0
SWEP.Primary.NumShots = 8
SWEP.Primary.KickUp = 5
SWEP.Primary.KickDown = 4.9
SWEP.ReloadTime = 2.6
SWEP.Primary.KickHorizontal = math.random(2,3)
SWEP.Primary.Spread = 0.01
SWEP.Primary.Ammo = 'buckshot'
SWEP.Primary.Automatic = true

SWEP.WorldModel = 'models/weapons/w_shot_m3super90_beanbag.mdl'
SWEP.AimPos = Vector(-5, -0.94, 4.2)
SWEP.AimAng = Angle(-9, 0, 0)

SWEP.Slot = 3
SWEP.SlotPos = 1

SWEP.Icon = "octoteam/icons/gun_shotgun.png"
SWEP.Volume = 4.5