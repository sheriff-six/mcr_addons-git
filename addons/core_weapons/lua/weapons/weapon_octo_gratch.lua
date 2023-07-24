--[[
Server Name: Доберман [&]
Server IP:   202.165.126.235:7004
File Path:   addons/core_weapons/lua/weapons/weapon_octo_p228.lua
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
SWEP.PrintName = 'Грач'
SWEP.Author = ''

SWEP.Passive = 'normal'
SWEP.Active = 'revolver'

SWEP.ReloadTime = 1.5
SWEP.Primary.Sound = Sound( 'weapons/p228/p228-1.wav' )
SWEP.Primary.Damage = math.random(24,40)
SWEP.Primary.RPM = 560
SWEP.Primary.ClipSize = 12
SWEP.Primary.DefaultClip = 0
SWEP.Primary.KickUp = math.random(2,3)
SWEP.Primary.KickDown = 2
SWEP.Primary.KickHorizontal = math.random(2,3)
SWEP.Primary.Spread = 0.01
SWEP.Primary.Ammo = 'pistol'
SWEP.Primary.Automatic = false

SWEP.WorldModel = 'models/weapons/act3/pistol_grach.mdl'
SWEP.AimPos = Vector(-10.5, -1.16, 4.15)
SWEP.AimAng = Angle(-2, 5, 0)

SWEP.Slot = 3
SWEP.SlotPos = 1

SWEP.Icon = "octoteam/icons/weapon_p228.png"
SWEP.Volume = 2