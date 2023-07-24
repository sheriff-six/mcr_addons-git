AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");
include("shared.lua");

function ENT:Initialize()
	self:SetModel("models/props/cs_office/offcorkboarda.mdl");
	self:SetSolid(SOLID_BBOX);
	self:SetUseType(SIMPLE_USE);
	self:SetNWInt("distance", 1000);

end;

function ENT:AcceptInput(name, activator, ply)
	if (name:lower() == "use" and ply:IsPlayer() ) then
		activator:SendLua('garagemenu()')
	end
end