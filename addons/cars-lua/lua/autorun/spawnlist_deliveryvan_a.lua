local V = {
	Name = "Armored Delivery Van",
	Model = "models/left4dead/vehicles/deliveryvan_armored.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "L4D - Special",
	SpawnOffset = Vector(0,0,10),
	SpawnAngleOffset = 90,
	NAKGame = "Left 4 Dead 2",
	NAKType = "Special",

	Members = {
		Mass = 2500,
		
		EnginePos = Vector(127,0,46),
		
		LightsTable = "deliveryvan_a",
		
		MaxHealth = 3625,
		
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		
		CustomWheelModel = "models/left4dead/vehicles/wheel_dvan_f.mdl",
		CustomWheelModel_R = "models/left4dead/vehicles/wheel_dvan_r.mdl",
		
		IsArmored = true,
		BulletProofTires = true,
		
		CustomWheelPosFL = Vector(86,42.8,8),
		CustomWheelPosFR = Vector(86,-42.8,8),
		CustomWheelPosRL = Vector(-76.5,37.5,8),
		CustomWheelPosRR = Vector(-76.5,-37.5,8),
		CustomWheelAngleOffset = Angle(0,270,0),
		
		CustomMassCenter = Vector(0,0,0),
		
		CustomSteerAngle = 30,
		
		SeatOffset = Vector(45,-26,82),
		SeatPitch = 0,
		SeatYaw = 90,
		
		--!!!!!!!!!!!RANDYS EXTRA FUNCTIONS!!!!!!!!!!!!!
		
		AllowRandomColors = true,
		RandomColorMin = 25,
		RandomColorMax = 100,
		
		NoAlarm = true,
		
		SimpleIgnition = true,
		
		snd_starter = "vehicles/starter_smalltruck.wav",
		snd_starter_good = "vehicles/starter_smalltruck_tail.wav",
		snd_stop = "vehicles/SHUT_DOWN_1.wav",
		snd_reverse_beep = "vehicles/gen_reverse.wav",
		
		--!!!!!!!!!!!END RANDYS EXTRA FUNCTIONS!!!!!!!!!!
		
		PassengerSeats = {
			{
				pos = Vector(52,-26,48),
				ang = Angle(0,-90,10)
			},
		},
		
		ExhaustPositions = {
			{
				pos = Vector(-45.2,-47,5.4),
				ang = Angle(125,270,0),
			},
		},
		
		FrontHeight = 7,
		FrontConstant = 24000,
		FrontDamping = 3500,
		FrontRelativeDamping = 800,
		
		RearHeight = 7,
		RearConstant = 24000,
		RearDamping = 3500,
		RearRelativeDamping = 800,
		
		FastSteeringAngle = 30,
		SteeringFadeFastSpeed = 535,
		
		TurnSpeed = 3,
		
		MaxGrip = 64,
		Efficiency = 1,
		GripOffset = 1.5,
		BrakePower = 45,
		
		IdleRPM = 800,
		LimitRPM = 5000,
		PeakTorque = 180,
		PowerbandStart = 1500,
		PowerbandEnd = 4000,
		Turbocharged = false,
		Supercharged = true,
		
		FuelFillPos = Vector(-45,48,16.5),
		FuelType = 2,
		FuelTankSize = 200,
		
		PowerBias = 1,
		
		EngineSoundPreset = 0,

		
		Sound_Idle = "left4dead/vehicles/deliveryvan_armor_idle.wav",
		Sound_IdlePitch = 1,
		
		Sound_Mid = "left4dead/vehicles/charger_low.wav",
		Sound_MidPitch = 1.3,
		Sound_MidVolume = 3,
		Sound_MidFadeOutRPMpercent = 40,
		Sound_MidFadeOutRate = 0.5,
		
		Sound_High = "left4dead/vehicles/charger_high.wav",
		Sound_HighPitch = 0.8,
		Sound_HighVolume = 2.5,
		Sound_HighFadeInRPMpercent = 40,
		Sound_HighFadeInRate = 0.5,
		
		Sound_Throttle = "left4dead/vehicles/charger_throttle.wav",
		Sound_ThrottlePitch = 0.7,
		Sound_ThrottleVolume = 2,
		
		--
		snd_horn = "left4dead/vehicles/deliveryvan_horn.wav",
		snd_bloweron = "left4dead/vehicles/bus_turbo.wav",
		snd_bloweroff = "common/null.wav",
		
		DifferentialGear = 0.5,
		Gears = {-0.13,0,0.055,0.125,0.25,0.35,0.5,0.7}
	}
}
list.Set( "simfphys_vehicles", "sim_fphys_l4d_deliveryvan_a", V )

