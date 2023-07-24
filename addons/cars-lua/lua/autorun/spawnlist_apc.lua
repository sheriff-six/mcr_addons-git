local V = {
	Name = "APC",
	Model = "models/left4dead/vehicles/apc_body.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "L4D - Government",
	SpawnOffset = Vector(0,0,0),
	SpawnAngleOffset = 90,
	NAKGame = "Left 4 Dead 2",
	NAKType = "Government",
	
	Members = {
		Mass = 5525,
		
		OnSpawn = function(ent)
        	ent:SetNWInt("_direction_", 0)
        	ent:SetNWInt("__SetBuoyancyRatio__", 1)
        	ent:SetNWBool("_can_swim__", true)
        	ent:SetNWBool("_isboat", false)
		end,
		
		MaxHealth = 7525,
		
		EnginePos = Vector(39.7,77.4,99.5),
		
		LightsTable = "apc",
		
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		
		OnSpawn = function(ent)
			ent.fdoornum = 0
			ent.fdoorMoving = false
			
			ent.fdoorstate = 0
		end,
		
		OnTick = function(ent)
			
			local function dooranim()
				local ply = ent:GetDriver()
			
				if !IsValid(ent) then return end
				if !IsValid(ent:GetDriver()) then return end --if there is no driver, end the script, otherwise it would error
				if !ply:IsPlayer() then return end --checks if the driver is an actual player, not an AI
				
				if ply:KeyDown( 1 ) and IsValid(ent:GetDriver()) then
					if ent.fdoornum == 0 and not ent.fdoorMoving then
						ent.fdoorMoving = true
						ent.fdoornum = 1
						ent.fdoorstate = 0
						sound.Play( "left4dead/vehicles/apc_rear_open.wav", ent:GetPos())
						ent:PlayAnimation("open")
						--ent.doormdl:SetNotSolid(true)
						timer.Simple(5, function()
							if IsValid(ent) then
								ent.fdoorMoving = false
							end
						end )
					elseif not ent.fdoorMoving then
						ent.fdoorMoving = true
						ent.fdoornum = 0
						ent.fdoorstate = 1
						sound.Play( "left4dead/vehicles/apc_rear_close.wav", ent:GetPos())
						ent:PlayAnimation("close")
						--ent.doormdl:SetNotSolid(false)
						timer.Simple(3, function()
							if IsValid(ent) then
								ent.fdoorMoving = false
							end
						end )
					end
				end
			end
			
			dooranim()
		end,
		
		IsArmored = true,
		BulletProofTires = true,
		
		CustomWheelModel = "models/left4dead/vehicles/wheel_apc.mdl",
		
		CustomWheelPosFL = Vector(89,70.5,35),
		CustomWheelPosFR = Vector(89,-70.5,35),	
		CustomWheelPosML = Vector(-10.7,70.5,36),
		CustomWheelPosMR = Vector(-10.7,-70.5,36),
		CustomWheelPosRL = Vector(-106.3,70.5,35),
		CustomWheelPosRR = Vector(-106.3,-70.5,35),
		CustomWheelAngleOffset = Angle(0,-90,0),
		
		CustomMassCenter = Vector(0,0,0),		
		
		CustomSteerAngle = 35,
		
		SeatOffset = Vector(90,-21,126),
		SeatPitch = 10,
		SeatYaw = 90,
		
		--!!!!!!!!!!!RANDYS EXTRA FUNCTIONS!!!!!!!!!!!!!
		
		HasAirbrakes = true,
		
		NoAlarm = true,
		
		snd_starter = "left4dead/vehicles/apc_ignition_start.wav",
		snd_starter_good = "left4dead/vehicles/apc_ignition_good.wav",
		snd_starter_bad = "left4dead/vehicles/apc_ignition_bad.wav",
		snd_stop = "left4dead/vehicles/apc_stop.wav",
		
		--!!!!!!!!!!!END RANDYS EXTRA FUNCTIONS!!!!!!!!!!
		
		ExhaustPositions = {
			{
				pos = Vector(39.7,75,106),
				ang = Angle(125,90,0),
			},
			{
				pos = Vector(39.7,79,94.6),
				ang = Angle(125,90,0),
			},
			{
				pos = Vector(39.7,-75,106),
				ang = Angle(125,-90,0),
			},
			{
				pos = Vector(39.7,-79,94.6),
				ang = Angle(125,-90,0),
			},
		},
		
		PassengerSeats = {
			{
				pos = Vector(112,-21,75),
				ang = Angle(0,-90,0)
			},
			{
				pos = Vector(7.6,-28,70),
				ang = Angle(0,0,0)
			},
			{
				pos = Vector(7.6,28,70),
				ang = Angle(0,180,0)
			},
			{
				pos = Vector(-87.1,41.2,70),
				ang = Angle(0,180,0)
			},
			{
				pos = Vector(-87.1,-41.2,70),
				ang = Angle(0,0,0)
			},
			{
				pos = Vector(-120.8,41.2,70),
				ang = Angle(0,180,0)
			},
			{
				pos = Vector(-120.8,-41.2,70),
				ang = Angle(0,0,0)
			},
		},
		Attachments = {
			{
				model = "models/left4dead/vehicles/apc_trim.mdl",
				color = Color(255,255,255,255),
				pos = Vector(0,0,0),
				ang = Angle(0,0,0)
			},
		},
		
		FrontHeight = 25,
		FrontConstant = 25000,
		FrontDamping = 2000,
		FrontRelativeDamping = 100,
		
		RearHeight = 25,
		RearConstant = 25000,
		RearDamping = 2000,
		RearRelativeDamping = 100,
		
		FastSteeringAngle = 35,
		SteeringFadeFastSpeed = 535,
		
		TurnSpeed = 3,
		
		MaxGrip = 150,
		Efficiency = 1,
		GripOffset = 0,
		BrakePower = 35,
		
		IdleRPM = 1200,
		LimitRPM = 5000,
		PeakTorque = 100,
		PowerbandStart = 1600,
		PowerbandEnd = 3000,
		Turbocharged = false,
		Supercharged = false,
		DoNotStall = false,
		
		FuelFillPos = Vector(-57.7,-73.8,52.4),
		FuelType = 2,
		FuelTankSize = 230,
		
		PowerBias = 0,
		
		EngineSoundPreset = 0,
		
		Sound_Idle = "left4dead/vehicles/apc_idle.wav",
		Sound_IdlePitch = 0.77,
		
		Sound_Mid = "left4dead/vehicles/apc_low.wav",
		Sound_MidPitch = 1,
		Sound_MidVolume = 1,
		Sound_MidFadeOutRPMpercent = 50,
		Sound_MidFadeOutRate = 0.3,
		
		Sound_High = "left4dead/vehicles/apc_high.wav",
		Sound_HighPitch = 1,
		Sound_HighVolume = 2,
		Sound_HighFadeInRPMpercent = 50,
		Sound_HighFadeInRate = 0.3,
		
		Sound_Throttle = "left4dead/vehicles/apc_throttle.wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 5,
		
		snd_horn = "left4dead/vehicles/hmmwv_horn.wav",
		
		DifferentialGear = 0.08,
		Gears = {-0.35,0,0.16,0.35,0.55}
	}
}
list.Set( "simfphys_vehicles", "sim_fphys_l4d_apc", V )

