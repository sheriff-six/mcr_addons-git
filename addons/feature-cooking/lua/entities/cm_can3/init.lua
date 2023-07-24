AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include( "shared.lua" )

function ENT:Initialize()
	self:SetModel( "models/foodnhouseholditems/sodacanb01.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	
	local phys = self.Entity:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
end

function ENT:Use( a , c )
    if c.Oncoffee1 == nil then
        c.Oncoffee1 = false
    end

	a:SetHealth( math.min( a:GetMaxHealth(), a:Health() + 20 ) )
	self:EmitSound("eating_&_drinking/drinking.wav")
	self:Remove()
    if c.Oncoffee1 == false then
        c.oldwalkspeed = c:GetWalkSpeed()
        c.oldrunspeed = c:GetRunSpeed()
        a:SetWalkSpeed(c.oldwalkspeed + 45)
        a:SetRunSpeed(c.oldrunspeed + 45)
        c.Oncoffee1 = true
    end
    timer.Create("speed_effect" .. c:SteamID(), 30, 1, function()
        a:SetWalkSpeed(c.oldwalkspeed)
        a:SetRunSpeed(c.oldrunspeed)
        c.Oncoffee1 = false
    end)
end

hook.Add("PlayerDeath", "Coffee_timers", function(victim, inflictor, attacker)
    if timer.Exists("speed_effect" .. victim:SteamID()) then
        timer.Remove("speed_effect" .. victim:SteamID())
    end
end)