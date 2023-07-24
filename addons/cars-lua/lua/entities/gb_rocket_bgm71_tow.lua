AddCSLuaFile()

DEFINE_BASECLASS( "base_rocket" )

local ExploSnds = {}
ExploSnds[1]                         =  "explosions/doi_generic_01.wav"
ExploSnds[2]                         =  "explosions/doi_generic_02.wav"
ExploSnds[3]                         =  "explosions/doi_generic_03.wav"
ExploSnds[4]                         =  "explosions/doi_generic_04.wav"

local CloseExploSnds = {}
CloseExploSnds[1]                         =  "explosions/doi_generic_01_close.wav"
CloseExploSnds[2]                         =  "explosions/doi_generic_02_close.wav"
CloseExploSnds[3]                         =  "explosions/doi_generic_03_close.wav"
CloseExploSnds[4]                         =  "explosions/doi_generic_04_close.wav"

local DistExploSnds = {}
DistExploSnds[1]                         =  "explosions/doi_generic_01_dist.wav"
DistExploSnds[2]                         =  "explosions/doi_generic_02_dist.wav"
DistExploSnds[3]                         =  "explosions/doi_generic_03_dist.wav"
DistExploSnds[4]                         =  "explosions/doi_generic_04_dist.wav"

local WaterExploSnds = {}
WaterExploSnds[1]                         =  "explosions/doi_generic_01_water.wav"
WaterExploSnds[2]                         =  "explosions/doi_generic_02_water.wav"
WaterExploSnds[3]                         =  "explosions/doi_generic_03_water.wav"
WaterExploSnds[4]                         =  "explosions/doi_generic_04_water.wav"

local CloseWaterExploSnds = {}
CloseWaterExploSnds[1]                         =  "explosions/doi_generic_02_closewater.wav"
CloseWaterExploSnds[2]                         =  "explosions/doi_generic_02_closewater.wav"
CloseWaterExploSnds[3]                         =  "explosions/doi_generic_03_closewater.wav"
CloseWaterExploSnds[4]                         =  "explosions/doi_generic_04_closewater.wav"

ENT.LaserGuided = true
ENT.Spawnable		        =  true         
ENT.AdminSpawnable		    =  true 

ENT.PrintName		        =  "[ROCKETS]BGM-71 TOW Rocket"
ENT.Author			        =  ""
ENT.Contact			        =  ""
ENT.Category                =  "Gredwitch's Stuff"

ENT.Model                	=  "models/vehicles_shelby/rockets/atgm/bgm71_tow.mdl"
ENT.RocketTrail          	=  "Small_mis_thrust"
ENT.RocketBurnoutTrail   	=  "grenadetrail"
ENT.Effect               	=  "ins_m203_explosion"
ENT.EffectAir            	=  "high_explosive_air"
ENT.EffectWater          	=  "ins_water_explosion"
ENT.AngEffect			 	=   true

ENT.ExplosionSound          =  table.Random(CloseExploSnds)
ENT.FarExplosionSound		=  table.Random(ExploSnds)
ENT.DistExplosionSound		=  table.Random(DistExploSnds)
ENT.WaterExplosionSound		=  table.Random(CloseWaterExploSnds)
ENT.WaterFarExplosionSound	=  table.Random(WaterExploSnds)

ENT.RSound					=	0

ENT.StartSound              =  "BGM71TOW_FIRE"
ENT.ArmSound                =  ""
ENT.ActivationSound         =  ""
ENT.EngineSound             =  "RP3_Engine"
ENT.StartSoundFollow		=	true

ENT.ExplosionDamage			=	1500
ENT.ExplosionDamageOverride =	1000
ENT.ExplosionRadius			=	450
ENT.Mass           			=	21.45
ENT.EnginePower    			=	1000
ENT.TNTEquivalent			=	4.41
ENT.FuelBurnoutTime			=	100
ENT.LinearPenetration		=	800
ENT.MaxVelocity				=	3000
ENT.Caliber					=	152
ENT.RotationalForce			=	0

