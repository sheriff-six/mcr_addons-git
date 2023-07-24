local V = {
	Name = "HMMWV",
	Model = "models/left4dead/vehicles/hmmwv.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "L4D - Government",
	SpawnOffset = Vector(0,0,0),
	SpawnAngleOffset = 90,
	NAKGame = "Left 4 Dead 2",
	NAKType = "Government",
	FLEX = {
		Trailers = {
			outputPos = Vector(-105,0,28),
			outputType = "ballsocket"
		}
	},

	Members = {
		Mass = 2150,
		
		MaxHealth = 4250,
		
		EnginePos = Vector(100,0,42.5),
		
		LightsTable = "hmmwv",
		
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		
		IsArmored = true,
		BulletProofTires = true,
		
		OnSpawn = function(ent)
			
			ent.fdoornum = 0
			ent.fdoorMoving = false
			
			ent.fdoorstate = 0
			ent.LastThink = 0
			ent.ChangeRate = 1
		end,
		
		OnTick = function(ent)
			local function Approach(Target)
				local now = CurTime()
				local timepassed = now - ent.LastThink
				ent.LastThink = now

				ent.fdoorstate = math.Approach( ent.fdoorstate, Target, ent.ChangeRate * timepassed )
			end
			
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
						ent.LastThink = CurTime()
						sound.Play( "left4dead/vehicles/ambulance_rear_open.wav", ent:GetPos())
						--ent.doormdl:SetNotSolid(true)
						timer.Simple(1, function()
							if IsValid(ent) then
								ent.fdoorMoving = false
							end
						end )
					elseif not ent.fdoorMoving then
						ent.fdoorMoving = true
						ent.fdoornum = 0
						ent.fdoorstate = 1
						ent.LastThink = CurTime()
						sound.Play( "left4dead/vehicles/ambulance_rear_close.wav", ent:GetPos())
						--ent.doormdl:SetNotSolid(false)
						timer.Simple(1, function()
							if IsValid(ent) then
								ent.fdoorMoving = false
							end
						end )
					end
				end
				
				if ent.fdoorMoving then
					Approach(ent.fdoornum)
					ent:SetPoseParameter( "rear_door", ent.fdoorstate)
				end
			end
			
			dooranim()
		end,
		
		CustomWheelModel = "models/left4dead/vehicles/wheel_hmmwv.mdl",
		CustomWheelPosFL = Vector(77.4,43,10),
		CustomWheelPosFR = Vector(77.4,-43,10),
		CustomWheelPosRL = Vector(-71.9,43,10),
		CustomWheelPosRR = Vector(-71.9,-43,10),
		CustomWheelAngleOffset = Angle(0,270,0),
		
		CustomMassCenter = Vector(0,0,0),
		
		CustomSteerAngle = 30,
		
		SeatOffset = Vector(4,-34,62),
		SeatPitch = 0,
		SeatYaw = 90,
		
		--!!!!!!!!!!!RANDYS EXTRA FUNCTIONS!!!!!!!!!!!!!
		
		AllowRandomSkins = true,
		RandomSkinRange = {0,3},
		
		ForceAlarm = true,
		
		snd_starter = "left4dead/vehicles/hmmwv_ignition_start.wav",
		snd_starter_good = "left4dead/vehicles/hmmwv_ignition_good.wav",
		snd_starter_bad = "left4dead/vehicles/hmmwv_ignition_bad.wav",
		snd_stop = "left4dead/vehicles/hmmwv_stop.wav",
		
		--!!!!!!!!!!!END RANDYS EXTRA FUNCTIONS!!!!!!!!!!
		
		PassengerSeats = {
			{
				pos = Vector(10,-31,31),
				ang = Angle(0,-90,10)
			},
			{
				pos = Vector(-34,31,31),
				ang = Angle(0,-90,10)
			},
			{
				pos = Vector(-34,-31,31),
				ang = Angle(0,-90,10)
			},
		},
		
		FrontHeight = 5,
		FrontConstant = 24000,
		FrontDamping = 2000,
		FrontRelativeDamping = 25,
		
		RearHeight = 5,
		RearConstant = 24000,
		RearDamping = 2000,
		RearRelativeDamping = 25,
		
		FastSteeringAngle = 30,
		SteeringFadeFastSpeed = 535,
		
		TurnSpeed = 3,
		
		MaxGrip = 54,
		Efficiency = 1,
		GripOffset = 1.5,
		BrakePower = 35,
		
		IdleRPM = 800,
		LimitRPM = 4000,
		PeakTorque = 130,
		PowerbandStart = 1500,
		PowerbandEnd = 3000,
		Turbocharged = false,
		Supercharged = false,
		
		FuelFillPos = Vector(-52,-48.25,46.6),
		FuelType = 2,
		FuelTankSize = 120,
		
		PowerBias = 0,
		
		EngineSoundPreset = 0,

		
		Sound_Idle = "left4dead/vehicles/hmmwv_idle.wav",
		Sound_IdlePitch = 1,
		
		Sound_Mid = "left4dead/vehicles/hmmwv_low.wav",
		Sound_MidPitch = 1.2,
		Sound_MidVolume = 1,
		Sound_MidFadeOutRPMpercent = 70,
		Sound_MidFadeOutRate = 0.5,
		
		Sound_High = "left4dead/vehicles/hmmwv_high.wav",
		Sound_HighPitch = 1.2,
		Sound_HighVolume = 1.5,
		Sound_HighFadeInRPMpercent = 70,
		Sound_HighFadeInRate = 0.5,
		
		Sound_Throttle = "left4dead/vehicles/hmmwv_throttle.wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 3,
		
		--
		snd_horn = "left4dead/vehicles/hmmwv_horn.wav",
		
		DifferentialGear = 0.15,
		Gears = {-0.35,0,0.15,0.22,0.29,0.37,0.49,0.6,0.79}
	}
}
list.Set( "simfphys_vehicles", "sim_fphys_l4d_hmmwv", V )

