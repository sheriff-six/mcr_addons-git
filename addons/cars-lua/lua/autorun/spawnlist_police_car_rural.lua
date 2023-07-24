local V = {
	Name = "Police Car (Rural)",
	Model = "models/left4dead/vehicles/police_car_city.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "L4D - Government",
	SpawnOffset = Vector(0,0,0),
	SpawnAngleOffset = 90,
	NAKGame = "Left 4 Dead 2",
	NAKType = "Government",
	
	Members = {
		Mass = 2000,
		
		EnginePos = Vector(104,0,30),
		
		LightsTable = "police_city",
		
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		
		CustomWheelModel = "models/left4dead/vehicles/wheel_policecar.mdl",
		CustomWheelPosFL = Vector(73.3,33.8,9),
		CustomWheelPosFR = Vector(73.3,-33.8,9),
		CustomWheelPosRL = Vector(-58.5,33.8,9),
		CustomWheelPosRR = Vector(-58.5,-33.8,9),
		CustomWheelAngleOffset = Angle(0,270,0),
		
		CustomMassCenter = Vector(0,0,0),
		
		CustomSteerAngle = 30,
		
		SeatOffset = Vector(-2,-17,48),
		SeatPitch = 0,
		SeatYaw = 90,
		
		ModelInfo = {
			Skin = 1,
		},
		
		--!!!!!!!!!!!RANDYS EXTRA FUNCTIONS!!!!!!!!!!!!!
		
		ForceAlarm = true,
		
		HasBullhorn = true,
		
		PolRadioSound = "Simf_PolRadio",
		
		snd_starter = "left4dead/vehicles/vic_ignition_start.wav",
		snd_starter_good = "left4dead/vehicles/vic_ignition_good.wav",
		snd_starter_bad = "left4dead/vehicles/vic_ignition_bad.wav",
		snd_stop = "left4dead/vehicles/vic_stop.wav",
		
		--!!!!!!!!!!!END RANDYS EXTRA FUNCTIONS!!!!!!!!!!
		
		PassengerSeats = {
			{
				pos = Vector(8,-17,15),
				ang = Angle(0,-90,10)
			},
			{
				pos = Vector(-34,17,16),
				ang = Angle(0,-90,10)
			},
			{
				pos = Vector(-34,-17,16),
				ang = Angle(0,-90,10)
			},
		},
		
		ExhaustPositions = {
			{
				pos = Vector(-104.5,18.8,13),
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
		
		FastSteeringAngle = 30,
		SteeringFadeFastSpeed = 535,
		
		TurnSpeed = 3,
		
		MaxGrip = 54,
		Efficiency = 1,
		GripOffset = 1.5,
		BrakePower = 35,
		
		IdleRPM = 800,
		LimitRPM = 5000,
		PeakTorque = 160,
		PowerbandStart = 1500,
		PowerbandEnd = 4000,
		Turbocharged = false,
		Supercharged = false,
		
		FuelFillPos = Vector(-75,-39,32.8),
		FuelType = 1,
		FuelTankSize = 100,
		
		PowerBias = 1,
		
		EngineSoundPreset = 0,

		
		Sound_Idle = "left4dead/vehicles/vic_idle.wav",
		Sound_IdlePitch = 1,
		
		Sound_Mid = "left4dead/vehicles/vic_low.wav",
		Sound_MidPitch = 1.2,
		Sound_MidVolume = 1,
		Sound_MidFadeOutRPMpercent = 70,
		Sound_MidFadeOutRate = 0.5,
		
		Sound_High = "left4dead/vehicles/vic_high.wav",
		Sound_HighPitch = 1.2,
		Sound_HighVolume = 1.5,
		Sound_HighFadeInRPMpercent = 70,
		Sound_HighFadeInRate = 0.5,
		
		Sound_Throttle = "left4dead/vehicles/vic_throttle.wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 3,
		
		--
		snd_horn = "left4dead/vehicles/vic_horn.wav",
		
		DifferentialGear = 0.5,
		Gears = {-0.18,0,0.095,0.15,0.23,0.37,0.65}
	}
}
list.Set( "simfphys_vehicles", "sim_fphys_l4d_police_rural", V )