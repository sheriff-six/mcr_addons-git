AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/foodnhouseholditems/cake_b.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    local phys = self.Entity:GetPhysicsObject()

    if phys:IsValid() then
        phys:Wake()
    end
    self:SetUseType(SIMPLE_USE)
	self.leftuses = 6
	self.poison = false
end

function ENT:Use(a)
	if self.leftuses > 1 then
		a:SetHealth(math.min(a:GetMaxHealth(), a:Health() + 30))
		self:EmitSound("eating_&_drinking/eating.wav")
		self.leftuses = self.leftuses - 1
		self:SetModel("models/foodnhouseholditems/cake"..self.leftuses.."b.mdl")
		if self.poison == true then
		    timer.Create("sound" .. a:SteamID(), 20, 1, function()
				a:EmitSound("npc/zombie/zombie_pain1.wav")
				timer.Create("poison" .. a:SteamID(), 10, 1, function()
					a:EmitSound("vo/npc/Barney/ba_pain09.wav")
		        	a:Kill()
				end)
			end)
		end
	else
		self:Remove()
	end
end

function ENT:StartTouch(ent)
    if ent:GetClass() == "cm_clorox" and self.poison == false then
        ent:Remove()
        self.poison = true
    end
end

hook.Add("PlayerDeath", "cake_timers", function(victim, inflictor, attacker)
    if timer.Exists("sound" .. victim:SteamID()) then
        timer.Remove("sound" .. victim:SteamID())
    end

    if timer.Exists("poison" .. victim:SteamID()) then
        timer.Remove("poison" .. victim:SteamID())
    end
end)