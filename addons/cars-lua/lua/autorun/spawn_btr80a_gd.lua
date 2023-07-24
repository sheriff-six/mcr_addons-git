util.PrecacheModel("models/gredwitch/viewports/shelbys_commander_viewport.mdl")
util.PrecacheModel("models/gredwitch/viewports/shelbys_driver_viewport.mdl")

gred = gred or {}
gred.AddonList = gred.AddonList or {}
table.insert(gred.AddonList,1131455085) -- Base addon
table.insert(gred.AddonList,771487490) -- simfphys
table.insert(gred.AddonList,831680603) -- simfphys armed

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

sound.Add({
	name = "2А72_LOOP",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 130,
	sound = "^btr80/30mm_gun_loop.wav"
})

sound.Add({
	name = "PKP_LOOP",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 130,
	sound = "^btr80/dt_loop.wav"
})

sound.Add({
	name = "2А72_LOOP_INSIDE",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 130,
	sound = "^btr80/30mm_gun_close_loop.wav"
})

sound.Add({
	name = "MG_RELOAD",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 130,
	sound = "^btr80/mg_reload.wav"
})

sound.Add({
	name = "KPVT_LAST",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 130,
	sound = "^btr80/kpvt_lastshot.wav"
})

sound.Add({
	name = "PKT_LAST",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 130,
	sound = "^btr80/dt_lastshot.wav"
})

list.Set("simfphys_lights","btr80a",{
	ModernLights = false,
	L_HeadLampPos = Vector(115.493,46.0128,61.655),
	L_HeadLampAng = Angle(10,0,0),

	R_HeadLampPos = Vector(115.493,-46.0128,61.655),
	R_HeadLampAng = Angle(10,0,0),

	L_RearLampPos = Vector(-135.914,27.6727,67.5404),
	L_RearLampAng = Angle(10,180,0),

	R_RearLampPos = Vector(-135.914,-27.6727,67.5404),
	R_RearLampAng = Angle(10,180,0),
	
	Headlight_sprites = { 
		{
			pos = Vector(115.493,46.0128,61.655),
			material = "sprites/light_ignorez",
			size = 45,
		},
		{
			pos = Vector(115.493,-46.0128,61.655),
			material = "sprites/light_ignorez",
			size = 45,
		},
		{
			pos = Vector(115.493,46.0128,61.655),
			material = "sprites/light_ignorez",
			size = 45,
		},
		{
			pos = Vector(115.493,-46.0128,61.655),
			material = "sprites/light_ignorez",
			size = 45,
		},
	},
	Headlamp_sprites = { 
		{
			pos = Vector(111,38.888,67.2769),
			material = "sprites/light_ignorez",
			size = 40,
		},
		{
			pos = Vector(111,38.888,67.2769),
			material = "sprites/light_ignorez",
			size = 40,
		},
		{
			pos = Vector(111,-38.888,67.2769),
			material = "sprites/light_ignorez",
			size = 40,
		},
		{
			pos = Vector(111,-38.888,67.2769),
			material = "sprites/light_ignorez",
			size = 40,
		},
	},
	FogLight_sprites = {
		{
			pos = Vector(166.145,47.3859,66.5182),
			material = "sprites/light_ignorez",
			size = 15,
		},
		{
			pos = Vector(166.145,-47.3859,66.5182),
			material = "sprites/light_ignorez",
			size = 15,
		},
		{
			pos = Vector(166.145,44.3859,66.5182),
			material = "sprites/light_ignorez",
			size = 15,
		},
		{
			pos = Vector(166.145,-44.3859,66.5182),
			material = "sprites/light_ignorez",
			size = 15,
		},
	},
	Rearlight_sprites = {
		Vector(-135.914,27.6727,67.5404),
		Vector(-135.914,-27.6727,67.5404),
		Vector(-135.914,27.6727,67.5404),
		Vector(-135.914,-27.6727,67.5404),
	},
	Brakelight_sprites = {
		Vector(-135.914,27.6727,67.5404),
		Vector(-135.914,-27.6727,67.5404),
		Vector(-135.914,27.6727,67.5404),
		Vector(-135.914,-27.6727,67.5404),
	},
	Reverselight_sprites = {
		Vector(-135.914,29.7217,67.5404),
		Vector(-135.914,-29.7217,67.5404),
	},
	Turnsignal_sprites = { -- поворотники
		Right = { -- правый
		Vector(117.862,-47.8184,55.7907),
		Vector(-135.914,-33.0217,67.5404),
		Vector(-135.914,-33.0217,67.5404),
		},
		Left = { -- левый
		Vector(117.862,47.8184,55.7907),
		Vector(-135.914,33.0217,67.5404),
		Vector(-135.914,33.0217,67.5404),
		},
	},
})

