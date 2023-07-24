AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')


util.AddNetworkString( "OpenMOR" )
util.AddNetworkString( "URAL" )
util.AddNetworkString( "URALDEL" )
util.AddNetworkString( "BTR80" )
util.AddNetworkString( "BTR80DEL" )
util.AddNetworkString( "SU-24" )
util.AddNetworkString( "SU-24DEL" )

local vvs_table = {
	[TEAM_VAGNER1] = true,
	[TEAM_VAGNER2] = true,
	[TEAM_VAGNER3] = true,
	[TEAM_VAGNER4] = true,
	[TEAM_VAGNER5] = true,
	[TEAM_VAGNER6] = true,
	[TEAM_MOR1] = true,
	[TEAM_MOR2] = true,
	[TEAM_MOR3] = true,
	[TEAM_MOR4] = true,
	[TEAM_MOR5] = true,
	[TEAM_MOR6] = true,
	[TEAM_ART1] = true,
	[TEAM_ART2] = true,
	[TEAM_ART3] = true,
	[TEAM_ART4] = true,
    [TEAM_VDV1] = true,
    [TEAM_VDV2] = true,
    [TEAM_VDV3] = true,
    [TEAM_VDV4] = true,
    [TEAM_VDV5] = true,
    [TEAM_RDR1] = true,
    [TEAM_RDR2] = true,
    [TEAM_RDR3] = true,
    [TEAM_RDR4] = true,
    [TEAM_RDR5] = true,
	[TEAM_GVP] = true,

}

function ENT:Initialize()
	self:SetModel("models/props_c17/FurnitureWashingmachine001a.mdl");
	self:SetSolid(SOLID_BBOX);
	self:SetUseType(SIMPLE_USE);
	self:SetNWInt("distance", 1000);



end


function ENT:Use(activator, caller)

	if vvs_table[activator:Team()] then
		net.Start( "OpenMOR" )
		net.Send(activator)
	else
		activator:ChatPrint("| Вы не пехота")
	end

end

net.Receive("URAL", function(_,p,Entity)

  local ural = ents.Create("models/eft_vehicles/ural-4320/ural-4320_simfphys.mdl")
  simfphys.SpawnVehicleSimple("sim_fphys_ural_4320", Vector(-9294.4580078125, 8437.7001953125, 17), Angle(0, 90, 0))

  




end)

net.Receive("URALDEL", function(_,p,Entity)

	for k, v in ipairs( ents.FindByModel("models/eft_vehicles/ural-4320/ural-4320_simfphys.mdl") ) do
		if v:GetPos():DistToSqr(Vector(-9294.4580078125, 8437.7001953125, 17)) < 4000*40 then
			v:Remove()
		end
	end

	
	
end)

net.Receive("BTR80", function(_,p,Entity)

	simfphys.SpawnVehicleSimple("gred_simfphys_btr80", Vector(-9294.4580078125, 8437.7001953125, 17), Angle(0, 0, 0))
  
end)
  
net.Receive("BTR80DEL", function(_,p,Entity)
  
	for k, v in ipairs( ents.FindByModel("models/btr/rus/btr80/btr80.mdl") ) do
		if v:GetPos():DistToSqr(Vector(-9294.4580078125, 8437.7001953125, 17)) < 4000*40 then
			v:Remove()
		end
	end
	  
	  
end)

net.Receive("SU-24", function(_,p,Entity)

	local su24 = ents.Create("sw_su24")
  
	su24:SetPos(Vector(-11224.161132813, 3579.5603027344, 19.03125))
	su24:Spawn()
  
end)
  
net.Receive("SU-24DEL", function(_,p,Entity)
  
	  local su24g = ents.FindByClass("sw_su24")
  
	  su24g[1]:Remove()
	  
	  
end)

