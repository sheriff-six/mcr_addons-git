local ENTITY = FindMetaTable("Entity")
local netStart = net.Start
local netWriteEntity = net.WriteEntity
local netBroadcast = net.Broadcast
local GetAttachment = ENTITY.GetAttachment
local random = math.random
local SetNWInt = ENTITY.SetNWInt
local netWriteUInt = net.WriteUInt

util.PrecacheModel("models/gredwitch/viewports/shelbys_commander_viewport.mdl")
util.PrecacheModel("models/gredwitch/viewports/shelbys_driver_viewport.mdl")

sound.Add({
	name = "T72B3_RELOAD",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 80,
	sound = "^t72b3/t72_cannon_reload.wav"
})

sound.Add({
	name = "T72B3_TURRET_MOVE",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 90,
	sound = "^t72b3/t72_turret_move.wav"
})

sound.Add({
	name = "T72B3_CANNON_FIRE_INSIDE",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 0,
	sound = "^t72b3/t72_interior_cannon_fire.ogg"
})

sound.Add({
	name = "T72B3_CANNON_FIRE",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 160,
	sound = "^t72b3/cannon_125mm_2a46_shot_01.wav"
})

sound.Add({
	name = "T72B3_ATGM_FIRE",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 160,
	sound = "^t72b3/rocket_shot_03.wav"
})

sound.Add({
	name = "SHELBY_PKT_LOOP",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 130,
	sound = "^t72b3/pkt_l.wav"
})

sound.Add({
	name = "SHELBY_PKT_LOOP_INSIDE",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 130,
	sound = "^t72b3/pkt_idl.wav"
})

sound.Add({
	name = "SHELBY_MG_PKT_LASTSHOT_01",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 130,
	sound = "^t72b3/pkt_t.wav"
})

sound.Add({
	name = "SHELBY_MG_PKT_LASTSHOT_INSIDE_01",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 130,
	sound = "^t72b3/pkt_idt.wav"
})


-- CUSTOM SHELL TYPES FOR SHELBYS' TANKS --

hook.Add("GredAmmoBoxAddShell","2A46MSMOOTHBOREGUNSHELLS",function(SHELLS)
	SHELLS["125"] = {
		["AP"] = true,
		["APBC"] = true,
		["APC"] = true,
		["APCBC"] = true,
		["APCR"] = true,
		["APDS"] = true,
		["APFSDS"] = true,
		["APHE"] = true,
		["APHEBC"] = true,
		["APHECBC"] = true,
		["HE"] = true,
		["HEAT"] = true,
		["HEATFS"] = true,
		["Smoke"] = true,
	}
end)

hook.Add("GredAmmoBoxAddShell","ORDBL65INSHELLS",function(SHELLS)
	SHELLS["165"] = {
		["AP"] = true,
		["APBC"] = true,
		["APC"] = true,
		["APCBC"] = true,
		["APCR"] = true,
		["APDS"] = true,
		["APFSDS"] = true,
		["APHE"] = true,
		["APHEBC"] = true,
		["APHECBC"] = true,
		["HE"] = true,
		["HEAT"] = true,
		["HEATFS"] = true,
		["Smoke"] = true,
	}
end)

hook.Add("GredAmmoBoxAddShell","115MILIMETERSHELLS",function(SHELLS)
	SHELLS["115"] = {
		["AP"] = true,
		["APBC"] = true,
		["APC"] = true,
		["APCBC"] = true,
		["APCR"] = true,
		["APDS"] = true,
		["APFSDS"] = true,
		["APHE"] = true,
		["APHEBC"] = true,
		["APHECBC"] = true,
		["HE"] = true,
		["HEAT"] = true,
		["HEATFS"] = true,
		["Smoke"] = true,
	}
end)

hook.Add("GredAmmoBoxAddShell","BMP173MMROCKETSHELLS",function(SHELLS)
	SHELLS["73"] = {
		["AP"] = true,
		["APBC"] = true,
		["APC"] = true,
		["APCBC"] = true,
		["APCR"] = true,
		["APDS"] = true,
		["APFSDS"] = true,
		["APHE"] = true,
		["APHEBC"] = true,
		["APHECBC"] = true,
		["HE"] = true,
		["HEAT"] = true,
		["HEATFS"] = true,
		["Smoke"] = true,
	}
end)

hook.Add("GredAmmoBoxAddShell","83MILIMETERMISCSHELLS",function(SHELLS)
	SHELLS["83"] = {
		["AP"] = true,
		["APBC"] = true,
		["APC"] = true,
		["APCBC"] = true,
		["APCR"] = true,
		["APDS"] = true,
		["APFSDS"] = true,
		["APHE"] = true,
		["APHEBC"] = true,
		["APHECBC"] = true,
		["HE"] = true,
		["HEAT"] = true,
		["HEATFS"] = true,
		["Smoke"] = true,
	}
end)

hook.Add("GredAmmoBoxAddShell","84MILIMETERMISCSHELLS",function(SHELLS)
	SHELLS["84"] = {
		["AP"] = true,
		["APBC"] = true,
		["APC"] = true,
		["APCBC"] = true,
		["APCR"] = true,
		["APDS"] = true,
		["APFSDS"] = true,
		["APHE"] = true,
		["APHEBC"] = true,
		["APHECBC"] = true,
		["HE"] = true,
		["HEAT"] = true,
		["HEATFS"] = true,
		["Smoke"] = true,
	}
end)

-- END OF CUSTOM SHELL TYPES FOR SHELBYS' TANKS --

