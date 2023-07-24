local V = {
	Name = "Tanker Trailer",
	Model = "models/left4dead/vehicles/tankertrailer.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "L4D - Industrial",
	SpawnOffset = Vector(0,0,0),
	SpawnAngleOffset = 90,
	NAKGame = "Left 4 Dead 2",
	NAKType = "Trailers",
	FLEX = {
		Trailers = {
			inputPos = Vector(202,0,50),
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
		
		LightsTable = "tanker_trailer",
		
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
			
		CustomWheelModel = "models/left4dead/vehicles/wheel_truck_rear.mdl",
		
		CustomWheelPosFL = Vector(-97,40,22),
		CustomWheelPosFR = Vector(-97,-40,22),	
		CustomWheelPosRL = Vector(-148,40,22),
		CustomWheelPosRR = Vector(-148,-40,22),
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
	list.Set( "simfphys_vehicles", "sim_fphys_l4d_tanker_trailer", V )
end

local light_table = {
	-- projected texture - rear
	L_RearLampPos = Vector(-175.6,34.6,57.6),
	L_RearLampAng = Angle(25,180,0),
	R_RearLampPos = Vector(-175.6,-34.6,57.6),
	R_RearLampAng = Angle(25,180,0),
	
	Headlight_sprites = {   -- lowbeam
		{
			pos = Vector(228,51,96),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(45,51,96),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(-161,51,96),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		
		{
			pos = Vector(228,-51,96),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(45,-51,96),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(-161,-51,96),
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
			pos = Vector(-172,5.5,140.4),
			material = "l4d/corona",
			size = 50,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-172,-5.6,140.4),
			material = "l4d/corona",
			size = 50,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-175.6,34.6,57.6),
			material = "l4d/corona",
			size = 50,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-175.6,-34.6,57.6),
			material = "l4d/corona",
			size = 50,
			color = Color(255,0,0,150),
		}
	},
	Brakelight_sprites = {
		{
			pos = Vector(-172,0.3,140.3),
			material = "l4d/corona",
			size = 50,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-175.6,28.6,57.6),
			material = "l4d/corona",
			size = 50,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-175.6,-28.6,57.6),
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
				pos = Vector(-175.6,40,57.6),
				material = "l4d/corona",
				size = 50,
				color = Color(255,135,0,255),
			},
		},
		Right = {
			{
				pos = Vector(-175.6,-40,57.6),
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
				[2] = "",
			},
			Brake = {
				[1] = "",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[1] = "",
				[2] = "",
			},
			Brake_Reverse = {
				[1] = "",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_lowbeam = {
			Base = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "",
			},
			Brake = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "",
			},
			Brake_Reverse = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_highbeam = {
			Base = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "",
			},
			Brake = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "",
			},
			Brake_Reverse = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		turnsignals = {
			left = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			right = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
	},
}
list.Set( "simfphys_lights", "tanker_trailer", light_table)