function ENT:SpawnFunction( ply, tr )
    if (!tr.Hit) then return end
	
    local ent = ents.Create(self.ClassName)
	ent:SetPhysicsAttacker(ply)
	ent.Owner = ply
    ent:SetPos(tr.HitPos + tr.HitNormal * 16) 
    ent:Spawn()
    ent:Activate()
	
    return ent
end

local Normal = Vector(1,1,0)
local Normal2 = Vector(0.1,1,1)
local trlength = Vector(0,0,9000)
local angle_zero = Angle()
local angle_1 = Angle(-90,0,0)
function ENT:PhysicsUpdate(ph)
	if not self.JDAM or not self.Armed then return end
	local pos = self:GetPos()
	local vel = self:WorldToLocal(pos+ph:GetVelocity())*0.4
	vel.x = 0
	local target = self.target:LocalToWorld(self.targetOffset)	
	local v = self:WorldToLocal(target + Vector(0,0,math.Clamp((pos*Normal):Distance(target*Normal)/5 - 50,0,0))):GetNormal()
	v.y = math.Clamp(v.y*10,-1,1)*100
	v.z = math.Clamp(v.z*10,-1,1)*100
	ph:AddAngleVelocity(
		ph:GetAngleVelocity()*-0.4
		+ Vector(math.Rand(-1,1), math.Rand(-1,1), math.Rand(-1,1))*5
		+ Vector(0,-vel.z,vel.y)
		+ Vector(0,-v.z,v.y)
	)
	ph:AddVelocity(self:GetForward() - self:LocalToWorld(vel*Normal2) + pos)
end
function ENT:AddOnThink()
    if self.Armed then
        if self.JDAM then   
			if self.LaserGuided == true then
				if IsValid(self.Launcher) then
					local Parent = self.Launcher
					local phys = self:GetPhysicsObject()
					local ID = Parent:LookupAttachment( self.LaserAttachment )
					local Attachment = Parent:GetAttachment( ID )
					if Parent:GetAttachment( ID ) then
						local TargetDir = Attachment.Ang:Forward()
						local tr = util.TraceHull( {
							start = Attachment.Pos,
							endpos = (Attachment.Pos + TargetDir  * 999999),
							mins = Vector( -1, -1, -1 ),
							maxs = Vector( 1, 1, 1 ),
							filter = {self,Parent,Parent.wheel_C,Parent.wheel_R,Parent.wheel_L}
						} )
						self.target = tr.Entity
						self.targetOffset = tr.Entity:WorldToLocal(tr.HitPos) 
						phys:SetVelocity( self:GetVelocity() + self:GetAngles():Forward() * 20 )      
					end
				else
					self.LaserGuided = false
				end
			end
        end 
    end
end
function ENT:Think()
	if not (self.Burnt or not self.Ignition or self.Exploded) then
		local phys = self:GetPhysicsObject()
		
		if !self.LaserGuided then
			if IsValid(phys) then
				if self.MaxVelocityUnitsSquared and phys:GetVelocity():LengthSqr() < self.MaxVelocityUnitsSquared then
					phys:ApplyForceCenter(self:GetForward() * self.EnginePower)
				end
			end
		end
	end	
	self:AddOnThink()

	self:NextThink(CurTime())
	return true
end

