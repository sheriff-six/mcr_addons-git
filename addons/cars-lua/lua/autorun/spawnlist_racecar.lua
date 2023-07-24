local V = {
	Name = "Jimmy Gibs Jr. Stock Car",
	Model = "models/left4dead/vehicles/racecar.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "L4D - Special",
	SpawnOffset = Vector(0,0,10),
	SpawnAngleOffset = 90,
	NAKGame = "Left 4 Dead 2",
	NAKType = "Special",

	Members = {
		Mass = 1500,
		
		EnginePos = Vector(80,0,35),
		
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		
		CustomWheelModel = "models/left4dead/vehicles/wheel_racecar_f.mdl",
		CustomWheelModel_R = "models/left4dead/vehicles/wheel_racecar_r.mdl",
		
		CustomWheelPosFL = Vector(79.5,37,11),
		CustomWheelPosFR = Vector(79.5,-37,11),
		CustomWheelPosRL = Vector(-66,38,11),
		CustomWheelPosRR = Vector(-66,-38,11),
		CustomWheelAngleOffset = Angle(0,90,0),
		
		CustomMassCenter = Vector(0,0,0),
		
		CustomSteerAngle = 30,
		
		SeatOffset = Vector(4,-17,45),
		SeatPitch = -4,
		SeatYaw = 90,
		
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
list.Set( "simfphys_vehicles", "sim_fphys_l4d_racecar", V )