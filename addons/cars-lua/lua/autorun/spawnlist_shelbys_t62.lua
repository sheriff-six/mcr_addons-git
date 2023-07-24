sound.Add({
	name = "T62_CANNON_FIRE",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 160,
	sound = "commpack7/cannon_115mm_u5ts_shot_01.wav"
})

sound.Add({
	name = "T62_CANNON_FIRE_INSIDE",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 0,
	sound = "commpack7/cannon_recoil_03.wav"
})

local Type
function table.FullCopy(tab)
	if (!tab) then return nil end
	
	local res = {}
	for k,v in pairs(tab) do
		Type = type(v)
		
		if Type == "table" then
			res[k] = table.FullCopy(v)
		elseif Type == "Vector" then
			res[k] = Vector(v.x,v.y,v.z)
		elseif Type == "Angle" then
			res[k] = Angle(v.p,v.y,v.r)
		else
			res[k] = v
		end
	end
	
	return res
end

list.Set("simfphys_vehicles","gred_simfphys_t62_custom",{
	Name = "T-62", 
	Model = Model("models/vehicles_shelby/tanks/t62/t62.mdl"),
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Shelby's Playground {Simfphys}",
	SpawnOffset = Vector(0,0,10),
	SpawnAngleOffset = 0,

	Members = {
		Mass = 9000,
		AirFriction = 0,
		Inertia = Vector(20000,90000,100000),
				
		ApplyDamage = function( ent, damage, type ) 
			simfphys.TankApplyDamage(ent, damage, type)
		end,	

		OnDestroyed = function(ent)
			local gib = ent.Gib
			if !IsValid(gib) then return end
			
			local pos,ang,skin,pitch,yaw = gib:GetPos(),gib:GetAngles(),gib:GetSkin(),ent:GetPoseParameter("cannon_aim_pitch"),ent:GetPoseParameter("cannon_aim_yaw")
			gib:SetPoseParameter("cannon_aim_pitch",pitch)
			gib:SetPoseParameter("cannon_aim_yaw",yaw)
			
			local function CreateAmmoFire(gib,ang)
				local bonepos = gib:GetBonePosition(gib:LookupBone("turret_root"))
				gib.AmmoFire = ents.Create("info_particle_system")
				gib.AmmoFire:SetKeyValue("effect_name","flame_jet")
				gib.AmmoFire:SetKeyValue("start_active",1)
				gib.AmmoFire:SetOwner(gib)
				gib.AmmoFire:SetPos(bonepos)
				gib.AmmoFire:SetAngles(ang)
				gib.AmmoFire:Spawn()
				gib.AmmoFire:Activate()
				gib.AmmoFire:SetParent(gib)
				
				gib.AmmoFireSound = CreateSound(gib,"gredwitch/burning_jet.wav")
				gib.AmmoFireSound:SetSoundLevel(120)
				gib.AmmoFireSound:Play()
				gib:CallOnRemove("removesnd",function(gib)
					gib.AmmoFireSound:Stop()
				end)
			end
			
			local function CreateTurret(gib,ang,pitch,yaw)

				
				local bonepos = gib:GetBonePosition(gib:LookupBone("turret_root"))
				local prop = ents.Create("prop_physics")
				prop:SetAngles(ang + Angle(pitch,yaw))
				prop:SetPos(bonepos)
				prop:SetMaterial( "models/player/player_chrome1" )
				prop:SetRenderMode( RENDERMODE_NORMAL )
				gib.Turret = prop
				
				gib:CallOnRemove("removeturret",function(gib)
					if IsValid(gib.Turret) then gib.Turret:Remove() end
				end)
			end
			
			local function StopAmmoFire(gib)
				gib.AmmoFire:Remove()
				gib.AmmoFireSound:Stop()
			end
			
			local function CreateExplosion(gib,ang)
				local pos = gib:LocalToWorld(Vector(-10,0,40))
				net.Start("gred_net_createparticle")
					net.WriteString("doi_flak88_explosion")
					net.WriteVector(pos)
					net.WriteAngle(ang)
					net.WriteBool(false)
				net.Broadcast()
				gred.CreateSound(pos,false,"explosions/fuel_depot_explode_close.wav","explosions/fuel_depot_explode_dist.wav","explosions/fuel_depot_explode_far.wav")
			end
			
			gred.TankDestruction(ent,gib,ang,skin,pitch,yaw,CreateAmmoFire,StopAmmoFire,CreateExplosion,CreateTurret)
		end,

		
		MaxHealth = 31000,
		
		IsArmored = true,
		
		NoWheelGibs = true,
		
		FirstPersonViewPos = Vector(0,0,0),
		
		FrontWheelRadius = 20,
		RearWheelRadius = 20,
		
		EnginePos = Vector(-180,0,45),
		
		CustomWheels = true,
		
		CustomWheelModel = "models/props_lab/huladoll.mdl",
		
		CustomWheelPosFL = Vector(50,50,10),
		CustomWheelPosFR = Vector(50,-50,10),
		
		CustomWheelPosML = Vector(-50,50,10),
		CustomWheelPosMR = Vector(-50,-50,10),
		
		CustomWheelPosRL = Vector(-160,50,10),
		CustomWheelPosRR = Vector(-160,-50,10),
		CustomWheelAngleOffset = Angle(0,180,0),
		
		CustomMassCenter = Vector(-16.53125,0,45.15625),
		
		CustomSteerAngle = 1,
		FastSteeringAngle = 1,
		SteeringFadeFastSpeed = 1,
		
		TurnSpeed = 1,
		
		SeatOffset = Vector(0,-20,45),
		SeatPitch = 0,
		SeatYaw = 90,
		
		ModelInfo = {
			WheelColor = Color(255,0,242,0),
			-- WheelColor = Color(0,0,0,255),
		},
		
		ExhaustPositions = {
			{
				pos = Vector(-110,65,50),
				ang = Angle(90,90,0)
			},
			{
				pos = Vector(-115,65,50),
				ang = Angle(90,90,0)
			},
			{
				pos = Vector(-120,65,50),
				ang = Angle(90,90,0)
			},
			{
				pos = Vector(-127,65,50),
				ang = Angle(90,90,0)
			},
			{
				pos = Vector(-110,65,50),
				ang = Angle(90,90,0)
			},
			{
				pos = Vector(-115,65,50),
				ang = Angle(90,90,0)
			},
			{
				pos = Vector(-120,65,50),
				ang = Angle(90,90,0)
			},
			{
				pos = Vector(-127,65,50),
				ang = Angle(90,90,0)
			},
			{
				pos = Vector(-110,65,50),
				ang = Angle(90,90,0)
			},
			{
				pos = Vector(-115,65,50),
				ang = Angle(90,90,0)
			},
			{
				pos = Vector(-120,65,50),
				ang = Angle(90,90,0)
			},
			{
				pos = Vector(-127,65,50),
				ang = Angle(90,90,0)
			},
			{
				pos = Vector(-110,65,50),
				ang = Angle(90,90,0)
			},
			{
				pos = Vector(-115,65,50),
				ang = Angle(90,90,0)
			},
			{
				pos = Vector(-120,65,50),
				ang = Angle(90,90,0)
			},
			{
				pos = Vector(-127,65,50),
				ang = Angle(90,90,0)
			},
			{
				pos = Vector(-110,65,50),
				ang = Angle(90,90,0)
			},
			{
				pos = Vector(-115,65,50),
				ang = Angle(90,90,0)
			},
			{
				pos = Vector(-120,65,50),
				ang = Angle(90,90,0)
			},
			{
				pos = Vector(-127,65,50),
				ang = Angle(90,90,0)
			},
			{
				pos = Vector(-110,65,50),
				ang = Angle(90,90,0)
			},
			{
				pos = Vector(-115,65,50),
				ang = Angle(90,90,0)
			},
			{
				pos = Vector(-120,65,50),
				ang = Angle(90,90,0)
			},
			{
				pos = Vector(-127,65,50),
				ang = Angle(90,90,0)
			},
			{
				pos = Vector(-110,65,50),
				ang = Angle(90,90,0)
			},
			{
				pos = Vector(-115,65,50),
				ang = Angle(90,90,0)
			},
			{
				pos = Vector(-120,65,50),
				ang = Angle(90,90,0)
			},
			{
				pos = Vector(-127,65,50),
				ang = Angle(90,90,0)
			},
		},

		
		PassengerSeats = {
			{
				pos = Vector(-40,21,30),
				ang = Angle(0,-90,0)
			},
			{
				pos = Vector(-64,21,40),
				ang = Angle(0,-90,0)
			},
			{
				pos = Vector(-40,-21,30),
				ang = Angle(0,-90,0)
			},
		},
		
		CustomSuspensionTravel = 5,
		
		FrontHeight = -1,
		FrontConstant = 37000,
		FrontDamping = 42800,
		FrontRelativeDamping = 5500,
		
		RearHeight = -1,
		RearConstant = 37000,
		RearDamping = 42800,
		RearRelativeDamping = 5500,
		
		MaxGrip = 1000,
		Efficiency = 1.2,
		GripOffset = -300,
		BrakePower = 60,
		BulletProofTires = true,
		
		IdleRPM = 600,
		LimitRPM = 3500,
		PeakTorque = 80,
		PowerbandStart = 600,
		PowerbandEnd = 3200,
		Turbocharged = false,
		Supercharged = false,
		DoNotStall = true,
		
		FuelFillPos = Vector( -161.54, -28.1, 59.59 ),
		FuelType = FUELTYPE_PETROL,
		FuelTankSize = 300,
		
		PowerBias = 0.5,
		
		EngineSoundPreset = 0,
		
		Sound_Idle = "commpack7/su_100_engine_rpm_33.wav",
		Sound_IdlePitch = 1,
		
		Sound_Mid = "commpack7/su_100_engine_rpm_66.wav",
		Sound_MidPitch = 1,
		Sound_MidVolume = 1,
		Sound_MidFadeOutRPMpercent = 100,
		Sound_MidFadeOutRate = 1,
		
		Sound_High = "commpack7/su_100_engine_rpm_99.wav",
		Sound_HighPitch = 1,
		Sound_HighVolume = 1,
		Sound_HighFadeInRPMpercent = 50,
		Sound_HighFadeInRate = 0.2,
		
		Sound_Throttle = "",
		Sound_ThrottlePitch = 0,
		Sound_ThrottleVolume = 0,
		
		snd_horn = "common/null.wav",
		ForceTransmission = 1,
		
		DifferentialGear = 0.4,
		Gears = {-0.02,0,0.05,0.1,0.13,0.18,0.22}
	}
})


