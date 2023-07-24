local V = {
	Name = "Semi Truck",
	Model = "models/left4dead/vehicles/semi_truck.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "L4D - Industrial",
	SpawnOffset = Vector(0,0,0),
	SpawnAngleOffset = 90,
	NAKGame = "Left 4 Dead 2",
	NAKType = "Industrial",
	FLEX = {
		Trailers = {
			outputPos = Vector(-110,0,50),
			outputType = "axis",
		}
	},

	Members = {
		Mass = 5650,
		
		EnginePos = Vector(184,0,62),
		
		LightsTable = "semi_truck",
		
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		
		CustomWheelModel = "models/left4dead/vehicles/wheel_truck_front.mdl",
		CustomWheelModel_R = "models/left4dead/vehicles/wheel_truck_rear.mdl",
		
		CustomWheelPosFL = Vector(156.5,39,24),
		CustomWheelPosFR = Vector(156.5,-39,24),	
		CustomWheelPosRL = Vector(-135.2,39,30),
		CustomWheelPosML = Vector(-77.8,39,30),
		CustomWheelPosMR = Vector(-77.8,-39,30),
		CustomWheelPosRR = Vector(-135.2,-39,30),
		CustomWheelAngleOffset = Angle(0,-90,0),
		
		CustomMassCenter = Vector(20,0,-20),		
		
		CustomSteerAngle = 35,
		
		SeatOffset = Vector(52,-20,110),
		SeatPitch = 10,
		SeatYaw = 90,
		
		--!!!!!!!!!!!RANDYS EXTRA FUNCTIONS!!!!!!!!!!!!!
		
		LPMountFront = Vector(187.6,0,24),
		LPMountRear = Vector(-174,0,32),
		LPGroup = Plates_L4D,
		
		AllowRandomColors = true,
		RandomColorMin = 10,
		RandomColorMax = 100,
		
		AllowRandomSkins = true,
		RandomSkinRange = {0,3},
		
		HasAirbrakes = true,
		
		snd_starter = "left4dead/vehicles/semi_ignition_start.wav",
		snd_starter_good = "left4dead/vehicles/semi_ignition_good.wav",
		snd_starter_bad = "left4dead/vehicles/semi_ignition_bad.wav",
		snd_stop = "left4dead/vehicles/semi_stop.wav",
		snd_reverse_beep = "vehicles/gen_reverse.wav",
		
		--!!!!!!!!!!!END RANDYS EXTRA FUNCTIONS!!!!!!!!!!
		
		ExhaustPositions = {
			{
				pos = Vector(59,45,158.4),
				ang = Angle(-90,0,0),
			},
			{
				pos = Vector(59,45,158.4),
				ang = Angle(-90,0,0),
			},
			{
				pos = Vector(59,-45,158.4),
				ang = Angle(-90,0,0),
			},
			{
				pos = Vector(59,-45,158.4),
				ang = Angle(-90,0,0),
			},
		},
		
		PassengerSeats = {
			{
				pos = Vector(72,-20,67),
				ang = Angle(0,-90,0)
			},
		},
		
		FrontHeight = 16,
		FrontConstant = 50000,
		FrontDamping = 3200,
		FrontRelativeDamping = 50,
		
		RearHeight = 16,
		RearConstant = 50000,
		RearDamping = 3200,
		RearRelativeDamping = 50,
		
		FastSteeringAngle = 35,
		SteeringFadeFastSpeed = 535,
		
		TurnSpeed = 3,
		
		MaxGrip = 120,
		Efficiency = 1,
		GripOffset = 0,
		BrakePower = 25,
		BulletProofTires = false,
		
		IdleRPM = 1200,
		LimitRPM = 5000,
		PeakTorque = 155,
		PowerbandStart = 1600,
		PowerbandEnd = 3000,
		Turbocharged = false,
		Supercharged = false,
		DoNotStall = false,
		
		FuelFillPos = Vector(21.5,-49,35.4),
		FuelType = 2,
		FuelTankSize = 130,
		
		PowerBias = -1,
		
		EngineSoundPreset = 0,
		
		Sound_Idle = "left4dead/vehicles/semi_idle.wav",
		Sound_IdlePitch = 0.8,
		
		Sound_Mid = "left4dead/vehicles/semi_low.wav",
		Sound_MidPitch = 1.1,
		Sound_MidVolume = 1,
		Sound_MidFadeOutRPMpercent = 50,
		Sound_MidFadeOutRate = 0.3,
		
		Sound_High = "left4dead/vehicles/semi_high.wav",
		Sound_HighPitch = 1.2,
		Sound_HighVolume = 2,
		Sound_HighFadeInRPMpercent = 50,
		Sound_HighFadeInRate = 0.3,
		
		Sound_Throttle = "left4dead/vehicles/semi_throttle.wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 2.5,
		
		snd_horn = "left4dead/vehicles/semi_horn.wav",
		
		DifferentialGear = 0.1,
		Gears = {-0.35,0,0.15,0.22,0.29,0.37,0.49,0.6,0.79,1,1.5,2.1,3}
	}
}
list.Set( "simfphys_vehicles", "sim_fphys_l4d_semi_truck", V )

