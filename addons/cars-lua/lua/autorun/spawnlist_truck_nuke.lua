local V = {
	Name = "Box Truck (Small)",
	Model = "models/left4dead/vehicles/truck_nuke.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "L4D - Industrial",
	SpawnOffset = Vector(0,0,0),
	SpawnAngleOffset = 90,
	NAKGame = "Left 4 Dead 2",
	NAKType = "Industrial",

	Members = {
		Mass = 3000,
		
		EnginePos = Vector(161,0,37),
		
		LightsTable = "truck_nuke",
		
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		
		CustomWheelModel = "models/left4dead/vehicles/wheel_truck_nuke_front.mdl",
		CustomWheelModel_R = "models/left4dead/vehicles/wheel_truck_nuke_rear.mdl",
		
		CustomWheelPosFL = Vector(112.6,36.6,23),
		CustomWheelPosFR = Vector(112.6,-36.6,23),	
		CustomWheelPosRL = Vector(-64.4,41.6,23),
		CustomWheelPosRR = Vector(-64.4,-41.6,23),
		CustomWheelAngleOffset = Angle(0,-90,0),
		
		CustomMassCenter = Vector(0,0,10),		
		
		CustomSteerAngle = 30,
		
		SeatOffset = Vector(94,-24,95),
		SeatPitch = 10,
		SeatYaw = 90,
		
		--!!!!!!!!!!!RANDYS EXTRA FUNCTIONS!!!!!!!!!!!!!
		
		AllowRandomColors = true,
		RandomColorMin = 10,
		RandomColorMax = 100,
		
		AllowRandomSkins = true,
		RandomSkinRange = {0,1},
		
		snd_starter = "vehicles/starter_smalltruck.wav",
		snd_starter_good = "vehicles/starter_smalltruck_tail.wav",
		snd_stop = "vehicles/SHUT_DOWN_1.wav",
		snd_reverse_beep = "vehicles/gen_reverse.wav",
		
		--!!!!!!!!!!!END RANDYS EXTRA FUNCTIONS!!!!!!!!!!
		
		PassengerSeats = {
			{
				pos = Vector(110,-25,45),
				ang = Angle(0,-90,0)
			},
			{
				pos = Vector(110,0,45),
				ang = Angle(0,-90,0)
			},
		},
		
		FrontHeight = 16,
		FrontConstant = 35000,
		FrontDamping = 2400,
		FrontRelativeDamping = 50,
		
		RearHeight = 16,
		RearConstant = 35000,
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
		PeakTorque = 90,
		PowerbandStart = 1600,
		PowerbandEnd = 3000,
		Turbocharged = false,
		Supercharged = false,
		DoNotStall = false,
		
		FuelFillPos = Vector(83,23,30),
		FuelType = 2,
		FuelTankSize = 100,
		
		PowerBias = -1,
		
		EngineSoundPreset = 0,
		
		Sound_Idle = "left4dead/vehicles/truck_nuke_idle.wav",
		Sound_IdlePitch = 0.8,
		
		Sound_Mid = "left4dead/vehicles/truck_nuke_low.wav",
		Sound_MidPitch = 1.1,
		Sound_MidVolume = 2,
		Sound_MidFadeOutRPMpercent = 50,
		Sound_MidFadeOutRate = 0.3,
		
		Sound_High = "left4dead/vehicles/truck_nuke_high.wav",
		Sound_HighPitch = 1.2,
		Sound_HighVolume = 3,
		Sound_HighFadeInRPMpercent = 50,
		Sound_HighFadeInRate = 0.3,
		
		Sound_Throttle = "left4dead/vehicles/truck_nuke_throttle.wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 2.5,
		
		snd_horn = "left4dead/vehicles/truck_nuke_horn.wav",
		
		DifferentialGear = 0.3,
		Gears = {-0.13,0,0.06,0.15,0.23,0.4,0.6}
	}
}
list.Set( "simfphys_vehicles", "sim_fphys_l4d_truck_nuke", V )

local light_table = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(159,35,35),
	L_HeadLampAng = Angle(0,0,0),
	R_HeadLampPos = Vector(159,-35,35),
	R_HeadLampAng = Angle(0,0,0),
	
	-- projected texture - rear
	L_RearLampPos = Vector(-148,54.7,48.1),
	L_RearLampAng = Angle(25,180,0),
	R_RearLampPos = Vector(-148,-54.7,48.1),
	R_RearLampAng = Angle(25,180,0),
	
	Headlight_sprites = {   -- lowbeam
		{
			pos = Vector(159,35,35),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
		{
			pos = Vector(159,-35,35),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
		{
			pos = Vector(76,54.7,140.2),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(76,-54.7,140.2),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(68.8,57.7,47.8),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(68.8,-57.7,47.8),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
	},
	
	Headlamp_sprites = {
		{pos = Vector(159,27,35),size = 100,material = "l4d/corona"},
		{pos = Vector(159,-27,35),size = 100,material = "l4d/corona"},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-148,54.7,48.1),
			material = "l4d/corona",
			size = 50,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-148,-54.7,48.1),
			material = "l4d/corona",
			size = 50,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-140.2,57.7,47.8),
			material = "l4d/corona",
			size = 40,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-140.2,-57.7,47.8),
			material = "l4d/corona",
			size = 40,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-146.9,52.6,154.4),
			material = "l4d/corona",
			size = 40,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-146.9,-52.6,154.4),
			material = "l4d/corona",
			size = 40,
			color = Color(255,0,0,150),
		},
	},
	Brakelight_sprites = {
		{
			pos = Vector(-148,54.7,48.1),
			material = "l4d/corona",
			size = 60,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-148,-54.7,48.1),
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
				pos = Vector(157,42,39.6),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
		},
		Right = {
			{
				pos = Vector(157,-42,39.6),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
		},
	},
	
	SubMaterials = {
		off = {
			Base = {
				[1] = "",
				[3] = "",
				[2] = "",
			},
			Brake = {
				[1] = "",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "",
			},
			Reverse = {
				[1] = "",
				[3] = "",
				[2] = "",
			},
			Brake_Reverse = {
				[1] = "",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "",
			},
		},
		on_lowbeam = {
			Base = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "",
			},
			Brake = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "",
			},
			Reverse = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "",
			},
			Brake_Reverse = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "",
			},
		},
		on_highbeam = {
			Base = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		turnsignals = {
			left = {
				[7] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			right = {
				[8] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
	}
}
list.Set( "simfphys_lights", "truck_nuke", light_table)