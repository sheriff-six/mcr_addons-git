include("shared.lua")
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

function ENT:SpawnFunction(ply, tr)
	if (!tr.Hit) then return end
	local ent=ents.Create(ClassName)
	ent:SetPos(tr.HitPos+tr.HitNormal+Vector(0,0,20))
	ent:Spawn()
	ent:Activate()
	ent:SetBodygroup(4,1)
	ent:SetBodygroup(1,1)
	ent.Owner=ply
	return ent
end
function ENT:receiveInput(name, value, seat)
	self:base("wac_hc_base").receiveInput(self, name, value, seat)
	if seat == 1 or seat == 2 then
		if name == "Flare" and value>0.5 then
			self:FlareShootRight(value > 0.5, seat)
			self:FlareShootRight2(value > 0.5, seat)
			self:FlareShootRight3(value > 0.5, seat)
			self:FlareShootRight4(value > 0.5, seat)
			self:FlareShootRight5(value > 0.5, seat)
			self:FlareShootLeft(value > 0.5, seat)
		 end
	 end
	if seat == 1 or seat == 2 then
		if name == "Door1" and value>0.5 then
			self.Door1 = !self.Door1
		end
	end
	if name == "Cargo_ramp" and value>0.5 then
        self.Ramp = !self.Ramp
	end
end
function ENT:RocketAlert()
	local b=false
	if self.rotorRpm > 0.1 then
		local rockets = ents.FindByClass("rpg_missile")
		local grockets = ents.FindByClass("wac_base_grocket")
		local grockets = ents.FindByClass("ent_stingermissile")
		local grockets = ents.FindByClass("ent_kub_sam")
		local grockets = ents.FindByClass("wac_hc_rocket")
		local grockets = ents.FindByClass("ent_cod4rm_stingermissile")
		local grockets = ents.FindByClass("ent_igla_radar_passive")
		local grockets = ents.FindByClass("ent_igla_radar_active")
		local grockets = ents.FindByClass("ent_cod4rm_javelinmissile_dir")
		local grockets = ents.FindByClass("ent_cod4rm_javelinmissile")
		local grockets = ents.FindByClass("sw_pod_vyihr_wac")
		local grockets = ents.FindByClass("wac_pod_vrocket_9m39")
		local grockets = ents.FindByClass("sw_pod_agm114_wac")
		local grockets = ents.FindByClass("sw_pod_aim92_wac")
		local grockets = ents.FindByClass("sw_pod_aim9_wac")
		local grockets = ents.FindByClass("sent_stinger_missile")
		table.Merge(rockets,grockets, ents.FindByClass("wac_w_rocket"))
		for _, e in pairs(rockets) do
			if e:GetPos():Distance(self:GetPos()) < 50000 then b = true break end
		end
		if self.sounds.MissileAlert:IsPlaying() then
			if !b then
				self.sounds.MissileAlert:Stop()
			end
		elseif b then
			self.sounds.MissileAlert:Play()
		end
	end
end

function ENT:SetNextFlare( delay )
	self.NextFlare = CurTime() + delay
end
function ENT:CanFlare()
	self.NextFlare = self.NextFlare or 0
	return self.NextFlare < CurTime()
end

function ENT:FlareShootLeft()	
	if not self:CanFlare() then return end
	self:SetNextFlare( 2.5 )	
	self:EmitSound( "ka52/flare.wav")
	---local shootOrigin = self:GetPos()-Vector(0,-20,0)
	self.flare = ents.Create("misc_flare")
	self.flare:SetPos(self:LocalToWorld(Vector(-10,250,70))) 
	self.flare:SetModel( "models/flare.mdl" )
	self.flare:Spawn()
	self.flare:GetPhysicsObject():ApplyForceCenter(self:GetRight() * -1000 )
end
function ENT:FlareShootRight()
	if not self:CanFlare() then return end	