local light_table = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(183.7,28.6,46.5),
	L_HeadLampAng = Angle(0,0,0),
	R_HeadLampPos = Vector(183.7,-28.6,46.5),
	R_HeadLampAng = Angle(0,0,0),
	
	-- projected texture - rear
	L_RearLampPos = Vector(-174.5,17.5,23.5),
	L_RearLampAng = Angle(25,180,0),
	R_RearLampPos = Vector(-174.5,-17.5,23.5),
	R_RearLampAng = Angle(25,180,0),
	
	Headlight_sprites = {   -- lowbeam
		{
			pos = Vector(183.7,35.5,46.5),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
		{
			pos = Vector(183.7,-35.5,46.5),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
		{
			pos = Vector(183.7,28.6,46.5),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
		{
			pos = Vector(183.7,-28.6,46.5),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
		
		{
			pos = Vector(54.9,47,44.9),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(54.9,-47,44.9),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		
		{
			pos = Vector(99,-29.3,115.1),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(99,29.3,115.1),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(99,8.3,115.1),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(99,-8.3,115.1),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(99,0,115.1),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(100.3,38.3,45.1),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(86.6,39.4,44.9),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(73.1,40.3,44.7),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(45,46.7,44.6),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(30,46.7,44.6),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(15.8,46.7,44.6),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(0,46.7,44.6),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(100.3,-38.3,45.1),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(86.6,-39.4,44.9),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(73.1,-40.3,44.7),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(45,-46.7,44.6),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(30,-46.7,44.6),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(15.8,-46.7,44.6),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(0,-46.7,44.6),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
	},
	
	Headlamp_sprites = {
		{pos = Vector(183.7,28.6,46.5),size = 100,material = "l4d/corona"},
		{pos = Vector(183.7,-28.6,46.5),size = 100,material = "l4d/corona"},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-174.5,17.5,23.5),
			material = "l4d/corona",
			size = 40,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-174.5,-17.5,23.5),
			material = "l4d/corona",
			size = 40,
			color = Color(255,0,0,150),
		},
	},
	
	DelayOn = 0,
	DelayOff = 0,
	
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(158.7,43,58),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
		},
		TurnBrakeLeft = {
			{
				pos = Vector(-174.5,8.7,23.6),
				material = "l4d/corona",
				size = 50,
				color = Color(255,0,0,255),
			},
		},
		Right = {
			{
				pos = Vector(158.7,-43,58),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
		},
		TurnBrakeRight = {
			{
				pos = Vector(-174.5,-8.7,23.6),
				material = "l4d/corona",
				size = 50,
				color = Color(255,0,0,255),
			},
		},
	},
	
	SubMaterials = {
		off = {
			Base = {
				[4] = "",
				[7] = "",
			},
			Brake = {
				[4] = "",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[4] = "",
				[7] = "",
			},
			Brake_Reverse = {
				[4] = "",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_lowbeam = {
			Base = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "",
			},
			Brake = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "",
			},
			Brake_Reverse = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_highbeam = {
			Base = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "",
			},
			Brake = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "",
			},
			Brake_Reverse = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		turnsignals = {
			left = {
				[6] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			right = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
	},
}
list.Set( "simfphys_lights", "semi_truck", light_table)