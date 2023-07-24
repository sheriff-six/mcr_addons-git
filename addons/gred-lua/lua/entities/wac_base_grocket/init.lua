
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Penetration = 1100
ENT.Caliber = 180
ENT.ShellType	= "HEAT"

local ExploSnds = {}
ExploSnds[1]                         =  "explosions/doi_ty_01.wav"
ExploSnds[2]                         =  "explosions/doi_ty_02.wav"
ExploSnds[3]                         =  "explosions/doi_ty_03.wav"
ExploSnds[4]                         =  "explosions/doi_ty_04.wav"

local CloseExploSnds = {}
CloseExploSnds[1]                         =  "explosions/doi_ty_01_close.wav"
CloseExploSnds[2]                         =  "explosions/doi_ty_02_close.wav"
CloseExploSnds[3]                         =  "explosions/doi_ty_03_close.wav"
CloseExploSnds[4]                         =  "explosions/doi_ty_04_close.wav"

local DistExploSnds = {}
DistExploSnds[1]                         =  "explosions/doi_ty_01_dist.wav"
DistExploSnds[2]                         =  "explosions/doi_ty_02_dist.wav"
DistExploSnds[3]                         =  "explosions/doi_ty_03_dist.wav"
DistExploSnds[4]                         =  "explosions/doi_ty_03_dist.wav"

local WaterExploSnds = {}
WaterExploSnds[1]                         =  "explosions/doi_ty_01_water.wav"
WaterExploSnds[2]                         =  "explosions/doi_ty_02_water.wav"
WaterExploSnds[3]                         =  "explosions/doi_ty_03_water.wav"
WaterExploSnds[4]                         =  "explosions/doi_ty_04_water.wav"

local CloseWaterExploSnds = {}
CloseWaterExploSnds[1]                         =  "explosions/doi_ty_01_closewater.wav"
CloseWaterExploSnds[2]                         =  "explosions/doi_ty_02_closewater.wav"
CloseWaterExploSnds[3]                         =  "explosions/doi_ty_03_closewater.wav"
CloseWaterExploSnds[4]                         =  "explosions/doi_ty_04_closewater.wav"
if SERVER then util.AddNetworkString("gred_net_wacrocket_explosion_fx") end
function ENT:Initialize()
	math.randomseed(CurTime())
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.phys = self.Entity:GetPhysicsObject()
	if (self.phys:IsValid()) then
		self.phys:SetMass(400)
		self.phys:EnableGravity(false)
		self.phys:EnableCollisions(true)
		self.phys:EnableDrag(false)
		self.phys:Wake()
	end
	self.sound = CreateSound(self.Entity, "")
	self.matType = MAT_DIRT
	self.ExplosionSound                  =  table.Random(CloseExploSnds)
	self.FarExplosionSound				 =  table.Random(ExploSnds)
	self.DistExplosionSound				 =  table.Random(DistExploSnds)
	self.WaterExplosionSound			 =  table.Random(CloseWaterExploSnds)
	self.WaterFarExplosionSound			 =  table.Random(WaterExploSnds)
	self.Damage = self.Damage * math.random(15,30)
end

