AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include( "shared.lua" )

function ENT:Initialize()
	self:SetModel( "models/foodnhouseholditems/baconcooked.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	
	local phys = self.Entity:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
	self:SetModelScale(1.28)
    timer.Create("bad".. math.random(1,999999999999999999), 240, 1, function()
		self.bad = true
    end)
	self.bad = false
	self.poison = false
end

function ENT:Use( activator )
	activator:SetHealth( math.min( activator:GetMaxHealth(), activator:Health() + 25 ) )
	self:EmitSound("eating_&_drinking/eating.wav")
	self:Remove()
	if self.poison == true then
		self:EmitSound("eating_&_drinking/eating.wav")
		self:Remove()
		timer.Create("sound" .. activator:SteamID(), 20, 1, function()
		activator:EmitSound("npc/zombie/zombie_pain1.wav")
		end)
	
		timer.Create("poison" .. activator:SteamID(), 30, 1, function()
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

function ENT:Think()
	if self.bad == true then
	self:Remove()
    local bread = ents.Create("cm_meatbad")
    bread:SetPos(self:GetPos() + Vector(0, 0, 0))
    bread:Spawn()
	bread:SetModel("models/foodnhouseholditems/baconcooked.mdl")
	bread:SetModelScale(1.28)
	end
end

hook.Add("PlayerDeath", "bacon_timers", function(victim, inflictor, attacker)
    if timer.Exists("sound" .. victim:SteamID()) then
        timer.Remove("sound" .. victim:SteamID())
    end

    if timer.Exists("poison" .. victim:SteamID()) then
        timer.Remove("poison" .. victim:SteamID())
    end
end)