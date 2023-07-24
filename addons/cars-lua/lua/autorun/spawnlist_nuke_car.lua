local V = {
	Name = "Toyota Corolla",
	Model = "models/left4dead/vehicles/nuke_car.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "L4D - Civilian",
	SpawnOffset = Vector(0,0,0),
	SpawnAngleOffset = 90,
	NAKGame = "Left 4 Dead 2",
	NAKType = "Civilian",

	Members = {
		Mass = 1500,
		
		EnginePos = Vector(70,0,30),
		
		LightsTable = "nuke_car",
		
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		
		CustomWheelModel = "models/left4dead/vehicles/nuke_car_wheel.mdl",
		CustomWheelPosFL = Vector(62,32,12),
		CustomWheelPosFR = Vector(62,-32,12),
		CustomWheelPosRL = Vector(-46,32,12),
		CustomWheelPosRR = Vector(-46,-32,12),
		CustomWheelAngleOffset = Angle(0,270,0),
		
		CustomMassCenter = Vector(10,0,2),
		
		CustomSteerAngle = 30,
		
		SeatOffset = Vector(6,-18,45),
		SeatPitch = -4,
		SeatYaw = 90,
		
		ModelInfo = {
			Skin = 1,
		},
		
		--!!!!!!!!!!!RANDYS EXTRA FUNCTIONS!!!!!!!!!!!!!
		
		LPMountRear = Vector(-87.6,-0.4,18.1),
		LPRotateRear = Angle(8,0,0),
		LPGroup = Plates_L4D,
		
		AllowRandomColors = true,
		RandomColorMin = 10,
		RandomColorMax = 100,
		
		snd_starter = "left4dead/vehicles/hatch_ignition_start.wav",
		snd_starter_good = "left4dead/vehicles/hatch_ignition_good.wav",
		snd_starter_bad = "left4dead/vehicles/hatch_ignition_bad.wav",
		snd_stop = "left4dead/vehicles/hatch_stop.wav",
		
		--!!!!!!!!!!!END RANDYS EXTRA FUNCTIONS!!!!!!!!!!
		
		PassengerSeats = {
			{
				pos = Vector(13,-18,13),
				ang = Angle(0,-90,10)
			},
			{
				pos = Vector(-27,18,13),
				ang = Angle(0,-90,10)
			},
			{
				pos = Vector(-27,-18,13),
				ang = Angle(0,-90,10)
			},
		},
		
		FrontHeight = 8,
		FrontConstant = 24000,
		FrontDamping = 1000,
		FrontRelativeDamping = 800,
		
		RearHeight = 8,
		RearConstant = 24000,
		RearDamping = 1000,
		RearRelativeDamping = 800,
		
		FastSteeringAngle = 30,
		SteeringFadeFastSpeed = 535,
		
		TurnSpeed = 3,
		
		MaxGrip = 42,
		Efficiency = 1,
		GripOffset = 1.5,
		BrakePower = 25,
		
		IdleRPM = 700,
		LimitRPM = 4500,
		PeakTorque = 90,
		PowerbandStart = 1200,
		PowerbandEnd = 4000,
		Turbocharged = false,
		Supercharged = false,
		
		FuelFillPos = Vector(-63,36,35),
		FuelType = 1,
		FuelTankSize = 80,
		
		PowerBias = 1,
		
		EngineSoundPreset = -1,

		EngineSoundPreset = 0,

		Sound_Idle = "left4dead/vehicles/hatch_idle.wav",
		Sound_IdlePitch = 1,
		
		Sound_Mid = "left4dead/vehicles/hatch_low.wav",
		Sound_MidPitch = 1.25,
		Sound_MidVolume = 2,
		Sound_MidFadeOutRPMpercent = 55,
		Sound_MidFadeOutRate = 0.5,
		
		Sound_High = "left4dead/vehicles/hatch_high.wav",
		Sound_HighPitch = 0.65,
		Sound_HighVolume = 1.5,
		Sound_HighFadeInRPMpercent = 55,
		Sound_HighFadeInRate = 0.5,
		
		Sound_Throttle = "left4dead/vehicles/hatch_throttle.wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 5,
		
		snd_horn = "left4dead/vehicles/hatch_horn.wav",
		
		DifferentialGear = 0.27,
		Gears = {-0.18,0,0.13,0.32,0.5,0.85,1.1}
	}
}
list.Set( "simfphys_vehicles", "sim_fphys_l4d_nuke_car", V )

local light_table = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(91,24,28),
	L_HeadLampAng = Angle(0,0,0),
	R_HeadLampPos = Vector(91,-24,28),
	R_HeadLampAng = Angle(0,0,0),
	
	-- projected texture - rear
	L_RearLampPos = Vector(-84,25,34),
	L_RearLampAng = Angle(25,180,0),
	R_RearLampPos = Vector(-84,-25,34),
	R_RearLampAng = Angle(25,180,0),
	
	Headlight_sprites = {   -- lowbeam
		{
			pos = Vector(91,24,28),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
		{
			pos = Vector(91,-24,28),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
	},
	
	Headlamp_sprites = {
		{pos = Vector(91,24,28),size = 100,material = "l4d/corona"},
		{pos = Vector(91,-24,28),size = 100,material = "l4d/corona"},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-84,25,34),
			material = "l4d/corona",
			size = 70,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-84,-25,34),
			material = "l4d/corona",
			size = 70,
			color = Color(255,0,0,150),
		}
	},
	Brakelight_sprites = {
		{
			pos = Vector(-84,20,34),
			material = "l4d/corona",
			size = 60,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-84,-20,34),
			material = "l4d/corona",
			size = 60,
			color = Color(255,0,0,150),
		}
	},
	Reverselight_sprites = {
		{
			pos = Vector(-84,17,33.5),
			material = "l4d/corona",
			size = 40,
			color = Color(255,255,255,150),
		},
		{
			pos = Vector(-84,-17,33.5),
			material = "l4d/corona",
			size = 40,
			color = Color(255,255,255,150),
		}
	},
	
	
	DelayOn = 0,
	DelayOff = 0,
	
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(85,31.5,28),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
			{
				pos = Vector(-81,31,33),
				material = "l4d/corona",
				size = 50,
				color = Color(255,0,0,150),
			},
		},
		Right = {
			{
				pos = Vector(85,-31.5,28),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
			{
				pos = Vector(-81,-31,33),
				material = "l4d/corona",
				size = 50,
				color = Color(255,0,0,150),
			},
		},
	},
	
	SubMaterials = {
		off = {
			Base = {
				[5] = "",
				[7] = "",
				[8] = ""
			},
			Brake = {
				[5] = "",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = ""
			},
			Reverse = {
				[5] = "",
				[7] = "",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			Brake_Reverse = {
				[5] = "",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
		on_lowbeam = {
			Base = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "",
				[8] = ""
			},
			Brake = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = ""
			},
			Reverse = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			Brake_Reverse = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
		on_highbeam = {
			Base = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "",
				[8] = ""
			},
			Brake = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = ""
			},
			Reverse = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			Brake_Reverse = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
		turnsignals = {
			left = {
				[9] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			right = {
				[6] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
	}
	
}
list.Set( "simfphys_lights", "nuke_car", light_table)