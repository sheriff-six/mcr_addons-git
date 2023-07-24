SWEP.Gun					= ("weapon_nightstick")
SWEP.PrintName				= "Дубинка"
SWEP.Slot		       		= 1
SWEP.SlotPos				= 0
SWEP.DrawAmmo				= true		
SWEP.BounceWeaponIcon		= false		
SWEP.DrawCrosshair			= true		
--SWEP.ViewModel			= "models/weapons/c_stunstick.mdl"	
SWEP.ViewModel				= "models/drover/baton.mdl"	
SWEP.ViewModelFOV			= 60
--SWEP.WorldModel			= "models/weapons/w_stunbaton.mdl"
SWEP.WorldModel				= "models/drover/w_baton.mdl"
SWEP.HoldType				= "melee"	
SWEP.UseHands           	= true

-- Other settings
SWEP.Weight					= 0
SWEP.AutoSwitchTo			= true			
SWEP.Spawnable				= true	

-- Weapon info
SWEP.Author					= "wh1t3"		
SWEP.Category 				= "Полиция"	

-- Primary fire settings
SWEP.Primary.Damage			= 0
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ""

-- Secondary fire settings		
SWEP.Secondary.ClipSize		= -1	
SWEP.Secondary.DefaultClip	= -1		
SWEP.Secondary.Ammo			= ""

-- Misc
SWEP.SelectIcon				= "hud/weaponicons/nightstick"

sv_nightstick_stuntime = CreateConVar("sv_nightstick_stuntime", 3, {FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_REPLICATED}, "How long the nightstick will stun a user (In Seconds)") 

function SWEP:Initialize()
    self:SetWeaponHoldType("melee")
end

function SWEP:PrimaryAttack()
    self.Weapon:SetNextPrimaryFire( CurTime() + 0.5 )

	self.Owner:SetAnimation(PLAYER_ATTACK1)
	self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)

    local trace = self.Owner:GetEyeTrace();
    if trace.HitPos:Distance(self.Owner:GetShootPos()) <= 75 then	
			if trace.MatType == MAT_GLASS or trace.MatType == MAT_PLASTIC or trace.MatType == MAT_WOOD or trace.MatType == MAT_CONCRETE or trace.MatType == MAT_DIRT or trace.MatType == MAT_METAL  or trace.MatType == MAT_GRASS and not trace.Entity:IsPlayer() then
				if trace.MatType == MAT_CONCRETE  or  trace.MatType == MAT_DIRT then	
					self.Weapon:EmitSound("physics/concrete/concrete_impact_hard".. math.random(1, 3).. ".wav")
				elseif trace.MatType == MAT_WOOD then
					self.Weapon:EmitSound("physics/wood/wood_box_impact_hard".. math.random(1, 3).. ".wav")
				elseif trace.MatType == MAT_METAL then 
					self.Weapon:EmitSound("physics/metal/metal_barrel_impact_hard".. math.random(1, 3).. ".wav")
				else
					self.Weapon:EmitSound("physics/plastic/plastic_box_impact_hard".. math.random(1, 3).. ".wav")
				end
			else
				if trace.Entity:IsPlayer() then
					self.Owner:SetAnimation(PLAYER_ATTACK1)

					trace.Entity:Freeze(true)
					trace.Entity:SetEyeAngles(Angle(60, trace.Entity.y, trace.Entity.r))

					self.Weapon:EmitSound("physics/body/body_medium_impact_soft".. math.random(1, 7).. ".wav")
					timer.Simple(GetConVar("sv_nightstick_stuntime"):GetInt(), function() trace.Entity:Freeze(false) end)
				end
			end
    else
        self.Weapon:EmitSound("npc/zombie/claw_miss".. math.random(1, 2).. ".wav")
	end

    self.Weapon:SetNextPrimaryFire(CurTime() + 0.43)
end

function SWEP:SecondaryAttack()
	return false
end

function SWEP:Deploy()
	return true
end

function SWEP:Holster()
	return true
end

function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )
	if self.SelectIcon then
		surface.SetDrawColor(255, 255, 255, 255)
		surface.SetTexture(surface.GetTextureID(self.SelectIcon))
		surface.DrawTexturedRect(x + 20, y + 20, 200, 120)
	else
		draw.SimpleText(self.IconLetter, self.SelectFont, x + wide / 2, y + tall * 0.2, Color(255, 210, 0, alpha), TEXT_ALIGN_CENTER)
	end

	y = y + 10
	x = x + 10
	wide = wide - 20

	self:PrintWeaponInfo( x + wide + 20, y + tall * 0.95, alpha )
end

function SWEP:Precache()
	util.PrecacheSound(self.Primary.Sound)
	util.PrecacheModel(self.ViewModel)
	util.PrecacheModel(self.WorldModel)
end