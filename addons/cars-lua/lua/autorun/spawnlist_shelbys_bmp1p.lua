local ENTITY = FindMetaTable("Entity")
local netStart = net.Start
local netWriteEntity = net.WriteEntity
local netBroadcast = net.Broadcast
local GetAttachment = ENTITY.GetAttachment
local random = math.random
local SetNWInt = ENTITY.SetNWInt
local netWriteUInt = net.WriteUInt

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

list.Set("simfphys_lights","bmp1",{
	L_HeadLampPos = Vector(130,54,59),
	R_HeadLampPos = Vector(130,-54,59),
	L_HeadLampAng = Angle(15,0,0),
	R_HeadLampAng = Angle(15,0,0),
	
	Headlight_sprites = { 
		Vector(125,52,58),
		Vector(125,-52,58),
	},
	
	Brakelight_sprites = {
		Vector(-125,41,66),
		Vector(-125,-41,66),
	},
	Rearlight_sprites = {
		Vector(-125,41,66),
		Vector(-125,-41,66),
	},

})

list.Set("simfphys_vehicles","gred_simfphys_bmp1p_custom",{
	Name = "BMP-1P", 
	Model = Model("models/vehicles_shelby/tanks/bmp1/bmp1p.mdl"),
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Shelby's Playground {Simfphys}",
	SpawnOffset = Vector(0,0,30),
	SpawnAngleOffset = 0,

	Members = {
		Mass = 8000,
		AirFriction = 0,
		Inertia = Vector(20000,90000,100000),
		
		LightsTable = "bmp1",
		
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

		
		MaxHealth = 10000,
		
		IsArmored = true,
		
		NoWheelGibs = true,
		
		FirstPersonViewPos = Vector(0,0,0),
		
		FrontWheelRadius = 20,
		RearWheelRadius = 20,
		
		EnginePos = Vector( 87.65, 1.93, 60.62 ),
		
		CustomWheels = true,
		
		CustomWheelModel = "models/hunter/blocks/cube1x1x1.mdl",
		
		CustomWheelPosFL = Vector(73,50,10),
		CustomWheelPosFR = Vector(73,-50,10),
		
		CustomWheelPosML = Vector(0,50,10),
		CustomWheelPosMR = Vector(0,-50,10),
		
		CustomWheelPosRL = Vector(-75,50,10),
		CustomWheelPosRR = Vector(-75,-50,10),
		CustomWheelAngleOffset = Angle(0,180,0),
		
		CustomMassCenter = Vector(-9.625,0,44.4375),
		
		CustomSteerAngle = 1,
		FastSteeringAngle = 1,
		SteeringFadeFastSpeed = 1,
		
		TurnSpeed = 1,
		
		SeatOffset = Vector(45,-30,55),
		SeatPitch = 0,
		SeatYaw = 90,
		
		ModelInfo = {
			WheelColor = Color(0,0,0,0),
			-- WheelColor = Color(0,0,0,255),
		},
		
		ExhaustPositions = {
			{
				pos = Vector(20,-51,67),
				ang = Angle(0,0,0)
			},
			{
				pos = Vector(30,-51,67),
				ang = Angle(0,0,0)
			},
			{
				pos = Vector(40,-51,67),
				ang = Angle(0,0,0)
			},
			{
				pos = Vector(20,-51,67),
				ang = Angle(0,0,0)
			},
			{
				pos = Vector(30,-51,67),
				ang = Angle(0,0,0)
			},
			{
				pos = Vector(40,-51,67),
				ang = Angle(0,0,0)
			},
			{
				pos = Vector(20,-51,67),
				ang = Angle(0,0,0)
			},
			{
				pos = Vector(30,-51,67),
				ang = Angle(0,0,0)
			},
			{
				pos = Vector(40,-51,67),
				ang = Angle(0,0,0)
			},
			{
				pos = Vector(20,-51,67),
				ang = Angle(0,0,0)
			},
			{
				pos = Vector(30,-51,67),
				ang = Angle(0,0,0)
			},
			{
				pos = Vector(40,-51,67),
				ang = Angle(0,0,0)
			},
		},
		
		PassengerSeats = {
			{
				pos = Vector(-26,13,35),
				ang = Angle(0,-90,0)
			},
			{
				pos = Vector(15,30,23),
				ang = Angle(0,-90,0)
			},
			{
				pos = Vector(-110,15,20),
				ang = Angle(0,0,0)
			},
			{
				pos = Vector(-80,15,20),
				ang = Angle(0,0,0)
			},
			{
				pos = Vector(-60,15,20),
				ang = Angle(0,0,0)
			},
			{
				pos = Vector(-110,-15,20),
				ang = Angle(0,180,0)
			},
			{
				pos = Vector(-80,-15,20),
				ang = Angle(0,180,0)
			},
			{
				pos = Vector(-60,-15,20),
				ang = Angle(0,180,0)
			},
			{
				pos = Vector(-120,-15,60),
				ang = Angle(0,90,0)
			},
			{
				pos = Vector(-100,15,60),
				ang = Angle(0,90,0)
			},
			{
				pos = Vector(-100,-15,60),
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
		Efficiency = 1.5,
		GripOffset = -300,
		BrakePower = 60,
		BulletProofTires = true,
		
		IdleRPM = 600,
		LimitRPM = 3000,
		PeakTorque = 70,
		PowerbandStart = 600,
		PowerbandEnd = 2700,
		Turbocharged = false,
		Supercharged = false,
		DoNotStall = true,
		
		FuelFillPos = Vector( -15.66, -55.5, 58.34 ),
		FuelType = FUELTYPE_PETROL,
		FuelTankSize = 330,
		
		PowerBias = 0,
		
		EngineSoundPreset = 0,
		
		Sound_Idle = "bmp2/bmp2_engine_idle.wav",
		Sound_IdlePitch = 1,
		
		Sound_Mid = "bmp2/bmp2_engine_mid.wav",
		Sound_MidPitch = 1,
		Sound_MidVolume = 1,
		Sound_MidFadeOutRPMpercent = 100,
		Sound_MidFadeOutRate = 1,
		
		Sound_High = "bmp2/bmp2_engine_high.wav",
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
		Gears = {-0.06,0,0.06,0.1,0.2,0.25,0.33}
	}
})


gred = gred or {}
gred.simfphys = gred.simfphys or {}

local BMP1P_SusData = {}

local Maxs = Vector(15,15,0)

for i = 1,6 do
	BMP1P_SusData[i] = { 
		Attachment = "susp_att_l_"..i,
		PoseParameter = "suspension_left_"..i,
		PoseParameterMultiplier = 1,
		-- ReversePoseParam = true,
		Height = 14,
		GroundHeight = -38,
		Mins = -Maxs,
		Maxs = Maxs,
	}
	
	BMP1P_SusData	[i + 6] = { 
		Attachment = "susp_att_r_"..i,
		PoseParameter = "suspension_right_"..i,
		PoseParameterMultiplier = 1,
		-- ReversePoseParam = true,
		Height = 14,
		GroundHeight = -38,
		Mins = -Maxs,
		Maxs = Maxs,
	}
end

gred.simfphys["gred_simfphys_bmp1p_custom"] = {
	Seats = {
		[0] = { -- Driver
			ArcadeMode = {
				PlayerBoneManipulation = {
					["ValveBiped.Bip01_R_Calf"] = Angle(0,30,0),
					["ValveBiped.Bip01_L_Calf"] = Angle(-0,30,0),
							
					["ValveBiped.Bip01_R_Thigh"] = Angle(0,-35,0),
					["ValveBiped.Bip01_L_Thigh"] = Angle(0,-35,0),
							
					["ValveBiped.Bip01_Neck1"] = Angle(0,-30),
				},
				
				ViewAttachment = "gunner_sight",
				FirstPersonViewPos = Vector(0,0,7),
				ThirdPersonViewPos = Vector(0,70,80),
				
				MuzzleDirection = Vector(0,0.5,0),
				MuzzleAttachment = "cannon_muzzle",
				FirstPersonViewPosIsInside = true,
				TraverseIndicator = "cannon_aim_yaw",
				SynchronousElevation = true,
				
				Sight = {
					SightPosOffset = Vector(0,0,0),
					SightAngOffset = Angle(0,0,0),
					SightAttachment = "gunner_sight",
					SightFOV = 60,
					SightFOVZoom = 30, -- ammount of FOV to remove, not the actual zoom value
					SightMaterial = "gredwitch/overlay_russian_tanksight_bmp2",
				},
				
				ViewPort = {
					Attachment = "gunner_sight",
					Pos = Vector(0,0,0),
					Ang = Angle(),
					
					MinAng = Angle(-0,-0,-0),
					MaxAng = Angle(0,0,0),
					
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
						PosOffset = Vector(15,-0.5,15),
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
				},
			
				Primary = {
					{
						AutoLoader = true,
						Type = "Cannon",
						ExactType = "2A28",
						ExactCaliber = "73",
						Caliber = "wac_base_30mm",
						ModuleID = 0,
						ShootAnimation = "fire",
						Sequential = false,
						Muzzles = {
							"cannon_muzzle",
						},
						Sounds = {
							Reload = {
								"sherman_reload",
							},
							Shoot = {
								"75MM_SA49_1",
								"75MM_SA49_2",
								"75MM_SA49_3",
							},
							ShootInside = {
								"T90A_CANNON_FIRE_INSIDE"
							},
						},
						MuzzleFlash = "gred_arti_muzzle_blast_alt",
						ReloadTime = 6,

						ShellTypes = {
							{
								Caliber = 73,
								ShellType = "HEAT",
								MuzzleVelocity = 665,
								Mass = 2.6,
								TNTEquivalent = 1.13,
								LinearPenetration = 300,
								TracerColor = "red",
							},
							{
								Caliber = 73,
								ShellType = "HE",
								MuzzleVelocity = 290,
								Mass = 3.7,
								TNTEquivalent = 735,
								LinearPenetration = 11,
								TracerColor = "red",
							},
						},
						MaxAmmo = 40,
						RecoilForce = 50000,
					},
				},
				Secondary = {
					Type = "MG",
					ExactCaliber = "PKT 7.62",
					Caliber = "wac_base_7mm",
					ModuleID = 0,
					Sequential = false,
					Muzzles = {
						"coax_muzzle",
					},
					FireRate = 700,
					Sounds = {
						Reload = {
							"BMP2_COAX_RELOAD",
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
					ReloadTime = 22,
					Ammo = 250,
					MuzzleFlash = "muzzleflash_bar_3p",
					TracerColor = "red",
				},
				
				TurretTraverseSoundPitch = 100,
				TurretTraverseSoundLevel = 60,
				TurretTraverseSpeed = 20,
				TurretTraverseSound = "turret/turret_turn_loop_1_manual.wav",
				
				TurretElevationSound = "gredwitch/turret_elev.wav",
				TurretElevationSoundPitch = 100,
				TurretElevationSoundLevel = 60,
				TurretElevationSpeed = 5,
				
				MinTraverse = -180,
				MaxTraverse = 180,
				MinElevation = -4,
				MaxElevation = 30,
				
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
					["ValveBiped.Bip01_R_Calf"] = Angle(0,30,0),
					["ValveBiped.Bip01_L_Calf"] = Angle(-0,30,0),
							
					["ValveBiped.Bip01_R_Thigh"] = Angle(0,-35,0),
					["ValveBiped.Bip01_L_Thigh"] = Angle(0,-35,0),
							
					["ValveBiped.Bip01_Neck1"] = Angle(0,-30),
				},
				FirstPersonViewPos = Vector(0,-0,10),
				ThirdPersonViewPos = Vector(0,15,80),
				FirstPersonViewPosIsInside = true,
			},
		},
		[1] = { -- Gunner
			ArcadeMode = {
				FirstPersonViewPosIsInside = true,
				Attachment = "turret_att",
				FirstPersonViewPos = Vector(5,0,5),
				ThirdPersonViewPos = Vector(0,0,10),

				PlayerBoneManipulation = {
					["ValveBiped.Bip01_R_Calf"] = Angle(0,45,0),
					["ValveBiped.Bip01_L_Calf"] = Angle(-0,45,0),
							
					["ValveBiped.Bip01_R_Thigh"] = Angle(0,-35,0),
					["ValveBiped.Bip01_L_Thigh"] = Angle(0,-35,0),
							
					["ValveBiped.Bip01_Neck1"] = Angle(0,-30),
				},
				
				Hatches = {
					{
						PoseParameters = {
							"hatch_gunner"
						},
						PosOffset = Vector(3,-5,42),
						AngOffset = Angle(0,0,0),
						ViewAttachment = "",
						
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
				ThirdPersonViewPos = Vector(0,0,0),

				PlayerBoneManipulation = {
					["ValveBiped.Bip01_R_Calf"] = Angle(0,30,0),
					["ValveBiped.Bip01_L_Calf"] = Angle(-0,30,0),
							
					["ValveBiped.Bip01_R_Thigh"] = Angle(0,-35,0),
					["ValveBiped.Bip01_L_Thigh"] = Angle(0,-35,0),
							
					["ValveBiped.Bip01_Neck1"] = Angle(0,-25),
				},

				IsCommander = true,
			}
		},
		[3] = {
			ArcadeMode = {
				FirstPersonViewPosIsInside = true,
				ThirdPersonViewPos = Vector(0,0,0),

				ViewPort = {
					FreeView = true,
					Pos = Vector(-111,37,72),
					Ang = Angle(0,55,0),
					Debug = false,
					
					ModelAngOffset = Angle(0,180),
					
					Model = "models/gredwitch/viewports/shelbys_driver_viewport.mdl",
					ModelPosOffset = Vector(3,4.5,-0.2),
					
					MinAng = Angle(-1,-10,-1),
					MaxAng = Angle(1,10,1),
				},

				PlayerBoneManipulation = {
					["ValveBiped.Bip01_R_Calf"] = Angle(0,45,0),
					["ValveBiped.Bip01_L_Calf"] = Angle(-0,45,0),
							
					["ValveBiped.Bip01_R_Thigh"] = Angle(0,-35,0),
					["ValveBiped.Bip01_L_Thigh"] = Angle(0,-35,0),
							
					["ValveBiped.Bip01_Neck1"] = Angle(0,-25),
				},
			}
		},
		[4] = {
			ArcadeMode = {
				FirstPersonViewPosIsInside = true,
				ThirdPersonViewPos = Vector(0,0,0),

				ViewPort = {
					FreeView = true,
					Pos = Vector(-111,37,72),
					Ang = Angle(0,55,0),
					Debug = false,
					
					ModelAngOffset = Angle(0,180),
					
					Model = "models/gredwitch/viewports/shelbys_driver_viewport.mdl",
					ModelPosOffset = Vector(3,4.5,-0.2),
					
					MinAng = Angle(-1,-10,-1),
					MaxAng = Angle(1,10,1),
				},

				PlayerBoneManipulation = {
					["ValveBiped.Bip01_R_Calf"] = Angle(0,45,0),
					["ValveBiped.Bip01_L_Calf"] = Angle(-0,45,0),
							
					["ValveBiped.Bip01_R_Thigh"] = Angle(0,-35,0),
					["ValveBiped.Bip01_L_Thigh"] = Angle(0,-35,0),
							
					["ValveBiped.Bip01_Neck1"] = Angle(0,-25),
				},
			}
		},
		[5] = {
			ArcadeMode = {
				FirstPersonViewPosIsInside = true,
				ThirdPersonViewPos = Vector(0,0,0),

				ViewPort = {
					FreeView = true,
					Pos = Vector(-111,37,72),
					Ang = Angle(0,55,0),
					Debug = false,
					
					ModelAngOffset = Angle(0,180),
					
					Model = "models/gredwitch/viewports/shelbys_driver_viewport.mdl",
					ModelPosOffset = Vector(3,4.5,-0.2),
					
					MinAng = Angle(-1,-10,-1),
					MaxAng = Angle(1,10,1),
				},

				PlayerBoneManipulation = {
					["ValveBiped.Bip01_R_Calf"] = Angle(0,45,0),
					["ValveBiped.Bip01_L_Calf"] = Angle(-0,45,0),
							
					["ValveBiped.Bip01_R_Thigh"] = Angle(0,-35,0),
					["ValveBiped.Bip01_L_Thigh"] = Angle(0,-35,0),
							
					["ValveBiped.Bip01_Neck1"] = Angle(0,-25),
				},
			}
		},
		[6] = {
			ArcadeMode = {
				FirstPersonViewPosIsInside = true,
				ThirdPersonViewPos = Vector(0,0,0),

				ViewPort = {
					FreeView = true,
					Pos = Vector(-111,-37,72),
					Ang = Angle(0,-55,0),
					Debug = false,
					
					ModelAngOffset = Angle(0,180),
					
					Model = "models/gredwitch/viewports/shelbys_driver_viewport.mdl",
					ModelPosOffset = Vector(3,-4.5,-0.2),
					
					MinAng = Angle(-1,-10,-1),
					MaxAng = Angle(1,10,1),
				},

				PlayerBoneManipulation = {
					["ValveBiped.Bip01_R_Calf"] = Angle(0,45,0),
					["ValveBiped.Bip01_L_Calf"] = Angle(-0,45,0),
							
					["ValveBiped.Bip01_R_Thigh"] = Angle(0,-35,0),
					["ValveBiped.Bip01_L_Thigh"] = Angle(0,-35,0),
							
					["ValveBiped.Bip01_Neck1"] = Angle(0,-25),
				},
			}
		},
		[7] = {
			ArcadeMode = {
				FirstPersonViewPosIsInside = true,
				ThirdPersonViewPos = Vector(0,0,0),

				ViewPort = {
					FreeView = true,
					Pos = Vector(-95,-35,72),
					Ang = Angle(0,-55,0),
					Debug = false,
					
					ModelAngOffset = Angle(0,180),
					
					Model = "models/gredwitch/viewports/shelbys_driver_viewport.mdl",
					ModelPosOffset = Vector(3,-4.5,-0.2),
					
					MinAng = Angle(-1,-10,-1),
					MaxAng = Angle(1,10,1),
				},

				PlayerBoneManipulation = {
					["ValveBiped.Bip01_R_Calf"] = Angle(0,45,0),
					["ValveBiped.Bip01_L_Calf"] = Angle(-0,45,0),
							
					["ValveBiped.Bip01_R_Thigh"] = Angle(0,-35,0),
					["ValveBiped.Bip01_L_Thigh"] = Angle(0,-35,0),
							
					["ValveBiped.Bip01_Neck1"] = Angle(0,-25),
				},
			}
		},
		[8] = {
			ArcadeMode = {
				Outside = true,
				FirstPersonViewPosIsInside = true,
				ThirdPersonViewPos = Vector(0,0,0),

				PlayerBoneManipulation = {
					["ValveBiped.Bip01_R_Calf"] = Angle(0,45,0),
					["ValveBiped.Bip01_L_Calf"] = Angle(-0,45,0),
							
					["ValveBiped.Bip01_R_Thigh"] = Angle(0,-35,0),
					["ValveBiped.Bip01_L_Thigh"] = Angle(0,-35,0),
							
					["ValveBiped.Bip01_Neck1"] = Angle(0,-25),
				},
			}
		},
		[9] = {
			ArcadeMode = {
				Outside = true,
				FirstPersonViewPosIsInside = true,
				ThirdPersonViewPos = Vector(0,0,0),
		
				PlayerBoneManipulation = {
					["ValveBiped.Bip01_R_Calf"] = Angle(0,30,0),
					["ValveBiped.Bip01_L_Calf"] = Angle(-0,30,0),
							
					["ValveBiped.Bip01_R_Thigh"] = Angle(0,-15,0),
					["ValveBiped.Bip01_L_Thigh"] = Angle(0,-15,0),
							
					["ValveBiped.Bip01_Neck1"] = Angle(0,0),
				},
			}
		},
		[10] = {
			ArcadeMode = {
				Outside = true,
				FirstPersonViewPosIsInside = true,
				ThirdPersonViewPos = Vector(0,0,0),
		
				PlayerBoneManipulation = {
					["ValveBiped.Bip01_R_Calf"] = Angle(0,45,0),
					["ValveBiped.Bip01_L_Calf"] = Angle(0,45,0),
							
					["ValveBiped.Bip01_R_Thigh"] = Angle(0,-55,0),
					["ValveBiped.Bip01_L_Thigh"] = Angle(0,-55,0),
							
					["ValveBiped.Bip01_Neck1"] = Angle(0,0),
				},
			}
		},
		[11] = {
			ArcadeMode = {
				Outside = true,
				FirstPersonViewPosIsInside = true,
				ThirdPersonViewPos = Vector(0,0,0),
		
				PlayerBoneManipulation = {
					["ValveBiped.Bip01_R_Calf"] = Angle(0,45,0),
					["ValveBiped.Bip01_L_Calf"] = Angle(0,45,0),
							
					["ValveBiped.Bip01_R_Thigh"] = Angle(0,-55,0),
					["ValveBiped.Bip01_L_Thigh"] = Angle(0,-55,0),
							
					["ValveBiped.Bip01_Neck1"] = Angle(0,0),
				},
			}
		},
	},
	Armour = {
		GetArmourThickness = function(vehicle,tr)
			if tr.LocalHitPos.z > 10 then
				tr.TurretHit = true
				
				if tr.PitchSideDetection == GRED_TANK_TOP then
					tr.ArmourThicknessKE = 25
					tr.ArmourThicknessCHEMICAL = 100
				else
					if tr.YawSideDetection == GRED_TANK_FRONT then
						local absy = math.abs(tr.LocalHitPos.y)
						if absy > 11 then
							if absy > 38 then
								tr.ArmourThicknessKE = 25
								tr.ArmourThicknessCHEMICAL = 100
							else
								tr.ArmourThicknessKE = 25
								tr.ArmourThicknessCHEMICAL = 100
							end
						else
							tr.ArmourThicknessKE = 25
							tr.ArmourThicknessCHEMICAL = 100
						end
					elseif tr.YawSideDetection == GRED_TANK_REAR then
						tr.ArmourThicknessKE = 25
					else
						tr.ArmourThicknessKE = 25
						tr.ArmourThicknessCHEMICAL = 100
					end
				end
			else
				if tr.PitchSideDetection == GRED_TANK_TOP then
					if tr.LocalHitPos.x > 39 then
						tr.ArmourThicknessKE = 15
						tr.ArmourThicknessCHEMICAL = 100
					else
						tr.ArmourThicknessKE = 25
					end
				elseif tr.PitchSideDetection == GRED_TANK_BOTTOM then
					tr.ArmourThicknessKE = 15
					tr.ArmourThicknessCHEMICAL = 200
				else
					if tr.YawSideDetection == GRED_TANK_FRONT then
						if tr.LocalHitPos.z > 80 then
							tr.ArmourThicknessKE = 15
							tr.ArmourThicknessCHEMICAL = 100 
						else
							tr.ArmourThicknessKE = 15
						end
					elseif tr.YawSideDetection == GRED_TANK_REAR then
						if tr.LocalHitPos.z > 40 then
							tr.ArmourThicknessKE = 13
						else
							tr.ArmourThicknessKE = 13
						end
					else
						tr.ArmourThicknessKE = 15
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
			["$basetexture"]				= "models/bmp1_shelby/ussr_bmp_1_track_c",
			["$bumpmap"]					= "models/bmp1_shelby/ussr_bmp_1_track_n",
											
			["$alphatest"] 					= "1",
			["$nocull"] 					= "1",
											
			["$phong"] 						= "1",
			["$phongboost"] 				= "0.5",
			["$phongexponent"] 				= "30",
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
		Divider = -400,
		LeftTrackID = 8,
		RightTrackID = 9,
		
		LowTrackSound  = "tracksounds/tracks_light_speed_33_3.wav",
		MedTrackSound  = "tracksounds/tracks_light_speed_66_3.wav",
		HighTrackSound = "tracksounds/tracks_light_speed_99_3.wav",
		TrackSoundLevel = 85,
		TrackSoundVolume = 0.75,
		HandBrakePower = 90,
		
		TankSteer = {
			HasNeutralSteering = true,
			MaxTurn = 35,
			TurnTorqueCenter = 70,
			TurnTorqueCenterRate = 1,
			TurnForceMul = 0.05,
		},
	},

	SusData = BMP1P_SusData,
	
	OnCSTick = function(vehicle)
		vehicle:SetPoseParameter("spin_wheels_right",vehicle.trackspin_r)
		vehicle:SetPoseParameter("spin_wheels_left",vehicle.trackspin_l)
	end,

	PostSVInit = function(vehicle)
		vehicle.IsAmphibious = true
		
		local ang = vehicle:GetAngles()
		ang.y = ang.y + 90

		local float_bmp1p = {}

		for i = -1,1,2 do
			local ent = ents.Create("prop_physics")
			ent:SetModel("models/hunter/blocks/cube05x6x05.mdl")
			ent:SetPos(vehicle:LocalToWorld(Vector(-15,55 * i,45)))
			ent:SetAngles(ang)
			ent:SetModelScale(0.7)
			ent:SetNoDraw(true)
			ent:Spawn()
			ent:Activate()
			ent:GetPhysicsObject():SetMass(50)
			ent:SetCollisionGroup(COLLISION_GROUP_WEAPON)

			vehicle:DeleteOnRemove(ent)

			constraint.Weld(ent,vehicle,0,0,0,true)

			table.insert(float_bmp1p,ent)
		end

		vehicle.float_bmp1p = float_bmp1p

		function vehicle:IsDriveWheelsOnGround()
			return (self.DriveWheelsOnGround == 1) or vehicle.susOnGround
		end

		local OldPhysicsUpdate = vehicle.PhysicsUpdate

		vehicle.PhysicsUpdate = function(vehicle,phy)
			OldPhysicsUpdate(vehicle,phy)
			
			for i = 1,2 do
				local ent = vehicle.float_bmp1p[i]

				if not IsValid(ent) then
					continue
				end
				
				ent:GetPhysicsObject():SetBuoyancyRatio(10)
			end

			if vehicle.IsUnderWater then
				local vel = phy:GetAngleVelocity()

				vel.z = 0
				vel:Mul(-0.09)

				phy:AddAngleVelocity(vel)
			end
		end

		if not FloatingBMP1P then
			FloatingBMP1P = FloatingBMP1P or gred.TankUpdateSuspension

			gred.TankUpdateSuspension = function(vehicle,ct,SusDataTab)
				FloatingBMP1P(vehicle,ct,SusDataTab)

				if vehicle.IsAmphibious and vehicle:WaterLevel() > 0 then
					vehicle.IsUnderWater = true
					vehicle.susOnGround = true
					vehicle.DriveWheelsOnGround = 1
			
					
					for k = 1,#vehicle.Wheels do
						vehicle.Wheels[k]:SetSurfaceMaterial("concrete")
		
						vehicle.VehicleData[ "SurfaceMul_"..k] = 1
						vehicle.VehicleData[ "onGround_"..k] = 1
					end
		
					return
				end

				vehicle.IsUnderWater = false
			end
		end
	end

}

gred.simfphys["gred_simfphys_bmp1p_custom"].Seats[1].NormalMode = table.FullCopy(gred.simfphys["gred_simfphys_bmp1p_custom"].Seats[0].ArcadeMode) -- we use table.FullCopy so we can change stuff
gred.simfphys["gred_simfphys_bmp1p_custom"].Seats[1].NormalMode.Hatches = gred.simfphys["gred_simfphys_bmp1p_custom"].Seats[1].ArcadeMode.Hatches -- we want the seat's normal mode to have the same hatches as in arcade mode
gred.simfphys["gred_simfphys_bmp1p_custom"].Seats[1].NormalMode.FirstPersonViewPosIsInside = true
gred.simfphys["gred_simfphys_bmp1p_custom"].Seats[1].NormalMode.ViewAttachment = nil
gred.simfphys["gred_simfphys_bmp1p_custom"].Seats[1].NormalMode.ThirdPersonViewPos = Vector(20,70,80)
gred.simfphys["gred_simfphys_bmp1p_custom"].Seats[1].NormalMode.Attachment = "turret_att"

gred.simfphys["gred_simfphys_bmp1p_custom"].Seats[2].ArcadeMode = {
	FirstPersonViewPosIsInside = true,
	FirstPersonViewPos = Vector(0,0,10),
	ThirdPersonViewPos = Vector(0,0,20),
	IsCommander = true,

	PlayerBoneManipulation = {
		["ValveBiped.Bip01_R_Calf"] = Angle(0,30,0),
		["ValveBiped.Bip01_L_Calf"] = Angle(-0,30,0),
				
		["ValveBiped.Bip01_R_Thigh"] = Angle(0,-35,0),
		["ValveBiped.Bip01_L_Thigh"] = Angle(0,-35,0),
				
		["ValveBiped.Bip01_Neck1"] = Angle(0,-25),
	},

	Hatches = {
		{
			PoseParameters = {
				"hatch_commander"
			},
			PosOffset = Vector(3,-0,35),
			AngOffset = Angle(0,0,0),
			ViewAttachment = "",
			
			PlayerBoneManipulation = {
				["ValveBiped.Bip01_R_Calf"] = Angle(0,-90,0),
				["ValveBiped.Bip01_L_Calf"] = Angle(0,-90,0),
				
				["ValveBiped.Bip01_R_Thigh"] = Angle(0,90,0),
				["ValveBiped.Bip01_L_Thigh"] = Angle(0,90,0),
			},
		},
	},

	Primary = {
		{
			Type = "Custom",
			ExactType = "9M113 Konkurs ATGM",
			Sequential = true,
			ReloadTime = 30,
			FireRate = 600 / 15,
			RocketLaserAttachment = "atgm_sight",
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
					
					vehicle:SetBodygroup(0,1)

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
					ent.phys:ApplyForceCenter(ent:GetAngles():Forward()*2500)
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
							ent.phys:ApplyForceCenter(ent:GetAngles():Forward()*2500)
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
					"9M133_FIRE",
				},
			},
						
			MuzzleFlash = "ins_weapon_at4_frontblast",
			Muzzles = {
				"atgm_muzzle",
			},
						
			SilenceRocket = false,
			Rocket = "gb_rocket_9m113",
						
			Ammo = 1,
			Spread = 0.05,
			
			OnReload = function(vehicle,seat,ply,ct,SeatTab,WeaponTab,SeatID,SeatSlotTab,SlotID)
				vehicle:SetBodygroup(0,0)
			end,
		},	

	},

	Sight = {
		SightPosOffset = Vector(0,-0,0),
		SightAngOffset = Angle(0,0,0),
		SightAttachment = "atgm_sight",
		SightFOV = 80,
		SightFOVZoom = 50, -- ammount of FOV to remove, not the actual zoom value
		Stabilizer = true,
		SightMaterial = "gredwitch/overlay_russian_tanksight_bmp2_atgm",
	},

	TurretTraverseSoundPitch = 100,
	TurretTraverseSoundLevel = 50,
	TurretTraverseSpeed = 15,
	TurretTraverseSound = "gredwitch/turret_electric.wav",
	
	TurretElevationSound = "turret/turret_turn_loop_1_manual.wav",
	TurretElevationSoundPitch = 100,
	TurretElevationSoundLevel = 50,
	TurretElevationSpeed = 15,
	
	MinTraverse = -37,
	MaxTraverse = 37,
	MinElevation = -5,
	MaxElevation = 10,

	MuzzleDirection = Vector(0,0.5,0),
	MuzzleAttachment = "atgm_muzzle",
	FirstPersonViewPosIsInside = true,
	TraverseIndicator = "atgm_aim_yaw",
	SynchronousElevation = true,

	ViewPort = {
		FreeView = true,
		Debug = false,
		Attachment = "atgm_sight",
		Pos = Vector(0,-0,0),
		Ang = Angle(0,0,0),					
	},
	
	PoseParameters = { -- turret pose parameter
		Yaw = {
			["atgm_aim_yaw"] = {
				Offset = 0,
				Invert = true,
			},
		},
		YawModuleName = "TurretRing",
		YawModuleID = 0,
		
		Pitch = {
			["atgm_aim_pitch"] = {
				Offset = 0,
				Invert = true,
			},
		},
	},
}
gred.simfphys["gred_simfphys_bmp1p_custom"].Seats[2].NormalMode = gred.simfphys["gred_simfphys_bmp1p_custom"].Seats[2].ArcadeMode
gred.simfphys["gred_simfphys_bmp1p_custom"].Seats[3].NormalMode = gred.simfphys["gred_simfphys_bmp1p_custom"].Seats[3].ArcadeMode
gred.simfphys["gred_simfphys_bmp1p_custom"].Seats[4].NormalMode = gred.simfphys["gred_simfphys_bmp1p_custom"].Seats[4].ArcadeMode
gred.simfphys["gred_simfphys_bmp1p_custom"].Seats[5].NormalMode = gred.simfphys["gred_simfphys_bmp1p_custom"].Seats[5].ArcadeMode
gred.simfphys["gred_simfphys_bmp1p_custom"].Seats[6].NormalMode = gred.simfphys["gred_simfphys_bmp1p_custom"].Seats[6].ArcadeMode
gred.simfphys["gred_simfphys_bmp1p_custom"].Seats[7].NormalMode = gred.simfphys["gred_simfphys_bmp1p_custom"].Seats[7].ArcadeMode
gred.simfphys["gred_simfphys_bmp1p_custom"].Seats[8].NormalMode = gred.simfphys["gred_simfphys_bmp1p_custom"].Seats[8].ArcadeMode
gred.simfphys["gred_simfphys_bmp1p_custom"].Seats[9].NormalMode = gred.simfphys["gred_simfphys_bmp1p_custom"].Seats[9].ArcadeMode
gred.simfphys["gred_simfphys_bmp1p_custom"].Seats[10].NormalMode = gred.simfphys["gred_simfphys_bmp1p_custom"].Seats[10].ArcadeMode
gred.simfphys["gred_simfphys_bmp1p_custom"].Seats[11].NormalMode = gred.simfphys["gred_simfphys_bmp1p_custom"].Seats[11].ArcadeMode

gred.simfphys["gred_simfphys_bmp1p_custom"].Seats[0].NormalMode.Hatches = gred.simfphys["gred_simfphys_bmp1p_custom"].Seats[0].ArcadeMode.Hatches
gred.simfphys["gred_simfphys_bmp1p_custom"].Seats[0].NormalMode.ViewPort = {
	FreeView = true,
	--Attachment = "gunner_sight",
	Pos = Vector(55,32,74),
	Ang = Angle(0,0,0),
	
	Debug = false,
	
	MinAng = Angle(-1,-35,-1),
	MaxAng = Angle(1,35,1),
	
	ModelAngOffset = Angle(0,180),
					
	Model = "models/gredwitch/viewports/shelbys_commander_viewport.mdl",
	ModelPosOffset = Vector(4,0,-4),
	--Model = "models/gredwitch/viewports/viewport_driver_alt.mdl",
	--ModelPosOffset = Vector(3.7,0,-0.6),
}