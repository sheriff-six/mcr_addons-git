gred = gred or {}
gred.AddonList = gred.AddonList or {}
table.insert(gred.AddonList,1131455085) -- Base addon
table.insert(gred.AddonList,771487490) -- simfphys
table.insert(gred.AddonList,831680603) -- simfphys armed

local light_table = {
	L_HeadLampPos = Vector(165,33,35),
	L_HeadLampAng = Angle(9,0,0),
	R_HeadLampPos = Vector(165,-33,35),
	R_HeadLampAng = Angle(9,0,0),	
	L_RearLampPos = Vector(-200,33,33),
	L_RearLampAng = Angle(45,180,0),
	R_RearLampPos = Vector(-200,-33,33),
	R_RearLampAng = Angle(45,180,0),	
	Headlight_sprites = {	
		{
			pos = Vector(80,-11,67),
			size = 25,
			color = Color(255,93,0,255),
		},
		{
			pos = Vector(81,0,67),
			size = 25,
			color = Color(255,93,0,255),
		},		
		{
			pos = Vector(80,12,67),
			size = 25,
			color = Color(255,93,0,255),
		},	
		{
			pos = Vector(152,30,11),Vector(152,30,11),
			size = 50,
		},		
		{
			pos = Vector(152,-30,11),Vector(152,-30,11),
			size = 50,
		},
	},
	Headlamp_sprites = { 
		{
			pos = Vector(152,30,11),
			size = 45,
		},
		{
			pos = Vector(152,-30,11),
			size = 45,
		},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-135,-38,10),Vector(-135,-38,10),
			size = 30,
		},
		{
			pos = Vector(-135,38,10),Vector(-135,-38,10),
			size = 30,
		},
	},
	Brakelight_sprites = {
		{
			pos = Vector(-135,-38,10),Vector(-135,-38,10),
			size = 30,
		},
		{
			pos = Vector(-135,38,10),Vector(-135,-38,10),
			size = 30,
		},
	},
}
list.Set( "simfphys_lights", "sw_ural4320_light", light_table)

local V = {
	Name = "URAL-4320",
	Model = "models/sw/ground/ural4320/ural4320.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Сирия - Военные",
	SpawnOffset = Vector(0,0,40),
	SpawnAngleOffset = 180,

	Members = {
		Mass = 5000,
		EnginePos = Vector(160,0,30),
		BulletProofTires = true,
		
		LightsTable = "sw_ural4320_light",
		
		MaxHealth = 3000,
		
		IsArmored = true,
				
		CustomWheels = true,
		CustomSuspensionTravel = 10,
		
		CustomWheelModel = "models/sw/ground/ural4320/wheel.mdl",
		CustomWheelPosFL = Vector(112,40,-26),
		CustomWheelPosFR = Vector(112,-40,-26),
		CustomWheelPosML = Vector(-28,40,-26),
		CustomWheelPosMR = Vector(-28,-40,-26),
		CustomWheelPosRL = Vector(-85,40,-26),
		CustomWheelPosRR = Vector(-85,-40,-26),
		CustomWheelAngleOffset = Angle(0,0,0),
		CustomMassCenter = Vector(-15,0,10),
		CustomSteerAngle = 30,
		SeatOffset = Vector(56,-20,48),
		SeatPitch = 0,
		SeatYaw = 90,

		PassengerSeats = {
			{
				pos = Vector(56,-3,15),
				ang = Angle(0,-90,0)
			},
			{
				pos = Vector(56,-23,15),
				ang = Angle(0,-90,0)
			},
			{
				pos = Vector(0,-36,22),
				ang = Angle(0,0,0)
			},
			{
				pos = Vector(-30,-36,22),
				ang = Angle(0,0,0)
			},
			{
				pos = Vector(-60,-36,22),
				ang = Angle(0,0,0)
			},
			{
				pos = Vector(-90,-36,22),
				ang = Angle(0,0,0)
			},
			{
				pos = Vector(0,36,22),
				ang = Angle(0,180,0)
			},
			{
				pos = Vector(-30,36,22),
				ang = Angle(0,180,0)
			},
			{
				pos = Vector(-60,36,22),
				ang = Angle(0,180,0)
			},
			{
				pos = Vector(-90,36,22),
				ang = Angle(0,180,0)
			},
		},

		FrontHeight = 2,
		FrontConstant = 100000,
		FrontDamping = 12000,
		FrontRelativeDamping = 2000,
		
		RearHeight = 2,
		RearConstant = 100000,
		RearDamping = 12000,
		RearRelativeDamping = 2000,
		
		FastSteeringAngle = 10,
		SteeringFadeFastSpeed = 535,
		
		TurnSpeed = 4,
		
		MaxGrip = 180,
		Efficiency = 1,
		GripOffset = -4,
		BrakePower = 80,
		
		IdleRPM = 4000,
		LimitRPM = 9000,
		PeakTorque = 190,
		PowerbandStart = 900,
		PowerbandEnd = 8000,
		Turbocharged = false,
		Supercharged = false,
		
		FuelFillPos = Vector(38,45,8),
		FuelType = FUELTYPE_PETROL,
		FuelTankSize = 80,
		
		PowerBias = 0,
		
		PowerBias = -1,
		
		EngineSoundPreset = 0,
		
		Sound_Idle = "vehicles/crane/crane_startengine1.wav",
		Sound_IdlePitch = 1,
		
		Sound_Mid = "simulated_vehicles/alfaromeo/alfaromeo_low.wav",
		Sound_MidPitch = 0.5,
		Sound_MidVolume = 1,
		Sound_MidFadeOutRPMpercent = 100,
		Sound_MidFadeOutRate = 1,
		
		Sound_High = "",
		
		Sound_Throttle = "simulated_vehicles/alfaromeo/alfaromeo_mid.wav",
		
		snd_horn = "simulated_vehicles/horn_2.wav",
		
		DifferentialGear = 0.25,
		Gears = {-0.2,0,0.2,0.4,0.6,0.8}
	}
}
list.Set( "simfphys_vehicles", "sw_ural4320", V )

gred = gred or {}
gred.simfphys = gred.simfphys or {}
gred.simfphys["sw_ural4320"] = {
	Armour = {
		GetArmourThickness = function(vehicle,tr)			
			tr.ArmourThicknessKE = tr.ArmourThicknessKE or 7
			tr.ArmourThicknessCHEMICAL = tr.ArmourThicknessCHEMICAL or tr.ArmourThicknessKE
			return tr
		end,
		
	},
}