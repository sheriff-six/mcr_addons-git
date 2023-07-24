--[[
Server Name: Доберман [&]
Server IP:   202.165.126.235:7004
File Path:   addons/core_weapons/lua/weapons/weapon_octo_hook.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]


AddCSLuaFile()

SWEP.Category			= "Оружие"
SWEP.Spawnable			= true
SWEP.AdminSpawnable	= false
SWEP.PrintName			= "Крюк"

SWEP.Slot				= 3
SWEP.SlotPos				= 1

SWEP.Spawnable				= true

SWEP.ViewModel				= Model( "models/weapons/HL2meleepack/v_hook.mdl" )
SWEP.WorldModel				= Model( "models/weapons/HL2meleepack/w_hook.mdl" )
SWEP.ViewModelFOV			= 67
SWEP.UseHands				= true

SWEP.Primary.ClipSize		= 0
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false

SWEP.Secondary.ClipSize		= 0
SWEP.Secondary.DefaultClip	= 0
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.DrawAmmo			= false

SWEP.Primary.Ammo		= 'sharp'
SWEP.HitDistance		= 50
SWEP.HitInclination	= 0.4
SWEP.HitPushback		= -1000
SWEP.HitRate			= 1.25
SWEP.MinDamage			= 34
SWEP.MaxDamage			= 50
SWEP.ScareMultiplier	= 0.7

SWEP.Icon				= 'octoteam/icons/crowbar.png'

local SwingSound = Sound( "WeaponFrag.Roll" )
local HitSoundWorld = Sound( "Canister.ImpactHard" )
local HitSoundBody = Sound( "Flesh.Break" )
local PushSoundBody = Sound( "Flesh.ImpactSoft" )

function SWEP:Initialize()

	self:SetHoldType( "melee2" )
end

function SWEP:PrimaryAttack()

	self.Owner:SetAnimation( PLAYER_ATTACK1 )

	local vm = self.Owner:GetViewModel()
	
	self:EmitSound( SwingSound )
	self.Weapon:SetNextPrimaryFire( CurTime() + self.HitRate )
	self.Weapon:SetNextSecondaryFire( CurTime() + self.HitRate )

	vm:SendViewModelMatchingSequence( vm:LookupSequence( "misscenter1" ) )

	timer.Create("hitdelay", 0.4, 1, function() self:Hitscan() end)

	timer.Start( "hitdelay" )

end

function SWEP:SecondaryAttack()

	self.Weapon:SetNextPrimaryFire( CurTime() + 0.35 )
	self.Weapon:SetNextSecondaryFire( CurTime() + 1.0 )

	self:EmitSound( SwingSound )

	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence( vm:LookupSequence( "pushback" ) )

	local tr = util.TraceLine( {
		start = self.Owner:GetShootPos(),
		endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 1.5 * 40,
		filter = self.Owner,
		mask = MASK_SHOT_HULL
	} )

	if ( tr.Hit ) then
	self:EmitSound( PushSoundBody )
	if tr.Entity:IsPlayer() or string.find(tr.Entity:GetClass(),"npc") or string.find(tr.Entity:GetClass(),"prop_ragdoll") or string.find(tr.Entity:GetClass(),"prop_physics") then
	tr.Entity:SetVelocity( self.Owner:GetAimVector() * Vector( 1, 1, 0 ) * 500 )
	end
	end

end

function SWEP:OnDrop()

	
end

function SWEP:Hitscan()

//This function calculate the trajectory

	for i=0, 170 do

	local tr = util.TraceLine( {
		start = (self.Owner:GetShootPos() - (self.Owner:EyeAngles():Up() * 10)),
		endpos = (self.Owner:GetShootPos() - (self.Owner:EyeAngles():Up() * 10)) + ( self.Owner:EyeAngles():Up() * ( self.HitDistance * 0.7 * math.cos(math.rad(i)) ) ) + ( self.Owner:EyeAngles():Forward() * ( self.HitDistance * 1.5 * math.sin(math.rad(i)) ) ) + ( self.Owner:EyeAngles():Right() * self.HitInclination * self.HitDistance * math.cos(math.rad(i)) ),
		filter = self.Owner,
		mask = MASK_SHOT_HULL
	} )

//This if shot the bullets

	if ( tr.Hit ) then
		
		local strikevector = ( self.Owner:EyeAngles():Up() * ( self.HitDistance * 0.5 * math.cos(math.rad(i)) ) ) + ( self.Owner:EyeAngles():Forward() * ( self.HitDistance * 1.5 * math.sin(math.rad(i)) ) ) + ( self.Owner:EyeAngles():Right() * self.HitInclination * self.HitDistance * math.cos(math.rad(i)) )

		bullet = {}
		bullet.Num    = 1
		bullet.Src    = (self.Owner:GetShootPos() - (self.Owner:EyeAngles():Up() * 15))
		bullet.Dir    = strikevector:GetNormalized()
		bullet.Spread = Vector(0, 0, 0)
		bullet.Tracer = 0
		bullet.Force  = 5
		bullet.Hullsize = 0
		bullet.Distance = self.HitDistance * 1.5
		bullet.Damage = math.random( 34, 50 )
		self.Owner:FireBullets(bullet)

		//local vPoint = (self.Owner:GetShootPos() - (self.Owner:EyeAngles():Up() * 10))
		//local effectdata = EffectData()
		//effectdata:SetOrigin( vPoint )
		//util.Effect( "BloodImpact", effectdata )

		self:EmitSound( SwingSound )

		//vm:SendViewModelMatchingSequence( vm:LookupSequence( "hitcenter1" ) )

		if tr.Entity:IsPlayer() or string.find(tr.Entity:GetClass(),"npc") or string.find(tr.Entity:GetClass(),"prop_ragdoll") then
			self:EmitSound( HitSoundBody )
			tr.Entity:SetVelocity( self.Owner:GetAimVector() * Vector( 1, 1, 0 ) * self.HitPushback )
		else
			self:EmitSound( HitSoundWorld )
		end
//if break
		break
//if end
		//else vm:SendViewModelMatchingSequence( vm:LookupSequence( "misscenter1" ) )
		end
end

end

function SWEP:Deploy()

	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence( vm:LookupSequence( "draw" ) )
	
	self.Weapon:SetNextPrimaryFire( CurTime() + 0.5 )
	self.Weapon:SetNextSecondaryFire( CurTime() + 0.5 )
	
	return true
end

function SWEP:Holster()

	return true
end

function SWEP:OnRemove()
	
	timer.Remove("hitdelay")
	return true
end