AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include( "shared.lua" )

function ENT:Initialize()
	self:SetModel( "models/cooking_mod/cm_cooking_book.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	
	local phys = self.Entity:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
	util.AddNetworkString("cookingbookv2")
	util.AddNetworkString("cookingbookv2close")
	self.Open = false
end

function ENT:Use( a, ply )
if self.Open == false then
	net.Start("cookingbookv2")
		net.WriteEntity( self )
	net.Send(ply)
	self.Open = true
end
end

function ENT:Think()
	net.Receive("cookingbookv2close",function()
	self.Open = false
	end)
end