local V = {
	Name = "Baggage Tractor",
	Model = "models/left4dead/vehicles/apbag.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "L4D - Airport Services",
	SpawnOffset = Vector(0,0,0),
	SpawnAngleOffset = 90,
	NAKGame = "Left 4 Dead 2",
	NAKType = "Airport Services",
	FLEX = {
		Trailers = {
			outputPos = Vector(-67.8,0,23),
			outputType = "ballsocket"
		}
	},

	Members = {
		Mass = 1200,
		
		EnginePos = Vector(65,0,31),
		
		LightsTable = "apbag",
		
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		
		CustomWheelModel = "models/left4dead/vehicles/wheel_apbag_front.mdl",
		CustomWheelModel_R = "models/left4dead/vehicles/wheel_apbag_rear.mdl",
		
		CustomWheelPosFL = Vector(42,24,12),
		CustomWheelPosFR = Vector(42,-24,12),
		CustomWheelPosRL = Vector(-27,24,17),
		CustomWheelPosRR = Vector(-27,-24,17),
		CustomWheelAngleOffset = Angle(0,270,0),
		
		FrontWheelRadius = 9,
		RearWheelRadius = 15,
		
		CustomMassCenter = Vector(0,0,0),
		
		CustomSteerAngle = 30,
		
		SeatOffset = Vector(-45,-17,60),
		SeatPitch = 15,
		SeatYaw = 90,
		
		--!!!!!!!!!!!RANDYS EXTRA FUNCTIONS!!!!!!!!!!!!!

		SimpleIgnition = true,
		
		NoAlarm = true,
		
		--!!!!!!!!!!!END RANDYS EXTRA FUNCTIONS!!!!!!!!!!
		
		PassengerSeats = {
			{
				pos = Vector(-25,-16,37),
				ang = Angle(0,-90,10)
			},
		
		},
		
		FrontHeight = 8,
		FrontConstant = 34000,
		FrontDamping = 1000,
		FrontRelativeDamping = 800,
		
		RearHeight = 8,
		RearConstant = 34000,
		RearDamping = 1000,
		RearRelativeDamping = 800,
		
		FastSteeringAngle = 30,
		SteeringFadeFastSpeed = 535,
		
		TurnSpeed = 3,
		
		MaxGrip = 42,
		Efficiency = 1,
		GripOffset = 1,
		BrakePower = 15,
		
		IdleRPM = 700,
		LimitRPM = 3500,
		PeakTorque = 25,
		PowerbandStart = 1200,
		PowerbandEnd = 3000,
		Turbocharged = false,
		Supercharged = false,
		
		FuelFillPos = Vector(18,18,36),
		FuelType = 1,
		FuelTankSize = 45,
		
		PowerBias = 1,
		
		EngineSoundPreset = 0,

		
		Sound_Idle = "left4dead/vehicles/apbag_idle.wav",
		Sound_IdlePitch = 1,
		
		Sound_Mid = "left4dead/vehicles/apbag_low.wav",
		Sound_MidPitch = 1.5,
		Sound_MidVolume = 1,
		Sound_MidFadeOutRPMpercent = 60,
		Sound_MidFadeOutRate = 0.5,
		
		Sound_High = "left4dead/vehicles/apbag_high.wav",
		Sound_HighPitch = 1,
		Sound_HighVolume = 1,
		Sound_HighFadeInRPMpercent = 60,
		Sound_HighFadeInRate = 0.5,
		
		Sound_Throttle = "left4dead/vehicles/apbag_throttle.wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 0.7,
		
		--
		snd_horn = "left4dead/vehicles/apbag_horn.wav",
		
		DifferentialGear = 0.12,
		Gears = {-0.3,0,0.15,0.32,0.66}
	}
}
list.Set( "simfphys_vehicles", "sim_fphys_l4d_apbag", V )

local light_table = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(59,20.2,31.8),
	L_HeadLampAng = Angle(0,0,0),
	R_HeadLampPos = Vector(59,-20.2,31.8),
	R_HeadLampAng = Angle(0,0,0),
	
	L_RearLampPos = Vector(-46,24.3,31.6),
	L_RearLampAng = Angle(25,180,0),
	R_RearLampPos = Vector(-46,-24.3,31.6),
	R_RearLampAng = Angle(25,180,0),
	
	Headlight_sprites = {   -- lowbeam
		{
			pos = Vector(59,20.2,31.8),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
		{
			pos = Vector(59,-20.2,31.8),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
	},
	
	Headlamp_sprites = {
		{pos = Vector(59,20.2,31.8),size = 100,material = "l4d/corona"},
		{pos = Vector(59,-20.2,31.8),size = 100,material = "l4d/corona"},
	},
	
	Rearlight_sprites = {
		{
			pos = Vector(-46,24.3,31.6),
			material = "l4d/corona",
			size = 70,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-46,-24.3,31.6),
			material = "l4d/corona",
			size = 70,
			color = Color(255,0,0,150),
		}
	},
	
	Brakelight_sprites = {
		{
			pos = Vector(-46,17.7,31.6),
			material = "l4d/corona",
			size = 70,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-46,-17.7,31.6),
			material = "l4d/corona",
			size = 70,
			color = Color(255,0,0,150),
		}
	},
	
	Reverselight_sprites = {
		{
			pos = Vector(-46,21.2,31.6),
			material = "l4d/corona",
			size = 60,
			color = Color(255,255,255,150),
		},
		{
			pos = Vector(-46,-21.2,31.6),
			material = "l4d/corona",
			size = 60,
			color = Color(255,255,255,150),
		}
	},
	
	DelayOn = 0,
	DelayOff = 0,
	
	SubMaterials = {
		off = {
			Base = {
				[1] = "",
				[2] = "",
				[3] = "",
			},
			Brake = {
				[1] = "",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "",
			},
			Reverse = {
				[1] = "",
				[2] = "",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[1] = "",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_lowbeam = {
			Base = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "",
				[3] = "",
			},
			Brake = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "",
			},
			Reverse = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_highbeam = {
			Base = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "",
				[3] = "",
			},
			Brake = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "",
			},
			Reverse = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
	},
}
list.Set( "simfphys_lights", "apbag", light_table)