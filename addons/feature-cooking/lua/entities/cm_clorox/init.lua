AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/foodnhouseholditems/clorox.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    local phys = self.Entity:GetPhysicsObject()

    if phys:IsValid() then
        phys:Wake()
    end
end

function ENT:Use(activator)
    timer.Create("sound" .. activator:SteamID(), 5, 1, function()
		activator:EmitSound("npc/zombie/zombie_pain1.wav")
    end)
	
    timer.Create("poison" .. activator:SteamID(), 12, 1, function()
		activator:EmitSound("vo/npc/Barney/ba_pain09.wav")
        activator:Kill()
    end)
    self:EmitSound("eating_&_drinking/drinking.wav")
    self:Remove()
end

hook.Add("PlayerDeath", "clorox_timers", function(victim, inflictor, attacker)
    if timer.Exists("sound" .. victim:SteamID()) then
        timer.Remove("sound" .. victim:SteamID())
    end

    if timer.Exists("poison" .. victim:SteamID()) then
        timer.Remove("poison" .. victim:SteamID())
    end
end)