local V = {
	Name = "M119 Howitzer",
	Model = "models/left4dead/vehicles/M119Howitzer_01.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "L4D - Government",
	SpawnOffset = Vector(0,0,0),
	SpawnAngleOffset = 90,
	NAKGame = "Left 4 Dead 2",
	NAKType = "Trailers",
	FLEX = {
		Trailers = {
			inputPos = Vector(125,0,24),
			inputType = "ballsocket",
		}
	},
	
	Members = {
		Mass = 1000.0,
		
		EnginePos = Vector(0,0,0),
		
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
			
		CustomWheelModel = "models/left4dead/vehicles/howitzer_wheel.mdl",
		CustomWheelModel_R = "models/left4dead/vehicles/howitzer_nowheel.mdl",
		
		CustomWheelPosFL = Vector(0,35,20),
		CustomWheelPosFR = Vector(0,-35,20),	
		CustomWheelPosRL = Vector(4,5,39),
		CustomWheelPosRR = Vector(4,-5,39),
		CustomWheelAngleOffset = Angle(0,90,0),
		
		FrontWheelRadius = 20,
		RearWheelRadius = 5,
		
		CustomMassCenter = Vector(0,0,10),		
		
		CustomSteerAngle = 60,
		
		--!!!!!!!!!!!RANDYS EXTRA FUNCTIONS!!!!!!!!!!!!!

		IsTrailer = true,
		
		NoAlarm = true,
		
		--!!!!!!!!!!!END RANDYS EXTRA FUNCTIONS!!!!!!!!!!
		
		SeatOffset = Vector(0,0,0),
		SeatPitch = 0,
		SeatYaw = 90,
		
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
	list.Set( "simfphys_vehicles", "sim_fphys_l4d_howitzer", V )
end