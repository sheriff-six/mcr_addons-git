local V = {
	Name = "Longnose Truck",
	Model = "models/left4dead/vehicles/longnose_truck.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "L4D - Industrial",
	SpawnOffset = Vector(0,0,10),
	SpawnAngleOffset = 90,
	NAKGame = "Left 4 Dead 2",
	NAKType = "Industrial",
	FLEX = {
		Trailers = {
			outputPos = Vector(-90,0,50),
			outputType = "axis",
		}
	},

	Members = {
		Mass = 5650,
		
		EnginePos = Vector(140,0,57),
		
		LightsTable = "longnose_truck",
		
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		
		CustomWheelModel = "models/left4dead/vehicles/wheel_truck_front.mdl",
		CustomWheelModel_R = "models/left4dead/vehicles/wheel_truck_rear.mdl",
		
		CustomWheelPosFL = Vector(150.45,42,22),
		CustomWheelPosFR = Vector(150.45,-42,22),	
		CustomWheelPosRL = Vector(-135,39,27),
		CustomWheelPosML = Vector(-83.7,39,27),
		CustomWheelPosMR = Vector(-83.7,-35,27),
		CustomWheelPosRR = Vector(-135,-35,27),
		CustomWheelAngleOffset = Angle(0,-90,0),
		
		CustomMassCenter = Vector(0,0,0),		
		
		CustomSteerAngle = 35,
		
		SeatOffset = Vector(50,-21.5,102),
		SeatPitch = 10,
		SeatYaw = 90,
		
		--!!!!!!!!!!!RANDYS EXTRA FUNCTIONS!!!!!!!!!!!!!
		
		LPMountFront = Vector(181.1,0,30),
		LPMountRear = Vector(-169,0,34),
		LPGroup = Plates_L4D,
		
		AllowRandomColors = true,
		RandomColorMin = 30,
		RandomColorMax = 100,
		
		AllowRandomSkins = true,
		RandomSkinRange = {1,3},
		
		HasAirbrakes = true,
		
		snd_starter = "left4dead/vehicles/longnose_ignition_start.wav",
		snd_starter_good = "left4dead/vehicles/longnose_ignition_good.wav",
		snd_starter_bad = "left4dead/vehicles/longnose_ignition_bad.wav",
		snd_stop = "left4dead/vehicles/longnose_stop.wav",
		snd_reverse_beep = "vehicles/gen_reverse.wav",
		
		--!!!!!!!!!!!END RANDYS EXTRA FUNCTIONS!!!!!!!!!!
		
		ExhaustPositions = {
			{
				pos = Vector(54.4,44.8,162),
				ang = Angle(0,0,0),
			},
			{
				pos = Vector(54.4,44.8,162),
				ang = Angle(0,0,0),
			},
		},
		
		PassengerSeats = {
			{
				pos = Vector(70,-22,58),
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
		
		MaxGrip = 100,
		Efficiency = 1,
		GripOffset = 0,
		BrakePower = 35,
		BulletProofTires = false,
		
		IdleRPM = 1200,
		LimitRPM = 5000,
		PeakTorque = 125,
		PowerbandStart = 1600,
		PowerbandEnd = 3000,
		Turbocharged = false,
		Supercharged = false,
		DoNotStall = false,
		
		FuelFillPos = Vector(77,-54,32.5),
		FuelType = 2,
		FuelTankSize = 130,
		
		PowerBias = -1,
		
		EngineSoundPreset = 0,
		
		Sound_Idle = "left4dead/vehicles/longnose_idle.wav",
		Sound_IdlePitch = 1,
		
		Sound_Mid = "left4dead/vehicles/longnose_low.wav",
		Sound_MidPitch = 1.4,
		Sound_MidVolume = 1,
		Sound_MidFadeOutRPMpercent = 80,
		Sound_MidFadeOutRate = 0.3,
		
		Sound_High = "left4dead/vehicles/longnose_high.wav",
		Sound_HighPitch = 1.6,
		Sound_HighVolume = 2,
		Sound_HighFadeInRPMpercent = 80,
		Sound_HighFadeInRate = 0.3,
		
		Sound_Throttle = "left4dead/vehicles/longnose_throttle.wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 5,
		
		snd_horn = "left4dead/vehicles/longnose_horn.wav",
		
		DifferentialGear = 0.1,
		Gears = {-0.35,0,0.15,0.22,0.29,0.37,0.49,0.6,0.79,1,1.5,2.1,3}
	}
}
list.Set( "simfphys_vehicles", "sim_fphys_l4d_longnose_truck", V )

local light_table = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(179.6,41.7,53.8),
	L_HeadLampAng = Angle(0,0,0),
	R_HeadLampPos = Vector(179.6,-41.7,53.8),
	R_HeadLampAng = Angle(0,0,0),
	
	-- projected texture - rear
	L_RearLampPos = Vector(-169,17,23.5),
	L_RearLampAng = Angle(25,180,0),
	R_RearLampPos = Vector(-169,-17,23.5),
	R_RearLampAng = Angle(25,180,0),
	
	Headlight_sprites = {   -- lowbeam
		{
			pos = Vector(179.6,41.7,53.8),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
		{
			pos = Vector(179.6,-41.7,53.8),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
		{
			pos = Vector(101.4,-30.8,118.9),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(101.4,30.8,118.9),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(107.5,9.17,118.9),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(107.5,-9.17,118.9),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(107.5,0,118.9),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		}
	},
	
	Headlamp_sprites = {
		{pos = Vector(179.6,41.7,53.8),size = 100,material = "l4d/corona"},
		{pos = Vector(179.6,-41.7,53.8),size = 100,material = "l4d/corona"},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-169,17,23.5),
			material = "l4d/corona",
			size = 50,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-169,-17,23.5),
			material = "l4d/corona",
			size = 50,
			color = Color(255,0,0,150),
		}
	},
	
	
	DelayOn = 0,
	DelayOff = 0,
	
	Turnsignal_sprites = {
		TurnBrakeLeft = {
			{
				pos = Vector(-169,9,23.5),
				material = "l4d/corona",
				size = 50,
				color = Color(255,0,0,255),
			},
		},
		TurnBrakeRight = {
			{
				pos = Vector(-169,-9,23.5),
				material = "l4d/corona",
				size = 50,
				color = Color(255,0,0,255),
			},
		},
	},
	
	SubMaterials = {
		off = {
			Base = {
				[3] = "",
				[4] = "",
			},
			Brake = {
				[3] = "",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[3] = "",
				[4] = "",
			},
			Brake_Reverse = {
				[3] = "",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_lowbeam = {
			Base = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "",
			},
			Brake = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "",
			},
			Brake_Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_highbeam = {
			Base = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "",
			},
			Brake = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "",
			},
			Brake_Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
	},
}
list.Set( "simfphys_lights", "longnose_truck", light_table)