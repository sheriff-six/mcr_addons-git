local Category = "Сирия - Военные"

local IV = {
	Name = "Kamaz-r142nm",
	Model = "models/russian/kamazr142nm/kamazr142nm.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = Category,
	SpawnOffset = Vector(0,0,50),

	Members = {
		Mass = 4000,
		LightsTable = "kamazr142nm",

           GibModels = {
			"models/russian/kamazr142nm/kamazr142nm.mdl",
		},

		CustomWheels = true,
		EnginePos = Vector(91,-1,58),
		CustomSuspensionTravel = 1.5,
		
		CustomWheelModel = "models/russian/kamazr142nm/kamazr142nm_wheel.mdl",
		CustomWheelPosFL = Vector(100,40,35.5),
		CustomWheelPosFR = Vector(100,-40,35.5),
		CustomWheelPosRL = Vector(-43,40,35.5),
		CustomWheelPosRR = Vector(-43,-40,35.5),
		
		CustomWheelAngleOffset = Angle(0,90,0),
		
		CustomMassCenter = Vector(0,0,2),
		
		CustomSteerAngle = 30,
		
		SeatOffset = Vector(102,-23,99),
		SeatPitch = 5,
		SeatYaw = 90,
		
		PassengerSeats = {
			{
				pos = Vector(113,-9,58),
				ang = Angle(0,-90,10)
			},
			{
				pos = Vector(113,-25,58),
				ang = Angle(0,-90,10)
			},
			{
				pos = Vector(-19,9,66),
				ang = Angle(0,-90,10)
			},

			{
				pos = Vector(-19,-9,66),
				ang = Angle(0,-90,10)
			},
			{
				pos = Vector(-19,-25,66),
				ang = Angle(0,-90,10)
			},

			{
				pos = Vector(-45,31,66),
				ang = Angle(0,-180,10)
			},
			{
				pos = Vector(-45,-31,66),
				ang = Angle(0,-360,10)
			},
			{
				pos = Vector(-65,31,66),
				ang = Angle(0,-180,10)
			},
			{
				pos = Vector(-65,-31,66),
				ang = Angle(0,-360,10)
			},
			{
				pos = Vector(-85,31,66),
				ang = Angle(0,-180,10)
			},
			{
				pos = Vector(-85,-31,66),
				ang = Angle(0,-360,10)
			},

			},
		ExhaustPositions = {
			{
				pos = Vector(-23,-43,41),
				ang = Angle(90,270,0),
			},

		},

		
		FrontHeight = 28,
		FrontConstant = 90000,
		FrontDamping = 7000,
		FrontRelativeDamping = 4000,
		
		RearHeight = 28,
		RearConstant = 90000,
		RearDamping = 7000,
		RearRelativeDamping = 4000,
		
		FastSteeringAngle = 80,
		SteeringFadeFastSpeed = 535,
		
		TurnSpeed = 3,
		
		MaxGrip = 110,
		Efficiency = 1.0,
		GripOffset = -2,
		BrakePower = 40,

		MaxHealth = 4500,

		IdleRPM = 950,
		LimitRPM = 4000,
		PeakTorque = 80,
		PowerbandStart = 1800,
		PowerbandEnd = 3200,
		Turbocharged = false,
		
		FuelFillPos = Vector(39,-39,47),
		FuelType = 2,
		FuelTankSize = 350,
		
		PowerBias = 1,
		
		EngineSoundPreset = 0,

		
		Sound_Idle = "russian/vehicles/armytruck_idle.wav",
		Sound_IdlePitch = 1,
		
		Sound_Mid = "russian/vehicles/armytruck_low.wav",
		Sound_MidPitch = 1.2,
		Sound_MidVolume = 1,
		Sound_MidFadeOutRPMpercent = 70,
		Sound_MidFadeOutRate = 0.5,
		
		Sound_High = "russian/vehicles/armytruck_high.wav",
		Sound_HighPitch = 1.2,
		Sound_HighVolume = 1.5,
		Sound_HighFadeInRPMpercent = 70,
		Sound_HighFadeInRate = 0.5,
		
		Sound_Throttle = "russian/vehicles/armytruck_throttle.wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 3,
		
		snd_horn = "russian/vehicles/armytruck_horn.wav",
		
		DifferentialGear = 0.80,
		Gears = {-0.05,0,0.05,0.10,0.15,0.20,0.21}

	}
}
list.Set( "simfphys_vehicles", "simfphys_kamazr142nm", IV )
local light_table = {
	L_HeadLampPos = Vector(151,31.5,52.5),
	L_HeadLampAng = Angle(0,0,0),

	R_HeadLampPos = Vector(151,-32,52.5),
	R_HeadLampAng = Angle(0,0,0),
	
	Headlight_sprites = { 
{
		pos = Vector(151,31.5,52.5),
		size = 55,
},
{
		pos = Vector(151,-32,52.5),
		size = 55,
},

},
	Headlamp_sprites = { 
{
		pos = Vector(151,31.5,52.5),
		size = 55,
},
{
		pos = Vector(134,47.5,103.5),
		size = 55,
},

{
		pos = Vector(151,-32,52.5),
		size = 55,
},

},
	
	Rearlight_sprites = {
{
		pos = Vector(-104,27,39),
		size = 35,
},
{
		pos = Vector(-104,-27,39),
		size = 35,
},

},
	Brakelight_sprites = {
{
		pos = Vector(-104,27,39),
		size = 35,
},
{
		pos = Vector(-104,-27,39),
		size = 35,
},

},
	Reverselight_sprites = {
{
		pos = Vector(-104,27,39),
		size = 35,
},
{
		pos = Vector(-104,-27,39),
		size = 35,
},

},
	DelayOn = 0.1,
	DelayOff = 0.1,
	
	Turnsignal_sprites = {
		Left = {
{
		pos = Vector(-104,31,39),
		size = 35,
},

{
		pos = Vector(158,32,38),
		size = 35,
},

},
		Right = {
{
		pos = Vector(-104,-31,39),
		size = 35,
},
{
		pos = Vector(158,-32.5,38),
		size = 35,
},

		},
	}
}
list.Set( "simfphys_lights", "kamazr142nm", light_table)


