local V = {
	Name = "Tractor (Small)",
	Model = "models/left4dead/vehicles/tractor.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "L4D - Services",
	SpawnOffset = Vector(0,0,0),
	SpawnAngleOffset = 90,
	NAKGame = "Left 4 Dead 2",
	NAKType = "Services",
	FLEX = {
		Trailers = {
			outputPos = Vector(-67.8,0,23),
			outputType = "ballsocket"
		}
	},

	Members = {
		Mass = 1200,
		
		EnginePos = Vector(44.5,-0.25,95.5),
		
		LightsTable = "tractor",
		
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		
		CustomWheelModel = "models/left4dead/vehicles/wheel_tractor_front.mdl",
		CustomWheelModel_R = "models/left4dead/vehicles/wheel_tractor_rear.mdl",
		
		CustomWheelPosFL = Vector(68,7.3,12),
		CustomWheelPosFR = Vector(68,-7.3,12),
		CustomWheelPosRL = Vector(-50.3,34.25,30),
		CustomWheelPosRR = Vector(-50.3,-34.25,30),
		CustomWheelAngleOffset = Angle(0,270,0),
		
		FrontWheelRadius = 11.5,
		RearWheelRadius = 29,
		
		CustomMassCenter = Vector(0,0,0),
		
		CustomSteerAngle = 30,
		
		SeatOffset = Vector(-72,0,77),
		SeatPitch = 15,
		SeatYaw = 90,
		
		ModelInfo = {
			Skin = 1,
		},
		
		--!!!!!!!!!!!RANDYS EXTRA FUNCTIONS!!!!!!!!!!!!!
		
		SimpleIgnition = true,
		
		NoAlarm = true,
		
		AllowRandomColors = true,
		RandomColorMin = 40,
		RandomColorMax = 100,
		
		--!!!!!!!!!!!END RANDYS EXTRA FUNCTIONS!!!!!!!!!!
		
		ExhaustPositions = {
			{
				pos = Vector(44.5,-0.25,95.5),
				ang = Angle(90,-90,0),
			},
			{
				pos = Vector(44.5,-0.25,95.5),
				ang = Angle(90,-90,0),
			},
		},
		
		FrontHeight = 8,
		FrontConstant = 24000,
		FrontDamping = 1000,
		FrontRelativeDamping = 800,
		
		RearHeight = 8,
		RearConstant = 24000,
		RearDamping = 1000,
		RearRelativeDamping = 800,
		
		FastSteeringAngle = 30,
		SteeringFadeFastSpeed = 535,
		
		TurnSpeed = 3,
		
		MaxGrip = 42,
		Efficiency = 1,
		GripOffset = 1,
		BrakePower = 25,
		
		IdleRPM = 700,
		LimitRPM = 3500,
		PeakTorque = 25,
		PowerbandStart = 1200,
		PowerbandEnd = 3000,
		Turbocharged = false,
		Supercharged = false,
		
		FuelFillPos = Vector(18,18,36),
		FuelType = 1,
		FuelTankSize = 35,
		
		PowerBias = 1,
		
		EngineSoundPreset = 0,

		
		Sound_Idle = "left4dead/vehicles/tractor_idle.wav",
		Sound_IdlePitch = 1,
		
		Sound_Mid = "left4dead/vehicles/tractor_low.wav",
		Sound_MidPitch = 1.5,
		Sound_MidVolume = 1.5,
		Sound_MidFadeOutRPMpercent = 60,
		Sound_MidFadeOutRate = 0.5,
		
		Sound_High = "left4dead/vehicles/tractor_high.wav",
		Sound_HighPitch = 1,
		Sound_HighVolume = 1.5,
		Sound_HighFadeInRPMpercent = 60,
		Sound_HighFadeInRate = 0.5,
		
		Sound_Throttle = "left4dead/vehicles/tractor_throttle.wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 1,
		
		--
		snd_horn = "left4dead/vehicles/racecar_horn.wav",
		
		DifferentialGear = 0.07,
		Gears = {-0.18,0,0.18,0.32}
	}
}
list.Set( "simfphys_vehicles", "sim_fphys_l4d_tractor", V )

local light_table = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(-30,30,63),
	L_HeadLampAng = Angle(15,0,0),
	R_HeadLampPos = Vector(-30,-30,63),
	R_HeadLampAng = Angle(8,0,0),
	
	
	Headlight_sprites = {   -- lowbeam
		{
			pos = Vector(-30,30,63),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
		{
			pos = Vector(-30,-30,63),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
		
		{
			pos = Vector(-30,25,63),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
		{
			pos = Vector(-30,-25,63),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
	},
	
	Headlamp_sprites = {
		{pos = Vector(-30,25,63),size = 100,material = "l4d/corona"},
		{pos = Vector(-30,-25,63),size = 100,material = "l4d/corona"},
	},
	
	
	DelayOn = 0,
	DelayOff = 0,
	
	SubMaterials = {
		off = {
			Base = {
				[1] = "",
			},
			Brake = {
				[1] = "",
			},
			Reverse = {
				[1] = "",
			},
			Brake_Reverse = {
				[1] = "",
			},
		},
		on_lowbeam = {
			Base = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_highbeam = {
			Base = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
	},
}
list.Set( "simfphys_lights", "tractor", light_table)