local V = {
	Name = "Tractor",
	Model = "models/left4dead/vehicles/tractor01.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "L4D - Services",
	SpawnOffset = Vector(0,0,0),
	SpawnAngleOffset = 90,
	NAKGame = "Left 4 Dead 2",
	NAKType = "Services",

	Members = {
		Mass = 4000,
		
		EnginePos = Vector(44.5,-0.25,95.5),
		
		LightsTable = "tractor01",
		
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		
		CustomWheelModel = "models/left4dead/vehicles/wheel_tractor01_front.mdl",
		CustomWheelModel_R = "models/left4dead/vehicles/wheel_tractor01_rear.mdl",
		
		CustomWheelPosFL = Vector(64,49,14),
		CustomWheelPosFR = Vector(64,-49,14),
		CustomWheelPosRL = Vector(-96,67,35),
		CustomWheelPosRR = Vector(-96,-67,35),
		CustomWheelAngleOffset = Angle(0,270,0),
		
		FrontWheelRadius = 32,
		RearWheelRadius = 53,
		
		CustomMassCenter = Vector(0,0,0),
		
		CustomSteerAngle = 30,
		
		SeatOffset = Vector(-110,0,115),
		SeatPitch = 15,
		SeatYaw = 90,
		
		--!!!!!!!!!!!RANDYS EXTRA FUNCTIONS!!!!!!!!!!!!!
		
		AllowRandomColors = true,
		RandomColorMin = 25,
		RandomColorMax = 100,
		
		NoAlarm = true,
		
		snd_starter = "left4dead/vehicles/tractor01_ignition_start.wav",
		snd_starter_good = "left4dead/vehicles/tractor01_ignition_good.wav",
		snd_starter_bad = "left4dead/vehicles/tractor01_ignition_bad.wav",
		snd_stop = "vehicles/SHUT_DOWN_1.wav",
		
		--!!!!!!!!!!!END RANDYS EXTRA FUNCTIONS!!!!!!!!!!
		
		ExhaustPositions = {
			{
				pos = Vector(-5.3,-50,173.6),
				ang = Angle(90,-45,0),
			},
			{
				pos = Vector(-5.3,-50,173.6),
				ang = Angle(90,-45,0),
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
		GripOffset = 1,
		BrakePower = 35,
		
		IdleRPM = 800,
		LimitRPM = 3500,
		PeakTorque = 100,
		PowerbandStart = 1500,
		PowerbandEnd = 3000,
		Turbocharged = false,
		Supercharged = false,
		
		FuelFillPos = Vector(4.5,-25,55.6),
		FuelType = 2,
		FuelTankSize = 135,
		
		PowerBias = 0,
		
		EngineSoundPreset = 0,

		
		Sound_Idle = "left4dead/vehicles/tractor01_idle.wav",
		Sound_IdlePitch = 1,
		
		Sound_Mid = "left4dead/vehicles/tractor01_low.wav",
		Sound_MidPitch = 1.5,
		Sound_MidVolume = 1.5,
		Sound_MidFadeOutRPMpercent = 60,
		Sound_MidFadeOutRate = 0.5,
		
		Sound_High = "left4dead/vehicles/tractor01_high.wav",
		Sound_HighPitch = 1,
		Sound_HighVolume = 1.5,
		Sound_HighFadeInRPMpercent = 60,
		Sound_HighFadeInRate = 0.5,
		
		Sound_Throttle = "left4dead/vehicles/tractor01_throttle.wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 1,
		
		--
		snd_horn = "left4dead/vehicles/tractor01_horn.wav",
		
		DifferentialGear = 0.08,
		Gears = {-0.23,0,0.18,0.35,0.5}
	}
}
list.Set( "simfphys_vehicles", "sim_fphys_l4d_tractor01", V )

local light_table = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(115.7,14,72.6),
	L_HeadLampAng = Angle(15,0,0),
	R_HeadLampPos = Vector(115.7,-14,72.6),
	R_HeadLampAng = Angle(8,0,0),
	
-- projected texture - rear
	L_RearLampPos = Vector(-129.3,59,110.6),
	L_RearLampAng = Angle(25,180,0),
	R_RearLampPos = Vector(-129.3,-59,110.6),
	R_RearLampAng = Angle(25,180,0),
	
	
	Headlight_sprites = {   -- lowbeam
		{
			pos = Vector(115.7,14,72.6),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
		{
			pos = Vector(115.7,-14,72.6),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
	},
	
	Rearlight_sprites = {
		{
			pos = Vector(-129.3,59,110.6),
			material = "l4d/corona",
			size = 70,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-129.3,-59,110.6),
			material = "l4d/corona",
			size = 70,
			color = Color(255,0,0,150),
		}
	},
	
	Brakelight_sprites = {
		{
			pos = Vector(-129.3,53,110.6),
			material = "l4d/corona",
			size = 70,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-129.3,-53,110.6),
			material = "l4d/corona",
			size = 70,
			color = Color(255,0,0,150),
		}
	},
	
	Headlamp_sprites = {
		{pos = Vector(115.7,14,72.6),size = 100,material = "l4d/corona"},
		{pos = Vector(115.7,-14,72.6),size = 100,material = "l4d/corona"},
	},
	
	
	DelayOn = 0,
	DelayOff = 0,
	
	SubMaterials = {
		off = {
			Base = {
				[3] = "",
				[2] = "",
			},
			Brake = {
				[3] = "",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[3] = "",
				[2] = "",
			},
			Brake_Reverse = {
				[3] = "",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_lowbeam = {
			Base = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_highbeam = {
			Base = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
	},
}
list.Set( "simfphys_lights", "tractor01", light_table)