list.Set("simfphys_vehicles","gred_simfphys_btr80a",{
	Name = "BTR-80A", 
	Model = Model("models/btr/rus/btr80/btr80a.mdl"),
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "RUS Ground",
	SpawnOffset = Vector(0,0,10),
	SpawnAngleOffset = 0,

	Members = {
		Mass = 5000,
		
		LightsTable = "btr80a",
		
		OnTick = function(vehicle)
			local turn = vehicle:GetVehicleSteer() * 2 -- -1 or 1
			vehicle:SetPoseParameter("steer_wheels", turn / 2)
		end,
		
		OnDestroyed = function(ent)
			local gib = ent.Gib
			if !IsValid(gib) then return end
			
			local pos,ang,skin,pitch,yaw = gib:GetPos(),gib:GetAngles(),gib:GetSkin(),ent:GetPoseParameter("cannon_aim_pitch"),ent:GetPoseParameter("cannon_aim_yaw")
			gib:SetPoseParameter("cannon_aim_pitch",pitch)
			gib:SetPoseParameter("cannon_aim_yaw",yaw)
		end,
		
		MaxHealth = -420000,
		
		IsArmored = true,
		
		NoWheelGibs = true,
		
		FrontWheelRadius = 20,
		RearWheelRadius = 20,
		
		EnginePos = Vector(-68.1931,0,73.9256),
		
		CustomWheels = true,
		
		CustomWheelModel = "models/props_c17/canisterchunk01g.mdl",		
		CustomWheelPosFL = Vector(91.5602,52.4676,9),
		CustomWheelPosFR = Vector(91.5602,-52.4676,9),	
		CustomWheelPosML = Vector(0,52.4676,9),
		CustomWheelPosMR = Vector(0,-52.4676,9),
		CustomWheelPosRL = Vector(-86.1969,52.4676,9),
		CustomWheelPosRR = Vector(-86.1969,-52.4676,9),
		CustomWheelAngleOffset = Angle(0,180,0),
		
		CustomMassCenter = Vector(0,0,0),
		
		CustomSteerAngle = 30,
		FastSteeringAngle = 15,
		SteeringFadeFastSpeed = 445,
		
		TurnSpeed = 4,
		
		SeatOffset = Vector(83.3507,-17.7656,57.6389),
		SeatPitch = 0,
		SeatYaw = 90,
		
		ModelInfo = {
			WheelColor = Color(0,0,0,0),
			-- WheelColor = Color(0,0,0,255),
		},
		
		PassengerSeats = {
			{
				pos = Vector(53.6135,-16.6115,22),
				ang = Angle(0,0,0)
			},
			{
				pos = Vector(88.3507,-13.212,22),
				ang = Angle(0,-90,0)
			},
-------------
			{
				pos = Vector(53.6135,18.6115,22),
				ang = Angle(0,180,0)
			},
-------------
			{
				pos = Vector(10.1356,-7.1356,25),
				ang = Angle(0,180,0)
			},
			{
				pos = Vector(-10.1356,-7.1356,25),
				ang = Angle(0,180,0)
			},
			{
				pos = Vector(-24.1356,-7.1356,25),
				ang = Angle(0,180,0)
			},
-------------
			{
				pos = Vector(10.1356,8.1356,25),
				ang = Angle(0,0,0)
			},
			{
				pos = Vector(-10.1356,8.1356,25),
				ang = Angle(0,0,0)
			},
			{
				pos = Vector(-24.1356,8.1356,25),
				ang = Angle(0,0,0)
			},
		},
		
		ExhaustPositions = {
			{
				pos = Vector(-129.668,-40.2157,70.4643),
				ang = Angle(-90,0,0)
			},
			{
				pos = Vector(-129.668,40.2157,70.4643),
				ang = Angle(-90,0,0)
			},
			{
				pos = Vector(-129.668,-40.2157,70.4643),
				ang = Angle(-90,0,0)
			},
			{
				pos = Vector(-129.668,40.2157,70.4643),
				ang = Angle(-90,0,0)
			},
			{
				pos = Vector(-129.668,-40.2157,70.4643),
				ang = Angle(-90,0,0)
			},
			{
				pos = Vector(-129.668,40.2157,70.4643),
				ang = Angle(-90,0,0)
			},
			{
				pos = Vector(-129.668,-40.2157,70.4643),
				ang = Angle(-90,0,0)
			},
			{
				pos = Vector(-129.668,40.2157,70.4643),
				ang = Angle(-90,0,0)
			},
			{
				pos = Vector(-129.668,-40.2157,70.4643),
				ang = Angle(-90,0,0)
			},
			{
				pos = Vector(-129.668,40.2157,70.4643),
				ang = Angle(-90,0,0)
			},
		},
		
		CustomSuspensionTravel = 10,
		
		FrontHeight = 0,
		FrontConstant = 45000,
		FrontDamping = 4000,
		FrontRelativeDamping = 4000,
		
		RearHeight = 0,
		RearConstant = 45000,
		RearDamping = 4000,
		RearRelativeDamping = 4000,
		
		MaxGrip = 100,
		Efficiency = 1,
		GripOffset = 0,
		BrakePower = 70,
		BulletProofTires = true,
		
		IdleRPM = 700,
		LimitRPM = 4500,
		PeakTorque = 160,
		PowerbandStart = 700,
		PowerbandEnd = 4700,
		Turbocharged = false,
		Supercharged = false,
		DoNotStall = true,
		
		FuelFillPos = Vector(-133,18,69),
		FuelType = FUELTYPE_DIESEL,
		FuelTankSize = 300,
		
		PowerBias = -0.5,
		
		EngineSoundPreset = 0,

		Sound_Idle = "btr80/btr80_idle.wav",
		Sound_IdlePitch = 1,
		
		Sound_Mid = "btr80/btr80_low.wav",
		Sound_MidPitch = 1,
		Sound_MidVolume = 1,
		Sound_MidFadeOutRPMpercent = 60,
		Sound_MidFadeOutRate = 0.4,
		
		Sound_High = "btr80/btr80_high.wav",
		Sound_HighPitch = 1,
		Sound_HighVolume = 1,
		Sound_HighFadeInRPMpercent = 45,
		Sound_HighFadeInRate = 0.2,
		
		Sound_Throttle = "",
		Sound_ThrottlePitch = 0,
		Sound_ThrottleVolume = 0,
		
		snd_horn = "common/null.wav",
		ForceTransmission = 1,
		
		DifferentialGear = 0.4,
		Gears = {-0.05,0,0.1,0.14,0.18,0.22,0.26,0.3}
	}
})


