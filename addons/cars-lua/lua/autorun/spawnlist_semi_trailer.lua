local V = {
	Name = "Semi Trailer",
	Model = "models/left4dead/vehicles/semi_trailer.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "L4D - Industrial",
	SpawnOffset = Vector(0,0,0),
	SpawnAngleOffset = 90,
	NAKGame = "Left 4 Dead 2",
	NAKType = "Trailers",
	FLEX = {
		Trailers = {
			inputPos = Vector(221,0,50),
			inputType = "axis",
		}
	},
	
	Members = {
		Mass = 2500.0,
		
		EnginePos = Vector(0,0,0),
		
		LightsTable = "semi_trailer",
		
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
			
		CustomWheelModel = "models/left4dead/vehicles/wheel_truck_rear.mdl",
		
		CustomWheelPosFL = Vector(-156.5,40,22),
		CustomWheelPosFR = Vector(-156.5,-40,22),	
		CustomWheelPosRL = Vector(-212.7,40,22),
		CustomWheelPosRR = Vector(-212.7,-40,22),
		CustomWheelAngleOffset = Angle(0,-90,0),
		
		CustomMassCenter = Vector(50,0,10),		
		
		CustomSteerAngle = 60,
		
		SeatOffset = Vector(0,0,0),
		SeatPitch = 0,
		SeatYaw = 90,
		
		--!!!!!!!!!!!RANDYS EXTRA FUNCTIONS!!!!!!!!!!!!!
		
		LPMountRear = Vector(-263.7,0,23.4),
		LPGroup = Plates_L4D,
		
		IsTrailer = true,
		
		NoAlarm = true,
		
		TrailerLegsPoseParameter = "trailer_braces",
		TrailerLegsPosition = Vector(90,17,-3),
		
		--!!!!!!!!!!!END RANDYS EXTRA FUNCTIONS!!!!!!!!!!
		
		FrontHeight = 5,
		FrontConstant = 50000,
		FrontDamping = 2000,
		FrontRelativeDamping = 350,
		
		RearHeight = 5,
		RearConstant = 50000,
		RearDamping = 2000,
		RearRelativeDamping = 350,
		
		FastSteeringAngle = 10,
		SteeringFadeFastSpeed = 700,
		
		TurnSpeed = 3,
		
		MaxGrip = 150,
		Efficiency = 1,
		GripOffset = 0,
		BrakePower = 40,
		BulletProofTires = false,
		
		IdleRPM = 0,
		LimitRPM = 0,
		PeakTorque = 0,
		PowerbandStart = 0,
		PowerbandEnd = 0,
		Turbocharged = false,
		Supercharged = false,
		DoNotStall = false,
		
		FuelFillPos = Vector(0,0,0),
		FuelType = FUELTYPE_NONE,
		FuelTankSize = 0,
		
		PowerBias = 0,
		
		EngineSoundPreset = -1,

		snd_pitch = 1,
		snd_idle = "common/null.wav",
		
		snd_low = "common/null.wav",
		snd_low_revdown = "common/null.wav",
		snd_low_pitch = 1,
		
		snd_mid = "common/null.wav",
		snd_mid_gearup = "common/null.wav",
		snd_mid_geardown = "common/null.wav",
		snd_mid_pitch = 1,
		
		snd_horn = "common/null.wav",
		
		DifferentialGear = 0,
		Gears = {-1,0,1}
	}
}
if file.Exists( "autorun/tr_init.lua", "LUA") then
	list.Set( "simfphys_vehicles", "sim_fphys_l4d_semi_trailer", V )
end

local light_table = {
	-- projected texture - rear
	L_RearLampPos = Vector(-266.5,44.6,50.8),
	L_RearLampAng = Angle(25,180,0),
	R_RearLampPos = Vector(-266.5,-44.6,50.8),
	R_RearLampAng = Angle(25,180,0),
	
	Headlight_sprites = {   -- lowbeam
		{
			pos = Vector(257,52,54.3),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(257,-52,54.3),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(264.7,49.1,163.4),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(264.7,-49.1,163.4),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
	},
	
	Headlamp_sprites = {
		{pos = Vector(140,41,57),size = 100,material = "l4d/corona"},
		{pos = Vector(140,-41,57),size = 100,material = "l4d/corona"},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-256.5,53,52.4),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(-256.5,-53,52.4),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(-266.5,8.3,49.9),
			material = "l4d/corona",
			size = 40,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-266.5,-8.3,49.9),
			material = "l4d/corona",
			size = 40,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-266.5,44.6,50.8),
			material = "l4d/corona",
			size = 50,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-266.5,-44.6,50.8),
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
				pos = Vector(-266.5,38.4,50.8),
				material = "l4d/corona",
				size = 50,
				color = Color(255,0,0,255),
			},
		},
		TurnBrakeRight = {
			{
				pos = Vector(-266.5,-38.4,50.8),
				material = "l4d/corona",
				size = 50,
				color = Color(255,0,0,255),
			},
		},
	},
	
	SubMaterials = {
		off = {
			Base = {
				[2] = "",
				[1] = "",
			},
			Brake = {
				[2] = "",
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[2] = "",
				[1] = "",
			},
			Brake_Reverse = {
				[2] = "",
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_lowbeam = {
			Base = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[1] = "",
			},
			Brake = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[1] = "",
			},
			Brake_Reverse = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_highbeam = {
			Base = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[1] = "",
			},
			Brake = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[1] = "",
			},
			Brake_Reverse = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
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
list.Set( "simfphys_lights", "semi_trailer", light_table)