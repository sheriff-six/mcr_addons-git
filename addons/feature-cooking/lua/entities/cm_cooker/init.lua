AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/furniturepack3/kitchen/counter_stove.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    local phys = self.Entity:GetPhysicsObject()

    if phys:IsValid() then
        phys:Wake()
    end
    self:SetModelScale(1.25)
    self.Cooking_Egg = false
    --self.Cooking_Egg_v2 = false
    --self.Cooking_Egg_v3 = false
    --self.Cooking_Egg_v4 = false
    self.Cooking_Bacon = false
    self.Cooking_Meat = false
    self.Cooking_Meat_2 = false
    self.Cooking_Fish_1 = false	
    self.Cooking_Fish_2 = false	
    self.Cooking_Fish_3 = false	
    self.Cooking_Cake = false
    self.Cooking_PanCake = false
    --self.Cooking_PanCake_v2 = false
    --self.Cooking_PanCake_v3 = false
    --self.Cooking_PanCake_v4 = false
    self.Cooking_Pizza = false
    self.panslot = 0
    self.pancoledown = 0
    self.finishBakeTime = 0
    --self.finishBakeTime_v2 = 0
    --self.finishBakeTime_v3 = 0
    --self.finishBakeTime_v4 = 0
    self.finishBakeTime2 = 0
    self.finishBakeTime3 = 0
    self.finishBakeTime4 = 0
    self.finishBakeTime5 = 0
    self.finishBakeTime6 = 0
    self.finishBakeTime7 = 0
    self.finishBakeTime8 = 0
    self.finishBakeTime9 = 0
    --self.finishBakeTime9_v2 = 0
    --self.finishBakeTime9_v3 = 0
    --self.finishBakeTime9_v4 = 0
    self.finishBakeTime10 = 0
    sound.Add( {
    	name = "cooking",
    	channel = CHAN_STATIC,
    	volume = 1.0,
    	level = 80,
    	pitch = { 95, 110 },
    	sound = "cooking/cookersound.wav"
    } )
end

function ENT:StartTouch(ent)

----------------------------------------- Egg

    if ent:GetClass() == "cm_foodegg2" and self.pancoledown <= CurTime() and self.Cooking_Egg == false and self.panslot == 1 and self.Cooking_Bacon == false and self.Cooking_Meat == false and self.Cooking_PanCake == false then
        ent:Remove()
        self.Cooking_Egg = true
        self.pancoledown = CurTime() + 1
        self.finishBakeTime = CurTime() + 30
		local prop2 = ents.Create("cm_pan1")
		prop2:SetPos(self:GetPos() + self:GetAngles():Up()*43.5 + self:GetAngles():Right()*-9 + self:GetAngles():Forward()*-12.5)
		prop2:SetAngles(self:GetAngles())
		prop2:Spawn()
		prop2:SetModel("models/foodnhouseholditems/egg.mdl")
		prop2:Activate()
		prop2:SetParent(self)
		prop2:SetSolid(SOLID_VPHYSICS)
		timer.Create("egg_1", 30, 1, function()
		prop2:Remove()
		self:StopSound( "cooking" )
		end)
		self:EmitSound("cooking")
    end