local Type
function table.FullCopy(tab)
	if (!tab) then return nil end
	
	local res = {}
	for k,v in pairs(tab) do
		Type = type(v)
		
		if Type == "table" then
			res[k] = table.FullCopy(v)
		elseif Type == "Vector" then
			res[k] = Vector(v.x,v.y,v.z)
		elseif Type == "Angle" then
			res[k] = Angle(v.p,v.y,v.r)
		else
			res[k] = v
		end
	end
	
	return res
end

list.Set("simfphys_lights","t72b3",{
	L_HeadLampPos = Vector(110,34.5,50),
	R_HeadLampPos = Vector(110,34.5,50),
	L_HeadLampAng = Angle(15,0,0),
	R_HeadLampAng = Angle(15,0,0),
	
	Headlight_sprites = { 
		Vector(110,34.5,50),
		Vector(110,34.5,50),
	},
	
	Brakelight_sprites = {
		Vector(-138,-50,53),
		Vector(-138,-50,53),
	},
	Rearlight_sprites = {
		Vector(-138,-50,53),
		Vector(-138,-50,53),
	},

})

list.Set("simfphys_vehicles","gred_simfphys_t72b3_custom",{
	Name = "T-72B3", 
	Model = Model("models/vehicles_merydian/tanks/t72b3/t72b3.mdl"),
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Shelby's Playground {Simfphys}",
	SpawnOffset = Vector(0,0,10),
	SpawnAngleOffset = 0,

	Members = {
		Mass = 9300,
		AirFriction = 0,
		Inertia = Vector(20000,90000,100000),
		
		LightsTable = "t72b3",
		
		ApplyDamage = function( ent, damage, type ) 
			simfphys.TankApplyDamage(ent, damage, type)
		end,	

		OnDestroyed = function(ent)
			local gib = ent.Gib
			if !IsValid(gib) then return end
			
			local pos,ang,skin,pitch,yaw = gib:GetPos(),gib:GetAngles(),gib:GetSkin(),ent:GetPoseParameter("cannon_aim_pitch"),ent:GetPoseParameter("cannon_aim_yaw")
			gib:SetPoseParameter("cannon_aim_pitch",pitch)
			gib:SetPoseParameter("cannon_aim_yaw",yaw)
			
			local function CreateAmmoFire(gib,ang)
				local bonepos = gib:GetBonePosition(gib:LookupBone("turret_root"))
				gib.AmmoFire = ents.Create("info_particle_system")
				gib.AmmoFire:SetKeyValue("effect_name","flame_jet")
				gib.AmmoFire:SetKeyValue("start_active",1)
				gib.AmmoFire:SetOwner(gib)
				gib.AmmoFire:SetPos(bonepos)
				gib.AmmoFire:SetAngles(ang)
				gib.AmmoFire:Spawn()
				gib.AmmoFire:Activate()
				gib.AmmoFire:SetParent(gib)
				
				gib.AmmoFireSound = CreateSound(gib,"gredwitch/burning_jet.wav")
				gib.AmmoFireSound:SetSoundLevel(120)
				gib.AmmoFireSound:Play()
				gib:CallOnRemove("removesnd",function(gib)
					gib.AmmoFireSound:Stop()
				end)
			end
			
			local function CreateTurret(gib,ang,pitch,yaw)

				
				local bonepos = gib:GetBonePosition(gib:LookupBone("turret_root"))
				local prop = ents.Create("prop_physics")
				prop:SetAngles(ang + Angle(pitch,yaw))
				prop:SetPos(bonepos)
				prop:SetMaterial( "models/player/player_chrome1" )
				prop:SetRenderMode( RENDERMODE_NORMAL )
				gib.Turret = prop
				
				gib:CallOnRemove("removeturret",function(gib)
					if IsValid(gib.Turret) then gib.Turret:Remove() end
				end)
			end
			
			local function StopAmmoFire(gib)
				gib.AmmoFire:Remove()
				gib.AmmoFireSound:Stop()
			end
			
			local function CreateExplosion(gib,ang)
				local pos = gib:LocalToWorld(Vector(-10,0,40))
				net.Start("gred_net_createparticle")
					net.WriteString("doi_flak88_explosion")
					net.WriteVector(pos)
					net.WriteAngle(ang)
					net.WriteBool(false)
				net.Broadcast()
				gred.CreateSound(pos,false,"explosions/fuel_depot_explode_close.wav","explosions/fuel_depot_explode_dist.wav","explosions/fuel_depot_explode_far.wav")
			end
			
			gred.TankDestruction(ent,gib,ang,skin,pitch,yaw,CreateAmmoFire,StopAmmoFire,CreateExplosion,CreateTurret)
		end,

		
		MaxHealth = 40000,
		
		IsArmored = true,
		
		NoWheelGibs = true,
		
		FirstPersonViewPos = Vector(0,0,0),
		
		FrontWheelRadius = 20,
		RearWheelRadius = 20,
		
		EnginePos = Vector(-74,0,48),
		
		CustomWheels = true,
		
		CustomWheelModel = "models/props_c17/canisterchunk01g.mdl",
		
		CustomWheelPosFL = Vector(73,60,12),
		CustomWheelPosFR = Vector(73,-60,12),
		
		CustomWheelPosML = Vector(0,60,12),
		CustomWheelPosMR = Vector(0,-60,12),
		
		CustomWheelPosRL = Vector(-69,60,12),
		CustomWheelPosRR = Vector(-69,-60,12),
		CustomWheelAngleOffset = Angle(0,180,0),
		
		CustomMassCenter = Vector(0,0,0),
		
		CustomSteerAngle = 1,
		FastSteeringAngle = 1,
		SteeringFadeFastSpeed = 1,
		
		TurnSpeed = 1,
		
		SeatOffset = Vector(62,0,47),
		SeatPitch = 0,
		SeatYaw = 90,
		
		ModelInfo = {
			WheelColor = Color(0,0,0,0),
			-- WheelColor = Color(0,0,0,255),
		},
		
		ExhaustPositions = {
			{
				pos = Vector(-76,73,53),
				ang = Angle(-90,-90,-10)
			},
			{
				pos = Vector(-76,73,53),
				ang = Angle(-90,-90,-10)
			},
			{
				pos = Vector(-76,73,53),
				ang = Angle(-90,-90,-10)
			},
			{
				pos = Vector(-76,73,53),
				ang = Angle(-90,-90,-10)
			},
			{
				pos = Vector(-66,73,53),
				ang = Angle(-90,-90,-10)
			},
			{
				pos = Vector(-66,73,53),
				ang = Angle(-90,-90,-10)
			},
			{
				pos = Vector(-66,73,53),
				ang = Angle(-90,-90,-10)
			},
			{
				pos = Vector(-66,73,53),
				ang = Angle(-90,-90,-10)
			},
			{
				pos = Vector(-86,73,53),
				ang = Angle(-90,-90,-10)
			},
			{
				pos = Vector(-86,73,53),
				ang = Angle(-90,-90,-10)
			},
			{
				pos = Vector(-86,73,53),
				ang = Angle(-90,-90,-10)
			},
			{
				pos = Vector(-86,73,53),
				ang = Angle(-90,-90,-10)
			},
		},
		
		PassengerSeats = {
			{
				pos = Vector(-18,21,40),
				ang = Angle(0,-90,0)
			},
			{
				pos = Vector(-18,-21,40),
				ang = Angle(0,90,0)
			},
		},
		
		CustomSuspensionTravel = 5,
		
		FrontHeight = -1,
		FrontConstant = 37000,
		FrontDamping = 42800,
		FrontRelativeDamping = 5500,
		
		RearHeight = -1,
		RearConstant = 37000,
		RearDamping = 42800,
		RearRelativeDamping = 5500,
		
		MaxGrip = 1000,
		Efficiency = 1.2,
		GripOffset = -300,
		BrakePower = 80,
		BulletProofTires = true,
		
		IdleRPM = 600,
		LimitRPM = 6000,
		PeakTorque = 100,
		PowerbandStart = 600,
		PowerbandEnd = 5500,
		Turbocharged = false,
		Supercharged = false,
		DoNotStall = false,
		
		FuelFillPos = Vector(-208.824,-52.8,47.256),
		FuelType = FUELTYPE_DIESEL,
		FuelTankSize = 600,
		
		PowerBias = -0.4,
		
		EngineSoundPreset = 0,
		
		Sound_Idle = "t72b3/t90a_engine_rpm_00.wav",
		Sound_IdlePitch = 1,
		
		Sound_Mid = "t72b3/t90a_engine_rpm_66.wav",
		Sound_MidPitch = 1,
		Sound_MidVolume = 0.9,
		Sound_MidFadeOutRPMpercent = 100,
		Sound_MidFadeOutRate = 1,
		
		Sound_High = "t72b3/t90a_engine_rpm_99.wav",
		Sound_HighPitch = 1,
		Sound_HighVolume = 1,
		Sound_HighFadeInRPMpercent = 50,
		Sound_HighFadeInRate = 0.2,
		
		Sound_Throttle = "",
		Sound_ThrottlePitch = 0,
		Sound_ThrottleVolume = 0,
		
		snd_horn = "common/null.wav",
		ForceTransmission = 1,
		
		DifferentialGear = 0.4,
		Gears = {-0.06,0,0.06,0.08,0.1,0.12,0.13}
	}
})


