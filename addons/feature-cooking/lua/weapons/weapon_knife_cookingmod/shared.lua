AddCSLuaFile()
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Delay = 2
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "None"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Delay = 2
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "None"
SWEP.Weight = 3
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.UseHands = true
SWEP.Author = "BananowyTasiemiec"
SWEP.Purpose = "Slice Bread"
SWEP.Category = "Cooking Mod"
SWEP.Instructions = "LMB to attack"
SWEP.ViewModelFOV = 60
SWEP.ViewModelFlip = false
SWEP.ViewModel = "models/weapons/cstrike/c_knife_t.mdl"
SWEP.WorldModel = "models/weapons/w_knife_t.mdl"
SWEP.PrintName = "Cooking Knife"
SWEP.HoldType = "knife"
SWEP.Slot = 0
SWEP.SlotPos = 0
SWEP.Spawnable = true
SWEP.AdminSpawnable = false

SWEP.Attackdelay = 0
SWEP.LoopLock = true

SWEP.Idledelay = 0
SWEP.LoopLockidle = true

function SWEP:Initialize()
    self:SetHoldType("knife")
end

function SWEP:Deploy()
    if CLIENT then return end
	self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
	self.Idledelay = CurTime() + 1.5
    self.LoopLockidle = false
	self.Owner:EmitSound("weapons/knife/knife_deploy1.wav",45)
end

function SWEP:Holster()
    return true
end

function SWEP:PrimaryAttack()
    tr = {}
    tr.start = self.Owner:GetShootPos()
    tr.endpos = self.Owner:GetShootPos() + (self.Owner:GetAimVector() * 75)
    tr.filter = self.Owner
    tr.mask = MASK_SHOT
    trace = util.TraceLine(tr)

    if (trace.Hit) then
        if trace.Entity:IsPlayer() then
            bullet = {}
            bullet.Num = 1
            bullet.Src = self.Owner:GetShootPos()
            bullet.Dir = self.Owner:GetAimVector()
            bullet.Spread = Vector(0, 0, 0)
            bullet.Tracer = 0
            bullet.Force = 1
            bullet.Damage = math.random(10,25)
            bullet.Distance = 75
            self.Owner:FireBullets(bullet)
            self.Owner:EmitSound("weapons/knife/knife_hit"..math.random(1,4)..".wav",45)
        else
        	if SERVER then
	            bullet = {}
	            bullet.Num = 1
	            bullet.Src = self.Owner:GetShootPos()
	            bullet.Dir = self.Owner:GetAimVector()
	            bullet.Spread = Vector(0, 0, 0)
	            bullet.Tracer = 0
	            bullet.Force = 1
	            bullet.Damage = 50
	            bullet.Distance = 75
	            self.Owner:FireBullets(bullet)
            	self.Owner:EmitSound("weapons/knife/knife_hitwall1.wav",45,math.random(95,100))
        	end
        	if CLIENT then
	            util.Decal("ManhackCut", trace.HitPos + trace.HitNormal, trace.HitPos - trace.HitNormal)
        	end
        end
   	else
   		if SERVER then
   			self.Owner:EmitSound("weapons/knife/knife_slash"..math.random(1,2)..".wav",45)
   		end
    end
    self.Owner:SetAnimation(PLAYER_ATTACK1)
    self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
    self.Weapon:SetNextPrimaryFire(CurTime() + 0.5)

	self.Idledelay = CurTime() + 1
    self.LoopLockidle = false
end