local light_table = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(102.8,23.4,41.3),
	L_HeadLampAng = Angle(0,0,0),
	R_HeadLampPos = Vector(102.8,-23.4,41.3),
	R_HeadLampAng = Angle(0,0,0),
	
	-- projected texture - rear
	L_RearLampPos = Vector(-109.1,37.3,44.7),
	L_RearLampAng = Angle(25,180,0),
	R_RearLampPos = Vector(-109.1,-37.3,44.7),
	R_RearLampAng = Angle(25,180,0),
	
	Headlight_sprites = {   -- lowbeam
		{
			pos = Vector(102.8,23.4,41.3),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
		{
			pos = Vector(102.8,-23.4,41.3),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
		
		{
			pos = Vector(93,49.4,45.7),
			material = "l4d/corona",
			size = 40,
			color = Color(255,136,0,150),
		},
		{
			pos = Vector(93,-49.4,45.7),
			material = "l4d/corona",
			size = 40,
			color = Color(255,136,0,150),
		},
		{
			pos = Vector(-101.6,50.6,37.2),
			material = "l4d/corona",
			size = 40,
			color = Color(255,136,0,150),
		},
		{
			pos = Vector(-101.6,-50.6,37.2),
			material = "l4d/corona",
			size = 40,
			color = Color(255,136,0,150),
		},
	},
	
	Headlamp_sprites = {
		{pos = Vector(102.8,23.4,41.3),size = 100,material = "l4d/corona"},
		{pos = Vector(102.8,-23.4,41.3),size = 100,material = "l4d/corona"},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-109.1,37.3,44.7),
			material = "l4d/corona",
			size = 70,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-109.1,-37.3,44.7),
			material = "l4d/corona",
			size = 70,
			color = Color(255,0,0,150),
		}
	},
	Brakelight_sprites = {
		{
			pos = Vector(-109.1,37.3,44.7),
			material = "l4d/corona",
			size = 60,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-109.1,-37.3,44.7),
			material = "l4d/corona",
			size = 60,
			color = Color(255,0,0,150),
		}
	},
	
	
	DelayOn = 0,
	DelayOff = 0,
	
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(102.4,42.4,45.7),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
			{
				pos = Vector(-109,45.6,39.7),
				material = "l4d/corona",
				size = 50,
				color = Color(255,0,0,150),
			},
		},
		Right = {
			{
				pos = Vector(102.4,-42.4,45.7),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
			{
				pos = Vector(-109,-45.6,39.7),
				material = "l4d/corona",
				size = 50,
				color = Color(255,0,0,150),
			},
		},
	},
	
	SubMaterials = {
		off = {
			Base = {
				[3] = "",
				[6] = "",
			},
			Brake = {
				[3] = "",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[3] = "",
				[6] = "",
			},
			Brake_Reverse = {
				[3] = "",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_lowbeam = {
			Base = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_highbeam = {
			Base = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		turnsignals = {
			left = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			right = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
	}
}
list.Set( "simfphys_lights", "hmmwv", light_table)