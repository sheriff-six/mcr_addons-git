AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/props_junk/garbage_coffeemug001a.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    local phys = self:GetPhysicsObject()

    if phys:IsValid() then
        phys:Wake()
    end

    timer.Create("coffee", 0.3, 1, function()
        local prop1 = ents.Create("cm_cup3")
        prop1:SetPos(self:GetPos() + self:GetAngles():Up() * 1.75 + self:GetAngles():Right() * 1.02 + self:GetAngles():Forward() * 0)
        prop1:SetAngles(self:GetAngles())
        prop1:Spawn()
        prop1:SetModel("models/hunter/tubes/circle2x2.mdl")
        prop1:SetMaterial("models/props_foliage/tree_deciduous_01a_trunk")
        prop1:SetColor(Color(72, 72, 72))
        prop1:Activate()
        prop1:SetModelScale(0.045)
        prop1:SetParent(self)
        prop1:SetSolid(SOLID_VPHYSICS)
    end)

    self.poison = false
end

function ENT:Use(a, c)
    if c.Oncoffee == nil then
        c.Oncoffee = false
    end

    a:SetHealth(math.min(a:GetMaxHealth(), a:Health() + 20))
    self:EmitSound("eating_&_drinking/drinking.wav")
    self:Remove()
    local bread = ents.Create("cm_cup")
    bread:SetPos(self:GetPos() + Vector(0, 0, 0))
    bread:Spawn()

    if c.Oncoffee == false then
        c.oldwalkspeed = c:GetWalkSpeed()
        c.oldrunspeed = c:GetRunSpeed()
        a:SetWalkSpeed(c.oldwalkspeed + 90)
        a:SetRunSpeed(c.oldrunspeed + 90)
        c.Oncoffee = true
    end

    timer.Create("speed_effect" .. c:SteamID(), 30, 1, function()
        a:SetWalkSpeed(c.oldwalkspeed)
        a:SetRunSpeed(c.oldrunspeed)
        c.Oncoffee = false
    end)

    if self.poison == true then
        self:EmitSound("eating_&_drinking/drinking.wav")
        self:Remove()

        timer.Create("sound" .. a:SteamID(), 20, 1, function()
            a:EmitSound("npc/zombie/zombie_pain1.wav")
        end)

        timer.Create("poison" .. a:SteamID(), 30, 1, function()
            a:EmitSound("vo/npc/Barney/ba_pain09.wav")
            a:Kill()
        end)
    end
end

function ENT:StartTouch(ent)
    if ent:GetClass() == "cm_clorox" and self.poison == false then
        ent:Remove()
        self.poison = true
    end
end

function ENT:OnRemove()
    timer.Remove("coffee")
end

hook.Add("PlayerDeath", "Coffee_timers", function(victim, inflictor, attacker)
    if timer.Exists("speed_effect" .. victim:SteamID()) then
        timer.Remove("speed_effect" .. victim:SteamID())
    end

    if timer.Exists("sound" .. victim:SteamID()) then
        timer.Remove("sound" .. victim:SteamID())
    end

    if timer.Exists("poison" .. victim:SteamID()) then
        timer.Remove("poison" .. victim:SteamID())
    end
end)