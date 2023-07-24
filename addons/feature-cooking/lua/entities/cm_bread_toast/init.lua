AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/foodnhouseholditems/bread-3.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    local phys = self.Entity:GetPhysicsObject()

    if phys:IsValid() then
        phys:Wake()
    end
    self:SetUseType(SIMPLE_USE)
    self.bread_health = 4
end

function ENT:OnTakeDamage(dmg)
	if(self.bread_health <= 0) then
		self:Remove()
	end
	local ply = dmg:GetAttacker()

	if ply:GetActiveWeapon():GetClass() == "weapon_knife_cookingmod" or ply:GetActiveWeapon():GetClass() == "tfa_nmrih_kknife" then
		self.bread_health = self.bread_health - 1
		local toast = ents.Create("cm_toast1")
		toast:SetPos(self:GetPos() + Vector(0,0,20))
		toast:SetAngles(self:GetAngles())
		toast:Spawn()
		toast:Activate()
	else return end
end