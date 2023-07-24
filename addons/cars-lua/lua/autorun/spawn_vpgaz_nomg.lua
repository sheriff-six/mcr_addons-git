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
	name = "AGS_Shoot",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 130,
	sound = "^rus/ags/30mm_shoot.wav"
})

sound.Add({
	name = "AGS_reload",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 130,
	sound = "^rus/ags/ags_reload.wav"
})

list.Set("simfphys_lights","gaz2975",{
	L_HeadLampPos = Vector(98,28,41),
	L_HeadLampAng = Angle(10,0,0),

	R_HeadLampPos = Vector(98,-28,41),
	R_HeadLampAng = Angle(10,0,0),

	L_RearLampPos = Vector(-88,31,24.5),
	L_RearLampAng = Angle(10,180,0),

	R_RearLampPos = Vector(-88,-31,24.5),
	R_RearLampAng = Angle(10,180,0),
	
	Headlight_sprites = { 
		Vector(98,28,41),
		Vector(98,-28,41),
	},
	Headlamp_sprites = { 
		Vector(98,28,41),
		Vector(98,-28,41),
	},
	FogLight_sprites = {
		Vector(29,0,89),
		Vector(-83,42,85),
		Vector(96.0314,-35.7789,43.3112),
		Vector(96.0314,35.7789,43.3112),
	},
	Rearlight_sprites = {
		Vector(-88,25,24.5),
		Vector(-88,-25,24.5),
	},
	Brakelight_sprites = {
		Vector(-88,37,24.5),
		Vector(-88,-37,24.5),
	},
	Reverselight_sprites = {
		Vector(-88,31,24.5),
		Vector(-88,-31,24.5),
	},
	Turnsignal_sprites = { -- поворотники
		Right = { -- правый
		Vector(96.0314,-35.7789,43.3112),
		Vector(56.2304,-44.3834,43.904),
		---- задние
		Vector(-88,-40,24.5),
		},
		Left = { -- левый
		Vector(96.0314,35.7789,43.3112),
		Vector(56.2304,44.3834,43.904),
		---- задние
		Vector(-88,40,24.5),
		},
	},
	ems_sounds = {"left4dead/vehicles/van_ambulance_wail.wav","left4dead/vehicles/van_ambulance_hilo.wav"},
    ems_sprites = {
	{
		pos = Vector(35,21,85),
		material = "l4d/corona",
		size = 80,
		Colors = {
					Color(0,0,255,255),
					Color(0,0,255,0),
				},
		Speed = 0.30
	},


	{
		pos = Vector(35,15,85),
		material = "l4d/corona",
		size = 80,
		Colors = {
					Color(0,0,255,255),
					Color(0,0,255,0),
				},
		Speed = 0.30
	},
	{
		pos = Vector(35,8,85),
		material = "l4d/corona",
		size = 80,
		Colors = {
					Color(0,0,255,255),
					Color(0,0,255,0),
				},
		Speed = 0.30
	},
	{
		pos = Vector(35,-7,85),
		material = "l4d/corona",
		size = 80,
		Colors = {
					Color(0,0,255,255),
					Color(0,0,255,0),
				},
		Speed = 0.20
	},
	{
		pos = Vector(35,-14,85),
		material = "l4d/corona",
		size = 80,
		Colors = {
					Color(0,0,255,255),
					Color(0,0,255,0),
				},
		Speed = 0.20
	},
	{
		pos = Vector(35,-21,85),
		material = "l4d/corona",
		size = 80,
		Colors = {
					Color(0,0,255,255),
					Color(0,0,255,0),
				},
		Speed = 0.20
	},

	
	
},
DelayOn = 0,
DelayOff = 0,
})




