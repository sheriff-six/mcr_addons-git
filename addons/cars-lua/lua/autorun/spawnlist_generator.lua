local V = {
	Name = "Portable Generator",
	Model = "models/left4dead/vehicles/floodlight_generator.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "L4D - Industrial",
	SpawnOffset = Vector(0,0,0),
	SpawnAngleOffset = 90,
	NAKGame = "Left 4 Dead 2",
	NAKType = "Trailers",
	FLEX = {
		Trailers = {
			inputPos = Vector(86,0,17),
			inputType = "ballsocket",
		}
	},
	
	Members = {
		Mass = 1100.0,
		
		EnginePos = Vector(0,0,0),
		
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
			
		CustomWheelModel = "models/left4dead/vehicles/generator_wheel.mdl",
		CustomWheelModel_R = "models/left4dead/vehicles/howitzer_nowheel.mdl",
		
		CustomWheelPosFL = Vector(-26.5,26,12.5),
		CustomWheelPosFR = Vector(-26.5,-26,12.5),	
		CustomWheelPosRL = Vector(0,5,30),
		CustomWheelPosRR = Vector(0,-5,30),
		CustomWheelAngleOffset = Angle(0,-90,0),
		
		FrontWheelRadius = 12,
		RearWheelRadius = 5,
		
		CustomMassCenter = Vector(0,0,10),		
		
		CustomSteerAngle = 60,
		
		SeatOffset = Vector(0,0,0),
		SeatPitch = 0,
		SeatYaw = 90,
		
		--[[OnSpawn = function(self)
			self.EngineBtn = ents.Create("prop_physics")
			self.EngineBtn:SetModel("models/hunter/plates/plate.mdl")
			self.EngineBtn:SetPos( self:LocalToWorld( Vector(22,-12,46) ) )
			self.EngineBtn:SetAngles( self:LocalToWorldAngles( Angle(0,0,0) ) )
			self.EngineBtn:SetParent( self )
			self.EngineBtn:Spawn()
			--self.EngineBtn:Activate()
			self.EngineBtn:GetPhysicsObject():SetDragCoefficient( -9000 )
			self.EngineBtn.DoNotDuplicate = true
			
			--self.EngineBtnWeld = constraint.Weld( self.EngineBtn, self, 0, 0, 0, 1, 1)
			
			self.EngineBtn.Use = function( activator, caller )
				local vehicle = self:GetParent()
				print("dicks")
				
				vehicle:SetActive( true )
				vehicle.EngineRPM = self:GetEngineData().IdleRPM
				vehicle.EngineIsOn = 1
			end
		end,
		
		OnSpawn = function(self)
			self.Use = function(self, ply)
				if self:GetActive() then
					if not self:EngineActive() then
						self:StartEngine()
					else
						self:StopEngine()
						self:SetActive( false )
					end
				else
					self:SetActive( true )
					self:StartEngine()
				end
			end
		end,]]
		
		--!!!!!!!!!!!RANDYS EXTRA FUNCTIONS!!!!!!!!!!!!!

		IsTrailer = true,
		
		NoAlarm = true,
		
		SimpleIgnition = true,
		
		TrailerLegsPoseParameter = "trailer_braces",
		TrailerLegsPosition = Vector(60,3,4.5),
		TrailerLegsHeight = 20,
		SingleTrailerLeg = true,
		
		--!!!!!!!!!!!END RANDYS EXTRA FUNCTIONS!!!!!!!!!!
		
		ExhaustPositions = {
			{
				pos = Vector(-23,6.6,61.4),
				ang = Angle(-90,0,0),
			},
		},
		
		FrontHeight = 5,
		FrontConstant = 50000,
		FrontDamping = 3000,
		FrontRelativeDamping = 350,
		
		RearHeight = 5,
		RearConstant = 50000,
		RearDamping = 3000,
		RearRelativeDamping = 350,
		
		FastSteeringAngle = 10,
		SteeringFadeFastSpeed = 700,
		
		TurnSpeed = 3,
		
		MaxGrip = 150,
		Efficiency = 1,
		GripOffset = 0,
		BrakePower = 40,
		BulletProofTires = false,
		
		IdleRPM = 700,
		LimitRPM = 5000,
		PeakTorque = 50,
		PowerbandStart = 2500,
		PowerbandEnd = 4000,
		Turbocharged = false,
		Supercharged = false,
		DoNotStall = false,
		
		FuelFillPos = Vector(-48,19,37),
		FuelType = 1,
		FuelTankSize = 50,
		
		PowerBias = 0,

		EngineSoundPreset = 0,

		Sound_Idle = "left4dead/vehicles/generator_start_loop.wav",
		Sound_IdlePitch = 1,
		
		Sound_Mid = "left4dead/vehicles/generator_sputter.wav",
		Sound_MidPitch = 1,
		Sound_MidVolume = 2,
		Sound_MidFadeOutRPMpercent = 55,
		Sound_MidFadeOutRate = 0.5,
		
		Sound_High = "left4dead/vehicles/generator_high.wav",
		Sound_HighPitch = 1,
		Sound_HighVolume = 1.5,
		Sound_HighFadeInRPMpercent = 55,
		Sound_HighFadeInRate = 0.5,
		
		Sound_Throttle = "common/null.wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 5,
		
		snd_horn = "common/null.wav",
		
		DifferentialGear = 0,
		Gears = {-1,0,1}
	}
}
if file.Exists( "autorun/tr_init.lua", "LUA") then
	list.Set( "simfphys_vehicles", "sim_fphys_l4d_generator", V )
end