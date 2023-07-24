AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')


util.AddNetworkString( "OpenVVS" )
util.AddNetworkString( "MI-8" )
util.AddNetworkString( "MI-8DEL" )
util.AddNetworkString( "MI-8R" )
util.AddNetworkString( "MI-8RDEL" )
util.AddNetworkString( "SU-24" )
util.AddNetworkString( "SU-24DEL" )
util.AddNetworkString( "MI-28N" )
util.AddNetworkString( "MI-28NDEL" )
util.AddNetworkString( "MAYDAY" )
util.AddNetworkString( "clmay" )

local vvs_table = {
    [TEAM_VVS] = true,
    [TEAM_VVS1] = true,
    [TEAM_VVS2] = true,

}

function ENT:Initialize()
	self:SetModel("models/props/cs_office/offcorkboarda.mdl");
	self:SetSolid(SOLID_BBOX);
	self:SetUseType(SIMPLE_USE);
	self:SetNWInt("distance", 1000);



end


function ENT:Use(activator, caller)

	if vvs_table[activator:Team()] then
		net.Start( "OpenVVS" )
		net.Send(activator)
	else
		activator:ChatPrint("| Вы не из ВКС")
	end

end

local spawnPos = Vector(-9972.404296875, 3502.5754394531, 82.03125)

net.Receive("MI-8", function()
	local mi8 = ents.Create("sw_mi8")
	mi8:SetPos(spawnPos)
	mi8:Spawn()
end)

net.Receive("MI-8DEL", function()
	for _, v in ipairs(ents.FindByClass("sw_mi8")) do
		if v:GetPos():DistToSqr(spawnPos) < 4000 * 40 then
			v:Remove()
		end
	end
end)

net.Receive("MI-8R", function()
	local mi8a = ents.Create("sw_mi8amtsh")
	mi8a:SetPos(spawnPos)
	mi8a:Spawn()
end)

net.Receive("MI-8RDEL", function()
	for _, v in ipairs(ents.FindByClass("sw_mi8amtsh")) do
		if v:GetPos():DistToSqr(spawnPos) < 4000 * 40 then
			v:Remove()
		end
	end
end)

net.Receive("SU-24", function()
	local su24 = ents.Create("sw_su24")
	su24:SetPos(Vector(-11224.161132813, 3579.5603027344, 19.03125))
	su24:Spawn()
end)

net.Receive("SU-24DEL", function()
	for _, v in ipairs(ents.FindByClass("sw_su24")) do
		if v:GetPos():DistToSqr(Vector(-11224.161132813, 3579.5603027344, 19.03125)) < 4000 * 400 then
			v:Remove()
		end
	end
end)

net.Receive("MI-28N", function()
	local su24 = ents.Create("sw_mi28")
	su24:SetPos(spawnPos)
	su24:Spawn()
end)

net.Receive("MI-28NDEL", function()
	for _, v in ipairs(ents.FindByClass("sw_mi28")) do
		if v:GetPos():DistToSqr(spawnPos) < 4000 * 400 then
			v:Remove()
		end
	end
end)


net.Receive("MAYDAY", function()
	local ply = net.ReadEntity(ply)
	local abibas = net.ReadVector(abiba)
	sound.Play( "mayday.wav", ply:GetPos() )
	net.Start("clmay")
	net.WriteEntity(ply)
	net.WriteVector(abibas)
	net.Send(player.GetAll())
end)


