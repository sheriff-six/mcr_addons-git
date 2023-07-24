if SERVER then
	AddCSLuaFile()
end

ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Пустышка"
ENT.Category = "Dobrograd"
ENT.Spawnable = false
ENT.AdminOnly = false

function ENT:Initialize()
	self:PhysicsInit(SOLID_NONE)
	self:SetMoveType(MOVETYPE_NONE)
end

if CLIENT then
	function createEmpty(model, rendergroup)
		local ent = ents.CreateClientside("ent_empty")
		ent.RenderGroup = rendergroup
		ent:SetModel(model)
		ent:Spawn()
		return ent
	end
end