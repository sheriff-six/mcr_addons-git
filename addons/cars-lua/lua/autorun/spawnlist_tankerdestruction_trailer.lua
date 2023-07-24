local V = {
	Name = "Tanker Trailer",
	Model = "models/left4dead/vehicles/tankertrailer2.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "L4D - Industrial",
	SpawnOffset = Vector(0,0,0),
	SpawnAngleOffset = 90,
	NAKGame = "Left 4 Dead 2",
	NAKType = "Trailers",
	FLEX = {
		Trailers = {
			inputPos = Vector(228,0,50),
			inputType = "axis",
		}
	},
	
	Members = {
		Mass = 1400.0,
		NAKTankerHB = {
            Tank = {
                OBBMax = Vector(270,50,50),
                OBBMin = Vector(-180,-50,-40),
            },
		},
		
		EnginePos = Vector(0,0,0),
		
		LightsTable = "tankerdestruction_trailer",
		
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
			
		CustomWheelModel = "models/left4dead/vehicles/wheel_tanker.mdl",
		
		CustomWheelPosFL = Vector(-140,40,25),
		CustomWheelPosFR = Vector(-140,-40,25),	
		CustomWheelPosRL = Vector(-200,40,25),
		CustomWheelPosRR = Vector(-200,-40,25),
		CustomWheelAngleOffset = Angle(0,-90,0),
		
		CustomMassCenter = Vector(50,0,10),		
		
		CustomSteerAngle = 60,
		
		SeatOffset = Vector(0,0,0),
		SeatPitch = 0,
		SeatYaw = 90,
		
		--!!!!!!!!!!!RANDYS EXTRA FUNCTIONS!!!!!!!!!!!!!
		
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
	list.Set( "simfphys_vehicles", "sim_fphys_l4d_tankerdestruction_trailer", V )
end

local light_table = {
	-- projected texture - rear
	L_RearLampPos = Vector(-232.5,34.8,57.2),
	L_RearLampAng = Angle(25,180,0),
	R_RearLampPos = Vector(-232.5,-34.8,57.2),
	R_RearLampAng = Angle(25,180,0),
	
	Headlight_sprites = {   -- lowbeam
		{
			pos = Vector(233,58.5,90.5),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(22,58.5,90.5),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(-212,58.5,90.5),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		
		{
			pos = Vector(233,-58.5,90.5),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(22,-58.5,90.5),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(-212,-58.5,90.5),
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
			pos = Vector(-232.5,34.8,57.2),
			material = "l4d/corona",
			size = 50,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-232.5,-34.8,57.2),
			material = "l4d/corona",
			size = 50,
			color = Color(255,0,0,150),
		},
	},
	Brakelight_sprites = {
		{
			pos = Vector(-232.5,28.8,57.2),
			material = "l4d/corona",
			size = 50,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-232.5,-28.8,57.2),
			material = "l4d/corona",
			size = 50,
			color = Color(255,0,0,150),
		},
	},
	
	
	DelayOn = 0,
	DelayOff = 0,
	
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(-232,40.2,57.2),
				material = "l4d/corona",
				size = 50,
				color = Color(255,135,0,255),
			},
		},
		Right = {
			{
				pos = Vector(-232,-40.2,57.2),
				material = "l4d/corona",
				size = 50,
				color = Color(255,135,0,255),
			},
		},
	},
	
	SubMaterials = {
		off = {
			Base = {
				[1] = "",
				[3] = "",
			},
			Brake = {
				[1] = "",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[1] = "",
				[3] = "",
			},
			Brake_Reverse = {
				[1] = "",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_lowbeam = {
			Base = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "",
			},
			Brake = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "",
			},
			Brake_Reverse = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_highbeam = {
			Base = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "",
			},
			Brake = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "",
			},
			Brake_Reverse = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		turnsignals = {
			left = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			right = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
	},
}
list.Set( "simfphys_lights", "tankerdestruction_trailer", light_table)