AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include( "shared.lua" )

function ENT:Initialize()
	self:SetModel( "models/griim/foodpack/pancakesingle.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	
	local phys = self.Entity:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
	self.poison = false
end

function ENT:Use( activator )
	if self.poison == false then
		activator:SetHealth( math.min( activator:GetMaxHealth(), activator:Health() + 60 ) )
		self:EmitSound("eating_&_drinking/eating.wav")
		self:Remove()
	end
	if self.poison == true then
		self:EmitSound("eating_&_drinking/eating.wav")
		self:Remove()
		self:EmitSound("eating_&_drinking/eating.wav")
		timer.Create("sound" .. activator:SteamID(), 10, 1, function()
		activator:EmitSound("npc/zombie/zombie_pain1.wav")
		end)
	
		timer.Create("poison" .. activator:SteamID(), 20, 1, function()
		activator:EmitSound("vo/npc/Barney/ba_pain09.wav")
        activator:Kill()
		end)
	end
end

function ENT:StartTouch(ent)
    if ent:GetClass() == "cm_clorox" and self.poison == false then
        ent:Remove()
        self.poison = true
    end
end

hook.Add("PlayerDeath", "pancake_timers", function(victim, inflictor, attacker)
    if timer.Exists("sound" .. victim:SteamID()) then
        timer.Remove("sound" .. victim:SteamID())
    end

    if timer.Exists("poison" .. victim:SteamID()) then
        timer.Remove("poison" .. victim:SteamID())
    end
end)