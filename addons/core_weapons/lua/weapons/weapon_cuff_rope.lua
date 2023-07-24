AddCSLuaFile()

SWEP.Base = "weapon_cuff_base"

SWEP.Category = "Полиция"
SWEP.Author = ""
SWEP.Instructions = ""

SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.AdminSpawnable = true

SWEP.Slot = 1
SWEP.PrintName = "Веревка"

//
// Handcuff Vars
SWEP.CuffTime = 0.8 // Seconds to handcuff
SWEP.CuffSound = Sound( "buttons/lever7.wav" )

SWEP.CuffMaterial = "models/props_foliage/tree_deciduous_01a_trunk"
SWEP.CuffRope = "cable/rope"
SWEP.CuffStrength = 2
SWEP.CuffRegen = 0.9
SWEP.RopeLength = 60
SWEP.CuffReusable = false

SWEP.CuffBlindfold = true
SWEP.CuffGag = true

SWEP.CuffStrengthVariance = 0.1 // Randomise strangth
SWEP.CuffRegenVariance = 0.2 // Randomise regen