--HEAT Effect
--function ENT:Explode(pos)
--	if !self.Exploded then return end
--	pos = pos or self:LocalToWorld(self:OBBCenter())
--	
--	if self:AddOnExplode(pos) then
--		self.Exploded = false 
--		return 
--	end
--	
--	if not self.Smoke then
--		gred.CreateExplosion(pos,self.ExplosionRadius,self.ExplosionDamage * gred.CVars.gred_sv_shell_gp_he_damagemultiplier:GetFloat(),self.Decal,self.TraceLength,self.Owner,self,self.DEFAULT_PHYSFORCE,self.DEFAULT_PHYSFORCE_PLYGROUND,self.DEFAULT_PHYSFORCE_PLYAIR)
--	end
--	
--	if not self.NO_EFFECT then
--		net.Start("gred_net_createparticle")
--		
--		if self:WaterLevel() >= 1 then
--			local tr = util.TraceLine({
--				start   = util.TraceLine({
--					start   = pos,
--					endpos  = pos + trlength,
--					filter  = self,
--				}).HitPos,
--				endpos  = pos - trlength,
--				filter  = self,
--				mask    = MASK_WATER + CONTENTS_TRANSLUCENT,
--			})
--
--			if tr.Hit then
--				net.WriteString(self.EffectWater) -- FIXME : Optimize
--				net.WriteVector(tr.HitPos)
--				net.WriteAngle(self.EffectWater == "ins_water_explosion" and angle_1 or angle_zero)
--				net.WriteBool(false)
--			end
--			
--			if !self.Smoke then
--				if self.WaterExplosionSound then 
--					self.ExplosionSound = self.WaterExplosionSound 
--				end
--				if self.WaterFarExplosionSound then
--					self.FarExplosionSound = self.WaterFarExplosionSound 
--				end
--			end
--		else
--			local tr = util.TraceLine({
--			start    = pos,
--			endpos   = pos - Vector(0,0,self.TraceLength),
--			filter   = self})
--			
--			net.WriteString(tr.HitWorld and self.Effect or self.EffectAir) -- FIXME : Optimize
--			net.WriteVector(pos)
--			net.WriteAngle(self.AngEffect and angle_1 or angle_zero)
--			net.WriteBool(tr.HitWorld)
--		end
--		
--		net.Broadcast()
--	end
--	gred.CreateSound(pos,nil,self.ExplosionSound,self.FarExplosionSound,self.DistExplosionSound) -- FIXME : Replace self.RSound == 1 with an actual bool
--
--	self.Exploded=true
--	local SelfPos,Att,Dir=self:GetPos()+Vector(30,0,0),self.Owner,self:GetForward()
--	---
--	util.ScreenShake(SelfPos,1000,3,2,1500)
--	self:EmitSound("snd_jack_fragsplodeclose.wav",90,100)
--	---
--	for i=1,10 do
--		util.BlastDamage(self.Owner,Att,SelfPos+Dir*30*i,500-i*7,math.random(300,3000)-i*290)
--	end
--	for k,ent in pairs(ents.FindInSphere(SelfPos,200))do
--		if(ent:GetClass()=="npc_helicopter")then ent:Fire("selfdestruct","",math.Rand(0,2)) end
--	end
--	---
--	timer.Simple(.2,function()
--		local Tr=util.QuickTrace(SelfPos-Dir*100,Dir*300)
--		if(Tr.Hit)then util.Decal("Scorch",Tr.HitPos+Tr.HitNormal,Tr.HitPos-Tr.HitNormal) end
--	end)
--	---
--	self:Remove()
--	local Ang=self:GetAngles()
--	Ang:RotateAroundAxis(Ang:Forward(),-90)
--	timer.Simple(.1,function()
--		ParticleEffect("50lb_air",SelfPos+Dir*130,Ang)
--		ParticleEffect("50lb_air",SelfPos,Ang)
--		ParticleEffect("50lb_air",SelfPos-Dir*50,Ang)
--	end)
--	timer.Simple(0,function()
--		if !IsValid(self) then return end
--		self:Remove()
--	end)
--end
--

function ENT:DoPreInit()
	self.ExplosionSound	= CloseExploSnds[math.random(#CloseExploSnds)]
	self.FarExplosionSound	= ExploSnds[math.random(#ExploSnds)]
	self.DistExplosionSound	= DistExploSnds[math.random(#DistExploSnds)]
	self.WaterExplosionSound	= CloseWaterExploSnds[math.random(#CloseWaterExploSnds)]
	self.WaterFarExplosionSound	= WaterExploSnds[math.random(#WaterExploSnds)]
end


if CLIENT then function ENT:Think() end end