gred = gred or {}
gred.simfphys = gred.simfphys or {}

local T62_SusData = {}

local Maxs = Vector(15,15,0)

for i = 1,5 do
	T62_SusData[i] = { 
		Attachment = "susp_att_l_"..i,
		PoseParameter = "suspension_left_"..i,
		PoseParameterMultiplier = 1,
		-- ReversePoseParam = true,
		Height = 19,
		GroundHeight = -38,
		Mins = -Maxs,
		Maxs = Maxs,
	}
	
	T62_SusData	[i + 5] = { 
		Attachment = "susp_att_r_"..i,
		PoseParameter = "suspension_right_"..i,
		PoseParameterMultiplier = 1,
		-- ReversePoseParam = true,
		Height = 19,
		GroundHeight = -38,
		Mins = -Maxs,
		Maxs = Maxs,
	}
end

gred.simfphys["gred_simfphys_t62_custom"] = {
	Seats = {
		[0] = { -- Driver
			ArcadeMode = {
				PlayerBoneManipulation = {
					["ValveBiped.Bip01_R_Calf"] = Angle(0,90,0),
					["ValveBiped.Bip01_L_Calf"] = Angle(0,90,0),
					
					["ValveBiped.Bip01_R_Thigh"] = Angle(0,-90,0),
					["ValveBiped.Bip01_L_Thigh"] = Angle(0,-90,0),
				},
				
				ViewAttachment = "gunner_sight",
				FirstPersonViewPos = Vector(0,0,10),
				ThirdPersonViewPos = Vector(0,70,80),
				
				MuzzleDirection = Vector(0,0.5,0),
				MuzzleAttachment = "cannon_muzzle",
				FirstPersonViewPosIsInside = true,
				TraverseIndicator = "cannon_aim_yaw",
				SynchronousElevation = true,
				
				Sight = {
					SightPosOffset = Vector(0,0,0),
					SightAngOffset = Angle(),
					SightAttachment = "gunner_sight",
					SightFOV = 40,
					SightFOVZoom = 20, -- ammount of FOV to remove, not the actual zoom value
					Stabilizer = true,
					SightMaterial = "gredwitch/overlay_russian_tanksight_t62",
				},
				
				ViewPort = {
					Freeview = false,
					Attachment = "gunner_sight",
					Debug = false,
					Pos = Vector(0,0,0),
					Ang = Angle(),
					
					MinAng = Angle(-0,-0,-0),
					MaxAng = Angle(0,0,0),
					
					ModelAngOffset = Angle(0,180),
					
					Model = "models/gredwitch/viewports/viewport_gunner.mdl",
					ModelPosOffset = Vector(9,0,0),
					-- Model = "models/gredwitch/viewports/viewport_driver_alt.mdl",
					-- ModelPosOffset = Vector(0,0,0),
				},
				
				Hatches = {
					{
						PoseParameters = {
							"hatch_driver",
						},
						PosOffset = Vector(20,0,15),
						AngOffset = Angle(0,0,0),
						ViewAttachment = "",
						PlayerBoneManipulation = {
							["ValveBiped.Bip01_R_Calf"] = Angle(10,20,0),
							["ValveBiped.Bip01_L_Calf"] = Angle(-10,20,0),
							
							["ValveBiped.Bip01_R_Thigh"] = Angle(0,-60,0),
							["ValveBiped.Bip01_L_Thigh"] = Angle(0,-60,0),
							
							["ValveBiped.Bip01_R_Foot"] = Angle(0,0),
							["ValveBiped.Bip01_L_Foot"] = Angle(0,0),
							
							-- ["ValveBiped.Bip01_R_Bicept"] = Angle(90,0),
							-- ["ValveBiped.Bip01_L_Bicept"] = Angle(90,0),
						},
					},
				},
			
				Primary = {
					{

						OnFire = function(vehicle,seat,ply,ct,SeatTab,WeaponTab,SeatID,SeatSlotTab,SlotID,k,v,shell,phy)
							
							timer.Create(tostring(seat).."0",0.5,1,function()
								if not IsValid(vehicle) then return end
								
								local Pos,Ang = vehicle:GetBonePosition(vehicle:LookupBone("shell_ejector"))
								Ang.y = Ang.y + 0
								
								local shell = ents.Create("gred_prop_casing")
								local c = constraint.NoCollide(shell,vehicle,0,0)
								shell.Model = "models/tankshell/tankshell.mdl"
								shell:SetPos(Pos)
								shell:SetAngles(Ang)
								shell.BodyGroupA = 1
								shell.BodyGroupB = 2
								shell:Spawn()
								shell:SetModelScale(WeaponTab.ShellTypes[SeatSlotTab.CurShellID].Caliber / 75)
								shell:Activate()
								
								local phys = shell:GetPhysicsObject()
								if IsValid(phys) then
									phys:AddVelocity(Ang:Forward()*100 + vehicle:GetVelocity())
								end
								
								timer.Simple(0.1,function()
									if IsValid(c) then c:Remove() end
								end)
							end)
						end,

						AutoLoader = true,
						Type = "Cannon",
						ExactType = "U-5TS",
						ExactCaliber = "115",
						ReloadTime = 12,
						ShootAnimation = "fire",
						GunBreachModuleID = 0, -- Module ID
						
						Sounds = {
							Shoot = {
								"T62_CANNON_FIRE",
							},
							ShootInside = {
								"T62_CANNON_FIRE_INSIDE"
							},
							Reload = {
								"sherman_reload",
							},
						},
						MuzzleFlash = "gred_arti_muzzle_blast_alt",
						Muzzles = {
							"cannon_muzzle",
						},
						
						ShellTypes = {
							{
								Caliber = 115,
								ShellType = "HEATFS",
								MuzzleVelocity = 950,
								Mass = 12.97,
								TNTEquivalent = 2.28,
								TracerColor = "red",
								LinearPenetration = 440,
							},
							{
								Caliber = 115,
								ShellType = "HE",
								MuzzleVelocity = 905,
								Mass = 14.86,
								TNTEquivalent = 2.64,
								TracerColor = "red",
								LinearPenetration = 31,
							},
							{
								Caliber = 115,
								ShellType = "APFSDS",
								MuzzleVelocity = 1615,
								Mass = 4,
								CoreMass = 45,
								TracerColor = "red",
								ForceDragCoef = true,
							},
						},
						MaxAmmo = 40,
						RecoilForce = 50000,
					},
				},
				Secondary = {
					Type = "MG",
					Caliber = "wac_base_7mm",
					ModuleID = 0,
					ExactCaliber = "PKT 7.62x54",
					Sequential = false,
					Muzzles = {
						"coax_muzzle",
					},
					FireRate = 700,
					Sounds = {
						Reload = {
							"GRED_M2HB_RELOAD",
						},
						Loop = {
							"SHELBY_T72_COAX_LOOP",
						},
						LoopInside = {
							"SHELBY_PKT_LOOP_INSIDE",
						},
						Stop = {
							"SHELBY_T72_COAX_STOP",
						},
						StopInside = {
							"SHELBY_MG_PKT_LASTSHOT_INSIDE_01",
						},
					},
					Spread = 0.1,
					ReloadTime = 10,
					Ammo = 250,
					MuzzleFlash = "muzzleflash_mg42_3p",
					TracerColor = "green",
				},
				
				TurretTraverseSoundPitch = 100,
				TurretTraverseSoundLevel = 90,
				TurretTraverseSpeed = 9,
				TurretTraverseSound = "turret/turret_turn_loop_1.wav",
				
				TurretElevationSound = "turret/turret_turn_loop_1_manual.wav",
				TurretElevationSoundPitch = 100,
				TurretElevationSoundLevel = 90,
				TurretElevationSpeed = 3,
				
				MinTraverse = -180,
				MaxTraverse = 180,
				MinElevation = -6,
				MaxElevation = 16,
				
				PoseParameters = { -- turret pose parameter
					Yaw = {
						["cannon_aim_yaw"] = {
							Offset = 0,
							Invert = false,
						},
					},
					YawModuleName = "TurretRing",
					YawModuleID = 0,
					
					Pitch = {
						["cannon_aim_pitch"] = {
							Offset = 0,
							Invert = true,
						},
					},
				},
				
			},
			NormalMode = {
				PlayerBoneManipulation = {
					["ValveBiped.Bip01_R_Calf"] = Angle(0,90,0),
					["ValveBiped.Bip01_L_Calf"] = Angle(0,90,0),
					
					["ValveBiped.Bip01_R_Thigh"] = Angle(0,-90,0),
					["ValveBiped.Bip01_L_Thigh"] = Angle(0,-90,0),
				},
				FirstPersonViewPos = Vector(0,0,7),
				ThirdPersonViewPos = Vector(0,15,80),
				FirstPersonViewPosIsInside = true,
			},
		},
		[1] = { -- Gunner
			ArcadeMode = {
				FirstPersonViewPosIsInside = true,
				Attachment = "turret_att",
				FirstPersonViewPos = Vector(0,0,0),
				ThirdPersonViewPos = Vector(0,0,30),
				PlayerBoneManipulation = {
					["ValveBiped.Bip01_R_Calf"] = Angle(0,90,0),
					["ValveBiped.Bip01_L_Calf"] = Angle(0,90,0),
					
					["ValveBiped.Bip01_R_Thigh"] = Angle(0,-90,0),
					["ValveBiped.Bip01_L_Thigh"] = Angle(0,-90,0),
				},
				
				ViewPort = {
					FreeView = true,
					Debug = false,
					Attachment = "turret_att",
					Pos = Vector(8,21,34),
					Ang = Angle(),

					ModelAngOffset = Angle(0,180),
					
					Model = "models/gredwitch/viewports/shelbys_driver_viewport.mdl",
					ModelPosOffset = Vector(4,0,-0.2),
					
					MinAng = Angle(-1,-10,-1),
					MaxAng = Angle(1,10,1),
				},
			},
		},
		[2] = { -- Commander
			ArcadeMode = {
				FirstPersonViewPosIsInside = true,
				Attachment = "turret_att",
				FirstPersonViewPos = Vector(0,0,7),
				ThirdPersonViewPos = Vector(0,0,0),
				IsCommander = true,
				PlayerBoneManipulation = {
					["ValveBiped.Bip01_R_Calf"] = Angle(0,90,0),
					["ValveBiped.Bip01_L_Calf"] = Angle(0,90,0),
					
					["ValveBiped.Bip01_R_Thigh"] = Angle(0,-90,0),
					["ValveBiped.Bip01_L_Thigh"] = Angle(0,-90,0),
				},

				Hatches = {
					{
						PoseParameters = {
							"hatch_commander"
						},
						PosOffset = Vector(-3,0,36),
						AngOffset = Angle(0,0,0),
						
						PlayerBoneManipulation = {
							["ValveBiped.Bip01_R_Calf"] = Angle(0,-90),
							["ValveBiped.Bip01_L_Calf"] = Angle(0,-90),
							
							["ValveBiped.Bip01_R_Thigh"] = Angle(5,100,0),
							["ValveBiped.Bip01_L_Thigh"] = Angle(-5,100,0),
						},
					},
				},

				ViewPort = {
					FreeView = true,
					Debug = false,
					Attachment = "turret_att",
					Pos = Vector(15,24,35),
					Ang = Angle(0,0,0),
			
					ModelAngOffset = Angle(0,180),
								
					Model = "models/gredwitch/viewports/shelbys_commander_viewport.mdl",
					ModelPosOffset = Vector(0,0,-3),
			
					MinAng = Angle(-1,-45,-1),
					MaxAng = Angle(1,45,1),
				},
			}
		},
		[3] = { -- Loader
			ArcadeMode = {
				FirstPersonViewPosIsInside = true,
				Attachment = "turret_att",
				FirstPersonViewPos = Vector(0,0,7),
				ThirdPersonViewPos = Vector(0,0,0),
				PlayerBoneManipulation = {
					["ValveBiped.Bip01_R_Calf"] = Angle(0,90,0),
					["ValveBiped.Bip01_L_Calf"] = Angle(0,90,0),
					
					["ValveBiped.Bip01_R_Thigh"] = Angle(0,-90,0),
					["ValveBiped.Bip01_L_Thigh"] = Angle(0,-90,0),
				},

				Hatches = {
					{
						PoseParameters = {
							"hatch_loader"
						},
						PosOffset = Vector(-10,0,45),
						AngOffset = Angle(0,0,0),
						
						PlayerBoneManipulation = {
							["ValveBiped.Bip01_R_Calf"] = Angle(0,-90),
							["ValveBiped.Bip01_L_Calf"] = Angle(0,-90),
							
							["ValveBiped.Bip01_R_Thigh"] = Angle(5,100,0),
							["ValveBiped.Bip01_L_Thigh"] = Angle(-5,100,0),
						},
					},
				},

				ViewPort = {
					FreeView = true,
					Debug = false,
					Attachment = "turret_att",
					Pos = Vector(20,-25,30),
					Ang = Angle(0,0,0),
			
					ModelAngOffset = Angle(0,180),
								
					Model = "models/gredwitch/viewports/shelbys_driver_viewport.mdl",
					ModelPosOffset = Vector(4,0,0),
			
					MinAng = Angle(-1,-5,-1),
					MaxAng = Angle(1,5,1),
				},
			}
		},
	},
	Armour = {
		GetArmourThickness = function(vehicle,tr)
			if tr.LocalHitPos.z > 59 then
				tr.TurretHit = true
				
				if tr.PitchSideDetection == GRED_TANK_TOP then
					if tr.LocalHitPos.z < 81 then
						tr.ArmourThicknessKE = 320
						tr.ArmourThicknessCHEMICAL = 300
					else
						tr.ArmourThicknessKE = 60
					end
				else
					if tr.YawSideDetection == GRED_TANK_FRONT then
						local absy = math.abs(tr.LocalHitPos.y)
						if absy > 11 then
							if absy > 38 then
								tr.ArmourThicknessKE = 320
								tr.ArmourThicknessCHEMICAL = 300
							else
								tr.ArmourThicknessKE = 320
								tr.ArmourThicknessCHEMICAL = 300
							end
						else
							tr.ArmourThicknessKE = 130
							tr.ArmourThicknessCHEMICAL = 99
						end
					elseif tr.YawSideDetection == GRED_TANK_REAR then
						tr.ArmourThicknessKE = 65
					else
						tr.ArmourThicknessKE = 165
						tr.ArmourThicknessCHEMICAL = 300
					end
				end
			else
				if tr.PitchSideDetection == GRED_TANK_TOP then
					if tr.LocalHitPos.x > 60 then
						tr.ArmourThicknessKE = 130
						tr.ArmourThicknessCHEMICAL = 300
					else
						tr.ArmourThicknessKE = 130
					end
				elseif tr.PitchSideDetection == GRED_TANK_BOTTOM then
					if tr.LocalHitPos.z < 80 then
						tr.ArmourThicknessKE = 745
						tr.ArmourThicknessCHEMICAL = 300
					else
						tr.ArmourThicknessKE = 80
					end
					if tr.LocalHitPos.z > 80 then
						tr.ArmourThicknessKE = 130
						tr.ArmourThicknessCHEMICAL = 300
					else
						tr.ArmourThicknessKE = 130
					end
				else
					if tr.YawSideDetection == GRED_TANK_FRONT then
						if tr.LocalHitPos.z > 80 then
							tr.ArmourThicknessKE = 460
							tr.ArmourThicknessCHEMICAL = 300 
						else
							tr.ArmourThicknessKE = 85
							tr.ArmourThicknessCHEMICAL = 99 
						end
					elseif tr.YawSideDetection == GRED_TANK_REAR then
						if tr.LocalHitPos.z > 40 then
							tr.ArmourThicknessKE = 45
						else
							tr.ArmourThicknessKE = 45
						end
					else
						tr.ArmourThicknessKE = 85
						tr.ArmourThicknessCHEMICAL = 300
					end
				end
			end
			
			tr.ArmourThicknessKE = tr.ArmourThicknessKE or 10
			tr.ArmourThicknessCHEMICAL = tr.ArmourThicknessCHEMICAL or tr.ArmourThicknessKE
			return tr
		end,
		
	},
	Tracks = {
		TrackMat = {
			["$basetexture"]				= "models/t62_shelby/ussr_t_62_track_c",
			["$bumpmap"]					= "models/t62_shelby/ussr_t_62_track_n",
						
			["$alphatest"] 					= "1",
			["$nocull"] 					= "1",
											
			["$phong"] 						= "1",
			["$phongboost"] 				= "0.5",
			["$phongexponent"] 				= "30",
			["$phongfresnelranges"] 		= "[0.3 1 4]",
			
			["$translate"] = "[0.0 0.0 0.0]",
			["Proxies"] = { 
				["TextureTransform"] = { 
					["translateVar"] = "$translate",
					["centerVar"]    = "$center",
					["resultVar"]    = "$basetexturetransform",
				}
			}
		},
		
		Smoother = 1,
		Divider = -400,
		LeftTrackID = 0,
		RightTrackID = 8,
		
		LowTrackSound  = "commpack7/t72_tracks_33_tracks.wav",
		MedTrackSound  = "commpack7/t72_tracks_66_tracks.wav",
		HighTrackSound = "commpack7/t72_tracks_99_tracks.wav",
		TrackSoundLevel = 90,
		TrackSoundVolume = 0.6,
		HandBrakePower = 90,
		
		TankSteer = {
			HasNeutralSteering = true,
			MaxTurn = 25,
			TurnTorqueCenter = 70,
			TurnTorqueCenterRate = 1,
			TurnForceMul = 0.05,
		},
	},

	SusData = T62_SusData,
	
	OnCSTick = function(vehicle)
		vehicle:SetPoseParameter("spin_wheels_right",vehicle.trackspin_r)
		vehicle:SetPoseParameter("spin_wheels_left",vehicle.trackspin_l)
	end,
}