list.Set("simfphys_vehicles","gred_simfphys_gaz2975_nomg",{
	Name = "GAZ 2975 VP", 
	Model = Model("models/cars/rus/gaz/gaz2975_nomgvp.mdl"),
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Сирия - Военные",
	SpawnOffset = Vector(0,0,10),
	SpawnAngleOffset = 0,

	Members = {
		Mass = 4000,
		
		LightsTable = "gaz2975",
		
		OnTick = function(vehicle)
			local turn = vehicle:GetVehicleSteer() * 2 -- -1 or 1
			vehicle:SetPoseParameter("steer_wheels", -turn / 2)
		end,
		
		OnDestroyed = function(ent)
			local gib = ent.Gib
			if !IsValid(gib) then return end
			
			local pos,ang,skin,pitch,yaw = gib:GetPos(),gib:GetAngles(),gib:GetSkin(),ent:GetPoseParameter("cannon_aim_pitch"),ent:GetPoseParameter("cannon_aim_yaw")
			gib:SetPoseParameter("mg_aim_pitch",pitch)
			gib:SetPoseParameter("mg_aim_yaw",yaw)
		end,
		
		MaxHealth = 5000,
		
		IsArmored = true,
		
		NoWheelGibs = true,
		
		FirstPersonViewPos = Vector(0,0,0),
		
		FrontWheelRadius = 20,
		RearWheelRadius = 20,
		
		EnginePos = Vector(65,0,48),
		
		CustomWheels = true,
		
		CustomWheelModel = "models/props_c17/canisterchunk01g.mdl",		
		CustomWheelPosFL = Vector(75,39,11),
		CustomWheelPosFR = Vector(75,-39,11),	
		CustomWheelPosRL = Vector(-65,39,11),
		CustomWheelPosRR = Vector(-65,-39,11),
		CustomWheelAngleOffset = Angle(0,180,0),
		
		CustomMassCenter = Vector(0,0,15),
		
		CustomSteerAngle = 35,
		FastSteeringAngle = 20,
		SteeringFadeFastSpeed = 445,
		
		TurnSpeed = 4,
		
		SeatOffset = Vector(5,-25,64),
		SeatPitch = 0,
		SeatYaw = 90,
		
		ModelInfo = {
			WheelColor = Color(0,0,0,0),
			-- WheelColor = Color(0,0,0,255),
		},
		
		ExhaustPositions = {
		},
		
		PassengerSeats = {
			{
				pos = Vector(-28,-26,35),
				ang = Angle(0,-90,10)
			},
			{
				pos = Vector(8,-26,35),
				ang = Angle(0,-90,10)
			},
			{
				pos = Vector(-28,26,35),
				ang = Angle(0,-90,10)
			},
			{
				pos = Vector(-60,-14,35),
				ang = Angle(0,-90,10)
			},
			{
				pos = Vector(-60,14,35),
				ang = Angle(0,90,5)
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
		
		MaxGrip = 85,
		Efficiency = 1,
		GripOffset = -2,
		BrakePower = 100,
		BulletProofTires = true,
		
		IdleRPM = 700,
		LimitRPM = 4500,
		PeakTorque = 180,
		PowerbandStart = 700,
		PowerbandEnd = 4700,
		Turbocharged = true,
		Supercharged = false,
		DoNotStall = false,
		
		FuelFillPos = Vector(7,45,34),
		FuelType = FUELTYPE_DIESEL,
		FuelTankSize = 100,
		
		PowerBias = 0,
		
		EngineSoundPreset = 0,
		
		Sound_Idle = "simulated_vehicles/misc/nanjing_loop.wav",
		Sound_IdlePitch = 0.7,
		
		Sound_Mid = "simulated_vehicles/alfaromeo/alfons_low.wav",
		Sound_MidPitch = 0.5,
		Sound_MidVolume = 2,
		Sound_MidFadeOutRPMpercent = 70,		-- at wich percentage of limitrpm the sound fades out
		Sound_MidFadeOutRate = 0.44,                    --how fast it fades out   0 = instant       1 = never
		
		Sound_High = "simulated_vehicles/misc/v8high2.wav",
		Sound_HighPitch = 0.7,
		Sound_HighVolume = 4.0,
		Sound_HighFadeInRPMpercent = 25,
		Sound_HighFadeInRate = 0.44,
		
		Sound_Throttle = "",		-- mutes the default throttle sound
		Sound_ThrottlePitch = 0,
		Sound_ThrottleVolume = 0,
		
		snd_horn = "simulated_vehicles/horn_3.wav",
		
		DifferentialGear = 0.3,
		Gears = {-0.1,0,0.1,0.2,0.3,0.4,0.5}
	}
})


gred = gred or {}
gred.simfphys = gred.simfphys or {}

local Gaz2975_kord_SusData = {}

local Maxs = Vector(10,10,0)

for i = 1,2 do
	Gaz2975_kord_SusData[i] = { 
		Attachment = "sus_left_attach_"..i,
		PoseParameter = "suspension_left_"..i,
		PoseParameterMultiplier = 1,
		-- ReversePoseParam = true,
		Height = 20,
		GroundHeight = -33,
		Mins = -Maxs,
		Maxs = Maxs,
	}
	
	Gaz2975_kord_SusData	[i + 2] = { 
		Attachment = "sus_right_attach_"..i,
		PoseParameter = "suspension_right_"..i,
		PoseParameterMultiplier = 1,
		-- ReversePoseParam = true,
		Height = 20,
		GroundHeight = -33,
		Mins = -Maxs,
		Maxs = Maxs,
	}
end

gred.simfphys["gred_simfphys_gaz2975_nomg"] = {
	Seats = {
		[0] = { -- Driver
			ArcadeMode = {
				PlayerBoneManipulation = {
					["ValveBiped.Bip01_R_Thigh"] = Angle(-40,-5),
					["ValveBiped.Bip01_L_Thigh"] = Angle(40,-5),
				},

				FirstPersonViewPos = Vector(0,-10,5),
				ThirdPersonViewPos = Vector(25,-10,27),
				FirstPersonViewPosIsInside = true,
				},
				NormalMode = {
					PlayerBoneManipulation = {
					["ValveBiped.Bip01_R_Thigh"] = Angle(-40,-5),
					["ValveBiped.Bip01_L_Thigh"] = Angle(40,-5),
				},
				FirstPersonViewPos = Vector(0,-10,5),
				ThirdPersonViewPos = Vector(25,-10,27),
				FirstPersonViewPosIsInside = true,
				},
		},
		[1] = { -- Commander
			ArcadeMode = {
				FirstPersonViewPosIsInside = true,
				FirstPersonViewPos = Vector(0,0,0),
				ThirdPersonViewPos = Vector(0,0,0),
				Attachment = "seat",
				ThirdPersonViewPos = Vector(0,0,0),
			}
		},
		[2] = {
			ArcadeMode = {
				FirstPersonViewPosIsInside = true,
				FirstPersonViewPos = Vector(0,0,0),
				ThirdPersonViewPos = Vector(0,0,0),
				Attachment = "seat",
				ThirdPersonViewPos = Vector(0,0,0),
			}
		},
		[3] = {
			ArcadeMode = {
				FirstPersonViewPosIsInside = true,
				FirstPersonViewPos = Vector(0,0,0),
				ThirdPersonViewPos = Vector(0,0,0),
				Attachment = "seat",
				ThirdPersonViewPos = Vector(0,0,0),
			}
		},
		[4] = {
			ArcadeMode = {
				FirstPersonViewPosIsInside = true,
				FirstPersonViewPos = Vector(0,0,0),
				ThirdPersonViewPos = Vector(0,0,0),
				Attachment = "seat",
				ThirdPersonViewPos = Vector(0,0,0),
			}
		},
		[5] = {
			ArcadeMode = {
				PlayerBoneManipulation = {
					["ValveBiped.Bip01_R_Thigh"] = Angle(-40,-9),
					["ValveBiped.Bip01_L_Thigh"] = Angle(40,-9),
					["ValveBiped.Bip01_L_Calf"] = Angle(0,20),
					["ValveBiped.Bip01_R_Calf"] = Angle(0,20),
				},
				FirstPersonViewPosIsInside = true,
				FirstPersonViewPos = Vector(0,0,0),
				ThirdPersonViewPos = Vector(0,0,0),
				Attachment = "seat",
				ThirdPersonViewPos = Vector(0,0,0),
			}
		},
	},
	Armour = {
		GetArmourThickness = function(vehicle,tr)		
			tr.ArmourThicknessKE = tr.ArmourThicknessKE or 10
			tr.ArmourThicknessCHEMICAL = tr.ArmourThicknessCHEMICAL or tr.ArmourThicknessKE
			return tr
		end,
		
	},

	SusData = Gaz2975_kord_SusData,
	
	OnCSTick = function(vehicle)
		vehicle:SetPoseParameter("spin_wheels_right",-vehicle.trackspin_r)
		vehicle:SetPoseParameter("spin_wheels_left",-vehicle.trackspin_l)
	end,
}
gred.simfphys["gred_simfphys_gaz2975_nomg"].Seats[1].NormalMode = gred.simfphys["gred_simfphys_gaz2975_nomg"].Seats[1].ArcadeMode
gred.simfphys["gred_simfphys_gaz2975_nomg"].Seats[2].NormalMode = gred.simfphys["gred_simfphys_gaz2975_nomg"].Seats[2].ArcadeMode
gred.simfphys["gred_simfphys_gaz2975_nomg"].Seats[3].NormalMode = gred.simfphys["gred_simfphys_gaz2975_nomg"].Seats[3].ArcadeMode
gred.simfphys["gred_simfphys_gaz2975_nomg"].Seats[4].NormalMode = gred.simfphys["gred_simfphys_gaz2975_nomg"].Seats[4].ArcadeMode
gred.simfphys["gred_simfphys_gaz2975_nomg"].Seats[5].NormalMode = gred.simfphys["gred_simfphys_gaz2975_nomg"].Seats[5].ArcadeMode

gred.simfphys["gred_simfphys_gaz2975_nomg"].Seats[0].NormalMode.Hatches = gred.simfphys["gred_simfphys_gaz2975_nomg"].Seats[0].ArcadeMode.Hatches