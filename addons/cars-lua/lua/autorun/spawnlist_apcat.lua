local V = {
	Name = "Catering Truck",
	Model = "models/left4dead/vehicles/apcat.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "L4D - Airport Services",
	SpawnOffset = Vector(0,0,10),
	SpawnAngleOffset = 90,
	NAKGame = "Left 4 Dead 2",
	NAKType = "Airport Services",

	Members = {
		Mass = 3500,
		
		EnginePos = Vector(177,0,53),
		
		LightsTable = "apcat",
		
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		
		CustomWheelModel = "models/left4dead/vehicles/wheel_apcat_front.mdl",
		CustomWheelModel_R = "models/left4dead/vehicles/wheel_apcat_rear.mdl",
		
		CustomWheelPosFL = Vector(143,43,25),
		CustomWheelPosFR = Vector(143,-43,25),	
		CustomWheelPosRL = Vector(-87,47,25),
		CustomWheelPosRR = Vector(-87,-47,25),
		CustomWheelAngleOffset = Angle(0,-90,0),
		
		CustomMassCenter = Vector(0,0,0),		
		
		CustomSteerAngle = 30,
		
		SeatOffset = Vector(60,-21,91),
		SeatPitch = 10,
		SeatYaw = 90,
		
		ModelInfo = {
			Skin = 1,
		},
		
		--!!!!!!!!!!!RANDYS EXTRA FUNCTIONS!!!!!!!!!!!!!
		
		AllowRandomColors = true,
		RandomColorMin = 10,
		RandomColorMax = 100,
		
		HasAirbrakes = true,
		
		snd_starter = "left4dead/vehicles/apcat_ignition_start.wav",
		snd_starter_good = "left4dead/vehicles/apcat_ignition_good.wav",
		snd_starter_bad = "left4dead/vehicles/apcat_ignition_bad.wav",
		snd_stop = "left4dead/vehicles/apcat_stop.wav",
		snd_reverse_beep = "vehicles/gen_reverse.wav",
		
		--!!!!!!!!!!!END RANDYS EXTRA FUNCTIONS!!!!!!!!!!
		
		PassengerSeats = {
			{
				pos = Vector(80,-22,47),
				ang = Angle(0,-90,0)
			},
		},
		
		FrontHeight = 16,
		FrontConstant = 38000,
		FrontDamping = 2400,
		FrontRelativeDamping = 50,
		
		RearHeight = 16,
		RearConstant = 38000,
		RearDamping = 2400,
		RearRelativeDamping = 50,
		
		FastSteeringAngle = 30,
		SteeringFadeFastSpeed = 535,
		
		TurnSpeed = 3,
		
		MaxGrip = 100,
		Efficiency = 1,
		GripOffset = 0,
		BrakePower = 25,
		BulletProofTires = false,
		
		IdleRPM = 1200,
		LimitRPM = 5000,
		PeakTorque = 110,
		PowerbandStart = 1600,
		PowerbandEnd = 3000,
		Turbocharged = false,
		Supercharged = true,
		DoNotStall = false,
		
		FuelFillPos = Vector(50,43,43),
		FuelType = 2,
		FuelTankSize = 120,
		
		PowerBias = -1,
		
		EngineSoundPreset = 0,
		
		Sound_Idle = "left4dead/vehicles/apcat_idle.wav",
		Sound_IdlePitch = 0.8,
		
		Sound_Mid = "left4dead/vehicles/apcat_low.wav",
		Sound_MidPitch = 1.1,
		Sound_MidVolume = 2,
		Sound_MidFadeOutRPMpercent = 50,
		Sound_MidFadeOutRate = 0.3,
		
		Sound_High = "left4dead/vehicles/apcat_high.wav",
		Sound_HighPitch = 1.2,
		Sound_HighVolume = 3,
		Sound_HighFadeInRPMpercent = 50,
		Sound_HighFadeInRate = 0.3,
		
		Sound_Throttle = "left4dead/vehicles/apcat_throttle.wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 2.5,
		
		snd_horn = "left4dead/vehicles/apcat_horn.wav",
		snd_bloweron = "left4dead/vehicles/bus_turbo.wav",
		snd_bloweroff = "common/null.wav",
		
		DifferentialGear = 0.3,
		Gears = {-0.13,0,0.06,0.15,0.23,0.4,0.6}
	}
}
list.Set( "simfphys_vehicles", "sim_fphys_l4d_apcat", V )

local light_table = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(168,44,44),
	L_HeadLampAng = Angle(0,0,0),
	R_HeadLampPos = Vector(168,-44,44),
	R_HeadLampAng = Angle(0,0,0),
	
	-- projected texture - rear
	L_RearLampPos = Vector(-171.6,56,58.4),
	L_RearLampAng = Angle(25,180,0),
	R_RearLampPos = Vector(-171.6,-56,58.4),
	R_RearLampAng = Angle(25,180,0),
	
	Headlight_sprites = {   -- lowbeam
		{
			pos = Vector(168,44,44),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
		{
			pos = Vector(168,-44,44),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},

		{
			pos = Vector(43.9,56,155.9),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(43.9,-56,155.9),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(36.7,58.9,58.1),
			material = "l4d/corona",
			size = 40,
			color = Color(255,100,0,150),
		},
		{
			pos = Vector(36.7,-58.9,58.1),
			material = "l4d/corona",
			size = 40,
			color = Color(255,100,0,150),
		},
		{
			pos = Vector(21.9,57.7,169.7),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(21.9,-57.7,169.7),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
	},
	
	Headlamp_sprites = {
		{pos = Vector(168,44,44),size = 100,material = "l4d/corona"},
		{pos = Vector(168,-44,44),size = 100,material = "l4d/corona"},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-171.6,56,58.4),
			material = "l4d/corona",
			size = 50,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-171.6,-56,58.4),
			material = "l4d/corona",
			size = 50,
			color = Color(255,0,0,150),
		},

		{
			pos = Vector(-165.5,57.7,169.7),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(-165.5,-57.7,169.7),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(-164,59,58),
			material = "l4d/corona",
			size = 40,
			color = Color(255,100,0,150),
		},
		{
			pos = Vector(-164,-59,58),
			material = "l4d/corona",
			size = 40,
			color = Color(255,100,0,150),
		},
	},
	Brakelight_sprites = {
		{
			pos = Vector(-171.6,56,58.4),
			material = "l4d/corona",
			size = 60,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-171.6,-56,58.4),
			material = "l4d/corona",
			size = 60,
			color = Color(255,0,0,150),
		},
	},
	
	DelayOn = 0,
	DelayOff = 0,
	
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(175,25.7,37.4),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
			{
				pos = Vector(158.5,47.2,59.5),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
			{
				pos = Vector(-171.6,56,58.4),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
		},
		Right = {
			{
				pos = Vector(175,-25.7,37.4),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
			{
				pos = Vector(158.5,-47.2,59.5),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
			{
				pos = Vector(-171.6,-56,58.4),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
		},
	},
	
	SubMaterials = {
		off = {
			Base = {
				[5] = "",
				[4] = "",
			},
			Brake = {
				[5] = "",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[5] = "",
				[4] = "",
			},
			Brake_Reverse = {
				[5] = "",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_lowbeam = {
			Base = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_highbeam = {
			Base = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		turnsignals = {
			left = {
				[6] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			right = {
				[7] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
	}
}
list.Set( "simfphys_lights", "apcat", light_table)