gred = gred or {}
gred.simfphys = gred.simfphys or {}

local btr80a_SusData = {}

local Maxs = Vector(10,10,0)

for i = 1,4 do
	btr80a_SusData[i] = { 
		Attachment = "sus_left_attach_"..i,
		PoseParameter = "suspension_left_"..i,
		PoseParameterMultiplier = 1,
		-- ReversePoseParam = true,
		Height = 22,
		GroundHeight = -55,
		Mins = -Maxs,
		Maxs = Maxs,
	}
	
	btr80a_SusData	[i + 4] = { 
		Attachment = "sus_right_attach_"..i,
		PoseParameter = "suspension_right_"..i,
		PoseParameterMultiplier = 1,
		-- ReversePoseParam = true,
		Height = 22,
		GroundHeight = -55,
		Mins = -Maxs,
		Maxs = Maxs,
	}
end

gred.simfphys["gred_simfphys_btr80a"] = {
	Seats = {
		[0] = { -- Driver
			ArcadeMode = {
				PlayerBoneManipulation = {
					["ValveBiped.Bip01_R_Thigh"] = Angle(-10,-18),
					["ValveBiped.Bip01_L_Thigh"] = Angle(10,-18),
					["ValveBiped.Bip01_L_Calf"] = Angle(0,45),
					["ValveBiped.Bip01_R_Calf"] = Angle(0,45),
				},

				ViewAttachment = "body_att",
				FirstPersonViewPos = Vector(0,0,0),
				ThirdPersonViewPos = Vector(19.0933,92.9814,90),
				
				MuzzleDirection = Vector(0,0.5,0),
				MuzzleAttachment = "muzzle",
				FirstPersonViewPosIsInside = true,
				TraverseIndicator = true,
				SynchronousElevation = true,
				
				Sight = {
					SightPosOffset = Vector(0,0,5),
					SightAngOffset = Angle(0,0,0),
					SightAttachment = "gun_camera",
					SightFOV = 45,
					SightFOVZoom = 40, -- ammount of FOV to remove, not the actual zoom value
					Stabilizer = true,
					SightMaterial = "gredwitch/overlay_french_tanksight_07",
				},
				
				ViewPort = {
					Attachment = "gun_camera",
					Pos = Vector(0,0,5),
					Ang = Angle(),
					
					MinAng = Angle(-90,-90,0),
					MaxAng = Angle(90,90,0),
					
					-- ModelAngOffset = Angle(0,180),
					
					-- Model = "models/gredwitch/viewports/viewport_gunner.mdl",
					-- ModelPosOffset = Vector(0,0,0),
					-- Model = "models/gredwitch/viewports/viewport_driver_alt.mdl",
					-- ModelPosOffset = Vector(0,0,0),
				},
				
				SmokeLaunchers = {
					"smoke1",
					"smoke2",
					"smoke3",
					"smoke4",
					"smoke5",
					"smoke6",
				},
			
				Primary = {
					{
						Type = "MG",
						ModuleID = 1,
						Caliber = "wac_base_30mm",
						ExactCaliber = "2А72 30",
						Sequential = false,
						Muzzles = {
							"muzzle",
						},
						
						OnShoot = function(vehicle, seat, ply, ct, SeatTab, WeaponTab, SeatID, SeatSlotTab, SlotID, MuzzleID)
							vehicle:ResetSequence("fire")
						end,
						
						FireRate = 550,
						Sounds = {
							Reload = {
								"2А72_RELOAD",
							},
							Loop = {
								"2А72_LOOP",
							},
							Stop = {
								"KPVT_LAST",
							},
							LoopInside = {
								"2А72_LOOP_INSIDE",
							},
						},
						Spread = 0.2,
						ReloadTime = 6,
						Ammo = 250,
						MuzzleFlash = "muzzleflash_mg42_3p",
						TracerColor = "red",
					},
				},
				Secondary = {
					Type = "MG",
					Caliber = "wac_base_7mm",
					ModuleID = 0,
					ExactCaliber = "PKT 7",
					Sequential = false,
					Muzzles = {
						"mg_muzzle",
					},
					FireRate = 650,
					Sounds = {
						Reload = {
							"MG_RELOAD",
						},
						Loop = {
							"PKP_LOOP",
						},
						Stop = {
							"PKT_LAST",
						},
						LoopInside = {
							"GRED_MG34_LOOP_INSIDE",
						},
						StopInside = {
							"GRED_MG_8MM_LASTSHOT_INSIDE_01",
						},
					},
					Spread = 0.1,
					ReloadTime = 5,
					Ammo = 2000,
					MuzzleFlash = "muzzleflash_mg42_3p",
					TracerColor = "red",
				},
				
				TurretTraverseSoundPitch = 100,
				TurretTraverseSoundLevel = 70,
				TurretTraverseSpeed = 60,
				TurretTraverseSound = "btr80/turret_turn_servo_h.wav",
				
				TurretElevationSound = "btr80/turret_turn_servo_v.wav",
				TurretElevationSoundPitch = 100,
				TurretElevationSoundLevel = 70,
				TurretElevationSpeed = 60,
				
				MinTraverse = -180,
				MaxTraverse = 180,
				MinElevation = -10,
				MaxElevation = 35,
				
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
							Invert = false,
						},
					},
				},
			},
			NormalMode = {
				PlayerBoneManipulation = {
					["ValveBiped.Bip01_R_Thigh"] = Angle(-10,-45),
					["ValveBiped.Bip01_L_Thigh"] = Angle(10,-45),
					["ValveBiped.Bip01_L_Calf"] = Angle(0,45),
					["ValveBiped.Bip01_R_Calf"] = Angle(0,45),
				},
				Attachment = "body_att",
				FirstPersonViewPos = Vector(0,0,0),
				ThirdPersonViewPos = Vector(30,47,90),
				FirstPersonViewPosIsInside = true,
			},
		},
		[1] = { -- Gunner
			ArcadeMode = {
				FirstPersonViewPosIsInside = true,
				Attachment = "body_att",
				FirstPersonViewPos = Vector(0,0,0),
				ThirdPersonViewPos = Vector(0,0,0),
				Attachment = "body_att",
				PlayerBoneManipulation = {
					["ValveBiped.Bip01_R_Thigh"] = Angle(-10,-45),
					["ValveBiped.Bip01_L_Thigh"] = Angle(10,-45),
					["ValveBiped.Bip01_L_Calf"] = Angle(0,45),
					["ValveBiped.Bip01_R_Calf"] = Angle(0,45),
				},
			},
		},
		[2] = { -- Commander
			ArcadeMode = {
				PlayerBoneManipulation = {
					["ValveBiped.Bip01_R_Thigh"] = Angle(-10,-45),
					["ValveBiped.Bip01_L_Thigh"] = Angle(10,-45),
					["ValveBiped.Bip01_L_Calf"] = Angle(0,45),
					["ValveBiped.Bip01_R_Calf"] = Angle(0,45),
				},
				Hatches = {
					{
						PoseParameters = {
							"hatch_commander"
						},
			
						PosOffset = Vector(0,0,0),
						AngOffset = Angle(0,0,0),
						SeatAttachment = "body_att",
					},
					
				},
				FirstPersonViewPosIsInside = true,
				IsCommander = true,
				FirstPersonViewPos = Vector(0,0,0),
				ThirdPersonViewPos = Vector(0,0,0),
				Attachment = "body_att",
			}
		},
		[3] = {
			ArcadeMode = {
				PlayerBoneManipulation = {
					["ValveBiped.Bip01_R_Thigh"] = Angle(-10,-45),
					["ValveBiped.Bip01_L_Thigh"] = Angle(10,-45),
					["ValveBiped.Bip01_L_Calf"] = Angle(0,45),
					["ValveBiped.Bip01_R_Calf"] = Angle(0,45),
					["ValveBiped.Bip01_Spine2"] = Angle(0,-15),
				},
				FirstPersonViewPosIsInside = true,
				FirstPersonViewPos = Vector(0,0,0),
				ThirdPersonViewPos = Vector(0,0,0),
				Attachment = "body_att",
			}
		},
		[4] = {
			ArcadeMode = {
				PlayerBoneManipulation = {
					["ValveBiped.Bip01_R_Thigh"] = Angle(-10,-45),
					["ValveBiped.Bip01_L_Thigh"] = Angle(10,-45),
					["ValveBiped.Bip01_L_Calf"] = Angle(0,65),
					["ValveBiped.Bip01_R_Calf"] = Angle(0,65),
					["ValveBiped.Bip01_Spine2"] = Angle(0,-15),
				},
				FirstPersonViewPosIsInside = true,
				FirstPersonViewPos = Vector(0,0,0),
				ThirdPersonViewPos = Vector(0,0,0),
				Attachment = "body_att",
			}
		},
		[5] = {
			ArcadeMode = {
				PlayerBoneManipulation = {
					["ValveBiped.Bip01_R_Thigh"] = Angle(-10,-45),
					["ValveBiped.Bip01_L_Thigh"] = Angle(10,-45),
					["ValveBiped.Bip01_L_Calf"] = Angle(0,65),
					["ValveBiped.Bip01_R_Calf"] = Angle(0,65),
					["ValveBiped.Bip01_Spine2"] = Angle(0,-15),
				},
				FirstPersonViewPosIsInside = true,
				FirstPersonViewPos = Vector(0,0,0),
				ThirdPersonViewPos = Vector(0,0,0),
				Attachment = "body_att",
			}
		},
		[6] = {
			ArcadeMode = {
				PlayerBoneManipulation = {
					["ValveBiped.Bip01_R_Thigh"] = Angle(-10,-45),
					["ValveBiped.Bip01_L_Thigh"] = Angle(10,-45),
					["ValveBiped.Bip01_L_Calf"] = Angle(0,65),
					["ValveBiped.Bip01_R_Calf"] = Angle(0,65),
					["ValveBiped.Bip01_Spine2"] = Angle(0,-15),
				},
				FirstPersonViewPosIsInside = true,
				FirstPersonViewPos = Vector(0,0,0),
				ThirdPersonViewPos = Vector(0,0,0),
				Attachment = "body_att",
			}
		},
		[7] = {
			ArcadeMode = {
				PlayerBoneManipulation = {
					["ValveBiped.Bip01_R_Thigh"] = Angle(-10,-45),
					["ValveBiped.Bip01_L_Thigh"] = Angle(10,-45),
					["ValveBiped.Bip01_L_Calf"] = Angle(0,65),
					["ValveBiped.Bip01_R_Calf"] = Angle(0,65),
					["ValveBiped.Bip01_Spine2"] = Angle(0,-15),
				},
				FirstPersonViewPosIsInside = true,
				FirstPersonViewPos = Vector(0,0,0),
				ThirdPersonViewPos = Vector(0,0,0),
				Attachment = "body_att",
			}
		},
		[8] = {
			ArcadeMode = {
				PlayerBoneManipulation = {
					["ValveBiped.Bip01_R_Thigh"] = Angle(-10,-45),
					["ValveBiped.Bip01_L_Thigh"] = Angle(10,-45),
					["ValveBiped.Bip01_L_Calf"] = Angle(0,65),
					["ValveBiped.Bip01_R_Calf"] = Angle(0,65),
					["ValveBiped.Bip01_Spine2"] = Angle(0,-15),
				},
				FirstPersonViewPosIsInside = true,
				FirstPersonViewPos = Vector(0,0,0),
				ThirdPersonViewPos = Vector(0,0,0),
				Attachment = "body_att",
			}
		},
		[9] = {
			ArcadeMode = {
				PlayerBoneManipulation = {
					["ValveBiped.Bip01_R_Thigh"] = Angle(-10,-45),
					["ValveBiped.Bip01_L_Thigh"] = Angle(10,-45),
					["ValveBiped.Bip01_L_Calf"] = Angle(0,65),
					["ValveBiped.Bip01_R_Calf"] = Angle(0,65),
					["ValveBiped.Bip01_Spine2"] = Angle(0,-15),
				},
				FirstPersonViewPosIsInside = true,
				FirstPersonViewPos = Vector(0,0,0),
				ThirdPersonViewPos = Vector(0,0,0),
				Attachment = "body_att",
			}
		},
	},
	Armour = {
		GetArmourThickness = function(vehicle,tr)		
			tr.ArmourThicknessKE = tr.ArmourThicknessKE or 12
			tr.ArmourThicknessCHEMICAL = tr.ArmourThicknessCHEMICAL or 10
			return tr
		end,
		
	},

	SusData = btr80a_SusData,
	
	OnCSTick = function(vehicle)
		vehicle:SetPoseParameter("spin_wheels_right",vehicle.trackspin_r * 0.5)
		vehicle:SetPoseParameter("spin_wheels_left",vehicle.trackspin_l * 0.5)
	end,
	
	PostSVInit = function(vehicle)
		vehicle.IsAmphibious = true
		
		local ang = vehicle:GetAngles()
		ang.y = ang.y + 90

		local Floaties = {}

		for i = -1,1,2 do
			local ent = ents.Create("prop_physics")
			ent:SetModel("models/hunter/blocks/cube05x6x05.mdl")
			ent:SetPos(vehicle:LocalToWorld(Vector(0,30 * i,56.2913)))
			ent:SetAngles(ang)
			ent:SetModelScale(0.7)
			ent:SetNoDraw(true)
			ent:Spawn()
			ent:Activate()
			ent:GetPhysicsObject():SetMass(1000)
			-- ent:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)

			vehicle:DeleteOnRemove(ent)

			constraint.Weld(ent,vehicle,0,0,0,true)

			table.insert(Floaties,ent)
		end

		vehicle.Floaties = Floaties

		function vehicle:IsDriveWheelsOnGround()
			return (self.DriveWheelsOnGround == 1) or vehicle.susOnGround
		end

		local OldPhysicsUpdate = vehicle.PhysicsUpdate

		vehicle.PhysicsUpdate = function(vehicle,phy)
			OldPhysicsUpdate(vehicle,phy)
			
			for i = 1,2 do
				local ent = vehicle.Floaties[i]

				if not IsValid(ent) then
					continue
				end
				
				ent:GetPhysicsObject():SetBuoyancyRatio(10)
			end

			if vehicle.IsUnderWater then
				local vel = phy:GetAngleVelocity()

				vel.z = 0
				vel:Mul(-0.05)

				phy:AddAngleVelocity(vel)
			end
		end

		if not FunnyLVT then
			FunnyLVT = FunnyLVT or gred.TankUpdateSuspension

			gred.TankUpdateSuspension = function(vehicle,ct,SusDataTab)
				FunnyLVT(vehicle,ct,SusDataTab)

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
gred.simfphys["gred_simfphys_btr80a"].Seats[2].NormalMode = gred.simfphys["gred_simfphys_btr80a"].Seats[2].ArcadeMode
gred.simfphys["gred_simfphys_btr80a"].Seats[3].NormalMode = gred.simfphys["gred_simfphys_btr80a"].Seats[3].ArcadeMode
gred.simfphys["gred_simfphys_btr80a"].Seats[4].NormalMode = gred.simfphys["gred_simfphys_btr80a"].Seats[4].ArcadeMode
gred.simfphys["gred_simfphys_btr80a"].Seats[5].NormalMode = gred.simfphys["gred_simfphys_btr80a"].Seats[5].ArcadeMode
gred.simfphys["gred_simfphys_btr80a"].Seats[6].NormalMode = gred.simfphys["gred_simfphys_btr80a"].Seats[6].ArcadeMode
gred.simfphys["gred_simfphys_btr80a"].Seats[7].NormalMode = gred.simfphys["gred_simfphys_btr80a"].Seats[7].ArcadeMode
gred.simfphys["gred_simfphys_btr80a"].Seats[8].NormalMode = gred.simfphys["gred_simfphys_btr80a"].Seats[8].ArcadeMode
gred.simfphys["gred_simfphys_btr80a"].Seats[9].NormalMode = gred.simfphys["gred_simfphys_btr80a"].Seats[9].ArcadeMode