function ENT:Explode(tr)
	if self.Exploded then return end
	self.Exploded = true
	
	local effectdata = EffectData()
    if(self:WaterLevel() >= 1) then
		effectdata:SetFlags(table.KeyFromValue(gred.Particles,"ins_water_explosion"))
		effectdata:SetOrigin(WaterHitPos)
		effectdata:SetAngles(Angle(-90))
		self.ExplosionSound =  self.WaterExplosionSound
		self.FarExplosionSound = self.WaterFarExplosionSound
	else
		if self.hellfire then
			effectdata:SetFlags(table.KeyFromValue(gred.Particles,"high_explosive_main_2"))
		else
			effectdata:SetFlags(table.KeyFromValue(gred.Particles,"100lb_air"))
		end
		effectdata:SetOrigin(tr.HitPos)
		effectdata:SetAngles(Angle(0))
	end
	util.Effect("gred_particle_simple",effectdata)
	
	local expl = ents.Create("env_physexplosion")
	if !self.hellfire then
		gred.CreateSound(pos,false,self.ExplosionSound,self.FarExplosionSound,self.DistExplosionSound)
		gred.CreateExplosion(pos,self.Radius * 0.5,self.Damage,"scorch_medium",100,self.Owner,self)
	else
		self.Damage = self.Damage * 2
		gred.CreateSound(pos,true,"explosions/gbomb_4.mp3","explosions/gbomb_4.mp3","explosions/gbomb_4.mp3")
		gred.CreateExplosion(pos,self.Radius * 1.5,self.Damage,"scorch_medium",100,self.Owner,self)
	end
	
	if IsValid(tr.Entity) and tr.Entity.GRED_TANK and tr.Entity.CachedSpawnList and gred.simfphys[tr.Entity.CachedSpawnList] and gred.simfphys[tr.Entity.CachedSpawnList].Armour then
		tr = gred.GetImpactInfo(tr,tr.Entity)
		local ArmourThickness = 0
		local AbsImpactAng = math.abs(tr.HitNormalAngle.p)
		
		if AbsImpactAng > 10 and gred.SLOPE_MULTIPLIERS[self.ShellType] then
			local prev
			
			for k,v in SortedPairs(gred.SLOPE_MULTIPLIERS[self.ShellType]) do
				if k > AbsImpactAng then
					prev = prev + 2.5 < AbsImpactAng and k or prev -- if we're closer to k than prev, we make k prev so we can use it as a var
					break
				else
					prev = k
				end
			end
			
			local Slope = gred.SLOPE_MULTIPLIERS[self.ShellType][prev]["a"] * (tr.ArmourThicknessKE / self.Caliber)^gred.SLOPE_MULTIPLIERS[self.ShellType][prev]["b"]
			local Normalization = math.deg(math.acos(1/Slope)) - AbsImpactAng
			
			tr.HitNormalAngle.p = tr.HitNormalAngle.p + Normalization
			tr.NormalNormalizedAngle = Angle(tr.NormalAngle.p + Normalization,tr.NormalAngle.y,tr.NormalAngle.r)
			tr.NormalNormalized = tr.NormalNormalizedAngle:Forward()
		else
			tr.NormalNormalizedAngle = tr.NormalAngle
			tr.NormalNormalized = tr.Normal
		end
		
		tr = gred.CalculateArmourThickness(tr,tr.Entity,0)
		local HP
		
		if gred.CVars.gred_sv_simfphys_realisticarmour:GetBool() then
			ArmourThickness = gred.IS_HEAT[self.ShellType] and tr.EffectiveArmourThicknessCHEMICAL or tr.EffectiveArmourThicknessKE
		else
			HP = tr.Entity:GetMaxHealth()*0.01 / gred.CVars.gred_sv_simfphys_health_multplier:GetFloat()
			ArmourThickness = HP / tr.CalculatedImpactCos
		end
		
		Fraction = ArmourThickness / self.Penetration
		self.Fraction = Fraction
		
		tr.ShellLastVel = self:GetVelocity():Length()
		tr.ShellPenTraceLength = tr.ShellLastVel
		tr.ShellExplodePos = tr.HitPos + tr.NormalNormalized * tr.ShellPenTraceLength
		tr.Caliber = 180
		
		local ShrapnelTab = {
			[0] = { -- HEADER
				[1] = tr.LocalHitPos, -- ShellHitPos
				[2] = tr.ShellPenTraceLength, -- ShellPenLength
				[3] = tr.Entity.ModelSizeLength, -- ModelSizeLength -- the client should do that on his side tbh
				[4] = tr.Entity:WorldToLocalAngles(tr.NormalNormalizedAngle), -- NormalNormalized
				[5] = self.Caliber, -- Caliber
				[6] = self.Fraction >= 1,
				[7] = tr.Entity:GetModel(),
				[8] = tr.Entity:GetSkin(),
				[9] = self.Damage,
				[10] = math.Round(self.Penetration),
				[11] = math.Round(ArmourThickness),
				[12] = self.ShrapnelPen,
				[13] = self.ShrapnelBoom,
				[14] = nil, -- let the client calculate that
				[15] = 1, -- let the client calculate that
			},
		}
		self.EntityHit = tr.Entity
		if Fraction < 1 then
			local dmg = DamageInfo()
			dmg:SetAttacker(self.Owner)
			dmg:SetInflictor(self)
			dmg:SetDamagePosition(tr.HitPos)
			dmg:SetDamage(self.Damage * 2)
			dmg:SetDamageType(64) -- DMG_BLAST
			dmg:SetDamageCustom(self:EntIndex())
			tr.Entity:TakeDamageInfo(dmg)
		end
		
		
		if IsValid(self.Owner) and self.Owner:IsPlayer() and gred.CVars.gred_sv_shell_enable_killcam:GetBool() then
			local CompressedTab = util.Compress(util.TableToJSON(ShrapnelTab))
			local len = CompressedTab:len()
			
			net.Start("gred_net_shell_shrapnel_windows_send")
				net.WriteUInt(len,14)
				net.WriteData(CompressedTab,len)
			net.Send(self.Owner)
		end
	end
	
	self:Remove()
