local V = {
	Name = "Flatnose Truck",
	Model = "models/left4dead/vehicles/flatnose_truck.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "L4D - Industrial",
	SpawnOffset = Vector(0,0,10),
	SpawnAngleOffset = 90,
	NAKGame = "Left 4 Dead 2",
	NAKType = "Industrial",
	FLEX = {
		Trailers = {
			outputPos = Vector(-69,0,50),
			outputType = "axis",
		}
	},

	Members = {
		Mass = 5650,
		
		EnginePos = Vector(140,0,57),
		
		LightsTable = "flatnose_truck",
		
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		
		CustomWheelModel = "models/left4dead/vehicles/wheel_truck_front.mdl",
		CustomWheelModel_R = "models/left4dead/vehicles/wheel_truck_rear.mdl",
		
		CustomWheelPosFL = Vector(107,42,22),
		CustomWheelPosFR = Vector(107,-42,22),	
		CustomWheelPosRL = Vector(-112,39,27),
		CustomWheelPosML = Vector(-62,39,27),
		CustomWheelPosMR = Vector(-62,-35,27),
		CustomWheelPosRR = Vector(-112,-35,27),
		CustomWheelAngleOffset = Angle(0,-90,0),
		
		CustomMassCenter = Vector(20,0,-20),		
		
		CustomSteerAngle = 35,
		
		SeatOffset = Vector(60,-27,124),
		SeatPitch = 15,
		SeatYaw = 90,
		
		--!!!!!!!!!!!RANDYS EXTRA FUNCTIONS!!!!!!!!!!!!!
		
		LPMountFront = Vector(140.5,0,31),
		LPMountRear = Vector(-146,0,34),
		LPGroup = Plates_L4D,
		
		AllowRandomColors = true,
		RandomColorMin = 30,
		RandomColorMax = 100,
		
		AllowRandomSkins = true,
		RandomSkinRange = {1,3},
		
		HasAirbrakes = true,
		
		snd_starter = "left4dead/vehicles/flatnose_ignition_start.wav",
		snd_starter_good = "left4dead/vehicles/flatnose_ignition_good.wav",
		snd_starter_bad = "left4dead/vehicles/flatnose_ignition_bad.wav",
		snd_stop = "left4dead/vehicles/flatnose_stop.wav",
		snd_reverse_beep = "vehicles/gen_reverse.wav",
		
		--!!!!!!!!!!!END RANDYS EXTRA FUNCTIONS!!!!!!!!!!
		
		ExhaustPositions = {
			{
				pos = Vector(41.5,44.5,155),
				ang = Angle(0,0,0),
			},
			{
				pos = Vector(41.5,44.5,155),
				ang = Angle(0,0,0),
			},
		},
		
		PassengerSeats = {
			{
				pos = Vector(107,-25,72),
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
		BrakePower = 25,
		BulletProofTires = false,
		
		IdleRPM = 1200,
		LimitRPM = 5000,
		PeakTorque = 125,
		PowerbandStart = 1600,
		PowerbandEnd = 3000,
		Turbocharged = false,
		Supercharged = false,
		DoNotStall = false,
		
		FuelFillPos = Vector(17,-54,35),
		FuelType = 2,
		FuelTankSize = 130,
		
		PowerBias = -1,
		
		EngineSoundPreset = 0,
		
		Sound_Idle = "left4dead/vehicles/flatnose_idle.wav",
		Sound_IdlePitch = 1,
		
		Sound_Mid = "left4dead/vehicles/flatnose_low.wav",
		Sound_MidPitch = 1.4,
		Sound_MidVolume = 1,
		Sound_MidFadeOutRPMpercent = 80,
		Sound_MidFadeOutRate = 0.3,
		
		Sound_High = "left4dead/vehicles/flatnose_high.wav",
		Sound_HighPitch = 1.6,
		Sound_HighVolume = 2,
		Sound_HighFadeInRPMpercent = 80,
		Sound_HighFadeInRate = 0.3,
		
		Sound_Throttle = "left4dead/vehicles/flatnose_throttle.wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 5,
		
		snd_horn = "left4dead/vehicles/flatnose_horn.wav",
		
		DifferentialGear = 0.1,
		Gears = {-0.35,0,0.15,0.22,0.29,0.37,0.49,0.6,0.79,1,1.5,2.1,3}
	}
}
list.Set( "simfphys_vehicles", "sim_fphys_l4d_flatnose_truck", V )

local light_table = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(140,41,57),
	L_HeadLampAng = Angle(0,0,0),
	R_HeadLampPos = Vector(140,-41,57),
	R_HeadLampAng = Angle(0,0,0),
	
	-- projected texture - rear
	L_RearLampPos = Vector(-146,17,23.5),
	L_RearLampAng = Angle(25,180,0),
	R_RearLampPos = Vector(-146,-17,23.5),
	R_RearLampAng = Angle(25,180,0),
	
	Headlight_sprites = {   -- lowbeam
		{
			pos = Vector(140,41,56.8),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
		{
			pos = Vector(140,-41,57),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
		{
			pos = Vector(126.5,-46.5,131),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(126.5,46.5,131),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(126.5,-9.5,131),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(126.5,9.5,131),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(126.5,0,131),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		}
	},
	
	Headlamp_sprites = {
		{pos = Vector(140,41,57),size = 100,material = "l4d/corona"},
		{pos = Vector(140,-41,57),size = 100,material = "l4d/corona"},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-146,17,23.5),
			material = "l4d/corona",
			size = 50,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-146,-17,23.5),
			material = "l4d/corona",
			size = 50,
			color = Color(255,0,0,150),
		}
	},
	
	
	DelayOn = 0,
	DelayOff = 0,
	
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(140,34,47),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
		},
		TurnBrakeLeft = {
			{
				pos = Vector(-146,9,23.5),
				material = "l4d/corona",
				size = 50,
				color = Color(255,0,0,255),
			},
		},
		Right = {
			{
				pos = Vector(140,-34,47),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
		},
		TurnBrakeRight = {
			{
				pos = Vector(-146,-9,23.5),
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
				[6] = "",
			},
			Brake = {
				[3] = "",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[3] = "",
				[6] = "",
			},
			Brake_Reverse = {
				[3] = "",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_lowbeam = {
			Base = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
			},
			Brake = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
			},
			Brake_Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_highbeam = {
			Base = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
			},
			Brake = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
			},
			Brake_Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		turnsignals = {
			left = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			right = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
	},
}
list.Set( "simfphys_lights", "flatnose_truck", light_table)