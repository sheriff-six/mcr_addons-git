local ENTITY = FindMetaTable("Entity")
local netStart = net.Start
local netWriteEntity = net.WriteEntity
local netBroadcast = net.Broadcast
local GetAttachment = ENTITY.GetAttachment
local random = math.random
local SetNWInt = ENTITY.SetNWInt
local netWriteUInt = net.WriteUInt


sound.Add({
	name = "T72B3_CANNON_FIRE_INSIDE",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 0,
	sound = "^t72b3/t72_interior_cannon_fire.ogg"
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

list.Set("simfphys_lights","bmp3",{
	L_HeadLampPos = Vector(130,54,59),
	R_HeadLampPos = Vector(130,-54,59),
	L_HeadLampAng = Angle(15,0,0),
	R_HeadLampAng = Angle(15,0,0),
	
	Headlight_sprites = { 
		Vector(118,22,66),
		Vector(118,22,67),
	},
	
	Brakelight_sprites = {
		Vector(-140,57,71),
		Vector(-140,-57,71),
	},
	Rearlight_sprites = {
		Vector(-140,57,71),
		Vector(-140,-57,71),
	},

})

list.Set("simfphys_vehicles","gred_simfphys_bmp3_custom",{
	Name = "BMP-3", 
	Model = Model("models/vehicles_shelby/tanks/bmp3/bmp3.mdl"),
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Shelby's Playground {Simfphys}",
	SpawnOffset = Vector(0,0,30),
	SpawnAngleOffset = 0,

	Members = {
		Mass = 8000,
		AirFriction = 0,
		Inertia = Vector(20000,90000,100000),
		
		LightsTable = "bmp3",
		
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
					net.WriteString("ins_ammo_explosionOLD")
					net.WriteVector(pos)
					net.WriteAngle(ang)
					net.WriteBool(false)
				net.Broadcast()
				gred.CreateSound(pos,false,"explosions/fuel_depot_explode_close.wav","explosions/fuel_depot_explode_dist.wav","explosions/fuel_depot_explode_far.wav")
			end
			
			gred.TankDestruction(ent,gib,ang,skin,pitch,yaw,CreateAmmoFire,StopAmmoFire,CreateExplosion,CreateTurret)
		end,


		MaxHealth = 16000,
		
		IsArmored = true,
		
		NoWheelGibs = true,
		
		FirstPersonViewPos = Vector(0,0,0),
		
		FrontWheelRadius = 20,
		RearWheelRadius = 20,
		
		EnginePos = Vector(-106,-47,75),
		
		CustomWheels = true,
		
		CustomWheelModel = "models/hunter/blocks/cube1x1x1.mdl",
		
		CustomWheelPosFL = Vector(73,60,12),
		CustomWheelPosFR = Vector(73,-60,12),
		
		CustomWheelPosML = Vector(0,60,12),
		CustomWheelPosMR = Vector(0,-60,12),
		
		CustomWheelPosRL = Vector(-75,60,12),
		CustomWheelPosRR = Vector(-75,-60,12),
		CustomWheelAngleOffset = Angle(0,180,0),
		
		CustomMassCenter = Vector(-4.625,0.8125,52.75),
		
		CustomSteerAngle = 1,
		FastSteeringAngle = 1,
		SteeringFadeFastSpeed = 1,
		
		TurnSpeed = 1,
		
		SeatOffset = Vector(50,0,60),
		SeatPitch = 0,
		SeatYaw = 90,
		
		ModelInfo = {
			WheelColor = Color(0,0,0,0),
			-- WheelColor = Color(0,0,0,255),
		},
		
		ExhaustPositions = {
			{
				pos = Vector(-123,-60,56),
				ang = Angle(90,-90,-90)
			},
			{
				pos = Vector(-111,-60,56),
				ang = Angle(90,-90,-90)
			},
			{
				pos = Vector(-98,-60,56),
				ang = Angle(90,-90,-90)
			},
			{
				pos = Vector(-85,-60,56),
				ang = Angle(90,-90,-90)
			},
			{
				pos = Vector(-123,-60,56),
				ang = Angle(90,-90,-90)
			},
			{
				pos = Vector(-111,-60,56),
				ang = Angle(90,-90,-90)
			},
			{
				pos = Vector(-98,-60,56),
				ang = Angle(90,-90,-90)
			},
			{
				pos = Vector(-85,-60,56),
				ang = Angle(90,-90,-90)
			},
			{
				pos = Vector(-123,-60,56),
				ang = Angle(90,-90,-90)
			},
			{
				pos = Vector(-111,-60,56),
				ang = Angle(90,-90,-90)
			},
			{
				pos = Vector(-98,-60,56),
				ang = Angle(90,-90,-90)
			},
			{
				pos = Vector(-85,-60,56),
				ang = Angle(90,-90,-90)
			},
		},
		
		PassengerSeats = {
			{
				pos = Vector(-10,24,48),
				ang = Angle(0,-90,0)
			},
			{
				pos = Vector(-10,-19,48),
				ang = Angle(0,-90,0)
			},
			{
				pos = Vector(50,33,23),
				ang = Angle(0,-90,0)
			},
			{
				pos = Vector(50,-33,23),
				ang = Angle(0,-90,0)
			},
			{
				pos = Vector(-40,33,29),
				ang = Angle(0,-90,0)
			},
			{
				pos = Vector(-67,33,29),
				ang = Angle(0,-90,0)
			},
			{
				pos = Vector(-67,0,29),
				ang = Angle(0,-90,0)
			},
			{
				pos = Vector(-67,-33,29),
				ang = Angle(0,-90,0)
			},
			{
				pos = Vector(-40,-33,29),
				ang = Angle(0,-90,0)
			},
			{
				pos = Vector(-122,25,65),
				ang = Angle(0,90,0)
			},
			{
				pos = Vector(-122,50,65),
				ang = Angle(0,90,0)
			},
			{
				pos = Vector(-122,0,65),
				ang = Angle(0,90,0)
			},
			{
				pos = Vector(-122,-25,65),
				ang = Angle(0,90,0)
			},
			{
				pos = Vector(-122,-50,67),
				ang = Angle(0,90,0)
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
		Efficiency = 2,
		GripOffset = -300,
		BrakePower = 60,
		BulletProofTires = true,
		
		IdleRPM = 600,
		LimitRPM = 8000,
		PeakTorque = 100,
		PowerbandStart = 600,
		PowerbandEnd = 4000,
		Turbocharged = false,
		Supercharged = false,
		DoNotStall = true,
		
		FuelFillPos = Vector(-208.824,-52.8,47.256),
		FuelType = FUELTYPE_DIESEL,
		FuelTankSize = 600,
		
		PowerBias = 0.5,
		
		EngineSoundPreset = 0,
		
		Sound_Idle = "bmp2/bmp2_engine_idle.wav",
		Sound_IdlePitch = 1,
		
		Sound_Mid = "bmp2/bmp2_engine_mid.wav",
		Sound_MidPitch = 1,
		Sound_MidVolume = 1,
		Sound_MidFadeOutRPMpercent = 100,
		Sound_MidFadeOutRate = 1,
		
		Sound_High = "bmp2/bmp2_engine_high.wav",
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
		Gears = {-0.06,0,0.06,0.08,0.1,0.12,0.13}
	}
})


gred = gred or {}
gred.simfphys = gred.simfphys or {}

local BMP3_SusData = {}

local Maxs = Vector(15,15,0)

for i = 1,6 do
	BMP3_SusData[i] = { 
		Attachment = "susp_att_l_"..i,
		PoseParameter = "suspension_left_"..i,
		PoseParameterMultiplier = 1,
		-- ReversePoseParam = true,
		Height = 12,
		GroundHeight = -38,
		Mins = -Maxs,
		Maxs = Maxs,
	}
	
	BMP3_SusData	[i + 6] = { 
		Attachment = "susp_att_r_"..i,
		PoseParameter = "suspension_right_"..i,
		PoseParameterMultiplier = 1,
		-- ReversePoseParam = true,
		Height = 12,
		GroundHeight = -38,
		Mins = -Maxs,
		Maxs = Maxs,
	}
end

gred.simfphys["gred_simfphys_bmp3_custom"] = {
	Seats = {
		[0] = { -- Driver
			ArcadeMode = {
				PlayerBoneManipulation = {
					["ValveBiped.Bip01_R_Calf"] = Angle(0,30,0),
					["ValveBiped.Bip01_L_Calf"] = Angle(-0,30,0),
							
					["ValveBiped.Bip01_R_Thigh"] = Angle(0,-35,0),
					["ValveBiped.Bip01_L_Thigh"] = Angle(0,-35,0),
							
					["ValveBiped.Bip01_Neck1"] = Angle(0,-45),
				},
				
				ViewAttachment = "gunner_sight",
				FirstPersonViewPos = Vector(5,0,5),
				ThirdPersonViewPos = Vector(0,70,80),
				
				MuzzleDirection = Vector(0,0.5,0),
				MuzzleAttachment = "cannon_muzzle",
				FirstPersonViewPosIsInside = true,
				TraverseIndicator = "cannon_aim_yaw",
				SynchronousElevation = true,
				
				Sight = {
					SightPosOffset = Vector(0,0,0),
					SightAngOffset = Angle(0,0,0),
					SightAttachment = "gunner_sight",
					SightFOV = 80,
					SightFOVZoom = 60,
					Stabilizer = true,
					SightMaterial = "gredwitch/overlay_russian_tanksight_bmp3",
				},
				
				ViewPort = {
					Attachment = "gunner_sight",
					Pos = Vector(0,0,0),
					Ang = Angle(),
					
					MinAng = Angle(-90,-90,-90),
					MaxAng = Angle(90,90,90),
					
					-- ModelAngOffset = Angle(0,180),
					
					-- Model = "models/gredwitch/viewports/viewport_gunner.mdl",
					-- ModelPosOffset = Vector(0,0,0),
					-- Model = "models/gredwitch/viewports/viewport_driver_alt.mdl",
					-- ModelPosOffset = Vector(0,0,0),
				},
				
				Hatches = {
					{
						PoseParameters = {
							"hatch_driver",
						},
						ViewAttachment = "",
						PosOffset = Vector(25,0,10),
						AngOffset = Angle(0,0,0),
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
				
				SmokeLaunchers = {
					"smoke_1",
					"smoke_2",
					"smoke_3",
					"smoke_4",
					"smoke_5",
					"smoke_6",
				},
			
				Primary = {
					{
						OnFire = function(vehicle,seat,ply,ct,SeatTab,WeaponTab,SeatID,SeatSlotTab,SlotID,k,v,shell,phy)
							
							timer.Create(tostring(seat).."0",0,1,function()
								if not IsValid(vehicle) then return end
								
								local Pos,Ang = vehicle:GetBonePosition(vehicle:LookupBone("turret_ejector"))
								Ang.y = Ang.y + 180
								
								local shell = ents.Create("gred_prop_casing")
								local c = constraint.NoCollide(shell,vehicle,0,0)
								shell.Model = "models/tankshell/tankshell.mdl"
								shell:SetPos(Pos)
								shell:SetAngles(Ang)
								shell:Spawn()
								shell:SetModelScale(WeaponTab.ShellTypes[SeatSlotTab.CurShellID].Caliber / 100)
								shell:Activate()
								
								local phys = shell:GetPhysicsObject()
								if IsValid(phys) then
									phys:AddVelocity(Ang:Forward()*-200 + vehicle:GetVelocity())
								end
								
								timer.Simple(0.1,function()
									if IsValid(c) then c:Remove() end
								end)
							end)
						end,

						AutoLoader = true,
						Type = "Cannon",
						ExactType = "2A70",
						ExactCaliber = "100",
						ModuleID = 0,
						ShootAnimation = "fire",
						Sequential = false,
						Muzzles = {
							"cannon_muzzle",
						},
						Sounds = {
							Reload = {
								"T72B3_RELOAD",
							},
							Shoot = {
								"100MM_D10T_1",
								"100MM_D10T_2",
								"100MM_D10T_3",
							},
							ShootInside = {
								"T90A_CANNON_FIRE_INSIDE"
							},
						},
						MuzzleFlash = "gred_arti_muzzle_blast_alt",
						ReloadTime = 4,

						ShellTypes = {
							{
								Caliber = 100,
								ShellType = "HE",
								MuzzleVelocity = 355,
								Mass = 15.8,
								TNTEquivalent = 3.54,
								LinearPenetration = 36,
								TracerColor = "red",
							},
						},
						MaxAmmo = 48,
						RecoilForce = 50000,
					},
					{
						OnFire = function(vehicle,seat,ply,ct,SeatTab,WeaponTab,SeatID,SeatSlotTab,SlotID,k,v,shell,phy)
					
							if not IsValid(vehicle) then return end
							
							local Pos,Ang = vehicle:GetBonePosition(vehicle:LookupBone("turret_gun"))
							Ang.y = Ang.y + -90
							Pos.y = Pos.y + -6
							Pos.z = Pos.z + 2
							Pos.x = Pos.x + 2
				
							local shell = ents.Create("gred_prop_casing")
							local c = constraint.NoCollide(shell,vehicle,0,0)
							shell.Model = "models/gredwitch/bombs/75mm_shell.mdl"
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
						end,

						Type = "Cannon",
						AutoLoader = true,
						ExactType = "2A72",
						ReloadTime = 0.10909091,
						Sequential = false,
						GunBreachModuleID = 0, -- Module ID
						
						Sounds = {
							Reload = {
								"sherman_reload",
							},
							Shoot = {
								"2A42_CANNON_FIRE_01",
								"2A42_CANNON_FIRE_02",
								"2A42_CANNON_FIRE_03",
								"2A42_CANNON_FIRE_04",
								"2A42_CANNON_FIRE_05",
								"2A42_CANNON_FIRE_06",
							},
							ShootInside = {
								"BMP2_CANNON_FIRE_INSIDE",
							},
						},
						MuzzleFlash = "muzzleflash_mg42_3p",
						Muzzles = {
							"cannon2_muzzle",
						},
						
						ShellTypes = {
							{
								Caliber = 30,
								ShellType = "HE",
								ExactShellType = "HEF-I",
								MuzzleVelocity = 960,
								Mass = 0.39,
								TNTEquivalent = 0.07546,
								TracerColor = "green",
								LinearPenetration = 3,
							},
							{
								Caliber = 30,
								ShellType = "AP",
								ExactShellType = "AP-T",
								MuzzleVelocity = 970,
								Mass = 0.4,
								TracerColor = "white",
								ForceDragCoef = true,
							},
							{
								Caliber = 30,
								ShellType = "HE",
								ExactShellType = "HEF-T",
								MuzzleVelocity = 960,
								Mass = 0.39,
								TNTEquivalent = 0.01786,
								TracerColor = "green",
								LinearPenetration = 2,
							},
							{
								Caliber = 30,
								ShellType = "APDS",
								MuzzleVelocity = 1120,
								Mass = 0.3,
								TracerColor = "white",
								ForceDragCoef = true,
							},
						},
						MaxAmmo = 250,
						RecoilForce = 500,
					},
					{
						Type = "Custom",
						ExactType = "9M117 ATGM",
						Sequential = true,
						ReloadTime = 15,
						FireRate = 600 / 15,
						RocketLaserAttachment = "gunner_sight",
						InitSV = function(vehicle,seat,SeatSlotTab,WeaponTab,WepID)
							SeatSlotTab.Ammo = WeaponTab.Ammo
							SeatSlotTab.ReloadTime = WeaponTab.ReloadTime
							SeatSlotTab.FireRate = WeaponTab.FireRate / 60
							SeatSlotTab.NextShot = 0			
						end,
						Shoot = function(vehicle,seat,ply,ct,SeatTab,WeaponTab,SeatID,SeatSlotTab,SlotID)
							if WeaponTab.Ammo <= 0 then return end
							if SeatSlotTab.Ammo <= 0 then return end
							if WeaponTab.Sequential then
								SeatSlotTab.CurrentMuzzle = (SlotID and seat.Primary[SlotID] or seat.Secondary).CurrentMuzzle and (SlotID and seat.Primary[SlotID] or seat.Secondary).CurrentMuzzle or 1
								SeatSlotTab.CurrentMuzzle = SeatSlotTab.CurrentMuzzle > #WeaponTab.Muzzles and 1 or SeatSlotTab.CurrentMuzzle
								
								netStart("gred_net_simfphys_shoot_"..(SlotID and "primary" or "secondary").."_machinegun_sequential")
									netWriteEntity(seat)
									netWriteUInt(SeatSlotTab.CurrentMuzzle,5)
								netBroadcast()
								
								local ID = vehicle:LookupAttachment( WeaponTab.RocketLaserAttachment )
								local Attachment = vehicle:GetAttachment( ID )
								local TargetDir = Attachment.Ang:Forward()
								local tr = util.TraceHull( {
									start = Attachment.Pos,
									endpos = (Attachment.Pos + TargetDir  * 999999),
									mins = Vector( -1, -1, -1 ),
									maxs = Vector( 1, 1, 1 ),
									filter = vehicle
								} )		
								local att = GetAttachment(vehicle,SeatSlotTab.Muzzles[SeatSlotTab.CurrentMuzzle])
								local ent = ents.Create(WeaponTab.Rocket)
								ent.IsOnPlane = true
								ent:SetPos(att.Pos)
								ent:SetAngles(att.Ang + Angle(math.random(-WeaponTab.Spread,WeaponTab.Spread),math.random(-WeaponTab.Spread,WeaponTab.Spread,90)))
								ent.Owner = ply
								ent.JDAM = true
								ent.Launcher = vehicle
								ent.LaserGuided = true
								ent.LaserAttachment = WeaponTab.RocketLaserAttachment
								ent.Launcher = vehicle
								ent.target = tr.Entity
								ent.targetOffset = tr.Entity:WorldToLocal(tr.HitPos)
								ent:Spawn()
								ent:Activate()
								ent.StartSound = WeaponTab.SilenceRocket and "" or ent.StartSound
								ent:Launch()
					
								local phys = ent:GetPhysicsObject()
								ent.phys = ent:GetPhysicsObject()
								ent.phys:ApplyForceCenter(ent:GetAngles():Right()*100)
								ent.phys:ApplyForceCenter(ent:GetAngles():Forward()*500)
								ent.phys:ApplyForceCenter(ent:GetAngles():Up()*700)
								for k,v in pairs(vehicle.FILTER) do
									constraint.NoCollide(ent,v,0,0)
								end
								
								SeatSlotTab.CurrentMuzzle = SeatSlotTab.CurrentMuzzle + 1
								
								SeatSlotTab.Ammo = SeatSlotTab.Ammo - 1
								
								if SeatSlotTab.Ammo < 1 then
									if WeaponTab.Sounds.Reload then
										seat:EmitSound(WeaponTab.Sounds.Reload[random(#WeaponTab.Sounds.Reload)])
									end
									
									SeatSlotTab.IsReloading = true
									
									timer.Simple(SeatSlotTab.ReloadTime,function()
										if !IsValid(vehicle) then return end
										if !IsValid(seat) then return end
										
										SeatSlotTab.IsReloading = false
										SeatSlotTab.Ammo = WeaponTab.Ammo
										SetNWInt(seat,SlotID and SlotID.."CurAmmo" or "SecondaryAmmo",SeatSlotTab.Ammo)
										
										if WeaponTab.OnReload then
											WeaponTab.OnReload(vehicle,seat,ply,ct,SeatTab,WeaponTab,SeatID,SeatSlotTab,SlotID)
										end
									end)
								end
							else
								netStart("gred_net_simfphys_shoot_"..(SlotID and "primary" or "secondary").."_machinegun")
									netWriteEntity(seat)
								netBroadcast()
								
								local phys
								local att
								local ent
								local v
								for k = 1,#WeaponTab.Muzzles do
									v = WeaponTab.Muzzles[k]
									if v then
										local ID = vehicle:LookupAttachment( WeaponTab.RocketLaserAttachment )
										local Attachment = vehicle:GetAttachment( ID )
										local TargetDir = Attachment.Ang:Forward()
										local tr = util.TraceHull( {
											start = Attachment.Pos,
											endpos = (Attachment.Pos + TargetDir  * 999999),
											mins = Vector( -1, -1, -1 ),
											maxs = Vector( 1, 1, 1 ),
											filter = vehicle
										} )		
										local att = GetAttachment(vehicle,SeatSlotTab.Muzzles[SeatSlotTab.CurrentMuzzle])
										local ent = ents.Create(WeaponTab.Rocket)
										ent.IsOnPlane = true
										ent.JDAM = true
										ent:SetPos(att.Pos)
										ent:SetAngles(att.Ang + Angle(math.random(-WeaponTab.Spread,WeaponTab.Spread),math.random(-WeaponTab.Spread,WeaponTab.Spread,90)))
										ent.Owner = ply
										ent.Launcher = vehicle
										ent.LaserGuided = true
										ent.LaserAttachment = WeaponTab.RocketLaserAttachment
										ent.Launcher = vehicle
										ent.target = tr.Entity
										ent.targetOffset = tr.Entity:WorldToLocal(tr.HitPos)
										ent:Spawn()
										ent:Activate()
										ent.StartSound = WeaponTab.SilenceRocket and "" or ent.StartSound
										ent:Launch()
										
										phys = ent:GetPhysicsObject()
										ent.phys = ent:GetPhysicsObject()
										ent.phys:ApplyForceCenter(ent:GetAngles():Right()*100)
										ent.phys:ApplyForceCenter(ent:GetAngles():Forward()*5000)
										ent.phys:ApplyForceCenter(ent:GetAngles():Up()*700)

										for k,v in pairs(vehicle.FILTER) do
											constraint.NoCollide(ent,v,0,0)
										end
										
										SeatSlotTab.Ammo = SeatSlotTab.Ammo - 1
										
										if WeaponTab.OnShoot then
											WeaponTab.OnShoot(vehicle,seat,ply,ct,SeatTab,WeaponTab,SeatID,SeatSlotTab,SlotID,k,att,ent)
										end
										
										if SeatSlotTab.Ammo < 1 then
											if WeaponTab.Sounds.Reload then 
												seat:EmitSound(WeaponTab.Sounds.Reload[random(#WeaponTab.Sounds.Reload)])
											end
											
											SeatSlotTab.IsReloading = true
											
											timer.Simple(SeatSlotTab.ReloadTime,function()
												if !IsValid(vehicle) then return end
												if !IsValid(seat) then return end
												
												SeatSlotTab.IsReloading = false
												SeatSlotTab.Ammo = WeaponTab.Ammo
												SetNWInt(seat,SlotID and SlotID.."CurAmmo" or "SecondaryAmmo",SeatSlotTab.Ammo)
												
												if WeaponTab.OnReload then
													WeaponTab.OnReload(vehicle,seat,ply,ct,SeatTab,WeaponTab,SeatID,SeatSlotTab,SlotID)
												end
											end)
											
											break
										end
									end
								end
							end
							
							SetNWInt(seat,SlotID and SlotID.."CurAmmo" or "SecondaryAmmo",SeatSlotTab.Ammo)
							
							SeatSlotTab.NextShot = ct + SeatSlotTab.FireRate
						end,
			
						CanShoot = function(vehicle,seat,ply,ct,SeatTab,WeaponTab,SeatID,SeatSlotTab,SlotID)
							return ct > SeatSlotTab.NextShot and SeatSlotTab.Ammo > 0
						end,
						Stop = function(vehicle,seat,ply,ct,SeatTab,WeaponTab,SeatID,SeatSlotTab,SlotID)
						end,	
						Sounds = {
							Shoot = {
								"9M133_FIRE",
							},
						},
									
						MuzzleFlash = "ins_weapon_at4_frontblast",
						Muzzles = {
							"cannon_muzzle",
						},
									
						SilenceRocket = false,
						Rocket = "gb_rocket_9m120",
									
						Ammo = 1,
						Spread = 0.05,
									
						-- OnShoot = function(vehicle,seat,ply,ct,SeatTab,WeaponTab,SeatID,SeatSlotTab,SlotID,CurrentMuzzle,att,ent)
						-- 	vehicle:SetBodygroup(CurrentMuzzle-2,1)
						-- end,
						
						-- OnReload = function(vehicle,seat,ply,ct,SeatTab,WeaponTab,SeatID,SeatSlotTab,SlotID)
						-- 	for i = 0,16 do
						-- 		vehicle:SetBodygroup(i,0)
						-- 	end
						-- end,
					},			
				},
				Secondary = {
					Type = "MG",
					ExactCaliber = "PKT 7.62",
					Caliber = "wac_base_7mm",
					ModuleID = 0,
					Sequential = false,
					Muzzles = {
						"coax_muzzle",
					},
					FireRate = 700,
					Sounds = {
						Reload = {
							"BMP2_COAX_RELOAD",
						},
						Loop = {
							"GRED_DSHK_LOOP",
						},
						LoopInside = {
							"GRED_DSHK_LOOP_INSIDE",
						},
						Stop = {
							"GRED_MG_8MM_LASTSHOT_01",
							"GRED_MG_8MM_LASTSHOT_02",
							"GRED_MG_8MM_LASTSHOT_03",
						},
						StopInside = {
							"GRED_MG_8MM_LASTSHOT_INSIDE_01",
							"GRED_MG_8MM_LASTSHOT_INSIDE_02",
							"GRED_MG_8MM_LASTSHOT_INSIDE_03",
						},
					},
					Spread = 0.1,
					ReloadTime = 22,
					Ammo = 250,
					MuzzleFlash = "muzzleflash_bar_3p",
					TracerColor = "red",
				},
				
				TurretTraverseSoundPitch = 100,
				TurretTraverseSoundLevel = 90,
				TurretTraverseSpeed = 30,
				TurretTraverseSound = "bmp2/ifv_turret_move.wav",
				
				TurretElevationSound = "gredwitch/turret_electric.wav",
				TurretElevationSoundPitch = 100,
				TurretElevationSoundLevel = 90,
				TurretElevationSpeed = 10,
				
				MinTraverse = -180,
				MaxTraverse = 180,
				MinElevation = -2,
				MaxElevation = 17,
				
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
							Offset = 27,
							Invert = false,
						},
					},
				},
				
			},
			NormalMode = {
				PlayerBoneManipulation = {
					["ValveBiped.Bip01_R_Calf"] = Angle(0,30,0),
					["ValveBiped.Bip01_L_Calf"] = Angle(-0,30,0),
							
					["ValveBiped.Bip01_R_Thigh"] = Angle(0,-35,0),
					["ValveBiped.Bip01_L_Thigh"] = Angle(0,-35,0),
							
					["ValveBiped.Bip01_Neck1"] = Angle(0,-30),
				},
				FirstPersonViewPos = Vector(2,-8,5),
				ThirdPersonViewPos = Vector(0,15,80),
				FirstPersonViewPosIsInside = true,
			},
		},
		[1] = { -- Gunner
			ArcadeMode = {
				FirstPersonViewPosIsInside = true,
				ViewAttachment = "gunner_sight",
				Attachment = "turret_att",
				FirstPersonViewPos = Vector(5,0,5),
				ThirdPersonViewPos = Vector(0,0,10),

				PlayerBoneManipulation = {
					["ValveBiped.Bip01_Neck1"] = Angle(0,-35),
				},
				
				Hatches = {
					{
						PoseParameters = {
							"hatch_gunner"
						},
						PosOffset = Vector(3,0,42),
						AngOffset = Angle(0,0,0),
						PlayerHullMins = Vector(),
						PlayerHullMaxs = Vector(),
						
						PlayerBoneManipulation = {
							["ValveBiped.Bip01_R_Calf"] = Angle(0,-90,0),
							["ValveBiped.Bip01_L_Calf"] = Angle(0,-90,0),
							
							["ValveBiped.Bip01_R_Thigh"] = Angle(0,90,0),
							["ValveBiped.Bip01_L_Thigh"] = Angle(0,90,0),
						},
					},
				},
			},
		},
		[2] = { -- Commander
			ArcadeMode = {
				FirstPersonViewPosIsInside = true,
				Attachment = "turret_att",
				ThirdPersonViewPos = Vector(0,0,0),

				PlayerBoneManipulation = {
					["ValveBiped.Bip01_R_Calf"] = Angle(0,30,0),
					["ValveBiped.Bip01_L_Calf"] = Angle(-0,30,0),
							
					["ValveBiped.Bip01_R_Thigh"] = Angle(0,-35,0),
					["ValveBiped.Bip01_L_Thigh"] = Angle(0,-35,0),
							
					["ValveBiped.Bip01_Neck1"] = Angle(0,-35),
				},

				IsCommander = true,
			}
		},
		[3] = {
			ArcadeMode = {
				FirstPersonViewPosIsInside = true,
				ThirdPersonViewPos = Vector(0,0,0),

				ViewPort = {
					FreeView = true,
					Pos = Vector(65,33,77),
					Ang = Angle(),
					Debug = false,
					
					ModelAngOffset = Angle(0,180),
					
					Model = "models/gredwitch/viewports/shelbys_driver_viewport.mdl",
					ModelPosOffset = Vector(4,0,-0.2),
					
					MinAng = Angle(-1,-10,-1),
					MaxAng = Angle(1,10,1),
				},

				PlayerBoneManipulation = {
					["ValveBiped.Bip01_R_Calf"] = Angle(0,30,0),
					["ValveBiped.Bip01_L_Calf"] = Angle(-0,30,0),
							
					["ValveBiped.Bip01_R_Thigh"] = Angle(0,-35,0),
					["ValveBiped.Bip01_L_Thigh"] = Angle(0,-35,0),
							
					["ValveBiped.Bip01_Neck1"] = Angle(0,-25),
				},
			}
		},
		[4] = {
			ArcadeMode = {
				FirstPersonViewPosIsInside = true,
				ThirdPersonViewPos = Vector(0,0,0),

				ViewPort = {
					FreeView = true,
					Pos = Vector(65,-35,77),
					Ang = Angle(),
					Debug = false,
					
					ModelAngOffset = Angle(0,180),
					
					Model = "models/gredwitch/viewports/shelbys_driver_viewport.mdl",
					ModelPosOffset = Vector(4,0,-0.2),
					
					MinAng = Angle(-1,-10,-1),
					MaxAng = Angle(1,10,1),
				},

				PlayerBoneManipulation = {
					["ValveBiped.Bip01_R_Calf"] = Angle(0,30,0),
					["ValveBiped.Bip01_L_Calf"] = Angle(-0,30,0),
							
					["ValveBiped.Bip01_R_Thigh"] = Angle(0,-35,0),
					["ValveBiped.Bip01_L_Thigh"] = Angle(0,-35,0),
							
					["ValveBiped.Bip01_Neck1"] = Angle(0,-25),
				},
			}
		},
		[5] = {
			ArcadeMode = {
				FirstPersonViewPosIsInside = true,
				ThirdPersonViewPos = Vector(0,0,0),

				ViewPort = {
					FreeView = true,
					Pos = Vector(-39,37,82.5),
					Ang = Angle(0,50,0),
					Debug = false,
					
					ModelAngOffset = Angle(0,180),
					
					Model = "models/gredwitch/viewports/shelbys_driver_viewport.mdl",
					ModelPosOffset = Vector(3,4,-0.2),
					
					MinAng = Angle(-1,-10,-1),
					MaxAng = Angle(1,10,1),
				},

				PlayerBoneManipulation = {
					["ValveBiped.Bip01_R_Calf"] = Angle(0,30,0),
					["ValveBiped.Bip01_L_Calf"] = Angle(-0,30,0),
							
					["ValveBiped.Bip01_R_Thigh"] = Angle(0,-35,0),
					["ValveBiped.Bip01_L_Thigh"] = Angle(0,-35,0),
							
					["ValveBiped.Bip01_Neck1"] = Angle(0,-25),
				},
			}
		},
		[6] = {
			ArcadeMode = {
				FirstPersonViewPosIsInside = true,
				ThirdPersonViewPos = Vector(0,0,0),

				ViewPort = {
					FreeView = true,
					Pos = Vector(-61,37,81),
					Ang = Angle(0,90,0),
					Debug = false,
					
					ModelAngOffset = Angle(0,180),
					
					Model = "models/gredwitch/viewports/shelbys_driver_viewport.mdl",
					ModelPosOffset = Vector(0,4,-0.2),
					
					MinAng = Angle(-1,-10,-1),
					MaxAng = Angle(1,10,1),
				},

				PlayerBoneManipulation = {
					["ValveBiped.Bip01_R_Calf"] = Angle(0,30,0),
					["ValveBiped.Bip01_L_Calf"] = Angle(-0,30,0),
							
					["ValveBiped.Bip01_R_Thigh"] = Angle(0,-35,0),
					["ValveBiped.Bip01_L_Thigh"] = Angle(0,-35,0),
							
					["ValveBiped.Bip01_Neck1"] = Angle(0,0,25),
				},
			}
		},
		[7] = {
			ArcadeMode = {
				FirstPersonViewPosIsInside = true,
				ThirdPersonViewPos = Vector(0,0,0),

				ViewPort = {
					FreeView = true,
					Pos = Vector(-63,1,80),
					Ang = Angle(0,180,0),
					Debug = false,
					
					ModelAngOffset = Angle(0,180),
					
					Model = "models/gredwitch/viewports/shelbys_driver_viewport.mdl",
					ModelPosOffset = Vector(-4,0,-0.2),
					
					MinAng = Angle(-1,-10,-1),
					MaxAng = Angle(1,10,1),
				},

				PlayerBoneManipulation = {
					["ValveBiped.Bip01_R_Calf"] = Angle(0,30,0),
					["ValveBiped.Bip01_L_Calf"] = Angle(-0,30,0),
							
					["ValveBiped.Bip01_R_Thigh"] = Angle(0,-35,0),
					["ValveBiped.Bip01_L_Thigh"] = Angle(0,-35,0),
							
					["ValveBiped.Bip01_Neck1"] = Angle(0,20,0),
				},
			}
		},
		[8] = {
			ArcadeMode = {
				Outside = true,
				FirstPersonViewPosIsInside = true,
				ThirdPersonViewPos = Vector(0,0,0),

				ViewPort = {
					FreeView = true,
					Pos = Vector(-53,-48,79),
					Ang = Angle(0,-90,0),
					Debug = false,
					
					ModelAngOffset = Angle(0,-180),
					
					Model = "models/gredwitch/viewports/shelbys_driver_viewport.mdl",
					ModelPosOffset = Vector(0,-4,-0.2),
					
					MinAng = Angle(-1,-10,-1),
					MaxAng = Angle(1,10,1),
				},

				PlayerBoneManipulation = {
					["ValveBiped.Bip01_R_Calf"] = Angle(0,30,0),
					["ValveBiped.Bip01_L_Calf"] = Angle(-0,30,0),
							
					["ValveBiped.Bip01_R_Thigh"] = Angle(0,-35,0),
					["ValveBiped.Bip01_L_Thigh"] = Angle(0,-35,0),
							
					["ValveBiped.Bip01_Neck1"] = Angle(0,20,0),
				},
			}
		},
		[9] = {
			ArcadeMode = {
				Outside = true,
				FirstPersonViewPosIsInside = true,
				ThirdPersonViewPos = Vector(0,0,0),
		
				ViewPort = {
					FreeView = true,
					Pos = Vector(-39,-45,82.5),
					Ang = Angle(0,-50,0),
					Debug = false,
					
					ModelAngOffset = Angle(0,180),
					
					Model = "models/gredwitch/viewports/shelbys_driver_viewport.mdl",
					ModelPosOffset = Vector(3,-4,-0.2),
					
					MinAng = Angle(-1,-180,-1),
					MaxAng = Angle(1,180,1),
				},

				PlayerBoneManipulation = {
					["ValveBiped.Bip01_R_Calf"] = Angle(0,30,0),
					["ValveBiped.Bip01_L_Calf"] = Angle(-0,30,0),
							
					["ValveBiped.Bip01_R_Thigh"] = Angle(0,-35,0),
					["ValveBiped.Bip01_L_Thigh"] = Angle(0,-35,0),
							
					["ValveBiped.Bip01_Neck1"] = Angle(0,-25),
				},
			}
		},
		[10] = {
			ArcadeMode = {
				Outside = true,
				FirstPersonViewPosIsInside = true,
				ThirdPersonViewPos = Vector(0,0,0),
		
				PlayerBoneManipulation = {
					["ValveBiped.Bip01_R_Calf"] = Angle(0,30,0),
					["ValveBiped.Bip01_L_Calf"] = Angle(-0,30,0),
							
					["ValveBiped.Bip01_R_Thigh"] = Angle(0,-55,0),
					["ValveBiped.Bip01_L_Thigh"] = Angle(0,-55,0),
							
					["ValveBiped.Bip01_Neck1"] = Angle(0,0),
				},
			}
		},
		[11] = {
			ArcadeMode = {
				Outside = true,
				FirstPersonViewPosIsInside = true,
				ThirdPersonViewPos = Vector(0,0,0),
		
				PlayerBoneManipulation = {
					["ValveBiped.Bip01_R_Calf"] = Angle(0,0,0),
					["ValveBiped.Bip01_L_Calf"] = Angle(0,0,0),
							
					["ValveBiped.Bip01_R_Thigh"] = Angle(0,0,0),
					["ValveBiped.Bip01_L_Thigh"] = Angle(0,0,0),
							
					["ValveBiped.Bip01_Neck1"] = Angle(0,0),
				},
			}
		},
	},
	Armour = {
		GetArmourThickness = function(vehicle,tr)
			if tr.LocalHitPos.z > 37 then
				tr.TurretHit = true
				
				if tr.PitchSideDetection == GRED_TANK_TOP then
					tr.ArmourThicknessKE = 15
					tr.ArmourThicknessCHEMICAL = 100
				else
					if tr.YawSideDetection == GRED_TANK_FRONT then
						local absy = math.abs(tr.LocalHitPos.y)
						if absy > 11 then
							if absy > 38 then
								tr.ArmourThicknessKE = 50
								tr.ArmourThicknessCHEMICAL = 100
							else
								tr.ArmourThicknessKE = 25
								tr.ArmourThicknessCHEMICAL = 100
							end
						else
							tr.ArmourThicknessKE = 70
							tr.ArmourThicknessCHEMICAL = 100
						end
					elseif tr.YawSideDetection == GRED_TANK_REAR then
						tr.ArmourThicknessKE = 43
					else
						tr.ArmourThicknessKE = 60
						tr.ArmourThicknessCHEMICAL = 100
					end
				end
			else
				if tr.PitchSideDetection == GRED_TANK_TOP then
					if tr.LocalHitPos.x > 39 then
						tr.ArmourThicknessKE = 15
						tr.ArmourThicknessCHEMICAL = 100
					else
						tr.ArmourThicknessKE = 25
					end
				elseif tr.PitchSideDetection == GRED_TANK_BOTTOM then
					tr.ArmourThicknessKE = 15
					tr.ArmourThicknessCHEMICAL = 200
				else
					if tr.YawSideDetection == GRED_TANK_FRONT then
						if tr.LocalHitPos.z > 80 then
							tr.ArmourThicknessKE = 15
							tr.ArmourThicknessCHEMICAL = 100 
						else
							tr.ArmourThicknessKE = 15
						end
					elseif tr.YawSideDetection == GRED_TANK_REAR then
						if tr.LocalHitPos.z > 40 then
							tr.ArmourThicknessKE = 13
						else
							tr.ArmourThicknessKE = 13
						end
					else
						tr.ArmourThicknessKE = 15
						tr.ArmourThicknessCHEMICAL = 115
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
			["$basetexture"]				= "models/bmp3_shelby/ussr_bmp_3_track_c",
			["$bumpmap"]					= "models/bmp3_shelby/ussr_bmp_3_track_n",
											
			["$alphatest"] 					= "1",
											
			["$phong"] 						= "1",
			["$phongboost"] 				= "1",
			["$phongexponent"] 				= "1",
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
		Divider = 400,
		LeftTrackID = 9,
		RightTrackID = 8,
		
		LowTrackSound  = "tracksounds/tracks_light_speed_33_3.wav",
		MedTrackSound  = "tracksounds/tracks_light_speed_66_3.wav",
		HighTrackSound = "tracksounds/tracks_light_speed_99_3.wav",
		TrackSoundLevel = 85,
		TrackSoundVolume = 0.75,
		HandBrakePower = 90,
		
		TankSteer = {
			HasNeutralSteering = true,
			MaxTurn = 35,
			TurnTorqueCenter = 70,
			TurnTorqueCenterRate = 1,
			TurnForceMul = 0.05,
		},
	},

	SusData = BMP3_SusData,
	
	OnCSTick = function(vehicle)
		vehicle:SetPoseParameter("spin_wheels_right",vehicle.trackspin_r)
		vehicle:SetPoseParameter("spin_wheels_left",vehicle.trackspin_l)
	end,
}

gred.simfphys["gred_simfphys_bmp3_custom"].Seats[1].NormalMode = table.FullCopy(gred.simfphys["gred_simfphys_bmp3_custom"].Seats[0].ArcadeMode) -- we use table.FullCopy so we can change stuff
gred.simfphys["gred_simfphys_bmp3_custom"].Seats[1].NormalMode.Hatches = gred.simfphys["gred_simfphys_bmp3_custom"].Seats[1].ArcadeMode.Hatches -- we want the seat's normal mode to have the same hatches as in arcade mode
gred.simfphys["gred_simfphys_bmp3_custom"].Seats[1].NormalMode.FirstPersonViewPosIsInside = true
gred.simfphys["gred_simfphys_bmp3_custom"].Seats[1].NormalMode.ViewAttachment = nil
gred.simfphys["gred_simfphys_bmp3_custom"].Seats[1].NormalMode.ThirdPersonViewPos = Vector(20,70,80)
gred.simfphys["gred_simfphys_bmp3_custom"].Seats[1].NormalMode.Attachment = "turret_att"

gred.simfphys["gred_simfphys_bmp3_custom"].Seats[2].ArcadeMode = {
	FirstPersonViewPosIsInside = true,
	Attachment = "turret_att",
	FirstPersonViewPos = Vector(0,0,10),
	ThirdPersonViewPos = Vector(0,0,20),
	IsCommander = true,

	PlayerBoneManipulation = {
		["ValveBiped.Bip01_R_Calf"] = Angle(0,30,0),
		["ValveBiped.Bip01_L_Calf"] = Angle(-0,30,0),
				
		["ValveBiped.Bip01_R_Thigh"] = Angle(0,-35,0),
		["ValveBiped.Bip01_L_Thigh"] = Angle(0,-35,0),
				
		["ValveBiped.Bip01_Neck1"] = Angle(0,-35),
	},
		
	Hatches = {
		{
			PoseParameters = {
				"hatch_commander"
			},
			PosOffset = Vector(0,0,42),
			AngOffset = Angle(0,0,0),
			
			PlayerBoneManipulation = {
				["ValveBiped.Bip01_R_Calf"] = Angle(0,-90),
				["ValveBiped.Bip01_L_Calf"] = Angle(0,-90),

				["ValveBiped.Bip01_R_Thigh"] = Angle(0,90),
				["ValveBiped.Bip01_L_Thigh"] = Angle(0,90),
			},
		},
	},
	
	ViewPort = {
		FreeView = true,
		Debug = false,
		Attachment = "turret_att",
		Pos = Vector(13,-19,24.5),
		Ang = Angle(0,180,0),

		ModelAngOffset = Angle(0,0),
					
		Model = "models/gredwitch/viewports/shelbys_commander_viewport.mdl",
		ModelPosOffset = Vector(0,0,-4),

		MinAng = Angle(-1,-180,-1),
		MaxAng = Angle(1,180,1),
	},
}
gred.simfphys["gred_simfphys_bmp3_custom"].Seats[2].NormalMode = gred.simfphys["gred_simfphys_bmp3_custom"].Seats[2].ArcadeMode
gred.simfphys["gred_simfphys_bmp3_custom"].Seats[3].NormalMode = gred.simfphys["gred_simfphys_bmp3_custom"].Seats[3].ArcadeMode
gred.simfphys["gred_simfphys_bmp3_custom"].Seats[4].NormalMode = gred.simfphys["gred_simfphys_bmp3_custom"].Seats[4].ArcadeMode
gred.simfphys["gred_simfphys_bmp3_custom"].Seats[5].NormalMode = gred.simfphys["gred_simfphys_bmp3_custom"].Seats[5].ArcadeMode
gred.simfphys["gred_simfphys_bmp3_custom"].Seats[6].NormalMode = gred.simfphys["gred_simfphys_bmp3_custom"].Seats[6].ArcadeMode
gred.simfphys["gred_simfphys_bmp3_custom"].Seats[7].NormalMode = gred.simfphys["gred_simfphys_bmp3_custom"].Seats[7].ArcadeMode
gred.simfphys["gred_simfphys_bmp3_custom"].Seats[8].NormalMode = gred.simfphys["gred_simfphys_bmp3_custom"].Seats[8].ArcadeMode
gred.simfphys["gred_simfphys_bmp3_custom"].Seats[9].NormalMode = gred.simfphys["gred_simfphys_bmp3_custom"].Seats[9].ArcadeMode
gred.simfphys["gred_simfphys_bmp3_custom"].Seats[10].NormalMode = gred.simfphys["gred_simfphys_bmp3_custom"].Seats[10].ArcadeMode
gred.simfphys["gred_simfphys_bmp3_custom"].Seats[11].NormalMode = gred.simfphys["gred_simfphys_bmp3_custom"].Seats[11].ArcadeMode

gred.simfphys["gred_simfphys_bmp3_custom"].Seats[0].NormalMode.Hatches = gred.simfphys["gred_simfphys_bmp3_custom"].Seats[0].ArcadeMode.Hatches
gred.simfphys["gred_simfphys_bmp3_custom"].Seats[0].NormalMode.ViewPort = {
	FreeView = true,
	--Attachment = "gunner_sight",
	Pos = Vector(65,0,79),
	Ang = Angle(0,0,0),
	
	Debug = false,
	
	MinAng = Angle(-1,-35,-1),
	MaxAng = Angle(1,35,1),
	
	ModelAngOffset = Angle(0,180),
					
	Model = "models/gredwitch/viewports/shelbys_commander_viewport.mdl",
	ModelPosOffset = Vector(4,0,-4),
	--Model = "models/gredwitch/viewports/viewport_driver_alt.mdl",
	--ModelPosOffset = Vector(3.7,0,-0.6),
}