--[[---
    if ent:GetClass() == "cm_foodegg2" and self.pancoledown <= CurTime() and self.Cooking_Egg == true and self.Cooking_Egg_v2 == false and self.panslot >= 2 and self.Cooking_Bacon == false and self.Cooking_Meat == false and self.Cooking_PanCake == false then
        ent:Remove()
        self.Cooking_Egg_v2 = true
        self.pancoledown = CurTime() + 1
        self.finishBakeTime_v2 = CurTime() + 30
        local prop2 = ents.Create("cm_pan1")
        prop2:SetPos(self:GetPos() + self:GetAngles():Up()*43.5 + self:GetAngles():Right()*9 + self:GetAngles():Forward()*-12.5)
        prop2:SetAngles(self:GetAngles())
        prop2:Spawn()
        prop2:SetModel("models/foodnhouseholditems/egg.mdl")
        prop2:Activate()
        prop2:SetParent(self)
        prop2:SetSolid(SOLID_VPHYSICS)
        timer.Create("egg_2", 30, 1, function()
        prop2:Remove()
        self:StopSound( "cooking" )
        end)
        self:EmitSound("cooking")
    end

    if ent:GetClass() == "cm_foodegg2" and self.pancoledown <= CurTime() and self.Cooking_Egg == true and self.Cooking_Egg_v2 == true and self.Cooking_Egg_v3 == false and self.panslot >= 3 and self.Cooking_Bacon == false and self.Cooking_Meat == false and self.Cooking_PanCake == false then
        ent:Remove()
        self.Cooking_Egg_v3 = true
        self.pancoledown = CurTime() + 1
        self.finishBakeTime_v3 = CurTime() + 30
        local prop2 = ents.Create("cm_pan1")
        prop2:SetPos(self:GetPos() + self:GetAngles():Up()*43.5 + self:GetAngles():Right()*-9 + self:GetAngles():Forward()*-24)
        prop2:SetAngles(self:GetAngles())
        prop2:Spawn()
        prop2:SetModel("models/foodnhouseholditems/egg.mdl")
        prop2:Activate()
        prop2:SetParent(self)
        prop2:SetSolid(SOLID_VPHYSICS)
        timer.Create("egg_3", 30, 1, function()
        prop2:Remove()
        self:StopSound( "cooking" )
        end)
        self:EmitSound("cooking")
    end
    if ent:GetClass() == "cm_foodegg2" and self.pancoledown <= CurTime() and self.Cooking_Egg == true and self.Cooking_Egg_v2 == true and self.Cooking_Egg_v3 == true and self.Cooking_Egg_v4 == false and self.panslot >= 4 and self.Cooking_Bacon == false and self.Cooking_Meat == false and self.Cooking_PanCake == false then
        ent:Remove()
        self.Cooking_Egg_v4 = true
        self.pancoledown = CurTime() + 1
        self.finishBakeTime_v4 = CurTime() + 30
        local prop2 = ents.Create("cm_pan1")
        prop2:SetPos(self:GetPos() + self:GetAngles():Up()*43.5 + self:GetAngles():Right()*9 + self:GetAngles():Forward()*-24)
        prop2:SetAngles(self:GetAngles())
        prop2:Spawn()
        prop2:SetModel("models/foodnhouseholditems/egg.mdl")
        prop2:Activate()
        prop2:SetParent(self)
        prop2:SetSolid(SOLID_VPHYSICS)
        timer.Create("egg_4", 30, 1, function()
        prop2:Remove()
        self:StopSound( "cooking" )
        end)
        self:EmitSound("cooking")
    end
--]]------
------------------------------------------------------------ PanCake

    if ent:GetClass() == "cm_dough3" and self.pancoledown <= CurTime() and self.Cooking_Egg == false and self.panslot == 1 and self.Cooking_Bacon == false and self.Cooking_Meat == false and self.Cooking_PanCake == false then
        ent:Remove()
        self.Cooking_PanCake = true
        self.pancoledown = CurTime() + 1
        self.finishBakeTime9 = CurTime() + 38
		local prop2 = ents.Create("cm_pan1")
		prop2:SetPos(self:GetPos() + self:GetAngles():Up()*43.5 + self:GetAngles():Right()*-9 + self:GetAngles():Forward()*-12.5)
		prop2:SetAngles(self:GetAngles())
		prop2:Spawn()
		prop2:SetModel("models/griim/foodpack/pancakesingle.mdl")
		prop2:SetModelScale(0.57)
		prop2:Activate()
		prop2:SetParent(self)
		prop2:SetSolid(SOLID_VPHYSICS)
		timer.Create("pancake_1", 38, 1, function()
		prop2:Remove()
		self:StopSound( "cooking" )
		end)
		self:EmitSound("cooking")
    end