gred.simfphys["gred_simfphys_t62_custom"].Seats[1].NormalMode = table.FullCopy(gred.simfphys["gred_simfphys_t62_custom"].Seats[0].ArcadeMode) -- we use table.FullCopy so we can change stuff
gred.simfphys["gred_simfphys_t62_custom"].Seats[1].NormalMode.Hatches = gred.simfphys["gred_simfphys_t62_custom"].Seats[1].ArcadeMode.Hatches -- we want the seat's normal mode to have the same hatches as in arcade mode
gred.simfphys["gred_simfphys_t62_custom"].Seats[1].NormalMode.FirstPersonViewPosIsInside = true
gred.simfphys["gred_simfphys_t62_custom"].Seats[1].NormalMode.ViewAttachment = nil
gred.simfphys["gred_simfphys_t62_custom"].Seats[1].NormalMode.ThirdPersonViewPos = Vector(20,70,80)
gred.simfphys["gred_simfphys_t62_custom"].Seats[1].NormalMode.Attachment = "turret_att"

gred.simfphys["gred_simfphys_t62_custom"].Seats[2].NormalMode = gred.simfphys["gred_simfphys_t62_custom"].Seats[2].ArcadeMode
gred.simfphys["gred_simfphys_t62_custom"].Seats[3].NormalMode = gred.simfphys["gred_simfphys_t62_custom"].Seats[3].ArcadeMode

gred.simfphys["gred_simfphys_t62_custom"].Seats[0].NormalMode.Hatches = gred.simfphys["gred_simfphys_t62_custom"].Seats[0].ArcadeMode.Hatches
gred.simfphys["gred_simfphys_t62_custom"].Seats[0].NormalMode.ViewPort = {
	FreeView = true,
	--Attachment = "gunner_sight",
	Pos = Vector(33,20,63),
	Ang = Angle(0,0,0),
	
	Debug = false,
	
	MinAng = Angle(-1,-45,-1),
	MaxAng = Angle(1,45,1),
	
	ModelAngOffset = Angle(0,180),
					
	Model = "models/gredwitch/viewports/shelbys_commander_viewport.mdl",
	ModelPosOffset = Vector(0,0,-3.5),
	--Model = "models/gredwitch/viewports/viewport_driver_alt.mdl",
	--ModelPosOffset = Vector(3.7,0,-0.6),
}