local Category = "Сирия - Военные"

local IV = {
	Name = "Ural-375 fuel",
	Model = "models/russian/ural375fuel/ural375fuel.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = Category,
	SpawnOffset = Vector(0,0,50),

	Members = {
		Mass = 4000,
		LightsTable = "ural375fuel",

           GibModels = {
			"models/russian/ural375fuel/ural375fuel.mdl",
		},
		IsArmored = false,
		BulletProofTires = false,
		CustomWheels = true,
		EnginePos = Vector(99,-1,68),
		CustomSuspensionTravel = 1.5,
		
		CustomWheelModel = "models/russian/ural375fuel/ural375fuel_wheel.mdl",
		CustomWheelPosFL = Vector(87,40,35),
		CustomWheelPosFR = Vector(87,-40,35),
		CustomWheelPosML = Vector(-46,38.5,35),
		CustomWheelPosMR = Vector(-46,-40,35),
		CustomWheelPosRL = Vector(-101,38.5,35),
		CustomWheelPosRR = Vector(-101,-40,35),

		
		CustomWheelAngleOffset = Angle(0,90,0),
		
		CustomMassCenter = Vector(0,0,0),
		
		CustomSteerAngle = 30,
		
		SeatOffset = Vector(26,-19,90),
		SeatPitch = 5,
		SeatYaw = 90,
		
		PassengerSeats = {
			{
				pos = Vector(40,-7,54),
				ang = Angle(0,-90,10)
			},
			{
				pos = Vector(40,-23,54),
				ang = Angle(0,-90,10)
			},

			},
		ExhaustPositions = {
			{
				pos = Vector(-7,-42.5,32.5),
				ang = Angle(90,270,0),
			},

		},

		
		FrontHeight = 28,
		FrontConstant = 90000,
		FrontDamping = 7000,
		FrontRelativeDamping = 4000,
		
		RearHeight = 28,
		RearConstant = 90000,
		RearDamping = 7000,
		RearRelativeDamping = 4000,
		
		FastSteeringAngle = 80,
		SteeringFadeFastSpeed = 535,
		
		TurnSpeed = 3,
		
		MaxGrip = 110,
		Efficiency = 1.0,
		GripOffset = -2,
		BrakePower = 40,

		MaxHealth = 4500,

		IdleRPM = 950,
		LimitRPM = 4000,
		PeakTorque = 80,
		PowerbandStart = 1800,
		PowerbandEnd = 3200,
		Turbocharged = false,
		
		FuelFillPos = Vector(16,48,48),
		FuelType = 2,
		FuelTankSize = 360,
		
		PowerBias = 1,
		
		EngineSoundPreset = 0,

		
		Sound_Idle = "russian/vehicles/armytruck_idle.wav",
		Sound_IdlePitch = 1,
		
		Sound_Mid = "russian/vehicles/armytruck_low.wav",
		Sound_MidPitch = 1.2,
		Sound_MidVolume = 1,
		Sound_MidFadeOutRPMpercent = 70,
		Sound_MidFadeOutRate = 0.5,
		
		Sound_High = "russian/vehicles/armytruck_high.wav",
		Sound_HighPitch = 1.2,
		Sound_HighVolume = 1.5,
		Sound_HighFadeInRPMpercent = 70,
		Sound_HighFadeInRate = 0.5,
		
		Sound_Throttle = "russian/vehicles/armytruck_throttle.wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 3,
		
		snd_horn = "russian/vehicles/armytruck_horn.wav",
		
		DifferentialGear = 0.80,
		Gears = {-0.05,0,0.05,0.10,0.15,0.20,0.21}

	}
}
list.Set( "simfphys_vehicles", "simfphys_ural375fuel", IV )
local light_table = {
	L_HeadLampPos = Vector(124,28.5,51.5),
	L_HeadLampAng = Angle(0,0,0),

	R_HeadLampPos = Vector(124,-28.5,51.5),
	R_HeadLampAng = Angle(0,0,0),
	
	Headlight_sprites = { 
{
		pos = Vector(124,28.5,51.5),
		size = 55,
},
{
		pos = Vector(124,-28.5,51.5),
		size = 55,
},

},
	Headlamp_sprites = { 
{
		pos = Vector(124,28.5,51.5),
		size = 55,
},
{
		pos = Vector(124,-28.5,51.5),
		size = 55,
},

{
		pos = Vector(67,41.5,80),
		size = 55,
},

},
	
	Rearlight_sprites = {
{
		pos = Vector(-131,34,37.5),
		size = 35,
},
{
		pos = Vector(-131,-34,37.5),
		size = 35,
},
{
		pos = Vector(-131,30,37.5),
		size = 35,
},
{
		pos = Vector(-131,-30,37.5),
		size = 35,
},

},
	Brakelight_sprites = {
{
		pos = Vector(-131,34,37.5),
		size = 35,
},
{
		pos = Vector(-131,-34,37.5),
		size = 35,
},
{
		pos = Vector(-131,30,37.5),
		size = 35,
},
{
		pos = Vector(-131,-30,37.5),
		size = 35,
},

},
	Reverselight_sprites = {
{
		pos = Vector(-131,34,37.5),
		size = 35,
},
{
		pos = Vector(-131,-34,37.5),
		size = 35,
},
{
		pos = Vector(-131,30,37.5),
		size = 35,
},
{
		pos = Vector(-131,-30,37.5),
		size = 35,
},

},
	DelayOn = 0.1,
	DelayOff = 0.1,
	
	Turnsignal_sprites = {
		Left = {
{
		pos = Vector(-131,37,37.5),
		size = 35,
},

{
		pos = Vector(125,36,54),
		size = 35,
},

},
		Right = {
{
		pos = Vector(-131,-37,37.5),
		size = 35,
},
{
		pos = Vector(125,-36,54),
		size = 35,
},

		},
	}
}
list.Set( "simfphys_lights", "ural375fuel", light_table)