--[[---
    if ent:GetClass() == "cm_dough3" and self.pancoledown <= CurTime() and self.Cooking_PanCake_v2 == false and self.panslot >= 2 and self.Cooking_PanCake == true then
        ent:Remove()
        self.Cooking_PanCake_v2 = true
        self.pancoledown = CurTime() + 1
        self.finishBakeTime9_v2 = CurTime() + 38
        local prop2 = ents.Create("cm_pan1")
        prop2:SetPos(self:GetPos() + self:GetAngles():Up()*43.5 + self:GetAngles():Right()*9 + self:GetAngles():Forward()*-12.5)
        prop2:SetAngles(self:GetAngles())
        prop2:Spawn()
        prop2:SetModel("models/griim/foodpack/pancakesingle.mdl")
        prop2:SetModelScale(0.57)
        prop2:Activate()
        prop2:SetParent(self)
        prop2:SetSolid(SOLID_VPHYSICS)
        timer.Create("pancake_2", 38, 1, function()
        prop2:Remove()
        self:StopSound( "cooking" )
        end)
        self:EmitSound("cooking")
    end
--]]----
    -------------------------------------------------------------- Bacon

    if ent:GetClass() == "cm_foodbacon1" and self.Cooking_Bacon == false and self.panslot == 1 and self.Cooking_Egg == false and self.Cooking_Meat == false and self.Cooking_PanCake == false then
        ent:Remove()
		local Angles = self:GetAngles()
		Angles:RotateAroundAxis(Angles:Up(), math.random(1,360))
        self.Cooking_Bacon = true
        self.finishBakeTime2 = CurTime() + 25
		local prop3 = ents.Create("cm_pan1")
		prop3:SetPos(self:GetPos() + self:GetAngles():Up()*43 + self:GetAngles():Right()*-9 + self:GetAngles():Forward()*-12.7)
		prop3:SetAngles(Angles)
		prop3:Spawn()
		prop3:SetModel("models/foodnhouseholditems/bacon.mdl")
		prop3:Activate()
		prop3:SetModelScale(0.65)
		prop3:SetParent(self)
		prop3:SetSolid(SOLID_VPHYSICS)
		timer.Create("bacon", 18, 1, function()
		prop3:Remove()
		end)
		self:EmitSound("cooking")
		timer.Create("bacon2", 18, 1, function()
		local prop4 = ents.Create("cm_pan1")
		prop4:SetPos(self:GetPos() + self:GetAngles():Up()*43 + self:GetAngles():Right()*-9 + self:GetAngles():Forward()*-12.5)
		prop4:SetAngles(Angles)
		prop4:Spawn()
		prop4:SetModel("models/foodnhouseholditems/baconcooked.mdl")
		prop4:Activate()
		prop4:SetModelScale(1.28)
		prop4:SetParent(self)
		prop4:SetSolid(SOLID_VPHYSICS)
			timer.Create("bacon3", 7, 1, function()
			prop4:Remove()
			self:StopSound( "cooking" )
			end)
		end)
    end

    if ent:GetClass() == "cm_meat" and self.Cooking_Meat == false and self.panslot == 1 and  self.Cooking_Bacon == false and self.Cooking_Egg == false and self.Cooking_PanCake == false then
        ent:Remove()
		local Angles = self:GetAngles()
		Angles:RotateAroundAxis(Angles:Up(), 45)
        self.Cooking_Meat = true
        self.finishBakeTime3 = CurTime() + 25
		local prop5 = ents.Create("cm_pan1")
		prop5:SetPos(self:GetPos() + self:GetAngles():Up()*43 + self:GetAngles():Right()*-9 + self:GetAngles():Forward()*-12.7)
		prop5:SetAngles(Angles)
		prop5:Spawn()
		prop5:SetModel("models/foodnhouseholditems/steak1.mdl")
		prop5:Activate()
		prop5:SetParent(self)
		prop5:SetSolid(SOLID_VPHYSICS)
		self:EmitSound("cooking")
		timer.Create("meat", 18, 1, function()
		prop5:Remove()
		end)
		timer.Create("meat2", 18, 1, function()
		local prop6 = ents.Create("cm_pan1")
		prop6:SetPos(self:GetPos() + self:GetAngles():Up()*43 + self:GetAngles():Right()*-9 + self:GetAngles():Forward()*-12.5)
		prop6:SetAngles(Angles)
		prop6:Spawn()
		prop6:SetModel("models/foodnhouseholditems/steak2.mdl")
		prop6:Activate()
		prop6:SetParent(self)
		prop6:SetSolid(SOLID_VPHYSICS)
			timer.Create("meat3", 7, 1, function()
			prop6:Remove()
			self:StopSound( "cooking" )
			end)
		end)
    end

    if ent:GetClass() == "cm_meat2" and self.Cooking_Meat_2 == false and self.Cooking_Fish_1 == false and self.Cooking_Fish_2 == false and self.Cooking_Fish_3 == false and self.Cooking_Cake == false and self.Cooking_Pizza == false then
        ent:Remove()
        self.Cooking_Meat_2 = true
        self.finishBakeTime4 = CurTime() + 35
		self:EmitSound("cooking")
		timer.Create("sound", 35, 1, function()
			self:StopSound( "cooking" )
		end)
    end
	
    if ent:GetClass() == "cm_fish1" and self.Cooking_Fish_1 == false and self.Cooking_Meat_2 == false and self.Cooking_Fish_2 == false and self.Cooking_Fish_3 == false and self.Cooking_Cake == false and self.Cooking_Pizza == false then
        ent:Remove()
        self.Cooking_Fish_1 = true
        self.finishBakeTime5 = CurTime() + 35
		self:EmitSound("cooking")
		timer.Create("sound2", 35, 1, function()
			self:StopSound( "cooking" )
		end)
    end
	
    if ent:GetClass() == "cm_fish2" and self.Cooking_Fish_2 == false and self.Cooking_Meat_2 == false and self.Cooking_Fish_1 == false and self.Cooking_Fish_3 == false and self.Cooking_Cake == false and self.Cooking_Pizza == false then
        ent:Remove()
        self.Cooking_Fish_2 = true
        self.finishBakeTime6 = CurTime() + 20
		self:EmitSound("cooking")
		timer.Create("sound3", 20, 1, function()
			self:StopSound( "cooking" )
		end)
    end
	
    if ent:GetClass() == "cm_fish3" and self.Cooking_Fish_3 == false and self.Cooking_Meat_2 == false and self.Cooking_Fish_1 == false and self.Cooking_Fish_2 == false and self.Cooking_Cake == false and self.Cooking_Pizza == false then
        ent:Remove()
        self.Cooking_Fish_3 = true
        self.finishBakeTime7 = CurTime() + 18
		self:EmitSound("cooking")
		timer.Create("sound4", 18, 1, function()
			self:StopSound( "cooking" )
		end)
    end
    if ent:GetClass() == "cm_dough2" and self.Cooking_Cake == false and self.Cooking_Meat_2 == false and self.Cooking_Fish_1 == false and self.Cooking_Fish_2 == false and self.Cooking_Fish_3 == false and self.Cooking_Pizza == false then
        ent:Remove()
        self.Cooking_Cake = true
        self.finishBakeTime8 = CurTime() + 35
		self:EmitSound("cooking")
		timer.Create("sound5", 35, 1, function()
			self:StopSound( "cooking" )
		end)
    end
    if ent:GetClass() == "cm_coldpizza" and self.Cooking_Pizza == false and self.Cooking_Meat_2 == false and self.Cooking_Fish_1 == false and self.Cooking_Fish_2 == false and self.Cooking_Fish_3 == false and self.Cooking_Cake == false then
        ent:Remove()
        self.Cooking_Pizza = true
        self.finishBakeTime10 = CurTime() + 45
		self:EmitSound("cooking")
		timer.Create("sound6", 45, 1, function()
			self:StopSound( "cooking" )
		end)
    end
    if ent:GetClass() == "cm_pan" --[[and self.panslot ~= 4 ]] and self.panslot ~= 1 and self.pancoledown <= CurTime() then
        ent:Remove()
		self.panslot = 1
