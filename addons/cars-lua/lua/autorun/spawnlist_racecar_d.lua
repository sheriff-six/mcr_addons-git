local V = {
	Name = "Jimmy Gibs' Damaged Stock Car",
	Model = "models/left4dead/vehicles/racecar_damaged.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "L4D - Special",
	SpawnOffset = Vector(0,0,0),
	SpawnAngleOffset = 90,

	Members = {
		Mass = 1500,
		
		EnginePos = Vector(80,0,35),
		
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		
		CustomWheelModel = "models/left4dead/vehicles/wheel2_racecar_f.mdl",
		CustomWheelModel_R = "models/left4dead/vehicles/wheel2_racecar_r.mdl",
		
		CustomWheelPosFL = Vector(79.5,37,11),
		CustomWheelPosFR = Vector(79.5,-37,11),
		CustomWheelPosRL = Vector(-66,38,11),
		CustomWheelPosRR = Vector(-66,-38,11),
		CustomWheelAngleOffset = Angle(0,90,0),
		
		CustomMassCenter = Vector(0,0,0),
		
		CustomSteerAngle = 30,
		
		LightsTable = "racecar_d",
		
		SeatOffset = Vector(4,-17,45),
		SeatPitch = -4,
		SeatYaw = 90,
		
		OnSpawn = function(ent) ent:SetCurHealth( 800 ) end,
		
		--!!!!!!!!!!!RANDYS EXTRA FUNCTIONS!!!!!!!!!!!!!

		SimpleIgnition = true,
		
		NoAlarm = true,
		
		--!!!!!!!!!!!END RANDYS EXTRA FUNCTIONS!!!!!!!!!!
		
		ExhaustPositions = {
			{
				pos = Vector(-125,18.8,12),
				ang = Angle(90,180,0),
			},
			{
				pos = Vector(-125,-18.8,12),
				ang = Angle(90,180,0),
			},
		},
		
		FrontHeight = 7,
		FrontConstant = 24000,
		FrontDamping = 2000,
		FrontRelativeDamping = 800,
		
		RearHeight = 7,
		RearConstant = 24000,
		RearDamping = 2000,
		RearRelativeDamping = 800,
		
		FastSteeringAngle = 5,
		SteeringFadeFastSpeed = 1000,
		
		TurnSpeed = 3,
		
		MaxGrip = 50,
		Efficiency = 1,
		GripOffset = 1.5,
		BrakePower = 50,
		
		IdleRPM = 800,
		LimitRPM = 5000,
		PeakTorque = 230,
		PowerbandStart = 1000,
		PowerbandEnd = 4000,
		Turbocharged = true,
		Supercharged = false,
		
		FuelFillPos = Vector(-88.8,-35.4,42.8),
		FuelType = 2,
		FuelTankSize = 250,
		
		PowerBias = 1,
		
		EngineSoundPreset = 0,

		
		Sound_Idle = "left4dead/vehicles/racecar_idle.wav",
		Sound_IdlePitch = 1,
		
		Sound_Mid = "left4dead/vehicles/racecar_low.wav",
		Sound_MidPitch = 1,
		Sound_MidVolume = 2,
		Sound_MidFadeOutRPMpercent = 40,
		Sound_MidFadeOutRate = 0.5,
		
		Sound_High = "left4dead/vehicles/racecar_high.wav",
		Sound_HighPitch = 0.8,
		Sound_HighVolume = 3,
		Sound_HighFadeInRPMpercent = 40,
		Sound_HighFadeInRate = 0.5,
		
		Sound_Throttle = "left4dead/vehicles/racecar_throttle.wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 5,
		
		--
		snd_horn = "left4dead/vehicles/racecar_horn.wav",
		
		DifferentialGear = 0.5,
		Gears = {-0.1,0,0.13,0.25,0.37,0.55}
	}
}
list.Set( "simfphys_vehicles", "sim_fphys_l4d_racecar_d", V )

local light_table = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(122,28.6,11.4),
	L_HeadLampAng = Angle(0,-7,0),
	R_HeadLampPos = Vector(122,-28.6,11.4),
	R_HeadLampAng = Angle(0,8,0),
	
	Headlight_sprites = {   -- lowbeam
		{
			pos = Vector(122,28.6,11.4),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
		{
			pos = Vector(122,-28.6,11.4),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
	},
	
	Headlamp_sprites = {
		{pos = Vector(122,28.6,11.4),size = 100,material = "l4d/corona"},
		{pos = Vector(122,-28.6,11.4),size = 100,material = "l4d/corona"},
	},
	
	SubMaterials = {
		off = {
			Base = {
				[3] = "",
			},
			Brake = {
				[3] = "",
			},
			Reverse = {
				[3] = "",
			},
			Brake_Reverse = {
				[3] = "",
			},
		},
		on_lowbeam = {
			Base = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_highbeam = {
			Base = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
	},
}
list.Set( "simfphys_lights", "racecar_d", light_table)