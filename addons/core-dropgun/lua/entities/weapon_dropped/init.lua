AddCSLuaFile( "cl_init.lua" ) 
AddCSLuaFile( "shared.lua" )  
 
////////////////////////////////////////
////////// MADE BY TOPHER III //////////
////////////////////////////////////////

include('shared.lua')
 
function ENT:Initialize()
 
	self:PhysicsInit( SOLID_VPHYSICS )  
	self:SetMoveType( MOVETYPE_VPHYSICS )   
	self:SetSolid( SOLID_VPHYSICS )
    if GetConVar("topher_weapondrop_droppedcollision"):GetInt() == 1 then
    self:SetCollisionGroup(COLLISION_GROUP_WEAPON) 
    end       
 
        local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end

    if GetConVar("topher_weapondrop_weapondecay"):GetInt() != 0 then
        timer.Simple(GetConVar("topher_weapondrop_weapondecay"):GetInt(),function() self:Remove() end)
    end
end
 
function ENT:Use( activator, caller )
    if not caller:HasWeapon(self.weapon) then
    caller:Give(self.weapon, true)
    caller:GetWeapon(self.weapon):SetClip1(self.clip1 or 0)
    caller:GetWeapon(self.weapon):SetClip2(self.clip2 or 0)
    else
    if caller:GetWeapon(self.weapon):GetMaxClip1() >= caller:GetWeapon(self.weapon):Clip1() then

        local clip1space = caller:GetWeapon(self.weapon):GetMaxClip1() - caller:GetWeapon(self.weapon):Clip1()
        if clip1space > self.clip1 then

            caller:GetWeapon(self.weapon):SetClip1(caller:GetWeapon(self.weapon):Clip1() + self.clip1)

        else

        caller:GetWeapon(self.weapon):SetClip1(caller:GetWeapon(self.weapon):GetMaxClip1())
        local clip1remainder = self.clip1 - clip1space
        caller:SetAmmo(caller:GetAmmoCount(caller:GetWeapon(self.weapon):GetPrimaryAmmoType()) + clip1remainder,caller:GetWeapon(self.weapon):GetPrimaryAmmoType()) 
        
        end 
    end
    if caller:GetWeapon(self.weapon):GetMaxClip2() >= caller:GetWeapon(self.weapon):Clip2() then

        local clip2space = caller:GetWeapon(self.weapon):GetMaxClip2() - caller:GetWeapon(self.weapon):Clip2()
        if clip2space > self.clip2 then

            caller:GetWeapon(self.weapon):SetClip2(caller:GetWeapon(self.weapon):Clip2() + self.clip2)

        else

        caller:GetWeapon(self.weapon):SetClip2(caller:GetWeapon(self.weapon):GetMaxClip2())
        local clip2remainder = self.clip2 - clip2space
        caller:SetAmmo(caller:GetAmmoCount(caller:GetWeapon(self.weapon):GetPrimaryAmmoType()) + clip2remainder,caller:GetWeapon(self.weapon):GetPrimaryAmmoType()) 
        
        end 
    end    
    end    
    caller:SelectWeapon(self.weapon)
    self:Remove()
end