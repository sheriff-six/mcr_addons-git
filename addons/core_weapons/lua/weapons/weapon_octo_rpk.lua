--[[
Server Name: Доберман [&]
Server IP:   202.165.126.235:7004
File Path:   addons/core_weapons/lua/weapons/weapon_octo_ak.lua
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
SWEP.PrintName = 'РПК-74'
SWEP.Author = ''

SWEP.Passive = 'passive'
SWEP.Active = 'ar2'

SWEP.ReloadTime = 2.5
SWEP.Primary.Sound 				= Sound( "dbg/weapons/ak47/cv47-1.wav" )
SWEP.Primary.DistantSound 		= Sound( "dbg/weapons/ak47/cv47-1-distant.wav" )
SWEP.Primary.Damage = 120
SWEP.Primary.RPM = 925
SWEP.Primary.ClipSize = 500
SWEP.Primary.DefaultClip = 300
SWEP.Primary.KickUp = 1.2
SWEP.Primary.KickDown = 1.2
SWEP.Primary.KickHorizontal = 1.2
SWEP.Primary.Spread = 0.01
SWEP.Primary.Ammo = 'smg1'

SWEP.WorldModel = 'models/weapons/w_mach_rpk74.mdl'
SWEP.AimPos = Vector(-4, -1.09, 4.5)
SWEP.AimAng = Angle(-9, 0, 0)

SWEP.Slot                       = 3
SWEP.SlotPos                    = 1

SWEP.Icon = 'octoteam/icons/gun_rifle.png'
SWEP.Volume = 6