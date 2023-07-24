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
SWEP.PrintName = 'AK-74'
SWEP.Author = ''

SWEP.Passive = 'passive'
SWEP.Active = 'ar2'

SWEP.ReloadTime = 2.1
SWEP.Primary.Sound 				= Sound( "weapons/cw_ak74m/ak74m.wav")
SWEP.Primary.Damage = 60
SWEP.Primary.RPM = 925
SWEP.Recoil = 25
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 300
SWEP.Primary.KickUp = 1.2
SWEP.Primary.KickDown = 1.2
SWEP.Primary.KickHorizontal = 1.2
SWEP.Primary.Spread = 0.08
SWEP.Primary.Ammo = 'smg1'

SWEP.WorldModel = 'models/weapons/w_rif_ak74m.mdl'
SWEP.AimPos = Vector(-2.5, -1, 5.5)
SWEP.AimAng = Angle(-9, 0, 0)

SWEP.Slot                       = 3
SWEP.SlotPos                    = 1

SWEP.Icon = 'octoteam/icons/gun_rifle.png'
SWEP.Volume = 6