--      self.panslot = self.panslot + 1
        self.pancoledown = CurTime() + 1
        if self.panslot == 1 then
    		local Angles1 = self:GetAngles()
    		Angles1:RotateAroundAxis(Angles1:Up(), math.random(45,135))
    		local prop1 = ents.Create("cm_pan1")
    		prop1:SetPos(self:GetPos() + self:GetAngles():Up()*40.5 + self:GetAngles():Right()*-9 + self:GetAngles():Forward()*-12.5)
    		prop1:SetAngles(Angles1)
    		prop1:Spawn()
    		prop1:Activate()
    		prop1:SetParent(self)
    		prop1:SetSolid(SOLID_VPHYSICS)
--[[        elseif self.panslot == 2 then
            local Angles2 = self:GetAngles()
            Angles2:RotateAroundAxis(Angles2:Up(), math.random(225,315))
            local prop2 = ents.Create("cm_pan1")
            prop2:SetPos(self:GetPos() + self:GetAngles():Up()*40.5 + self:GetAngles():Right()*9 + self:GetAngles():Forward()*-12.5)
            prop2:SetAngles(Angles2)
            prop2:Spawn()
            prop2:Activate()
            prop2:SetParent(self)
            prop2:SetSolid(SOLID_VPHYSICS)
        elseif self.panslot == 3 then
            local Angles3 = self:GetAngles()
            Angles3:RotateAroundAxis(Angles3:Up(), math.random(90,135))
            local prop3 = ents.Create("cm_pan1")
            prop3:SetPos(self:GetPos() + self:GetAngles():Up()*40.5 + self:GetAngles():Right()*-9 + self:GetAngles():Forward()*-24)
            prop3:SetAngles(Angles3)
            prop3:Spawn()
            prop3:Activate()
            prop3:SetParent(self)
            prop3:SetSolid(SOLID_VPHYSICS)
        elseif self.panslot == 4 then
            local Angles4 = self:GetAngles()
            Angles4:RotateAroundAxis(Angles4:Up(), math.random(225,315))
            local prop4 = ents.Create("cm_pan1")
            prop4:SetPos(self:GetPos() + self:GetAngles():Up()*40.5 + self:GetAngles():Right()*9 + self:GetAngles():Forward()*-24)
            prop4:SetAngles(Angles4)
            prop4:Spawn()
            prop4:Activate()
            prop4:SetParent(self)
            prop4:SetSolid(SOLID_VPHYSICS)
            ]]
        end
    end