local light_table = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(167.1,66,65.2),
	L_HeadLampAng = Angle(0,0,0),
	R_HeadLampPos = Vector(167.1,-66,65.2),
	R_HeadLampAng = Angle(0,0,0),
	
	Headlight_sprites = {   -- lowbeam
		{
			pos = Vector(167.1,66,65.2),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
		{
			pos = Vector(167.1,-66,65.2),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
	},
	
	Headlamp_sprites = {
		{pos = Vector(167.1,66,65.2),size = 100,material = "l4d/corona"},
		{pos = Vector(167.1,-66,65.2),size = 100,material = "l4d/corona"},
		{pos = Vector(133.6,41,128),size = 150,material = "l4d/corona"},
		{pos = Vector(133.6,41,128),size = 50,color = Color(255,255,255,255),material = "l4d/corona"},
		{pos = Vector(133.6,-41,128),size = 150,material = "l4d/corona"},
		{pos = Vector(133.6,-41,128),size = 50,color = Color(255,255,255,255),material = "l4d/corona"},
	},
	
	DelayOn = 0,
	DelayOff = 0,
	
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(164.8,69.8,75.5),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
		},
		Right = {
			{
				pos = Vector(164.8,-69.8,75.5),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
		},
	},
	
	SubMaterials = {
		off = {
			Base = {
				[9] = "",
				[8] = "",
			},
			Brake = {
				[9] = "",
				[8] = "",
			},
			Reverse = {
				[9] = "",
				[8] = "",
			},
			Brake_Reverse = {
				[9] = "",
				[8] = "",
			},
		},
		on_lowbeam = {
			Base = {
				[9] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "",
			},
			Brake = {
				[9] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "",
			},
			Reverse = {
				[9] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "",
			},
			Brake_Reverse = {
				[9] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "",
			},
		},
		on_highbeam = {
			Base = {
				[9] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake = {
				[9] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[9] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[9] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		turnsignals = {
			left = {
				[10] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			right = {
				[7] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
	}
}
list.Set( "simfphys_lights", "apc", light_table)