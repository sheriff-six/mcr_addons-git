local V = {
	Name = "Longnose Bus",
	Model = "models/left4dead/vehicles/church_bus.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "L4D - Services",
	SpawnOffset = Vector(0,0,0),
	SpawnAngleOffset = 90,
	NAKGame = "Left 4 Dead 2",
	NAKType = "Services",

	Members = {
		Mass = 3525,
		
		EnginePos = Vector(205,0,38),
		
		LightsTable = "cbus",
		
		CustomWheels = true,
		CustomSuspensionTravel = 2,
		
		CustomWheelModel = "models/left4dead/vehicles/wheel_bus2_f.mdl",
		CustomWheelModel_R = "models/left4dead/vehicles/wheel_bus2_r.mdl",
		
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
			
			local ply = ent:GetDriver()
			
			if !IsValid(ent) then return end
			if !IsValid(ent:GetDriver()) then return end --if there is no driver, end the script, otherwise it would error
			if !ply:IsPlayer() then return end --checks if the driver is an actual player, not an AI
			
			local function dooranim()
				if ply:KeyDown( 1 ) and IsValid(ent:GetDriver()) then
					if ent.fdoornum == 0 and not ent.fdoorMoving then
						ent.fdoorMoving = true
						ent.fdoornum = 1
						ent.fdoorstate = 0
						ent.LastThink = CurTime()
						sound.Play( "left4dead/vehicles/bus_fdoor_open.wav", ent:GetPos())
						timer.Simple(1, function()
							if IsValid(ent) then
								ent.fdoorMoving = false
							end
						end )
					elseif not ent.fdoorMoving then
						ent:SetPoseParameter( "front_door", ent.fdoorstate)
						ent.fdoorMoving = true
						ent.fdoornum = 0
						ent.fdoorstate = 1
						ent.LastThink = CurTime()
						sound.Play( "left4dead/vehicles/bus_fdoor_close.wav", ent:GetPos())
						timer.Simple(1, function()
							if IsValid(ent) then
								ent.fdoorMoving = false
							end
						end )
					end
				end
				
				if ent.fdoorMoving then
					Approach(ent.fdoornum)
					ent:SetPoseParameter( "front_door", ent.fdoorstate)
				end
				
				if IsValid(ply) then
					if ply:GetInfoNum( "cl_simfphys_bus_safety_brakes", 0 ) == 1 then
						if ent.fdoorstate > 0.1 then
							ent.PressedKeys["joystick_handbrake"] = 1
						end
					end
				end
			end
			
			local ConVarValue = ply:GetInfoNum( "cl_simfphys_bus_safety_brakes", 0 )
			
			if ConVarValue == 1 then
				if ent.ForwardSpeed < 100 then
					dooranim()
				end
			else
				dooranim()
			end
		end,
		
		CustomWheelPosFL = Vector(180,47,10),
		CustomWheelPosFR = Vector(180,-47,10),
		CustomWheelPosRL = Vector(-98.9,43,10),
		CustomWheelPosRR = Vector(-98.9,-43,10),
		CustomWheelAngleOffset = Angle(0,270,0),
		
		CustomSteerAngle = 50,
		
		CustomMassCenter = Vector(0,0,50),
		
		SeatOffset = Vector(88,-27,102),
		SeatPitch = 10,
		SeatYaw = 90,
		
		--!!!!!!!!!!!RANDYS EXTRA FUNCTIONS!!!!!!!!!!!!!
		
		LPMountFront = Vector(212.3,0,27),
		LPMountRear = Vector(-241.9,36.8,45.7),
		LPGroup = Plates_L4D,
		
		AllowRandomSkins = true,
		RandomSkinRange = {0,1},
		
		HasAirbrakes = true,
		
		snd_starter = "left4dead/vehicles/bus_ignition_start.wav",
		snd_starter_good = "left4dead/vehicles/bus_ignition_good.wav",
		snd_starter_bad = "left4dead/vehicles/bus_ignition_bad.wav",
		snd_stop = "left4dead/vehicles/bus_stop.wav",
		snd_reverse_beep = "left4dead/vehicles/bus_rev_beep.wav",
		
		--!!!!!!!!!!!END RANDYS EXTRA FUNCTIONS!!!!!!!!!!
		
		PassengerSeats = {
			{
				pos = Vector(60,-35.4,50),
				ang = Angle(0,-90,0)
			},
			{
				pos = Vector(20,35.4,50),
				ang = Angle(0,-90,0)
			},
			{
				pos = Vector(-19,-35.4,50),
				ang = Angle(0,-90,0)
			},
			{
				pos = Vector(-57,35.4,50),
				ang = Angle(0,-90,0)
			},
			{
				pos = Vector(-96,-35.4,50),
				ang = Angle(0,-90,0)
			},
			{
				pos = Vector(-136,35.4,50),
				ang = Angle(0,-90,0)
			},
			{
				pos = Vector(-174,-35.4,50),
				ang = Angle(0,-90,0)
			},
			{
				pos = Vector(-214,35.4,50),
				ang = Angle(0,-90,0)
			},
		},
		
		ExhaustPositions = {
			{
				pos = Vector(-229,56,23),
				ang = Angle(90,90,0),
			},
			{
				pos = Vector(-229,56,23),
				ang = Angle(90,90,0),
			},
		},
		
		FrontHeight = 2,
		FrontConstant = 24000,
		FrontDamping = 2500,
		FrontRelativeDamping = 4000,
		
		RearHeight = 2,
		RearConstant = 24000,
		RearDamping = 2500,
		RearRelativeDamping = 4000,
		
		FastSteeringAngle = 30,
		SteeringFadeFastSpeed = 100,
		
		TurnSpeed = 3,
		
		MaxGrip = 62,
		Efficiency = 1,
		GripOffset = 1.5,
		BrakePower = 40,
		
		IdleRPM = 800,
		LimitRPM = 5000,
		PeakTorque = 80,
		PowerbandStart = 1500,
		PowerbandEnd = 3000,
		Turbocharged = false,
		Supercharged = true,
		
		FuelFillPos = Vector(-200,51.3,37.1),
		FuelType = 2,
		FuelTankSize = 110,
		
		PowerBias = 1,
		
		EngineSoundPreset = 0,

		
		Sound_Idle = "left4dead/vehicles/bus_idle.wav",
		Sound_IdlePitch = 1,
		
		Sound_Mid = "left4dead/vehicles/bus_low.wav",
		Sound_MidPitch = 1,
		Sound_MidVolume = 2,
		Sound_MidFadeOutRPMpercent = 40,
		Sound_MidFadeOutRate = 0.5,
		
		Sound_High = "left4dead/vehicles/bus_high.wav",
		Sound_HighPitch = 1,
		Sound_HighVolume = 1.5,
		Sound_HighFadeInRPMpercent = 40,
		Sound_HighFadeInRate = 0.5,
		
		Sound_Throttle = "left4dead/vehicles/bus_throttle.wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 5,
		
		--
		snd_horn = "left4dead/vehicles/bus_horn.wav",
		snd_bloweron = "left4dead/vehicles/bus_turbo.wav",
		snd_bloweroff = "common/null.wav",
		
		DifferentialGear = 0.5,
		Gears = {-0.075,0,0.055,0.125,0.2,0.275,0.375}
	}
}
list.Set( "simfphys_vehicles", "sim_fphys_l4d_cbus", V )

