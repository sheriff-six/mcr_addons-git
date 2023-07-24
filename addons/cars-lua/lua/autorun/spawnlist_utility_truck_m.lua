local V = {
	Name = "Maintenance Truck",
	Model = "models/left4dead/vehicles/utility_truck_m.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "L4D - Industrial",
	SpawnOffset = Vector(0,0,-10),
	SpawnAngleOffset = 90,
	NAKGame = "Left 4 Dead 2",
	NAKType = "Industrial",
	FLEX = {
		Trailers = {
			outputPos = Vector(-102.9,0,18),
			outputType = "ballsocket"
		}
	},
	
	Members = {
		Mass = 2700,
		
		EnginePos = Vector(100,0,33),
		
		LightsTable = "utility_truck_m",
		
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		
		CustomWheelModel = "models/left4dead/vehicles/wheel_utility_truck_front.mdl",
		CustomWheelModel_R = "models/left4dead/vehicles/wheel_utility_truck_rear.mdl",
		
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
					ent:SetPoseParameter( "rear_sign", ent.fdoorstate)
				end
				
				if ent.fdoorstate > 0.9 then
					ent:SetBodygroup( 1, 1 )
				else
					ent:SetBodygroup( 1, 0 )
				end
				
				if !ConVarExists( "simfphys_bus_safety_brakes" ) then return end
				
				if (GetConVar( "simfphys_bus_safety_brakes" ):GetInt() == 1) then
					if ent.fdoorstate > 0.1 then
						ent.PressedKeys["joystick_handbrake"] = 1
					end
				end
			end
			
			if !ConVarExists( "simfphys_bus_safety_brakes" ) then
				dooranim()
			return end
			
			if (GetConVar( "simfphys_bus_safety_brakes" ):GetInt() == 1) then
				if ent.ForwardSpeed < 100 then
					dooranim()
				end
			else
				dooranim()
			end
		end,
		
		CustomWheelPosFL = Vector(72,34,13),
		CustomWheelPosFR = Vector(72,-34,13),
		CustomWheelPosRL = Vector(-49,41,13),
		CustomWheelPosRR = Vector(-49,-41,13),
		CustomWheelAngleOffset = Angle(0,270,0),
		
		CustomMassCenter = Vector(0,0,0),
		
		CustomSteerAngle = 30,
		
		SeatOffset = Vector(7,-20,55),
		SeatPitch = 5,
		SeatYaw = 90,
		
		--!!!!!!!!!!!RANDYS EXTRA FUNCTIONS!!!!!!!!!!!!!
		
		LPMountRear = Vector(-100.9,18.8,25),
		LPGroup = Plates_L4D,
		
		--!!!!!!!!!!!END RANDYS EXTRA FUNCTIONS!!!!!!!!!!
		
		PassengerSeats = {
			{
				pos = Vector(18,-18,22),
				ang = Angle(0,-90,10)
			},
		},
		
		ExhaustPositions = {
			{
				pos = Vector(-100,28,15),
				ang = Angle(140,180,0),
			},
		},
		
		FrontHeight = 7,
		FrontConstant = 35000,
		FrontDamping = 2500,
		FrontRelativeDamping = 800,
		
		RearHeight = 7,
		RearConstant = 35000,
		RearDamping = 2500,
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
		PeakTorque = 150,
		PowerbandStart = 1500,
		PowerbandEnd = 4000,
		Turbocharged = false,
		Supercharged = false,
		
		FuelFillPos = Vector(-18,45,27),
		FuelType = 2,
		FuelTankSize = 120,
		
		PowerBias = 1,
		
		EngineSoundPreset = 0,

		
		Sound_Idle = "left4dead/vehicles/utility_truck_idle.wav",
		Sound_IdlePitch = 1,
		
		Sound_Mid = "left4dead/vehicles/utility_truck_low.wav",
		Sound_MidPitch = 1,
		Sound_MidVolume = 2,
		Sound_MidFadeOutRPMpercent = 60,
		Sound_MidFadeOutRate = 0.5,
		
		Sound_High = "left4dead/vehicles/utility_truck_high.wav",
		Sound_HighPitch = 1,
		Sound_HighVolume = 1.5,
		Sound_HighFadeInRPMpercent = 60,
		Sound_HighFadeInRate = 0.5,
		
		Sound_Throttle = "left4dead/vehicles/utility_truck_throttle.wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 5,
		
		--
		snd_horn = "left4dead/vehicles/utility_truck_horn.wav",
		
		DifferentialGear = 0.37,
		Gears = {-0.14,0,0.09,0.17,0.28,0.4,0.65}
	}
}
list.Set( "simfphys_vehicles", "sim_fphys_l4d_utility_truck_m", V )