local Category = "Сирия - Военные"

local IV = {
	Name = "Ural APA-5D",
	Model = "models/russian/uralapa5d/uralapa5d.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = Category,
	SpawnOffset = Vector(0,0,50),

	Members = {
		Mass = 4000,
		LightsTable = "uralapa5d",

           GibModels = {
			"models/russian/uralapa5d/uralapa5d.mdl",
		},
		IsArmored = false,
		BulletProofTires = false,
		CustomWheels = true,
		EnginePos = Vector(105,0,72),
		CustomSuspensionTravel = 1.5,
		
		CustomWheelModel = "models/russian/uralapa5d/uralapa5d_wheel.mdl",
		CustomWheelPosFL = Vector(91,40,37),
		CustomWheelPosFR = Vector(91,-40,37),
		CustomWheelPosML = Vector(-50,40,37),
		CustomWheelPosMR = Vector(-50,-40,37),
		CustomWheelPosRL = Vector(-106,40,37),
		CustomWheelPosRR = Vector(-106,-40,37),

		
		CustomWheelAngleOffset = Angle(0,90,0),
		
		CustomMassCenter = Vector(0,0,0),
		
		CustomSteerAngle = 30,
		
		SeatOffset = Vector(28,-21,95),
		SeatPitch = 5,
		SeatYaw = 90,
		
		PassengerSeats = {
			{
				pos = Vector(40,-7,60),
				ang = Angle(0,-90,10)
			},
			{
				pos = Vector(40,-23,60),
				ang = Angle(0,-90,10)
			},

			},
		ExhaustPositions = {
			{
				pos = Vector(4.5,-40.5,38),
				ang = Angle(90,270,0),
			},

		},

		
		FrontHeight = 28,
		FrontConstant = 90000,
		FrontDamping = 7000,
		FrontRelativeDamping = 4000,
		
		RearHeight = 28,
		RearConstant = 90000,
		RearDamping = 7000,
		RearRelativeDamping = 4000,
		
		FastSteeringAngle = 80,
		SteeringFadeFastSpeed = 535,
		
		TurnSpeed = 3,
		
		MaxGrip = 110,
		Efficiency = 1.0,
		GripOffset = -2,
		BrakePower = 40,

		MaxHealth = 4500,

		IdleRPM = 950,
		LimitRPM = 4000,
		PeakTorque = 80,
		PowerbandStart = 1800,
		PowerbandEnd = 3200,
		Turbocharged = false,
		
		FuelFillPos = Vector(16,50,51.5),
		FuelType = 2,
		FuelTankSize = 360,
		
		PowerBias = 1,
		
		EngineSoundPreset = 0,

		
		Sound_Idle = "russian/vehicles/armytruck_idle.wav",
		Sound_IdlePitch = 1,
		
		Sound_Mid = "russian/vehicles/armytruck_low.wav",
		Sound_MidPitch = 1.2,
		Sound_MidVolume = 1,
		Sound_MidFadeOutRPMpercent = 70,
		Sound_MidFadeOutRate = 0.5,
		
		Sound_High = "russian/vehicles/armytruck_high.wav",
		Sound_HighPitch = 1.2,
		Sound_HighVolume = 1.5,
		Sound_HighFadeInRPMpercent = 70,
		Sound_HighFadeInRate = 0.5,
		
		Sound_Throttle = "russian/vehicles/armytruck_throttle.wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 3,
		
		snd_horn = "russian/vehicles/armytruck_horn.wav",
		
		DifferentialGear = 0.80,
		Gears = {-0.05,0,0.05,0.10,0.15,0.20,0.21}

	}
}
list.Set( "simfphys_vehicles", "simfphys_uralapa5d", IV )
local light_table = {
	L_HeadLampPos = Vector(131,29.5,54),
	L_HeadLampAng = Angle(0,0,0),

	R_HeadLampPos = Vector(131,-29.5,54),
	R_HeadLampAng = Angle(0,0,0),
	
	Headlight_sprites = { 
{
		pos = Vector(131,29.5,54),
		size = 55,
},
{
		pos = Vector(131,-29.5,54),
		size = 55,
},

},
	Headlamp_sprites = { 
{
		pos = Vector(131,29.5,54),
		size = 55,
},
{
		pos = Vector(131,-29.5,54),
		size = 55,
},

{
		pos = Vector(70,43.5,86.3),
		size = 55,
},

},
	Rearlight_sprites = {
{
		pos = Vector(-157.5,25,42.5),
		size = 35,
},
{
		pos = Vector(-157.5,-25,42.5),
		size = 35,
},
{
		pos = Vector(-157.5,28,42.5),
		size = 35,
},
{
		pos = Vector(-157.5,-28,42.5),
		size = 35,
},

},
	Brakelight_sprites = {
{
		pos = Vector(-157.5,25,42.5),
		size = 35,
},
{
		pos = Vector(-157.5,-25,42.5),
		size = 35,
},
{
		pos = Vector(-157.5,28,42.5),
		size = 35,
},
{
		pos = Vector(-157.5,-28,42.5),
		size = 35,
},

},
	Reverselight_sprites = {
{
		pos = Vector(-157.5,25,42.5),
		size = 35,
},
{
		pos = Vector(-157.5,-25,42.5),
		size = 35,
},
{
		pos = Vector(-157.5,28,42.5),
		size = 35,
},
{
		pos = Vector(-157.5,-28,42.5),
		size = 35,
},
},	
	DelayOn = 0.1,
	DelayOff = 0.1,
	
	Turnsignal_sprites = {
		Left = {

{
		pos = Vector(130.5,37,58.5),
		size = 35,
},
{
		pos = Vector(-157.5,31.5,42.5),
		size = 35,
},

},
		Right = {
{
		pos = Vector(130.5,-37,58.5),
		size = 35,
},
{
		pos = Vector(-157.5,-31.5,42.5),
		size = 35,
},

		},
	}
}
list.Set( "simfphys_lights", "uralapa5d", light_table)