gred.simfphys["gred_simfphys_btr80a"].Seats[1].NormalMode = table.FullCopy(gred.simfphys["gred_simfphys_btr80a"].Seats[0].ArcadeMode) -- we use table.FullCopy so we can change stuff
gred.simfphys["gred_simfphys_btr80a"].Seats[1].NormalMode.Hatches = gred.simfphys["gred_simfphys_btr80a"].Seats[1].ArcadeMode.Hatches -- we want the body_att's normal mode to have the same hatches as in arcade mode
gred.simfphys["gred_simfphys_btr80a"].Seats[1].NormalMode.FirstPersonViewPosIsInside = true
gred.simfphys["gred_simfphys_btr80a"].Seats[1].NormalMode.ViewAttachment = nil
gred.simfphys["gred_simfphys_btr80a"].Seats[1].NormalMode.ThirdPersonViewPos = Vector(-17.3077,-21.5318,80)
gred.simfphys["gred_simfphys_btr80a"].Seats[1].NormalMode.Attachment = "body_att"

gred.simfphys["gred_simfphys_btr80a"].Seats[0].NormalMode.Hatches = gred.simfphys["gred_simfphys_btr80a"].Seats[0].ArcadeMode.Hatches

gred.simfphys["gred_simfphys_btr80a"].Seats[0].NormalMode.ViewPort = {
	FreeView = true,
	--Attachment = "gunner_sight",
	Pos = Vector(118.802,15.6415,61.7836),
	Ang = Angle(),
	
	Debug = false,
	
	MinAng = Angle(-1,-25,-1),
	MaxAng = Angle(1,25,1),
}