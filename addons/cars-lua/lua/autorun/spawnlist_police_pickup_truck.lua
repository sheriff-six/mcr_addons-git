local V = {
	Name = "2004 Pickup (police)",
	Model = "models/left4dead/vehicles/police_pickup_truck.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "L4D - Government",
	SpawnOffset = Vector(0,0,0),
	SpawnAngleOffset = 90,
	NAKGame = "Left 4 Dead 2",
	NAKType = "Government",
	FLEX = {
		Trailers = {
			outputPos = Vector(-160,0,23),
			outputType = "ballsocket"
		}
	},

	Members = {
		Mass = 2750,
		
		EnginePos = Vector(122,0,47),
		
		LightsTable = "police_pickup",
		
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		
		CustomWheelModel = "models/left4dead/vehicles/wheel_pickup_2004.mdl",
		CustomWheelPosFL = Vector(85,41.8,14),
		CustomWheelPosFR = Vector(85,-41.8,14),
		CustomWheelPosRL = Vector(-93,41.8,14),
		CustomWheelPosRR = Vector(-93,-41.8,14),
		CustomWheelAngleOffset = Angle(0,270,0),
		
		CustomMassCenter = Vector(0,0,0),
		
		CustomSteerAngle = 30,
		
		SeatOffset = Vector(5,-24,73),
		SeatPitch = 5,
		SeatYaw = 90,
		
		--!!!!!!!!!!!RANDYS EXTRA FUNCTIONS!!!!!!!!!!!!!
		
		LPMountRear = Vector(-145,0,31.8),
		LPGroup = Plates_L4D,
		
		ForceAlarm = true,
		
		HasBullhorn = true,
		
		PolRadioSound = "Simf_PolRadio",
		
		snd_starter = "left4dead/vehicles/pickup78_ignition_start.wav",
		snd_starter_good = "left4dead/vehicles/pickup78_ignition_good.wav",
		snd_starter_bad = "left4dead/vehicles/pickup78_ignition_bad.wav",
		snd_stop = "left4dead/vehicles/pickup78_stop.wav",
		
		--!!!!!!!!!!!END RANDYS EXTRA FUNCTIONS!!!!!!!!!!
		
		PassengerSeats = {
			{
				pos = Vector(18,-22,38),
				ang = Angle(0,-90,10)
			},
			{
				pos = Vector(-16,22,38),
				ang = Angle(0,-90,10)
			},
			{
				pos = Vector(-16,-22,38),
				ang = Angle(0,-90,10)
			},
		},
		
		ExhaustPositions = {
			{
				pos = Vector(-132,25,26),
				ang = Angle(140,180,0),
			},
		},
		
		FrontHeight = 7,
		FrontConstant = 35000,
		FrontDamping = 2500,
		FrontRelativeDamping = 800,
		
		RearHeight = 7,
		RearConstant = 35000,
		RearDamping = 2500,
		RearRelativeDamping = 800,
		
		FastSteeringAngle = 30,
		SteeringFadeFastSpeed = 535,
		
		TurnSpeed = 3,
		
		MaxGrip = 54,
		Efficiency = 1,
		GripOffset = 1.5,
		BrakePower = 35,
		
		IdleRPM = 800,
		LimitRPM = 5000,
		PeakTorque = 175,
		PowerbandStart = 1500,
		PowerbandEnd = 4000,
		Turbocharged = false,
		Supercharged = false,
		
		FuelFillPos = Vector(-38,-47,39.5),
		FuelType = 2,
		FuelTankSize = 110,
		
		PowerBias = 0,
		
		EngineSoundPreset = 0,

		
		Sound_Idle = "left4dead/vehicles/pickup2004_idle.wav",
		Sound_IdlePitch = 1,
		
		Sound_Mid = "left4dead/vehicles/pickup2004_low.wav",
		Sound_MidPitch = 1,
		Sound_MidVolume = 2,
		Sound_MidFadeOutRPMpercent = 60,
		Sound_MidFadeOutRate = 0.5,
		
		Sound_High = "left4dead/vehicles/pickup2004_high.wav",
		Sound_HighPitch = 1,
		Sound_HighVolume = 1.5,
		Sound_HighFadeInRPMpercent = 60,
		Sound_HighFadeInRate = 0.5,
		
		Sound_Throttle = "left4dead/vehicles/pickup2004_throttle.wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 5,
		
		--
		snd_horn = "left4dead/vehicles/pickup2004_horn.wav",
		
		DifferentialGear = 0.4,
		Gears = {-0.18,0,0.09,0.17,0.28,0.4,0.65}
	}
}
list.Set( "simfphys_vehicles", "sim_fphys_l4d_police_pickup", V )

