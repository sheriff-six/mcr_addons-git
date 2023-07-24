local function mg_fire(ply,vehicle,shootOrigin,shootDirection)

	vehicle:EmitSound("kamazzu_fire")
	
	local projectile = {}
		projectile.filter = vehicle.VehicleData["filter"]
		projectile.shootOrigin = shootOrigin
		projectile.shootDirection = shootDirection
		projectile.attacker = ply
		projectile.Tracer	= 2
		projectile.Spread = Vector(0.01,0.01,0.01)
		projectile.HullSize = 5
		projectile.attackingent = vehicle
		projectile.Damage = 1750
		projectile.Force = 12
	simfphys.FireHitScan( projectile )
	
end

function simfphys.weapon:ValidClasses()
	
	local classes = {
		"simfphys_kamazzu"
	}
	
	return classes
end

function simfphys.weapon:Initialize( vehicle )
	net.Start( "kamazzu_register_tank")
		net.WriteEntity( vehicle )
		net.WriteString( "kamazzu" )
	net.Broadcast()
	vehicle:SetNWBool( "SpecialCam_Loader", true )
	
	simfphys.RegisterCrosshair( vehicle.pSeat[1], { Direction = Vector(0,0,0),Attachment = "turret_machingun", Type = 1 } )
	simfphys.RegisterCamera( vehicle.pSeat[1], Vector(-20.5,-25.0,-0.5), Vector(-25,0,100), true,"mashingun_cannon_pitch" )
	
	if not istable( vehicle.PassengerSeats ) or not istable( vehicle.pSeat ) then return end
	vehicle.pSeat[1]:SetParent(vehicle,vehicle:LookupAttachment("mashingun_turret_yaw"))	
	---звук поворота башни

	---
	timer.Simple( 1, function()
		if not IsValid( vehicle ) then return end
		if not vehicle.VehicleData["filter"] then print("[simfphys Armed Vehicle Pack] ERROR:TRACE FILTER IS INVALID. PLEASE UPDATE SIMFPHYS BASE") return end
	end)
end


function simfphys.weapon:Think( vehicle )
	if not IsValid( vehicle ) or not vehicle:IsInitialized() then return end
	
	vehicle.wOldPos = vehicle.wOldPos or Vector(0,0,0)
	local deltapos = vehicle:GetPos() - vehicle.wOldPos
	vehicle.wOldPos = vehicle:GetPos()
	
	local handbrake = vehicle:GetHandBrakeEnabled()
	
	self:ControlTurret( vehicle, deltapos )
	
		---проверка на воду
	if vehicle:WaterLevel()==3 then
	vehicle:StopEngine()
	end
end

function simfphys.weapon:ControlTurret( vehicle, deltapos )
	---звуки башни

	---
	local pod = vehicle.pSeat[1]
	
	if not IsValid( pod ) then return end
	
	local ply = pod:GetDriver()
	
	if not IsValid( ply ) then return end
	

	
	local ID = vehicle:LookupAttachment( "turret_machingun" )
	local Attachment = vehicle:GetAttachment( ID )
	
	self:AimCannon( ply, vehicle, pod, Attachment )
	
	local shootOrigin = Attachment.Pos + deltapos * engine.TickInterval()
	
	local fire = ply:KeyDown( IN_ATTACK )
		
	if fire then
		self:Attack( vehicle, ply, vehicle:GetAttachment( vehicle:LookupAttachment( "turret_machingun" ) ).Pos + deltapos * engine.TickInterval(), Attachment,vehicle:LookupAttachment( "turret_machingun"))
	end
end

function simfphys.weapon:AimCannon( ply, vehicle, pod, Attachment )	
	if not IsValid( pod ) then return end
	
	local Aimang = pod:WorldToLocalAngles( ply:EyeAngles() )
	--вращение башни
	local AimRate = 125
	
	local Angles = vehicle:WorldToLocalAngles( Aimang )
	
	---поворот
	local v = math.abs((math.Round(Angles.y,1) - (vehicle.sm_pp_yaw and math.Round(vehicle.sm_pp_yaw,1) or 0)))
	vehicle.VAL_TurretHorizontal = (v <= 0.3 or (v >= 359.7 and v <= 360)) and 0 or 1
	v = math.abs((math.Round(Angles.p,1) - (vehicle.sm_pp_pitch and math.Round(vehicle.sm_pp_pitch,1) or 0)))
	vehicle.VAL_TurretVertical = (v == 0) and 0 or 1	
	local ft = FrameTime()
	vehicle.sm_pp_yaw = vehicle.sm_pp_yaw and math.ApproachAngle(vehicle.sm_pp_yaw,Angles.y,AimRate*ft) or 0
	vehicle.sm_pp_yaw = vehicle.sm_pp_yaw > 360 and 0 or vehicle.sm_pp_yaw < -360 and 0 or vehicle.sm_pp_yaw
	vehicle.sm_pp_pitch = vehicle.sm_pp_pitch and math.ApproachAngle(vehicle.sm_pp_pitch,Angles.p,AimRate*ft) or 0
	---	
	local TargetAng = Angle(vehicle.sm_pp_pitch,vehicle.sm_pp_yaw,0)
	TargetAng:Normalize() 

	vehicle:SetPoseParameter("mashingun_turret_yaw", TargetAng.y )
	vehicle:SetPoseParameter("mashingun_cannon_pitch", TargetAng.p )
end

function simfphys.weapon:CanPrimaryAttack( vehicle )
	vehicle.NextShoot = vehicle.NextShoot or 0
	return vehicle.NextShoot < CurTime()
end

function simfphys.weapon:SetNextPrimaryFire( vehicle, time )
	vehicle.NextShoot = time
	vehicle:SetNWFloat( "SpecialCam_LoaderNext", time )
end
-------------------------------------------
local reloudsA=0
function simfphys.weapon:Attack( vehicle, ply, shootOrigin, Attachment, ID )
	
	if not self:CanAttack( vehicle ) then return end
	
	local ID = vehicle:LookupAttachment( "turret_machingun" )
	local Attachment = vehicle:GetAttachment( ID )
	
	local shootDirection = Attachment.Ang:Forward()
	
	reloudsA=reloudsA+1
	if reloudsA<200 then
		mg_fire( ply, vehicle, Attachment.Pos, (Attachment.Ang - Angle(0,0.5,0)):Forward() )
		self:SetNextFire( vehicle, CurTime() + 0.2 )
	else
		vehicle:EmitSound("weapons/reload/mg3_reload.wav")
		reloudsA=0
		self:SetNextFire( vehicle, CurTime() + 9)
	end
end

function simfphys.weapon:CanAttack( vehicle )
	vehicle.NextShoot3 = vehicle.NextShoot3 or 0
	return vehicle.NextShoot3 < CurTime()
end

function simfphys.weapon:SetNextFire( vehicle, time )
	vehicle.NextShoot3 = time
end