local Category = "Сирия - Военные"

local IV = {
	Name = "Ural-4320 ammo",
	Model = "models/russian/ural4320ammo/ural4320ammo.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = Category,
	SpawnOffset = Vector(0,0,50),

	Members = {
		Mass = 4000,
		LightsTable = "ural4320ammo",

           GibModels = {
			"models/russian/ural4320ammo/ural4320ammo.mdl",
		},
		IsArmored = false,
		BulletProofTires = false,
		CustomWheels = true,
		EnginePos = Vector(99,-1,68),
		CustomSuspensionTravel = 1.5,
		
		CustomWheelModel = "models/russian/ural4320ammo/ural4320ammo_wheel.mdl",
		CustomWheelPosFL = Vector(87,40,35),
		CustomWheelPosFR = Vector(87,-40,35),
		CustomWheelPosML = Vector(-46,38.5,35),
		CustomWheelPosMR = Vector(-46,-40,35),
		CustomWheelPosRL = Vector(-101,38.5,35),
		CustomWheelPosRR = Vector(-101,-40,35),

		
		CustomWheelAngleOffset = Angle(0,90,0),
		
		CustomMassCenter = Vector(0,0,0),
		
		CustomSteerAngle = 30,
		
		SeatOffset = Vector(26,-19,90),
		SeatPitch = 5,
		SeatYaw = 90,
		
		PassengerSeats = {
			{
				pos = Vector(40,-7,54),
				ang = Angle(0,-90,10)
			},
			{
				pos = Vector(40,-23,54),
				ang = Angle(0,-90,10)
			},

			},
		ExhaustPositions = {
			{
				pos = Vector(-7,-42.5,32.5),
				ang = Angle(90,270,0),
			},

		},

		
		FrontHeight = 28,
		FrontConstant = 90000,
		FrontDamping = 7000,
		FrontRelativeDamping = 4000,
		
		RearHeight = 28,
		RearConstant = 90000,
		RearDamping = 7000,
		RearRelativeDamping = 4000,
		
		FastSteeringAngle = 80,
		SteeringFadeFastSpeed = 535,
		
		TurnSpeed = 3,
		
		MaxGrip = 110,
		Efficiency = 1.0,
		GripOffset = -2,
		BrakePower = 40,

		MaxHealth = 4500,

		IdleRPM = 950,
		LimitRPM = 4000,
		PeakTorque = 80,
		PowerbandStart = 1800,
		PowerbandEnd = 3200,
		Turbocharged = false,
		
		FuelFillPos = Vector(16.5,48,48),
		FuelType = 2,
		FuelTankSize = 360,
		
		PowerBias = 1,
		
		EngineSoundPreset = 0,

		
		Sound_Idle = "russian/vehicles/armytruck_idle.wav",
		Sound_IdlePitch = 1,
		
		Sound_Mid = "russian/vehicles/armytruck_low.wav",
		Sound_MidPitch = 1.2,
		Sound_MidVolume = 1,
		Sound_MidFadeOutRPMpercent = 70,
		Sound_MidFadeOutRate = 0.5,
		
		Sound_High = "russian/vehicles/armytruck_high.wav",
		Sound_HighPitch = 1.2,
		Sound_HighVolume = 1.5,
		Sound_HighFadeInRPMpercent = 70,
		Sound_HighFadeInRate = 0.5,
		
		Sound_Throttle = "russian/vehicles/armytruck_throttle.wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 3,
		
		snd_horn = "russian/vehicles/armytruck_horn.wav",
		
		DifferentialGear = 0.80,
		Gears = {-0.05,0,0.05,0.10,0.15,0.20,0.21}

	}
}
list.Set( "simfphys_vehicles", "simfphys_ural4320ammo", IV )
local light_table = {
	L_HeadLampPos = Vector(124,28.5,51),
	L_HeadLampAng = Angle(0,0,0),

	R_HeadLampPos = Vector(124,-28.5,51),
	R_HeadLampAng = Angle(0,0,0),
	
	Headlight_sprites = { 
{
		pos = Vector(124,28.5,51.5),
		size = 55,
},
{
		pos = Vector(124,-28.5,51.5),
		size = 55,
},

},
	Headlamp_sprites = { 
{
		pos = Vector(124,28.5,51.5),
		size = 55,
},
{
		pos = Vector(124,-28.5,51.5),
		size = 55,
},

{
		pos = Vector(66,42,80.5),
		size = 55,
},

},
	
	Rearlight_sprites = {
{
		pos = Vector(-148,42,53),
		size = 35,
},
{
		pos = Vector(-148,-42,53),
		size = 35,
},
{
		pos = Vector(-148,38,53),
		size = 35,
},
{
		pos = Vector(-148,-38,53),
		size = 35,
},
{
		pos = Vector(-148,34,53),
		size = 35,
},
{
		pos = Vector(-148,-34,53),
		size = 35,
},

},
	Brakelight_sprites = {
{
		pos = Vector(-148,42,53),
		size = 35,
},
{
		pos = Vector(-148,-42,53),
		size = 35,
},
{
		pos = Vector(-148,38,53),
		size = 35,
},
{
		pos = Vector(-148,-38,53),
		size = 35,
},
{
		pos = Vector(-148,34,53),
		size = 35,
},
{
		pos = Vector(-148,-34,53),
		size = 35,
},

},
	Reverselight_sprites = {
{
		pos = Vector(-148,42,53),
		size = 35,
},
{
		pos = Vector(-148,-42,53),
		size = 35,
},
{
		pos = Vector(-148,38,53),
		size = 35,
},
{
		pos = Vector(-148,-38,53),
		size = 35,
},
{
		pos = Vector(-148,34,53),
		size = 35,
},
{
		pos = Vector(-148,-34,53),
		size = 35,
},

},
	DelayOn = 0.1,
	DelayOff = 0.1,
	
	Turnsignal_sprites = {
		Left = {
{
		pos = Vector(-148,41,53),
		size = 35,
},

{
		pos = Vector(125,36.5,54.5),
		size = 35,
},

},
		Right = {
{
		pos = Vector(-148,-41,53),
		size = 35,
},
{
		pos = Vector(125,-35.5,54.5),
		size = 35,
},

		},
	}
}
list.Set( "simfphys_lights", "ural4320ammo", light_table)