gred = gred or {}
gred.simfphys = gred.simfphys or {}

local T72B3_SusData = {}

local Maxs = Vector(15,15,0)

for i = 1,6 do
	T72B3_SusData[i] = { 
		Attachment = "susp_att_l_"..i,
		PoseParameter = "suspension_left_"..i,
		PoseParameterMultiplier = 1,
		-- ReversePoseParam = true,
		Height = 11.5,
		GroundHeight = -38,
		Mins = -Maxs,
		Maxs = Maxs,
	}
	
	T72B3_SusData	[i + 6] = { 
		Attachment = "susp_att_r_"..i,
		PoseParameter = "suspension_right_"..i,
		PoseParameterMultiplier = 1,
		-- ReversePoseParam = true,
		Height = 11.5,
		GroundHeight = -38,
		Mins = -Maxs,
		Maxs = Maxs,
	}
end

gred.simfphys["gred_simfphys_t72b3_custom"] = {
	Seats = {
		[0] = { -- Driver
			ArcadeMode = {
				PlayerBoneManipulation = {
					["ValveBiped.Bip01_R_Thigh"] = Angle(-40,-60),
					["ValveBiped.Bip01_L_Thigh"] = Angle(40,-60),
				},
				
				ViewAttachment = "gunner_sight",
				FirstPersonViewPos = Vector(5,0,5),
				ThirdPersonViewPos = Vector(0,70,80),
				
				MuzzleDirection = Vector(0,0.5,0),
				MuzzleAttachment = "cannon_muzzle",
				FirstPersonViewPosIsInside = true,
				TraverseIndicator = "cannon_aim_yaw",
				SynchronousElevation = true,
				
				Sight = {
					SightPosOffset = Vector(50,-20,0),
					SightAngOffset = Angle(0,0,0),
					SightAttachment = "gunner_sight",
					SightFOV = 50,
					SightFOVZoom = 40, -- ammount of FOV to remove, not the actual zoom value
					Stabilizer = true,
					SightMaterial = "gredwitch/overlay_russian_tanksight_t90a",
				},
				
				ViewPort = {
					Attachment = "gunner_sight",
					Pos = Vector(0,0,0),
					Ang = Angle(),
					
					MinAng = Angle(-90,-90,-90),
					MaxAng = Angle(90,90,90),
					
					-- ModelAngOffset = Angle(0,180),
					
					-- Model = "models/gredwitch/viewports/viewport_gunner.mdl",
					-- ModelPosOffset = Vector(0,0,0),
					-- Model = "models/gredwitch/viewports/viewport_driver_alt.mdl",
					-- ModelPosOffset = Vector(0,0,0),
				},
				
				Hatches = {
					{
						PoseParameters = {
							"hatch_driver",
						},
						ViewAttachment = "",
						PosOffset = Vector(0,3,10),
						AngOffset = Angle(0,0,0),
						PlayerBoneManipulation = {
							["ValveBiped.Bip01_R_Calf"] = Angle(10,20,0),
							["ValveBiped.Bip01_L_Calf"] = Angle(-10,20,0),
							
							["ValveBiped.Bip01_R_Thigh"] = Angle(0,-60,0),
							["ValveBiped.Bip01_L_Thigh"] = Angle(0,-60,0),
							
							["ValveBiped.Bip01_R_Foot"] = Angle(0,0),
							["ValveBiped.Bip01_L_Foot"] = Angle(0,0),
							
							-- ["ValveBiped.Bip01_R_Bicept"] = Angle(90,0),
							-- ["ValveBiped.Bip01_L_Bicept"] = Angle(90,0),
						},
					},
				},
				
				SmokeLaunchers = {
					"smoke_1",
					"smoke_2",
					"smoke_3",
					"smoke_4",
					"smoke_5",
					"smoke_6",
					"smoke_7",
					"smoke_8",
				},
			
				Primary = {
					{
						OnFire = function(vehicle,seat,ply,ct,SeatTab,WeaponTab,SeatID,SeatSlotTab,SlotID,k,v,shell,phy)
							
							timer.Create(tostring(seat).."0",1.5,1,function()
								if not IsValid(vehicle) then return end
								
								local Pos,Ang = vehicle:GetBonePosition(vehicle:LookupBone("turret_ejector"))
								Ang.y = Ang.y + -90
								
								local shell = ents.Create("gred_prop_casing")
								local c = constraint.NoCollide(shell,vehicle,0,0)
								shell.Model = "models/tankshell/tankshell.mdl"
								shell:SetPos(Pos)
								shell:SetAngles(Ang)
								shell.BodyGroupA = 1
								shell.BodyGroupB = 2
								shell:Spawn()
								shell:SetModelScale(WeaponTab.ShellTypes[SeatSlotTab.CurShellID].Caliber / 75)
								shell:Activate()
								
								local phys = shell:GetPhysicsObject()
								if IsValid(phys) then
									phys:AddVelocity(Ang:Forward()*100 + vehicle:GetVelocity())
								end
								
								timer.Simple(0.1,function()
									if IsValid(c) then c:Remove() end
								end)
							end)
						end,

						AutoLoader = true,
						Type = "Cannon",
						
						ReloadTime = 7.1,
						ShootAnimation = "fire",
						GunBreachModuleID = 0, -- Module ID
						
						Sounds = {
							Shoot = {
								"T72B3_CANNON_FIRE",
							},
							ShootInside = {
								"T72B3_CANNON_FIRE_INSIDE"
							},
							Reload = {
								"T72B3_RELOAD",
							},
						},
						MuzzleFlash = "gred_arti_muzzle_blast_alt",
						Muzzles = {
							"cannon_muzzle",
						},
						
						ShellTypes = {
							{
								Caliber = 125,
								ShellType = "HEATFS",
								ExactShellType = "HEATFS 3BK18M",
								MuzzleVelocity = 905,
								Mass = 19,
								TNTEquivalent = 2.79,
								LinearPenetration = 550,
								TracerColor = "red",
							},
							{
								Caliber = 125,
								ShellType = "HE",
								ExactShellType = "HE 3OF26",
								MuzzleVelocity = 850,
								Mass = 23,
								CoreMass = 42.2,
								TNTEquivalent = 5.24,
								TracerColor = "green",
							},
							{
								Caliber = 125,
								ShellType = "APFSDS",
								ExactShellType = "APFSDS 3BM42",
								MuzzleVelocity = 1700,
								Mass = 4.85,
								CoreMass = 42.6,
								TracerColor = "",
								ForceDragCoef = true,
							},
							{
								Caliber = 125,
								ShellType = "APFSDS",
								ExactShellType = "APFSDS 3BM60",
								MuzzleVelocity = 1660,
								Mass = 5.12,
								CoreMass = 64.6,
								TracerColor = "",
								ForceDragCoef = true,
							},
						},
						MaxAmmo = 45,
						RecoilForce = 25000,
					},
					{
						Type = "Custom",
						ExactType = "9M119M1 ATGM",
						Sequential = false,
						ReloadTime = 10,
						FireRate = 60 / 15,
						RocketLaserAttachment = "gunner_sight",
						InitSV = function(vehicle,seat,SeatSlotTab,WeaponTab,WepID)
							SeatSlotTab.Ammo = WeaponTab.Ammo
							SeatSlotTab.ReloadTime = WeaponTab.ReloadTime
							SeatSlotTab.FireRate = WeaponTab.FireRate / 60
							SeatSlotTab.NextShot = 0			
						end,
						Shoot = function(vehicle,seat,ply,ct,SeatTab,WeaponTab,SeatID,SeatSlotTab,SlotID)
							if WeaponTab.Ammo <= 0 then return end
							if SeatSlotTab.Ammo <= 0 then return end
							if WeaponTab.Sequential then
								SeatSlotTab.CurrentMuzzle = (SlotID and seat.Primary[SlotID] or seat.Secondary).CurrentMuzzle and (SlotID and seat.Primary[SlotID] or seat.Secondary).CurrentMuzzle or 1
								SeatSlotTab.CurrentMuzzle = SeatSlotTab.CurrentMuzzle > #WeaponTab.Muzzles and 1 or SeatSlotTab.CurrentMuzzle
								
								netStart("gred_net_simfphys_shoot_"..(SlotID and "primary" or "secondary").."_machinegun_sequential")
									netWriteEntity(seat)
									netWriteUInt(SeatSlotTab.CurrentMuzzle,5)
								netBroadcast()
								
								local ID = vehicle:LookupAttachment( WeaponTab.RocketLaserAttachment )
								local Attachment = vehicle:GetAttachment( ID )
								local TargetDir = Attachment.Ang:Forward()
								local tr = util.TraceHull( {
									start = Attachment.Pos,
									endpos = (Attachment.Pos + TargetDir  * 999999),
									mins = Vector( -1, -1, -1 ),
									maxs = Vector( 1, 1, 1 ),
									filter = vehicle
								} )		
								local att = GetAttachment(vehicle,SeatSlotTab.Muzzles[SeatSlotTab.CurrentMuzzle])
								local ent = ents.Create(WeaponTab.Rocket)
								ent.IsOnPlane = true
								ent:SetPos(att.Pos)
								ent:SetAngles(att.Ang + Angle(math.random(-WeaponTab.Spread,WeaponTab.Spread),math.random(-WeaponTab.Spread,WeaponTab.Spread,90)))
								ent.Owner = ply
								ent.JDAM = true
								ent.Launcher = vehicle
								ent.LaserGuided = true
								ent.LaserAttachment = WeaponTab.RocketLaserAttachment
								ent.Launcher = vehicle
								ent.target = tr.Entity
								ent.targetOffset = tr.Entity:WorldToLocal(tr.HitPos)
								ent:Spawn()
								ent:Activate()
								ent.StartSound = WeaponTab.SilenceRocket and "" or ent.StartSound
								ent:Launch()

								local phys = ent:GetPhysicsObject()
								ent.phys = ent:GetPhysicsObject()
								ent.phys:ApplyForceCenter(ent:GetAngles():Right()*100)
								ent.phys:ApplyForceCenter(ent:GetAngles():Forward()*5000)
								ent.phys:ApplyForceCenter(ent:GetAngles():Up()*700)
								for k,v in pairs(vehicle.FILTER) do
									constraint.NoCollide(ent,v,0,0)
								end
								
								SeatSlotTab.CurrentMuzzle = SeatSlotTab.CurrentMuzzle + 1
								
								SeatSlotTab.Ammo = SeatSlotTab.Ammo - 1
								
								if SeatSlotTab.Ammo < 1 then
									if WeaponTab.Sounds.Reload then
										seat:EmitSound(WeaponTab.Sounds.Reload[random(#WeaponTab.Sounds.Reload)])
									end
									
									SeatSlotTab.IsReloading = true
									
									timer.Simple(SeatSlotTab.ReloadTime,function()
										if !IsValid(vehicle) then return end
										if !IsValid(seat) then return end
										
										SeatSlotTab.IsReloading = false
										SeatSlotTab.Ammo = WeaponTab.Ammo
										SetNWInt(seat,SlotID and SlotID.."CurAmmo" or "SecondaryAmmo",SeatSlotTab.Ammo)
										
										if WeaponTab.OnReload then
											WeaponTab.OnReload(vehicle,seat,ply,ct,SeatTab,WeaponTab,SeatID,SeatSlotTab,SlotID)
										end
									end)
								end
							else
								netStart("gred_net_simfphys_shoot_"..(SlotID and "primary" or "secondary").."_machinegun")
									netWriteEntity(seat)
								netBroadcast()
								
								local phys
								local att
								local ent
								local v
								for k = 1,#WeaponTab.Muzzles do
									v = WeaponTab.Muzzles[k]
									if v then
										local ID = vehicle:LookupAttachment( WeaponTab.RocketLaserAttachment )
										local Attachment = vehicle:GetAttachment( ID )
										local TargetDir = Attachment.Ang:Forward()
										local tr = util.TraceHull( {
											start = Attachment.Pos,
											endpos = (Attachment.Pos + TargetDir  * 999999),
											mins = Vector( -1, -1, -1 ),
											maxs = Vector( 1, 1, 1 ),
											filter = vehicle
										} )		
										local att = GetAttachment(vehicle,SeatSlotTab.Muzzles[SeatSlotTab.CurrentMuzzle])
										local ent = ents.Create(WeaponTab.Rocket)
										ent.IsOnPlane = true
										ent.JDAM = true
										ent:SetPos(att.Pos)
										ent:SetAngles(att.Ang + Angle(math.random(-WeaponTab.Spread,WeaponTab.Spread),math.random(-WeaponTab.Spread,WeaponTab.Spread,90)))
										ent.Owner = ply
										ent.Launcher = vehicle
										ent.LaserGuided = true
										ent.LaserAttachment = WeaponTab.RocketLaserAttachment
										ent.Launcher = vehicle
										ent.target = tr.Entity
										ent.targetOffset = tr.Entity:WorldToLocal(tr.HitPos)
										ent:Spawn()
										ent:Activate()
										ent.StartSound = WeaponTab.SilenceRocket and "" or ent.StartSound
										ent:Launch()
										
										phys = ent:GetPhysicsObject()
										ent.phys = ent:GetPhysicsObject()
										ent.phys:ApplyForceCenter(ent:GetAngles():Right()*100)
										ent.phys:ApplyForceCenter(ent:GetAngles():Forward()*5000)
										ent.phys:ApplyForceCenter(ent:GetAngles():Up()*700)
										
										for k,v in pairs(vehicle.FILTER) do
											constraint.NoCollide(ent,v,0,0)
										end
										
										SeatSlotTab.Ammo = SeatSlotTab.Ammo - 1
										
										if WeaponTab.OnShoot then
											WeaponTab.OnShoot(vehicle,seat,ply,ct,SeatTab,WeaponTab,SeatID,SeatSlotTab,SlotID,k,att,ent)
										end
										
										if SeatSlotTab.Ammo < 1 then
											if WeaponTab.Sounds.Reload then 
												seat:EmitSound(WeaponTab.Sounds.Reload[random(#WeaponTab.Sounds.Reload)])
											end
											
											SeatSlotTab.IsReloading = true
											
											timer.Simple(SeatSlotTab.ReloadTime,function()
												if !IsValid(vehicle) then return end
												if !IsValid(seat) then return end
												
												SeatSlotTab.IsReloading = false
												SeatSlotTab.Ammo = WeaponTab.Ammo
												SetNWInt(seat,SlotID and SlotID.."CurAmmo" or "SecondaryAmmo",SeatSlotTab.Ammo)
												
												if WeaponTab.OnReload then
													WeaponTab.OnReload(vehicle,seat,ply,ct,SeatTab,WeaponTab,SeatID,SeatSlotTab,SlotID)
												end
											end)
											
											break
										end
									end
								end
							end
							
							SetNWInt(seat,SlotID and SlotID.."CurAmmo" or "SecondaryAmmo",SeatSlotTab.Ammo)
							
							SeatSlotTab.NextShot = ct + SeatSlotTab.FireRate
						end,
						CanShoot = function(vehicle,seat,ply,ct,SeatTab,WeaponTab,SeatID,SeatSlotTab,SlotID)
							return ct > SeatSlotTab.NextShot and SeatSlotTab.Ammo > 0
						end,
						Stop = function(vehicle,seat,ply,ct,SeatTab,WeaponTab,SeatID,SeatSlotTab,SlotID)
						end,	
						Sounds = {
							Shoot = {
								"T72B3_ATGM_FIRE",
							},
							Reload = {
								"T72B3_RELOAD",
							},
						},
									
						MuzzleFlash = "ins_weapon_rpg_backblast",
						Muzzles = {
							"cannon_muzzle",
						},
									
						SilenceRocket = false,
						Rocket = "gb_rocket_9m120",
									
						Ammo = 1,
						Spread = 0.05,
									
						-- OnShoot = function(vehicle,seat,ply,ct,SeatTab,WeaponTab,SeatID,SeatSlotTab,SlotID,CurrentMuzzle,att,ent)
						-- 	vehicle:SetBodygroup(CurrentMuzzle-2,1)
						-- end,
						
						-- OnReload = function(vehicle,seat,ply,ct,SeatTab,WeaponTab,SeatID,SeatSlotTab,SlotID)
						-- 	for i = 0,16 do
						-- 		vehicle:SetBodygroup(i,0)
						-- 	end
						-- end,
					},
				},
				Secondary = {
					Type = "MG",
					Caliber = "wac_base_7mm",
					ModuleID = 0,
					ExactCaliber = "PKT 7.62x54",
					Sequential = false,
					Muzzles = {
						"coax_muzzle",
					},
					FireRate = 700,
					Sounds = {
						Reload = {
							"GRED_M2HB_RELOAD",
						},
						Loop = {
							"SHELBY_PKT_LOOP",
						},
						LoopInside = {
							"SHELBY_PKT_LOOP_INSIDE",
						},
						Stop = {
							"SHELBY_MG_PKT_LASTSHOT_01",
						},
						StopInside = {
							"SHELBY_MG_PKT_LASTSHOT_INSIDE_01",
						},
					},
					Spread = 0.1,
					ReloadTime = 5,
					Ammo = 250,
					MuzzleFlash = "muzzleflash_mg42_3p",
					TracerColor = "green",
				},
				
				TurretTraverseSoundPitch = 100,
				TurretTraverseSoundLevel = 90,
				TurretTraverseSpeed = 30,
				TurretTraverseSound = "t72b3/t72_turret_move.wav",
				
				TurretElevationSound = "gredwitch/turret_electric.wav",
				TurretElevationSoundPitch = 100,
				TurretElevationSoundLevel = 90,
				TurretElevationSpeed = 18,
				
				MinTraverse = -180,
				MaxTraverse = 180,
				MinElevation = -6,
				MaxElevation = 13,
				
				PoseParameters = { -- turret pose parameter
					Yaw = {
						["cannon_aim_yaw"] = {
							Offset = 0,
							Invert = false,
						},
					},
					YawModuleName = "TurretRing",
					YawModuleID = 0,
					
					Pitch = {
						["cannon_aim_pitch"] = {
							Offset = 0,
							Invert = true,
						},
					},
				},
				
			},
			NormalMode = {
				PlayerBoneManipulation = {
					["ValveBiped.Bip01_R_Calf"] = Angle(110,30),
					["ValveBiped.Bip01_L_Calf"] = Angle(-110,30),
				},
				FirstPersonViewPos = Vector(2,-8,5),
				ThirdPersonViewPos = Vector(0,15,80),
				FirstPersonViewPosIsInside = true,
			},
		},
		[1] = { -- Gunner
			ArcadeMode = {
				FirstPersonViewPosIsInside = true,
				Attachment = "turret_att",
				FirstPersonViewPos = Vector(0,0,0),
				ThirdPersonViewPos = Vector(0,0,30),
				
				ViewPort = {
					FreeView = true,
					Attachment = "turret_att",
					Pos = Vector(-11,22,15),
					Ang = Angle(),
					
					MinAng = Angle(-180,-180,-180),
					MaxAng = Angle(180,180,180),
				},
				
				Hatches = {
					{
						PoseParameters = {
							"hatch_gunner"
						},
						PosOffset = Vector(-8,-2,45),
						AngOffset = Angle(0,0,0),
						PlayerHullMins = Vector(),
						PlayerHullMaxs = Vector(),
						
						PlayerBoneManipulation = {
							["ValveBiped.Bip01_R_Calf"] = Angle(0,-90,0),
							["ValveBiped.Bip01_L_Calf"] = Angle(0,-90,0),
							
							["ValveBiped.Bip01_R_Thigh"] = Angle(0,90,0),
							["ValveBiped.Bip01_L_Thigh"] = Angle(0,90,0),
						},
					},
				},
			},
		},
		[2] = { -- Commander
			ArcadeMode = {
				FirstPersonViewPosIsInside = true,
				Attachment = "turret_att",
				ThirdPersonViewPos = Vector(0,0,0),
				IsCommander = true,
			}
		},
	},
	Armour = {
		GetArmourThickness = function(vehicle,tr)
			if tr.LocalHitPos.z > 67 then
				tr.TurretHit = true
				
				if tr.PitchSideDetection == GRED_TANK_TOP then
					tr.ArmourThicknessKE = 30
				else
					if tr.YawSideDetection == GRED_TANK_FRONT then
						local absy = math.abs(tr.LocalHitPos.y)
						if absy > 11 then
							if absy > 38 then
								tr.ArmourThicknessKE = 890
								tr.ArmourThicknessCHEMICAL = 1010
							else
								tr.ArmourThicknessKE = 180
								tr.ArmourThicknessCHEMICAL = 260
							end
						else
							tr.ArmourThicknessKE = 86
							tr.ArmourThicknessCHEMICAL = 99
						end
					elseif tr.YawSideDetection == GRED_TANK_REAR then
						tr.ArmourThicknessKE = 65
					else
						tr.ArmourThicknessKE = 160
						tr.ArmourThicknessCHEMICAL = 260
					end
				end
			else
				if tr.PitchSideDetection == GRED_TANK_TOP then
					if tr.LocalHitPos.x > 44 then
						tr.ArmourThicknessKE = 277
						tr.ArmourThicknessCHEMICAL = 301
					else
						tr.ArmourThicknessKE = 80
					end
				elseif tr.PitchSideDetection == GRED_TANK_BOTTOM then
					tr.ArmourThicknessKE = 80
				else
					if tr.YawSideDetection == GRED_TANK_FRONT then
						if tr.LocalHitPos.z > 80 then
							tr.ArmourThicknessKE = 534
							tr.ArmourThicknessCHEMICAL = 698 
						else
							tr.ArmourThicknessKE = 50
						end
					elseif tr.YawSideDetection == GRED_TANK_REAR then
						if tr.LocalHitPos.z > 40 then
							tr.ArmourThicknessKE = 50
						else
							tr.ArmourThicknessKE = 50
						end
					else
						tr.ArmourThicknessKE = 80
						tr.ArmourThicknessCHEMICAL = 115
					end
				end
			end
			
			tr.ArmourThicknessKE = tr.ArmourThicknessKE or 10
			tr.ArmourThicknessCHEMICAL = tr.ArmourThicknessCHEMICAL or tr.ArmourThicknessKE
			return tr
		end,
		
	},
	Tracks = {
		TrackMat = {
			["$basetexture"]				= "models/merydian_wt_tanks/shared/t80bv_tracks",
											
			["$alphatest"] 					= "1",
			["$nocull"] 					= "1",
											
			["$phong"] 						= "1",
			["$phongboost"] 				= "3",
			["$phongexponent"] 				= "15",
			["$phongfresnelranges"] 		= "[0.3 1 4]",
			
			["$translate"] = "[0.0 0.0 0.0]",
			["Proxies"] = { 
				["TextureTransform"] = { 
					["translateVar"] = "$translate",
					["centerVar"]    = "$center",
					["resultVar"]    = "$basetexturetransform",
				}
			}
		},
		
		Smoother = 1,
		Divider = 400,
		LeftTrackID = 2,
		RightTrackID = 3,
		
		LowTrackSound  = "t72b3/tracks_speed_33_2.wav",
		MedTrackSound  = "t72b3/tracks_speed_66_2.wav",
		HighTrackSound = "t72b3/tracks_speed_99_2.wav",
		TrackSoundLevel = 85,
		TrackSoundVolume = 0.8,
		HandBrakePower = 90,
		
		TankSteer = {
			HasNeutralSteering = true,
			MaxTurn = 30,
			TurnTorqueCenter = 70,
			TurnTorqueCenterRate = 1,
			TurnForceMul = 0.05,
		},
	},

	SusData = T72B3_SusData,
	
	OnCSTick = function(vehicle)
		vehicle:SetPoseParameter("spin_wheels_right",vehicle.trackspin_r)
		vehicle:SetPoseParameter("spin_wheels_left",vehicle.trackspin_l)
	end,
}

gred.simfphys["gred_simfphys_t72b3_custom"].Seats[1].NormalMode = table.FullCopy(gred.simfphys["gred_simfphys_t72b3_custom"].Seats[0].ArcadeMode) -- we use table.FullCopy so we can change stuff
gred.simfphys["gred_simfphys_t72b3_custom"].Seats[1].NormalMode.Hatches = gred.simfphys["gred_simfphys_t72b3_custom"].Seats[1].ArcadeMode.Hatches -- we want the seat's normal mode to have the same hatches as in arcade mode
gred.simfphys["gred_simfphys_t72b3_custom"].Seats[1].NormalMode.FirstPersonViewPosIsInside = true
gred.simfphys["gred_simfphys_t72b3_custom"].Seats[1].NormalMode.ViewAttachment = nil
gred.simfphys["gred_simfphys_t72b3_custom"].Seats[1].NormalMode.ThirdPersonViewPos = Vector(20,70,80)
gred.simfphys["gred_simfphys_t72b3_custom"].Seats[1].NormalMode.Attachment = "turret_att"

gred.simfphys["gred_simfphys_t72b3_custom"].Seats[2].ArcadeMode = {
	FirstPersonViewPosIsInside = true,
	Attachment = "turret_att",
	FirstPersonViewPos = Vector(0,0,10),
	ThirdPersonViewPos = Vector(0,0,20),
	IsCommander = true,
	CustomEyeAngles = function(vehicle,seat,SeatTab,ply,HatchID,PoseParamTab)
		Angles = vehicle:WorldToLocalAngles(seat:WorldToLocalAngles(ply:EyeAngles()))
		Angles.y = Angles.y - vehicle:GetPoseParameter("cannon_aim_yaw")
		
		return Angles
	end,
	MuzzleAttachment = "hmg_muzzle",
	
	RequiresHatch = {
		[1] = true, -- Hatch ID, this hatch needs to be open if we want to use the machinegun
	},
	
	Hatches = {
		{
			PoseParameters = {
				"hatch_commander"
			},
			PosOffset = Vector(10,20,34),
			AngOffset = Angle(180,0,0),
			SeatAttachment = "cupola_att",
			
			PlayerBoneManipulation = {
				["ValveBiped.Bip01_R_Calf"] = Angle(0,-90),
				["ValveBiped.Bip01_L_Calf"] = Angle(0,-90),
				
				["ValveBiped.Bip01_R_Thigh"] = Angle(5,100,0),
				["ValveBiped.Bip01_L_Thigh"] = Angle(-5,100,0),

				["ValveBiped.Bip01_R_Clavicle"] = Angle(15,0,45),
				["ValveBiped.Bip01_L_Clavicle"] = Angle(0,0,-10),

				["ValveBiped.Bip01_R_UpperArm"] = Angle(0,25,0),
				["ValveBiped.Bip01_L_UpperArm"] = Angle(-10,0,0),

				["ValveBiped.Bip01_R_Forearm"] = Angle(0,0,0),
				["ValveBiped.Bip01_L_Forearm"] = Angle(-30,-15,0),

				["ValveBiped.Bip01_L_Hand"] = Angle(0,0,0),
				["ValveBiped.Bip01_R_Hand"] = Angle(-50,0,0),
			},
		},
	},
	Primary = {
		{
			Type = "MG",
			ModuleID = 1,
			Caliber = "wac_base_12mm",
			ExactCaliber = "Kord 12.7x108",
			Sequential = false,
			Muzzles = {
				"hmg_muzzle",
			},
			FireRate = 700,
			Sounds = {
				Reload = {
					"GRED_DSHK_RELOAD",
				},
				Loop = {
					"SHELBY_NSV_LOOP",
				},
				LoopInside = {
					"SHELBY_NSV_LOOP_INSIDE",
				},
				Stop = {
					"SHELBY_MG_NSV_LASTSHOT_01",
				},
				StopInside = {
					"SHELBY_MG_NSV_LASTSHOT_INSIDE_01",
				},
			},
			Spread = 0.15,
			ReloadTime = 5,
			Ammo = 150,
			MuzzleFlash = "muzzleflash_mg42_3p",
			TracerColor = "green",
		},
	},
				
	MinTraverse = 0,
	MaxTraverse = 0,
	MinElevation = 0,
	MaxElevation = 0,
	
	PoseParameters = { -- turret pose parameter
		Yaw = {
			["hmg_aim_yaw"] = {
				Offset = 0,
				Invert = true,
				ModuleName = "MG",
				ModuleID = 1,
			},
		},
		Pitch = {
			["hmg_aim_pitch"] = {
				Offset = -1,
				Invert = true,
				ModuleName = "MG",
				ModuleID = 1,
			},
		},
	},
	
	ViewPort = {
		FreeView = true,
		Debug = false,
		Attachment = "cupola_att",
		Pos = Vector(0,0,-20),
		Ang = Angle(180,0,0),

		ModelAngOffset = Angle(0,0),
					
		Model = "models/gredwitch/viewports/shelbys_commander_viewport.mdl",
		ModelPosOffset = Vector(0,0,4),

		MinAng = Angle(-1,-180,-1),
		MaxAng = Angle(1,180,1),
	},
}
gred.simfphys["gred_simfphys_t72b3_custom"].Seats[2].NormalMode = gred.simfphys["gred_simfphys_t72b3_custom"].Seats[2].ArcadeMode

gred.simfphys["gred_simfphys_t72b3_custom"].Seats[0].NormalMode.Hatches = gred.simfphys["gred_simfphys_t72b3_custom"].Seats[0].ArcadeMode.Hatches
gred.simfphys["gred_simfphys_t72b3_custom"].Seats[0].NormalMode.ViewPort = {
	FreeView = true,
	--Attachment = "gunner_sight",
	Pos = Vector(80,0,60),
	Ang = Angle(0,0,0),
	
	Debug = false,
	
	MinAng = Angle(-1,-15,-1),
	MaxAng = Angle(1,15,1),
	
	ModelAngOffset = Angle(0,180),
					
	Model = "models/gredwitch/viewports/shelbys_driver_viewport.mdl",
	ModelPosOffset = Vector(4,0,-0.2),
	--Model = "models/gredwitch/viewports/viewport_driver_alt.mdl",
	--ModelPosOffset = Vector(3.7,0,-0.6),
}