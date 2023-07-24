--[[
Server Name: Доберман [&]
Server IP:   202.165.126.235:7004
File Path:   addons/core_weapons/lua/weapons/weapon_octo_p90.lua
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
SWEP.PrintName = 'P90'
SWEP.Author = ''

SWEP.Passive = 'passive'
SWEP.Active = 'smg'

SWEP.ReloadTime = 2.1
SWEP.Primary.Sound = Sound( 'weapons/p90/p90-1.wav' )
SWEP.Primary.Damage = math.random(19,28)
SWEP.Primary.RPM	= 1200
SWEP.Primary.ClipSize	= 50
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.KickUp = math.random(1,1.3)
SWEP.Primary.KickDown = 1.5
SWEP.Primary.KickHorizontal = 1.5
SWEP.Primary.Spread = 0.035
SWEP.Primary.Ammo = 'pistol'

SWEP.WorldModel = 'models/weapons/w_smg_p90.mdl'
SWEP.AimPos = Vector(-7, -1.03, 10.15)
SWEP.AimAng = Angle(-3, 2.2, 0)

SWEP.Slot = 3
SWEP.SlotPos = 1

SWEP.Icon = "octoteam/icons/weapon_p90.png"
SWEP.Volume = 5