end

function ENT:Think()
    if self.Cooking_Egg == true then
        if self.finishBakeTime <= CurTime() then
            self.Cooking_Egg = false
            local bread = ents.Create("cm_foodegg1")
            bread:SetPos(self:GetPos() + Vector(0, 0, 50))
            bread:Spawn()
        end
    end
--[[
    if self.Cooking_Egg_v2 == true then
        if self.finishBakeTime_v2 <= CurTime() then
            self.Cooking_Egg_v2 = false
            local bread = ents.Create("cm_foodegg1")
            bread:SetPos(self:GetPos() + Vector(0, 0, 50))
            bread:Spawn()
        end
    end
    if self.Cooking_Egg_v3 == true then
        if self.finishBakeTime_v3 <= CurTime() then
            self.Cooking_Egg_v3 = false
            local bread = ents.Create("cm_foodegg1")
            bread:SetPos(self:GetPos() + Vector(0, 0, 50))
            bread:Spawn()
        end
    end
    if self.Cooking_Egg_v4 == true then
        if self.finishBakeTime_v4 <= CurTime() then
            self.Cooking_Egg_v4 = false
            local bread = ents.Create("cm_foodegg1")
            bread:SetPos(self:GetPos() + Vector(0, 0, 50))
            bread:Spawn()
        end
    end
--]]
--------------------------------------------------------------------

    if self.Cooking_Bacon == true then
        if self.finishBakeTime2 <= CurTime() then
            self.Cooking_Bacon = false
            local bread = ents.Create("cm_foodbacon2")
            bread:SetPos(self:GetPos() + Vector(0, 0, 50))
            bread:Spawn()
        end
    end

    if self.Cooking_Meat == true then
        if self.finishBakeTime3 <= CurTime() then
            self.Cooking_Meat = false
            local bread = ents.Create("cm_cookedmeat")
            bread:SetPos(self:GetPos() + Vector(0, 0, 50))
            bread:Spawn()
        end
    end

    if self.Cooking_Meat_2 == true then
        if self.finishBakeTime4 <= CurTime() then
            self.Cooking_Meat_2 = false
            local bread = ents.Create("cm_cookedmeat2")
            bread:SetPos(self:GetPos() + Vector(0, 0, 50))
            bread:Spawn()
        end
    end
	
    if self.Cooking_Fish_1 == true then
        if self.finishBakeTime5 <= CurTime() then
            self.Cooking_Fish_1 = false
            local bread = ents.Create("cm_fishcooked")
            bread:SetPos(self:GetPos() + Vector(0, 0, 50))
            bread:Spawn()
            local bread = ents.Create("cm_fishcooked")
            bread:SetPos(self:GetPos() + Vector(0, 0, 52))
            bread:Spawn()
            local bread = ents.Create("cm_fishcooked")
            bread:SetPos(self:GetPos() + Vector(0, 0, 54))
            bread:Spawn()
        end
    end
	
    if self.Cooking_Fish_2 == true then
        if self.finishBakeTime6 <= CurTime() then
            self.Cooking_Fish_2 = false
            local bread = ents.Create("cm_fishcooked")
            bread:SetPos(self:GetPos() + Vector(0, 0, 50))
            bread:Spawn()
            local bread = ents.Create("cm_fishcooked")
            bread:SetPos(self:GetPos() + Vector(0, 0, 52))
            bread:Spawn()
        end
    end
	
    if self.Cooking_Fish_3 == true then
        if self.finishBakeTime7 <= CurTime() then
            self.Cooking_Fish_3 = false
            local bread = ents.Create("cm_fishcooked")
            bread:SetPos(self:GetPos() + Vector(0, 0, 50))
            bread:Spawn()
        end
    end
    if self.Cooking_Cake == true then
        if self.finishBakeTime8 <= CurTime() then
            self.Cooking_Cake = false
            local bread = ents.Create("cm_cake")
            bread:SetPos(self:GetPos() + Vector(0, 0, 50))
            bread:Spawn()
        end
    end

