--[[
Server Name: Доберман [&]
Server IP:   202.165.126.235:7004
File Path:   addons/core_weapons/lua/weapons/weapon_octo_usp.lua
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
SWEP.PrintName = 'ПМ'
SWEP.Author = ''

SWEP.Passive = 'normal'
SWEP.Active = 'revolver'

SWEP.ReloadTime = 2.8
SWEP.Primary.Sound = Sound( "dbg/weapons/p228/p228-1.wav" )
SWEP.Primary.DistantSound 		= Sound( "dbg/weapons/p228/p228-1-distant.wav" )
SWEP.Primary.Damage = math.random(40,65)
SWEP.Primary.RPM = 620
SWEP.Primary.ClipSize = 8
SWEP.Primary.DefaultClip = 0
SWEP.Primary.KickUp = 1
SWEP.Primary.KickDown = 1
SWEP.Primary.KickHorizontal = 2
SWEP.Primary.Spread = 0.01
SWEP.Primary.Ammo = 'pistol'
SWEP.Primary.Automatic = false

SWEP.WorldModel = 'models/weapons/w_pist_p228.mdl'
SWEP.AimPos = Vector(-10.5, -1, 3.5)
SWEP.AimAng = Angle(-2, 8, 0)

SWEP.Slot = 3
SWEP.SlotPos = 1

SWEP.Icon = "octoteam/icons/weapon_usp.png"
SWEP.Volume = 2.5