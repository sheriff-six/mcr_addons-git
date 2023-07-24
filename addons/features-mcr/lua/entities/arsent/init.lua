AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')


util.AddNetworkString( "sdat" )
util.AddNetworkString( "abob" )

local sdat_table = {

	[TEAM_GVP1] = true,
	[TEAM_GVP] = true,
	[TEAM_SHTAB1] = true,
	[TEAM_SHTAB2] = true,
	[TEAM_SHTAB3] = true,


}

function ENT:Initialize()
	self:SetModel("models/props/cs_italy/it_mkt_table3.mdl");
	self:SetSolid(SOLID_BBOX);
	self:SetUseType(SIMPLE_USE);
	self:SetNWInt("distance", 1000);



end


function ENT:Use(activator, caller)


	if not sdat_table[activator:Team()] then
		local ply = activator
		local posa = self:GetPos()
		net.Start( "sdat" )
		net.WriteEntity(ply)
		net.WriteVector(posa)
		net.Send(activator)
	else
		activator:ChatPrint("| Ваше оружие не хранится в КХО")
	end

end

net.Receive( "abob", function()

	local ply = net.ReadEntity(ply)

	ply:StripWeapon(ply:GetActiveWeapon():GetClass())

end)
