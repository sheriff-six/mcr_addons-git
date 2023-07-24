local V = {
	Name = "Boat Trailer 20Ft",
	Model = "models/left4dead/vehicles/Boat_Trailer20ft.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "L4D - Civilian",
	SpawnOffset = Vector(0,0,0),
	SpawnAngleOffset = 90,
	NAKGame = "Left 4 Dead 2",
	NAKType = "Trailers",
	FLEX = {
		Trailers = {
			inputPos = Vector(217,0,9),
			inputType = "ballsocket",
		}
	},
	
	Members = {
		Mass = 1200.0,
		
		EnginePos = Vector(0,0,0),
		
		LightsTable = "boat_trailer_20ft",
		
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
			
		CustomWheelModel = "models/left4dead/vehicles/wheel_boat20ft.mdl",
		
		CustomWheelPosFL = Vector(-9,48,-3),
		CustomWheelPosFR = Vector(-9,-48,-3),	
		CustomWheelPosRL = Vector(-47,48,-3),
		CustomWheelPosRR = Vector(-47,-48,-3),
		CustomWheelAngleOffset = Angle(0,-90,0),
		
		CustomMassCenter = Vector(0,0,0),		
		
		CustomSteerAngle = 60,
		
		SeatOffset = Vector(0,0,0),
		SeatPitch = 0,
		SeatYaw = 90,
		
		--!!!!!!!!!!!RANDYS EXTRA FUNCTIONS!!!!!!!!!!!!!
		
		LPMountRear = Vector(-147.2,0,-2),
		LPGroup = Plates_L4D,
		
		IsTrailer = true,
		
		NoAlarm = true,
		
		TrailerLegsPoseParameter = "trailer_braces",
		TrailerLegsPosition = Vector(200,5,-12),
		TrailerLegsHeight = 20,
		SingleTrailerLeg = true,
		
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
	list.Set( "simfphys_vehicles", "sim_fphys_l4d_boat_trailer_20ft", V )
end

local light_table = {
	-- projected texture - rear
	L_RearLampPos = Vector(-148,38.6,5.3),
	L_RearLampAng = Angle(25,180,0),
	R_RearLampPos = Vector(-148,-38.6,5.3),
	R_RearLampAng = Angle(25,180,0),
	
	Headlight_sprites = {   -- lowbeam
		{
			pos = Vector(-142,41,5),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(-142,-41,5),
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
			pos = Vector(-148,38.6,5.3),
			material = "l4d/corona",
			size = 40,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-148,-38.6,5.3),
			material = "l4d/corona",
			size = 40,
			color = Color(255,0,0,150),
		},
	},
	Brakelight_sprites = {
		{
			pos = Vector(-147.4,32.2,2.7),
			material = "l4d/corona",
			size = 50,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-147.4,-32.2,2.7),
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
				pos = Vector(-147.4,27.3,1.9),
				material = "l4d/corona",
				size = 30,
				color = Color(255,0,0,255),
			},
			{
				pos = Vector(-147.4,23.8,1.1),
				material = "l4d/corona",
				size = 30,
				color = Color(255,0,0,255),
			},
		},
		Right = {
			{
				pos = Vector(-147.4,-27.3,1.9),
				material = "l4d/corona",
				size = 30,
				color = Color(255,0,0,255),
			},
			{
				pos = Vector(-147.4,-23.8,1.1),
				material = "l4d/corona",
				size = 30,
				color = Color(255,0,0,255),
			},
		},
	},
	
	SubMaterials = {
		off = {
			Base = {
				[2] = "",
				[4] = "",
			},
			Brake = {
				[2] = "",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[2] = "",
				[4] = "",
			},
			Brake_Reverse = {
				[2] = "",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_lowbeam = {
			Base = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "",
			},
			Brake = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "",
			},
			Brake_Reverse = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_highbeam = {
			Base = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "",
			},
			Brake = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "",
			},
			Brake_Reverse = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		turnsignals = {
			left = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			right = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
	},
}
list.Set( "simfphys_lights", "boat_trailer_20ft", light_table)