--[[
Server Name: Доберман [&]
Server IP:   202.165.126.235:7004
File Path:   addons/core_weapons/lua/weapons/weapon_octo_bottle.lua
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
SWEP.PrintName			= 'Бутылка'

SWEP.Slot				= 3
SWEP.SlotPos				= 1

SWEP.Spawnable				= true

SWEP.ViewModel				= Model( "models/weapons/HL2meleepack/v_bottle.mdl" )
SWEP.WorldModel				= Model( "models/weapons/HL2meleepack/w_bottle.mdl" )
SWEP.ViewModelFOV			= 62
SWEP.UseHands				= true

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo		= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.DrawAmmo			= false

SWEP.Primary.Ammo		= 'sharp'
SWEP.HitDistance		= 35
SWEP.HitInclination	= 0.2
SWEP.HitPushback		= 100
SWEP.HitRate			= 0.50
SWEP.MinDamage			= 30
SWEP.MaxDamage			= 38
SWEP.ScareMultiplier	= 0.2

SWEP.Icon				= 'octoteam/icons/bottle.png'

local SwingSound = Sound( "WeaponFrag.Roll" )
local HitSoundWorld = Sound( "GlassBottle.Break" )
local HitSoundBody = Sound( "GlassBottle.Break" )

function SWEP:Initialize()

	self:SetHoldType( "melee" )
end

function SWEP:PrimaryAttack()

	self.Owner:SetAnimation( PLAYER_ATTACK1 )

	local vm = self.Owner:GetViewModel()
	
	self:EmitSound( SwingSound )
	self.Weapon:SetNextPrimaryFire( CurTime() + self.HitRate )
	self.Weapon:SetNextSecondaryFire( CurTime() + self.HitRate )

	vm:SendViewModelMatchingSequence( vm:LookupSequence( "misscenter1" ) )

	timer.Create("hitdelay", 0.2, 1, function() self:Hitscan() end)

	timer.Start( "hitdelay" )

end

function SWEP:SecondaryAttack()

	self.Weapon:SetNextSecondaryFire( CurTime() + 1 )

	self.Owner:SetAnimation( PLAYER_ATTACK1 )

	self:EmitSound( SwingSound )

	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence( vm:LookupSequence( "misscenter1" ) )

	timer.Create("throwdelay", 0.2, 1, function() self:Throwbottle() end)

	timer.Start( "throwdelay" )
	
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
		bullet.Force  = 10
		bullet.Hullsize = 0
		bullet.Distance = self.HitDistance * 1.5
		bullet.Damage = math.random( self.MinDamage, self.MaxDamage )

		self.Owner:FireBullets(bullet)

		self:EmitSound( SwingSound )

		//vm:SendViewModelMatchingSequence( vm:LookupSequence( "hitcenter1" ) )

		if tr.Entity:IsPlayer() or string.find(tr.Entity:GetClass(),"npc") or string.find(tr.Entity:GetClass(),"prop_ragdoll") then
			self:EmitSound( HitSoundBody )
			tr.Entity:SetVelocity( self.Owner:GetAimVector() * Vector( 1, 1, 0 ) * self.HitPushback )
		else
			self:EmitSound( HitSoundWorld )
		end

		if (SERVER) then self.Owner:Give("weapon_octo_bottle_broken")
			self.Owner:SelectWeapon("weapon_octo_bottle_broken")
			self.Owner:StripWeapon("weapon_octo_bottle")
		end
//if break
		break

//if end
		//else vm:SendViewModelMatchingSequence( vm:LookupSequence( "misscenter1" ) )
		end
end

end

function SWEP:Throwbottle()

	if not SERVER then return false end

	local ent = ents.Create( "prop_physics" )

	if ( !IsValid( ent ) ) then return end
	
	ent:SetModel( "models/props_junk/garbage_glassbottle003a.mdl" )
	ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * 20 ) )
	ent:SetAngles( self.Owner:EyeAngles() - Angle( 0, 50, 190 ) )
	ent:Spawn()

	local phys = ent:GetPhysicsObject();
 
	//local shot_length = tr.HitPos:Length();
	phys:ApplyForceCenter (self.Owner:GetAimVector()*2000 )
	phys:AddAngleVelocity(Vector( -250, -250, 0 ))

	self.Owner:StripWeapon("weapon_octo_bottle")

	timer.Simple(20, function()
		ent:Remove()
	end )

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
	timer.Remove("throwdelay")
	return true
end