local light_table = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(98.3,27.1,32.8),
	L_HeadLampAng = Angle(0,0,0),
	R_HeadLampPos = Vector(98.3,-27.1,32.8),
	R_HeadLampAng = Angle(0,0,0),
	
	-- projected texture - rear
	L_RearLampPos = Vector(-101.1,40.4,24.9),
	L_RearLampAng = Angle(25,180,0),
	R_RearLampPos = Vector(-101.1,-40.4,24.9),
	R_RearLampAng = Angle(25,180,0),
	
	Headlight_sprites = {   -- lowbeam
		{
			pos = Vector(98.3,27.1,32.8),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
		{
			pos = Vector(98.3,-27.1,32.8),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
	},
	
	Headlamp_sprites = {
		{pos = Vector(98.3,27.1,32.8),size = 100,material = "l4d/corona"},
		{pos = Vector(98.3,-27.1,32.8),size = 100,material = "l4d/corona"},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-101.1,40.4,24.9),
			material = "l4d/corona",
			size = 80,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-101.1,-40.4,24.9),
			material = "l4d/corona",
			size = 80,
			color = Color(255,0,0,150),
		}
	},
	
	DelayOn = 0,
	DelayOff = 0,
	
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(98.1,34.8,32.8),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
				OnBodyGroups = { 
					[1] = {0},
				}
			},
			{
				pos = Vector(101.9,27.4,24.9),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
				OnBodyGroups = { 
					[1] = {0},
				}
			},
			--SIGN
			{
				pos = Vector(-101,39,94),
				material = "l4d/corona",
				size = 50,
				color = Color(255,155,0,100),
				OnBodyGroups = { 
					[1] = {1},
				}
			},
			{
				pos = Vector(-101,34,103),
				material = "l4d/corona",
				size = 50,
				color = Color(255,155,0,100),
				OnBodyGroups = { 
					[1] = {1},
				}
			},
			{
				pos = Vector(-101,29,111),
				material = "l4d/corona",
				size = 50,
				color = Color(255,155,0,100),
				OnBodyGroups = { 
					[1] = {1},
				}
			},
			{
				pos = Vector(-101,34,86),
				material = "l4d/corona",
				size = 50,
				color = Color(255,155,0,100),
				OnBodyGroups = { 
					[1] = {1},
				}
			},
			{
				pos = Vector(-101,29,78),
				material = "l4d/corona",
				size = 50,
				color = Color(255,155,0,100),
				OnBodyGroups = { 
					[1] = {1},
				}
			},
			{
				pos = Vector(-101,21.4,94),
				material = "l4d/corona",
				size = 50,
				color = Color(255,155,0,100),
				OnBodyGroups = { 
					[1] = {1},
				}
			},
			{
				pos = Vector(-101,4.4,94),
				material = "l4d/corona",
				size = 50,
				color = Color(255,155,0,100),
				OnBodyGroups = { 
					[1] = {1},
				}
			},
			{
				pos = Vector(-101,-12.6,94),
				material = "l4d/corona",
				size = 50,
				color = Color(255,155,0,100),
				OnBodyGroups = { 
					[1] = {1},
				}
			},
			{
				pos = Vector(-101,-29.8,94),
				material = "l4d/corona",
				size = 50,
				color = Color(255,155,0,100),
				OnBodyGroups = { 
					[1] = {1},
				}
			},
		},
		TurnBrakeLeft = {
			{
				pos = Vector(-101.1,33.7,24.9),
				material = "l4d/corona",
				size = 100,
				color = Color(255,0,0,150),
				OnBodyGroups = { 
					[1] = {0},
				}
			},
		},
		Right = {
			{
				pos = Vector(98.1,-34.8,32.8),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
				OnBodyGroups = { 
					[1] = {0},
				}
			},
			{
				pos = Vector(101.9,-27.4,24.9),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
				OnBodyGroups = { 
					[1] = {0},
				}
			},
			--SIGN
			{
				pos = Vector(-101,-39,94),
				material = "l4d/corona",
				size = 50,
				color = Color(255,155,0,100),
				OnBodyGroups = { 
					[1] = {1},
				}
			},
			{
				pos = Vector(-101,-34,103),
				material = "l4d/corona",
				size = 50,
				color = Color(255,155,0,100),
				OnBodyGroups = { 
					[1] = {1},
				}
			},
			{
				pos = Vector(-101,-29,111),
				material = "l4d/corona",
				size = 50,
				color = Color(255,155,0,100),
				OnBodyGroups = { 
					[1] = {1},
				}
			},
			{
				pos = Vector(-101,-34,86),
				material = "l4d/corona",
				size = 50,
				color = Color(255,155,0,100),
				OnBodyGroups = { 
					[1] = {1},
				}
			},
			{
				pos = Vector(-101,-29,78),
				material = "l4d/corona",
				size = 50,
				color = Color(255,155,0,100),
				OnBodyGroups = { 
					[1] = {1},
				}
			},
			{
				pos = Vector(-101,-21.4,94),
				material = "l4d/corona",
				size = 50,
				color = Color(255,155,0,100),
				OnBodyGroups = { 
					[1] = {1},
				}
			},
			{
				pos = Vector(-101,-4.4,94),
				material = "l4d/corona",
				size = 50,
				color = Color(255,155,0,100),
				OnBodyGroups = { 
					[1] = {1},
				}
			},
			{
				pos = Vector(-101,12.6,94),
				material = "l4d/corona",
				size = 50,
				color = Color(255,155,0,100),
				OnBodyGroups = { 
					[1] = {1},
				}
			},
			{
				pos = Vector(-101,29.8,94),
				material = "l4d/corona",
				size = 50,
				color = Color(255,155,0,100),
				OnBodyGroups = { 
					[1] = {1},
				}
			},
		},
		TurnBrakeRight = {
			{
				pos = Vector(-101.1,-33.7,24.9),
				material = "l4d/corona",
				size = 100,
				color = Color(255,0,0,150),
				OnBodyGroups = { 
					[1] = {0},
				}
			},
		},
	},
	
	SubMaterials = {
		off = {
			Base = {
				[3] = "",
				[4] = "",
			},
			Brake = {
				[3] = "",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[3] = "",
				[4] = "",
			},
			Brake_Reverse = {
				[3] = "",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_lowbeam = {
			Base = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "",
			},
			Brake = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "",
			},
			Brake_Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_highbeam = {
			Base = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "",
			},
			Brake = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "",
			},
			Brake_Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		turnsignals = {
			left = {
				[6] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			right = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
	},
}
list.Set( "simfphys_lights", "utility_truck_m", light_table)