local light_table = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(117.1,39.2,46),
	L_HeadLampAng = Angle(0,0,0),
	R_HeadLampPos = Vector(117.1,-39.2,46),
	R_HeadLampAng = Angle(0,0,0),
	
	-- projected texture - rear
	L_RearLampPos = Vector(-145.8,45,44.5),
	L_RearLampAng = Angle(25,180,0),
	R_RearLampPos = Vector(-145.8,-45,44.5),
	R_RearLampAng = Angle(25,180,0),
	
	Headlight_sprites = {   -- lowbeam
		{
			pos = Vector(117.1,39.2,46),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
		{
			pos = Vector(117.1,-39.2,46),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
	},
	
	Headlamp_sprites = {
		{pos = Vector(117.1,39.2,46),size = 100,material = "l4d/corona"},
		{pos = Vector(117.1,-39.2,46),size = 100,material = "l4d/corona"},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-145.8,45,44.5),
			material = "l4d/corona",
			size = 80,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-145.8,-45,44.5),
			material = "l4d/corona",
			size = 80,
			color = Color(255,0,0,150),
		}
	},
	Brakelight_sprites = {
		{
			pos = Vector(-145.8,45,44.5),
			material = "l4d/corona",
			size = 100,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-145.8,-45,44.5),
			material = "l4d/corona",
			size = 100,
			color = Color(255,0,0,150),
		},
	},
	Reverselight_sprites = {
		{
			pos = Vector(-145.8,45,39.6),
			material = "l4d/corona",
			size = 60,
			color = Color(255,255,255,150),
		},
		{
			pos = Vector(-145.8,-45,39.6),
			material = "l4d/corona",
			size = 60,
			color = Color(255,255,255,150),
		},
	},
	
	ems_sounds = {"left4dead/vehicles/pickup2004_police_wail.wav","left4dead/vehicles/pickup2004_police_yelp.wav"},
	ems_sprites = {
		{
			pos = Vector(28.5,21,94),
			material = "l4d/corona",
			size = 100,
			Colors = {
						Color(0,0,255,255),
						Color(0,0,255,150),
						Color(0,0,255,255),
						Color(0,0,255,150),
						Color(0,0,255,0),
						Color(0,0,255,0),
						Color(0,0,255,0),
						Color(0,0,255,0),
					},
			Speed = 0.1
		},
		{
			pos = Vector(28.5,10,94),
			material = "l4d/corona",
			size = 100,
			Colors = {
						Color(0,0,255,0),
						Color(0,0,255,0),
						Color(0,0,255,0),
						Color(0,0,255,0),
						Color(0,0,255,255),
						Color(0,0,255,150),
						Color(0,0,255,255),
						Color(0,0,255,150),
					},
			Speed = 0.1
		},
	},
	
	DelayOn = 0,
	DelayOff = 0,
	
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(115,46.5,46.1),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
			{
				pos = Vector(-145.8,45,51.5),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
		},
		Right = {
			{
				pos = Vector(115,-46.5,46.1),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
			{
				pos = Vector(-145.8,-45,51.5),
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
				[6] = "",
				[7] = ""
			},
			Brake = {
				[5] = "",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = ""
			},
			Reverse = {
				[5] = "",
				[6] = "",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			Brake_Reverse = {
				[5] = "",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
		on_lowbeam = {
			Base = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = ""
			},
			Brake = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = ""
			},
			Reverse = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			Brake_Reverse = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
		on_highbeam = {
			Base = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = ""
			},
			Brake = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = ""
			},
			Reverse = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			Brake_Reverse = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
		turnsignals = {
			left = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			right = {
				[8] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
	}
}
list.Set( "simfphys_lights", "police_pickup", light_table)