local light_table = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(112,31.8,42.8),
	L_HeadLampAng = Angle(0,0,0),
	R_HeadLampPos = Vector(112,-31.8,42.8),
	R_HeadLampAng = Angle(0,0,0),
	
	-- projected texture - rear
	L_RearLampPos = Vector(-145.2,42.2,59.8),
	L_RearLampAng = Angle(25,180,0),
	R_RearLampPos = Vector(-145.2,-42.2,59.8),
	R_RearLampAng = Angle(25,180,0),
	
	Headlight_sprites = {   -- lowbeam
		{
			pos = Vector(126.7,35.5,48.8),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
		{
			pos = Vector(126.7,-35.5,48.8),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
		{
			pos = Vector(117.7,48.5,35.2),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(117.7,-48.5,35.2),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(74.5,9.8,110),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(74.5,-9.8,110),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(74.5,0,110),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
	},
	
	Headlamp_sprites = {
		{pos = Vector(126.7,35.5,48.8),size = 100,material = "l4d/corona"},
		{pos = Vector(126.7,-35.5,48.8),size = 100,material = "l4d/corona"},
		{pos = Vector(79.1,21.3,120.4),size = 150,material = "l4d/corona"},
		{pos = Vector(79.1,21.3,120.4),size = 50,color = Color(255,255,255,255),material = "l4d/corona"},
		{pos = Vector(79.1,6.9,120.4),size = 150,material = "l4d/corona"},
		{pos = Vector(79.1,6.9,120.4),size = 50,color = Color(255,255,255,255),material = "l4d/corona"},
		{pos = Vector(79.1,-12.7,120.4),size = 150,material = "l4d/corona"},
		{pos = Vector(79.1,-12.7,120.4),size = 50,color = Color(255,255,255,255),material = "l4d/corona"},
		{pos = Vector(79.1,-28.4,120.4),size = 150,material = "l4d/corona"},
		{pos = Vector(79.1,-28.4,120.4),size = 50,color = Color(255,255,255,255),material = "l4d/corona"},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-145.2,42.2,59.8),
			material = "l4d/corona",
			size = 50,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-145.2,-42.2,59.8),
			material = "l4d/corona",
			size = 70,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-145.2,-41.8,110.1),
			material = "l4d/corona",
			size = 20,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-145.2,41.8,110.1),
			material = "l4d/corona",
			size = 20,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-145.2,16,110.1),
			material = "l4d/corona",
			size = 20,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-145.2,-16,110.1),
			material = "l4d/corona",
			size = 20,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-145.2,6,110.1),
			material = "l4d/corona",
			size = 20,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-145.2,-6,110.1),
			material = "l4d/corona",
			size = 20,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-136.2,48,109.4),
			material = "l4d/corona",
			size = 20,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(-136.2,-48,109.4),
			material = "l4d/corona",
			size = 20,
			color = Color(255,178,0,150),
		},
	},
	Brakelight_sprites = {
		{
			pos = Vector(-145.2,42.2,59.8),
			material = "l4d/corona",
			size = 40,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-145.2,-41.8,110.1),
			material = "l4d/corona",
			size = 40,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-145.2,41.8,110.1),
			material = "l4d/corona",
			size = 40,
			color = Color(255,0,0,150),
		},	
		{
			pos = Vector(-145.2,-42.2,59.8),
			material = "l4d/corona",
			size = 60,
			color = Color(255,0,0,150),
		}
	},
	
	DelayOn = 0,
	DelayOff = 0,
	
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(126.7,35.5,39.2),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
			{
				pos = Vector(117.7,48.5,41),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
		},
		Right = {
			{
				pos = Vector(126.7,-35.5,39.2),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
			{
				pos = Vector(117.7,-48.5,41),
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
				[8] = "",
			},
			Brake = {
				[5] = "",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "",
			},
			Reverse = {
				[5] = "",
				[4] = "",
				[8] = "",
			},
			Brake_Reverse = {
				[5] = "",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "",
			},
		},
		on_lowbeam = {
			Base = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "",
			},
			Brake = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "",
			},
			Reverse = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "",
			},
			Brake_Reverse = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "",
			},
		},
		on_highbeam = {
			Base = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		turnsignals = {
			left = {
				[7] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			right = {
				[6] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
	}
}
list.Set( "simfphys_lights", "deliveryvan_a", light_table)