---------------------------------------------------------------------

    if self.Cooking_PanCake == true then
        if self.finishBakeTime9 <= CurTime() then
            self.Cooking_PanCake = false
            local bread = ents.Create("cm_pancake")
            bread:SetPos(self:GetPos() + Vector(0, 0, 50))
            bread:Spawn()
        end
    end
--[[
    if self.Cooking_PanCake_v2 == true then
        if self.finishBakeTime9_v2 <= CurTime() then
            self.Cooking_PanCake_v2 = false
            local bread = ents.Create("cm_pancake")
            bread:SetPos(self:GetPos() + Vector(0, 0, 50))
            bread:Spawn()
        end
    end
--]]
----------------------------------------------------------------------

    if self.Cooking_Pizza == true then
        if self.finishBakeTime10 <= CurTime() then
            self.Cooking_Pizza = false
            local bread = ents.Create("cm_pizza")
            bread:SetPos(self:GetPos() + Vector(0, 0, 50))
            bread:Spawn()
        end
    end
end

function ENT:OnRemove()
	timer.Remove("egg_1")
    timer.Remove("egg_2")
    timer.Remove("egg_3")
    timer.Remove("egg_4")
	timer.Remove("bacon")
	timer.Remove("bacon2")
	timer.Remove("bacon3")
	timer.Remove("meat")
	timer.Remove("meat2")
	timer.Remove("meat3")
    timer.Remove("pancake_1")
    timer.Remove("pancake_2")
    timer.Remove("pancake_3")
    timer.Remove("pancake_4")
	timer.Remove("sound")
	timer.Remove("sound2")
	timer.Remove("sound3")
	timer.Remove("sound4")
	timer.Remove("sound5")
	timer.Remove("sound6")
end