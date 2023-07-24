--[[
Server Name: Доберман [&]
Server IP:   202.165.126.235:7004
File Path:   addons/core_weapons/lua/weapons/weapon_octo_m4a1.lua
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
SWEP.PrintName = 'M4A1'
SWEP.Author = ''

SWEP.Passive = 'passive'
SWEP.Active = 'ar2'

SWEP.ReloadTime = 2.1
SWEP.Primary.Sound = Sound( 'weapons/m4a1/m4a1_unsil-1.wav' )
SWEP.Primary.Damage = 30
SWEP.Primary.RPM = 900
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 0
SWEP.Primary.KickUp = 2
SWEP.Primary.KickDown = 0.3
SWEP.Primary.KickHorizontal = 0.3
SWEP.Primary.Spread = 0.01
SWEP.Primary.Ammo = 'smg1'

SWEP.WorldModel = 'models/weapons/w_rif_m4a1.mdl'
SWEP.AimPos = Vector(-8, -0.97, 5.9)
SWEP.AimAng = Angle(-9, 0, 0)

SWEP.Slot = 3
SWEP.SlotPos = 1

SWEP.Icon = "octoteam/icons/weapon_m4a1.png"
SWEP.Volume = 7