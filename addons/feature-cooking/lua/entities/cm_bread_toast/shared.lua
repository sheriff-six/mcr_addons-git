ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Toast Bread"
ENT.Category = "Cooking Mod"
ENT.Author = "BananowyTasiemiec"
ENT.Spawnable = true

function ENT:SetupDataTables()
	self:NetworkVar("Int",0,"price")
	self:NetworkVar("Entity",1,"owning_ent")
end