end

function ENT:StartRocket()
	if self.Started then return end	
	self.Owner = self.Owner or self.Entity
	self.Fuel=self.Fuel or 1000
	self.Started = true
	local pos = self:GetPos()
	local ang = self:GetAngles()
	ParticleEffectAttach("ins_rockettrail",PATTACH_ABSORIGIN_FOLLOW,self.Entity,1)
	local light = ents.Create("env_sprite")
	light:SetPos(self.Entity:GetPos())
	light:SetKeyValue("renderfx", "0")
	light:SetKeyValue("rendermode", "5")
	light:SetKeyValue("renderamt", "255")
	light:SetKeyValue("rendercolor", "250 200 100")
	light:SetKeyValue("framerate12", "20")
	light:SetKeyValue("model", "light_glow03.spr")
	light:SetKeyValue("scale", "0.4")
	light:SetKeyValue("GlowProxySize", "50")
	light:Spawn()
	light:SetParent(self.Entity)
	self.sound:Play()
	self.OldPos=self:GetPos()
	self.phys:EnableCollisions(false)
end

function ENT:OnRemove()
	self.sound:Stop()
end

function ENT:GetFuelMul()
	self.MaxFuel=self.MaxFuel or self.Fuel or 0
	if self.Fuel then
		return math.Clamp(self.Fuel/self.MaxFuel*5,0,1)
	end
	return 1
end

function ENT:PhysicsUpdate(ph)
	if !self.Started or self.HasNoFuel then return end
	pos = self:GetPos()
	local trd = {
		start = self.OldPos,
		endpos = pos,
		filter = {self,self.Owner,self.Launcher},
		mask = CONTENTS_SOLID + CONTENTS_MOVEABLE + CONTENTS_OPAQUE + CONTENTS_DEBRIS + CONTENTS_HITBOX + CONTENTS_MONSTER + CONTENTS_WINDOW
	}
	local tr = util.TraceLine(trd)
	
	local trd2 = {
		start   = self.OldPos,
		endpos  = pos,
		filter  = self,
		mask    = MASK_WATER
	}
	local tr2 = util.TraceLine(trd2)
	if tr2.Hit then WaterHitPos = tr2.HitPos end
	
	if tr.Hit and !self.Exploded then
		if tr.HitSky then self:Remove() return end
		util.Decal("Scorch", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)
		self.matType = tr.MatType
		self.hitAngle = tr.HitNormal:Angle()
		self:Explode(tr)
		return
	end
	self.OldPos = trd.endpos
	local vel = self:WorldToLocal(self:GetPos()+self:GetVelocity())*0.4
	vel.x = 0
	local m = self:GetFuelMul()
	ph:AddVelocity(self:GetForward()*m*self.Speed-self:LocalToWorld(vel*Vector(0.1, 1, 1))+self:GetPos())
	ph:AddAngleVelocity(
		ph:GetAngleVelocity()*-0.4
		+ Vector(math.Rand(-1,1), math.Rand(-1,1), math.Rand(-1,1))*5
		+ Vector(0, -vel.z, vel.y)
	)
	if self.calcTarget then
		local target = self:calcTarget()
		local dist = self:GetPos():Distance(target)
		if dist > 2000 then
			target = target + Vector(0,0,200)
		end
		local v = self:WorldToLocal(target + Vector(
			0, 0, math.Clamp((self:GetPos()*Vector(1,1,0)):Distance(target*Vector(1,1,0))/5 - 50, 0, 1000)
		)):GetNormal()
		v.y = math.Clamp(v.y*10,-0.5,0.5)*300
		v.z = math.Clamp(v.z*10,-0.5,0.5)*300
		self:TakeFuel(math.abs(v.y) + math.abs(v.z))
		ph:AddAngleVelocity(Vector(0,-v.z,v.y))
	end
	self:TakeFuel(self.Speed)
end

function ENT:TakeFuel(amt)
	self.Fuel = self.Fuel-amt/10*FrameTime()
	if self.Fuel < 0 then
		self:Remove()
	end
end

function ENT:Think()
	if self.StartTime and self.StartTime < CurTime() and !self.Started then
		self:StartRocket()
	end
end
