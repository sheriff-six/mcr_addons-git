--[[
Server Name: Доберман [&]
Server IP:   202.165.126.235:7004
File Path:   addons/core_weapons/lua/weapons/weapon_octo_ump45.lua
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
SWEP.PrintName = 'ПП-Витязь'
SWEP.Author = ''

SWEP.Passive = 'passive'
SWEP.Active = 'smg'

SWEP.ReloadTime = 2.1
SWEP.Primary.Sound = Sound( 'weapons/ump45/ump45-1.wav' )
SWEP.Primary.Damage = math.random(30,42)
SWEP.Primary.RPM = 900
SWEP.Primary.ClipSize = 25
SWEP.Primary.DefaultClip = 0
SWEP.Primary.KickUp = 1
SWEP.Primary.KickDown = 1
SWEP.Primary.KickHorizontal = 1
SWEP.Primary.Spread = 0.01
SWEP.Primary.Ammo		= 'pistol'

SWEP.WorldModel = 'models/weapons/w_smg_vityaz.mdl'
SWEP.AimPos = Vector(-7, -0.8, 5.4)
SWEP.AimAng = Angle(-9.5, 0, 0)

SWEP.Slot = 3
SWEP.SlotPos = 1

SWEP.Icon = "octoteam/icons/weapon_ump45.png"
SWEP.Volume = 4.5