AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

util.AddNetworkString( "OpenMenuArsenal" )
util.AddNetworkString( "GetPlayer" )
util.AddNetworkString( "GiveWeapon" )
util.AddNetworkString( "GivePistol" )
util.AddNetworkString( "GiveOther" )

local weapons_table = {
	["АСВал"] = "weapon_octo_val",--1
	["АК74"] = "weapon_octo_ak74", --2
    ["СВД-С"] = "weapon_octo_svd",--3
    ["ПМ"] = "weapon_octo_pmm",--4
    ["ППВитязь"] = "weapon_octo_vityaz",--5
    ["РПК74"] = "weapon_octo_rpk",--6
    ["РПГ-7"] = "tfa_ins2_rpg7_scoped",--7
    ["АК-74У"] = "weapon_octo_aksu",--8
    ["Наручники"] = "weapon_cuff_police",--9
    ["Веревка"] = "weapon_cuff_rope",--10
    ["Аптечка"] = "weapon_medkit", --11
	["weapon_simrepair"] = "Инструменты",
	["weapon_octo_stick"] = "Дубинка",
}

local jobs_table = {
	[TEAM_MOR1] = true,
	[TEAM_MOR2] = true,
	[TEAM_MOR3] = true,
	[TEAM_MOR4] = true,
	[TEAM_MOR5] = true,
	[TEAM_MOR6] = true,
	[TEAM_MOR7] = true,
    [TEAM_MOR8] = true,
	[TEAM_SHTAB1] = true,
	[TEAM_SHTAB2] = true,
	[TEAM_SHTAB3] = true,
	[TEAM_VP1] = true,
	[TEAM_VP2] = true,
	[TEAM_VP3] = true,
	[TEAM_VP4] = true,
	[TEAM_VP5] = true,
    [TEAM_TER1] = true,
    [TEAM_TER2] = true,
    [TEAM_TER3] = true,
    [TEAM_TER4] = true,
    [TEAM_VDV1] = true,
    [TEAM_VDV2] = true,
    [TEAM_VDV3] = true,
    [TEAM_VDV4] = true,
    [TEAM_VDV5] = true,
    [TEAM_VVS] = true,
	[TEAM_313] = true,
	[TEAM_3131] = true,
}

function ENT:Initialize()
	local model = "models/props_stu/storagelocker_001b.mdl"
	self:SetModel( model )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType(SIMPLE_USE)
	if ( SERVER ) then
		self:PhysicsInit( SOLID_VPHYSICS )
	end
	local phys = self:GetPhysicsObject()
	if ( IsValid( phys ) ) then phys:Wake() end
end

function ENT:SpawnFunction( ply, tr, ClassName )
	if ( !tr.Hit ) then return end
	local SpawnPos = ply:GetShootPos() + ply:GetForward()*80
	local ent = ents.Create( ClassName )
	ent:SetPos(SpawnPos)
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:Use(activator, caller)

	if jobs_table[activator:Team()] then
		net.Start( "OpenMenuArsenal" )
		net.Send(activator)
	else
		activator:ChatPrint("[#] Вам недоступен арсенал")
	end

end

net.Receive( "GetPlayer", function()

	здн = net.ReadType()

end)

net.Receive( "GiveWeapon", function()

	weapon_gun = net.ReadType()

	if weapon_gun ~= nil then здн:Give(weapons_table[weapon_gun]) end

end)

net.Receive( "GivePistol", function()

	weapon_pistol = net.ReadType()

	if weapon_pistol ~= nil then здн:Give(weapons_table[weapon_pistol]) end

end)

net.Receive( "GiveOther", function()

	weapon_other = net.ReadType()

	if weapon_other ~= nil then здн:Give(weapons_table[weapon_other]) end

end)