local light_table = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(211,44,38),
	L_HeadLampAng = Angle(0,0,0),
	R_HeadLampPos = Vector(211,-44,38),
	R_HeadLampAng = Angle(0,0,0),
	
	-- projected texture - rear
	L_RearLampPos = Vector(-242,37,67),
	L_RearLampAng = Angle(25,180,0),
	R_RearLampPos = Vector(-242,-37,67),
	R_RearLampAng = Angle(25,180,0),
	
	Headlight_sprites = {   -- lowbeam
		{
			pos = Vector(211,44,38),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
		{
			pos = Vector(211,-44,38),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
		{
			pos = Vector(148,-14,125),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(148,14,125),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(148,0,125.4),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(139,-54.4,108),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(139,54.4,108),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		
		{
			pos = Vector(-233,56,108),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(-233,-56,108),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		
		{
			pos = Vector(103,56,45),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(103,-56,45),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
	},
	
	Headlamp_sprites = {
		{pos = Vector(211,35,38),size = 100,material = "l4d/corona"},
		{pos = Vector(211,-35,38),size = 100,material = "l4d/corona"},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-242,37,67),
			material = "l4d/corona",
			size = 80,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-242,-37,67),
			material = "l4d/corona",
			size = 80,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-59.2,57,36.3),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(-59.2,-57,36.3),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(-226.6,57,36.3),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(-226.6,-57,36.3),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(-240.4,7.6,125.5),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(-240.4,-7.6,125.5),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(-240.4,0,125.5),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
	},
	Brakelight_sprites = {
		{
			pos = Vector(-242,37,67),
			material = "l4d/corona",
			size = 100,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-242,-37,67),
			material = "l4d/corona",
			size = 100,
			color = Color(255,0,0,150),
		},
	},
	Reverselight_sprites = {
		{
			pos = Vector(-242,29,67),
			material = "l4d/corona",
			size = 60,
			color = Color(255,255,255,150),
		},
		{
			pos = Vector(-242,-29,67),
			material = "l4d/corona",
			size = 60,
			color = Color(255,255,255,150),
		},
	},
	
	DelayOn = 0,
	DelayOff = 0,
	
	ems_sounds = {"common/null.wav"},
	ems_sprites = {
		{
			pos = Vector(147,32,113),
			material = "l4d/corona",
			size = 90,
			Colors = {
						Color(255,135,66,255),
						Color(255,135,66,0),
					},
			Speed = 0.75
		},
		{
			pos = Vector(147,43,113),
			material = "l4d/corona",
			size = 90,
			Colors = {
						Color(255,135,66,0),
						Color(255,135,66,255),
					},
			Speed = 0.75
		},
		{
			pos = Vector(147,-32,113),
			material = "l4d/corona",
			size = 90,
			Colors = {
						Color(255,135,66,255),
						Color(255,135,66,0),
					},
			Speed = 0.75
		},
		{
			pos = Vector(147,-43,113),
			material = "l4d/corona",
			size = 90,
			Colors = {
						Color(255,135,66,0),
						Color(255,135,66,255),
					},
			Speed = 0.75
		},
		{
			pos = Vector(-239,32,113),
			material = "l4d/corona",
			size = 90,
			Colors = {
						Color(255,135,66,255),
						Color(255,135,66,0),
					},
			Speed = 0.75
		},
		{
			pos = Vector(-239,43,113),
			material = "l4d/corona",
			size = 90,
			Colors = {
						Color(255,135,66,0),
						Color(255,135,66,255),
					},
			Speed = 0.75
		},
		{
			pos = Vector(-239,-32,113),
			material = "l4d/corona",
			size = 90,
			Colors = {
						Color(255,135,66,255),
						Color(255,135,66,0),
					},
			Speed = 0.75
		},
		{
			pos = Vector(-239,-43,113),
			material = "l4d/corona",
			size = 90,
			Colors = {
						Color(255,135,66,0),
						Color(255,135,66,255),
					},
			Speed = 0.75
		},
		{
			pos = Vector(-231,0,133),
			material = "l4d/corona",
			size = 90,
			Colors = {
						Color(255,135,66,255),
						Color(255,135,66,255),
					},
			Speed = 0.75
		},
	},
	
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(185,45,57),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
			{
				pos = Vector(-242,46,67),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
		},
		Right = {
			{
				pos = Vector(185,-45,57),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
			{
				pos = Vector(-242,-46,67),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
		},
	},
	
	SubMaterials = {
		off = {
			Base = {
				[6] = "",
				[7] = "",
				[8] = "",
				[9] = "",
			},
			Brake = {
				[6] = "",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "",
				[9] = "",
			},
			Reverse = {
				[6] = "",
				[7] = "",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
				[9] = "",
			},
			Brake_Reverse = {
				[6] = "",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
				[9] = "",
			},
		},
		on_lowbeam = {
			Base = {
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "",
				[9] = "",
			},
			Brake = {
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "",
				[9] = "",
			},
			Reverse = {
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
				[9] = "",
			},
			Brake_Reverse = {
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
				[9] = "",
			},
		},
		on_highbeam = {
			Base = {
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "",
				[9] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake = {
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "",
				[9] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
				[9] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
				[9] = "models/left4dead/vehicles/4carz1024_lights_on",
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
list.Set( "simfphys_lights", "cbus", light_table)