self:EmitSound( "ka52/flare.wav")
	---local shootOrigin = self:GetPos()-Vector(0,20,0)
	self.flare = ents.Create("misc_flare")
	self.flare:SetPos(self:LocalToWorld(Vector(-10,-250,70)))
	self.flare:SetModel( "models/flare.mdl" )
	self.flare:Spawn()
	self.flare:GetPhysicsObject():ApplyForceCenter(self:GetRight() * 1000 )
end
function ENT:FlareShootRight2()
	if not self:CanFlare() then return end	
self:EmitSound( "ka52/flare.wav")
	---local shootOrigin = self:GetPos()-Vector(0,20,0)
	self.flare = ents.Create("misc_flare")
	self.flare:SetPos(self:LocalToWorld(Vector(-100,-250,70)))
	self.flare:SetModel( "models/flare.mdl" )
	self.flare:Spawn()
	self.flare:GetPhysicsObject():ApplyForceCenter(self:GetRight() * 1000 )
end
function ENT:FlareShootRight3()
	if not self:CanFlare() then return end	
self:EmitSound( "ka52/flare.wav")
	---local shootOrigin = self:GetPos()-Vector(0,20,0)
	self.flare = ents.Create("misc_flare")
	self.flare:SetPos(self:LocalToWorld(Vector(-300,-60,-40)))
	self.flare:SetModel( "models/flare.mdl" )
	self.flare:Spawn()
	self.flare:GetPhysicsObject():ApplyForceCenter(self:GetRight() * 90 )
end
function ENT:FlareShootRight4()	
	if not self:CanFlare() then return end	
	self:EmitSound( "ka52/flare.wav")
	---local shootOrigin = self:GetPos()-Vector(0,-20,0)
	self.flare = ents.Create("misc_flare")
	self.flare:SetPos(self:LocalToWorld(Vector(-100,250,70))) 
	self.flare:SetModel( "models/flare.mdl" )
	self.flare:Spawn()
	self.flare:GetPhysicsObject():ApplyForceCenter(self:GetRight() * -1000 )
end
function ENT:FlareShootRight5()	
	if not self:CanFlare() then return end
	self:EmitSound( "ka52/flare.wav")
	---local shootOrigin = self:GetPos()-Vector(0,-20,0)
	self.flare = ents.Create("misc_flare")
	self.flare:SetPos(self:LocalToWorld(Vector(-300,60,-40))) 
	self.flare:SetModel( "models/flare.mdl" )
	self.flare:Spawn()
	self.flare:GetPhysicsObject():ApplyForceCenter(self:GetRight() * -90 )
end


function ENT:PhysicsUpdate(ph)
	self:base("wac_hc_base").PhysicsUpdate(self,ph)		
	self:SetNWFloat("Door1",self.Door1Closed)
	self:SetNWFloat("Ramp",self.RampClosed)
	local trace=util.QuickTrace(self:LocalToWorld(Vector(0,0,62)), self:LocalToWorld(Vector(0,0,50)), {self, self.wheels[1], self.wheels[2], self.wheels[3], self.rotor})
	local phys=self:GetPhysicsObject()
	local geartrace = util.QuickTrace(self:LocalToWorld(Vector(0,0,-80)), Vector(0,0,-5), self)
	if self.Door1 and !self.Door1Closed then
		self:EmitSound( "wac/mi171/Cockpit.wav"	)
		self.Door1Closed = true
		self:SetBodygroup(4,0)
	elseif !self.Door1 and self.Door1Closed then
		self:EmitSound( "wac/mi171/Cockpit.wav"	)
		self.Door1Closed = false
		self:SetBodygroup(4,1)
	end
	if self.Ramp and !self.RampClosed then
		self:EmitSound( "wac/mi171/Cockpit.wav"	)
		self.RampClosed = true
		self:SetBodygroup(5,1)
	elseif !self.Ramp and self.RampClosed then
		self:EmitSound( "wac/mi171/Cockpit.wav"	)
		self.RampClosed = false
		self:SetBodygroup(5,0)
	end
end
