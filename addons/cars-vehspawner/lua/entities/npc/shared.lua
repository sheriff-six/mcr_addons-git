ENT.Base = "base_gmodentity"

ENT.PrintName 	= "Гараж"
ENT.Author 		= "Cocucka"
ENT.Contact 	= ""
ENT.Category = "Предметы"

ENT.AutomaticFrameAdvance = true;
   
ENT.Spawnable = true;
ENT.AdminSpawnable = true;

function ENT:PhysicsCollide(data, physobj)
end;

function ENT:PhysicsUpdate(physobj)
end;

function ENT:SetAutomaticFrameAdvance(bUsingAnim)
	self.AutomaticFrameAdvance = bUsingAnim;
end