local Category = "Сирия - Военные"

local IV = {
	Name = "UAZ-469",
	Model = "models/russian/uaz3151/uaz3151.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = Category,
	SpawnOffset = Vector(0,0,50),

	Members = {
		Mass = 3000,
		LightsTable = "uaz3151",

           GibModels = {
			"models/russian/uaz3151/uaz3151.mdl",
		},

		IsArmored = false,
		BulletProofTires = false,
		CustomWheels = true,
		EnginePos = Vector(48,0,46),
		CustomSuspensionTravel = 1.5,
		
		CustomWheelModel = "models/russian/uaz3151/uaz3151_wheel.mdl",
		CustomWheelPosFL = Vector(55,33,29),
		CustomWheelPosFR = Vector(55,-33,29),
		CustomWheelPosRL = Vector(-46,33,29),
		CustomWheelPosRR = Vector(-46,-33,29),
		
		CustomWheelAngleOffset = Angle(0,90,0),
		
		CustomMassCenter = Vector(0,0,0),
		
		CustomSteerAngle = 30,
		
		SeatOffset = Vector(-10,-16,67),
		SeatPitch = 5,
		SeatYaw = 90,
		
		PassengerSeats = {
			{
				pos = Vector(2,-17,36),
				ang = Angle(0,-90,10)
			},
			{
				pos = Vector(-32,-20,36),
				ang = Angle(0,-90,10)
			},
			{
				pos = Vector(-32,0,36),
				ang = Angle(0,-90,10)
			},

			{
				pos = Vector(-32,19,36),
				ang = Angle(0,-90,10)
			},

			},
		ExhaustPositions = {
			{
				pos = Vector(-74,-13.5,24),
				ang = Angle(90,-165,0),
			},

		},

		
		FrontHeight = 28,
		FrontConstant = 90000,
		FrontDamping = 7000,
		FrontRelativeDamping = 4000,
		
		RearHeight = 28,
		RearConstant = 90000,
		RearDamping = 7000,
		RearRelativeDamping = 4000,
		
		FastSteeringAngle = 20,
		SteeringFadeFastSpeed = 535,
		
		TurnSpeed = 3,
		
		MaxGrip = 110,
		Efficiency = 1.0,
		GripOffset = -2,
		BrakePower = 40,

		MaxHealth = 3000,

		IdleRPM = 950,
		LimitRPM = 4000,
		PeakTorque = 90,
		PowerbandStart = 1800,
		PowerbandEnd = 3200,
		Turbocharged = false,
		
		FuelFillPos = Vector(-5,-35,35),
		FuelType = 1,
		FuelTankSize = 78,
		
		PowerBias = 1,
		
		EngineSoundPreset = 0,

		
		Sound_Idle = "russian/vehicles/hmmwv_idle.wav",
		Sound_IdlePitch = 1,
		
		Sound_Mid = "russian/vehicles/uaz.wav",
		Sound_MidPitch = 1.2,
		Sound_MidVolume = 1,
		Sound_MidFadeOutRPMpercent = 70,
		Sound_MidFadeOutRate = 0.5,
		
		Sound_High = "russian/vehicles/uaz.wav",
		Sound_HighPitch = 1.2,
		Sound_HighVolume = 1.5,
		Sound_HighFadeInRPMpercent = 70,
		Sound_HighFadeInRate = 0.5,
		
		Sound_Throttle = "russian/vehicles/hmmwv_throttle.wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 3,
		
		snd_horn = "russian/vehicles/hmmwv_horn.wav",
		
		DifferentialGear = 0.80,
		Gears = {-0.05,0,0.05,0.10,0.15,0.20,0.21}

	}
}
list.Set( "simfphys_vehicles", "simfphys_uaz3151", IV )
local light_table = {
	L_HeadLampPos = Vector(75,26,35.5),
	L_HeadLampAng = Angle(0,0,0),

	R_HeadLampPos = Vector(75,-25.5,35.5),
	R_HeadLampAng = Angle(0,0,0),
	
	Headlight_sprites = { 
{
		pos = Vector(75,23.5,44),
		size = 65,
},
{
		pos = Vector(75,-23,44),
		size = 65,
},

},
	Headlamp_sprites = { 
{
		pos = Vector(75,26,35.5),
		size = 45,
},
{
		pos = Vector(75,-25.5,35.5),
		size = 45,
},
{
		pos = Vector(30,34.5,61),
		size = 65,
},


},
	
	Rearlight_sprites = {
{
		pos = Vector(-74,30.5,34.5),
		size = 45,
},
{
		pos = Vector(-74,-31,34.5),
		size = 45,
},

},
	Brakelight_sprites = {
{
		pos = Vector(-74,30.5,34.5),
		size = 45,
},
{
		pos = Vector(-74,-31,34.5),
		size = 45,
},
{
		pos = Vector(-72.5,30.5,26.5),
		size = 45,
},
{
		pos = Vector(-72.5,-31,26.5),
		size = 45,
},

},
	Reverselight_sprites = {
{
		pos = Vector(-74,30.5,34.5),
		size = 45,
},
{
		pos = Vector(-74,-31,34.5),
		size = 45,
},

},
	DelayOn = 0.1,
	DelayOff = 0.1,
	
	Turnsignal_sprites = {
		Left = {
{
		pos = Vector(-74,30.5,39),
		size = 45,
},

{
		pos = Vector(75,26,35.5),
		size = 45,
},

},
		Right = {
{
		pos = Vector(-74,-31,39),
		size = 45,
},
{
		pos = Vector(75,-25.5,35.5),
		size = 45,
},

		},
	}
}
list.Set( "simfphys_lights", "uaz3151", light_table)

