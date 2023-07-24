--[[
Server Name: Доберман [&]
Server IP:   202.165.126.235:7004
File Path:   addons/core_weapons/lua/weapons/weapon_octo_m3.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

SWEP.Base = 'weapon_octo_base'
SWEP.Category = 'Оружие'
SWEP.Spawnable = true
SWEP.DrawCrosshair		= false
SWEP.PrintName = 'M3'
SWEP.Author = ''

SWEP.Passive = 'passive'
SWEP.Active = 'ar2'

SWEP.Primary.Sound = Sound( 'weapons/m3/m3-1.wav' )
SWEP.Primary.Damage = 8
SWEP.Primary.RPM = 80
SWEP.Primary.ClipSize = 7
SWEP.Primary.DefaultClip = 0
SWEP.Primary.NumShots = 6
SWEP.Primary.KickUp = 12
SWEP.Primary.KickDown = 6
SWEP.ReloadTime = 2.6
SWEP.Primary.KickHorizontal = math.random(15,19)
SWEP.Primary.Spread = 0.02
SWEP.Primary.Ammo = 'buckshot'
SWEP.Primary.Automatic = true

SWEP.WorldModel = 'models/weapons/w_shot_m3super90.mdl'
SWEP.AimPos = Vector(-5, -0.94, 4.6)
SWEP.AimAng = Angle(-9, 0, 0)

SWEP.Slot = 3
SWEP.SlotPos = 1

SWEP.Icon = "octoteam/icons/weapon_m3.png"
SWEP.Volume = 7