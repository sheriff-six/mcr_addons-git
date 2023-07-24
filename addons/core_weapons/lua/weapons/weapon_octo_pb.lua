--[[
Server Name: Доберман [&]
Server IP:   202.165.126.235:7004
File Path:   addons/core_weapons/lua/weapons/weapon_octo_usps.lua
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
SWEP.PrintName = 'ПБ'
SWEP.Author = 'wh1t3'

SWEP.Passive = 'normal'
SWEP.Active = 'revolver'

SWEP.ReloadTime = 2.8
SWEP.Primary.Sound = Sound( "dbg/weapons/usp/usp1.wav" )
SWEP.Primary.DistantSound 		= Sound( "dbg/weapons/usp/usp1-distant.wav" )
SWEP.Primary.Damage = math.random(700,1000)
SWEP.Primary.RPM = 825
SWEP.Primary.ClipSize = 12
SWEP.Primary.DefaultClip = 0
SWEP.Primary.KickUp = 0.5
SWEP.Primary.KickDown = 0.5
SWEP.Primary.KickHorizontal = 0
SWEP.Primary.Spread = 0.01
SWEP.Primary.Ammo = 'pistol'
SWEP.Primary.Automatic = false

SWEP.WorldModel = 'models/weapons/w_pist_pmb.mdl'
SWEP.AimPos = Vector(-10.5, -1.13, 4.05)
SWEP.AimAng = Angle(-2, 5, 0)

SWEP.Slot = 3
SWEP.SlotPos = 1

SWEP.Icon = "octoteam/icons/weapon_usp_s.png"
SWEP.Volume = 3