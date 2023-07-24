local screenw = ScrW()
local screenh = ScrH()
local Widescreen = (screenw / screenh) > (4 / 3)
local sizex = screenw * (Widescreen and 1 or 1.32)
local sizey = screenh
local xpos = sizex * 0.02
local ypos = sizey * 0.8
local x = xpos * (Widescreen and 43.5 or 32)
local y = ypos * 1.015
local radius = 0.085 * sizex
local startang = 105

local lights_on = Material( "simfphys/hud/low_beam_on" )
local lights_on2 = Material( "simfphys/hud/high_beam_on" )
local lights_off = Material( "simfphys/hud/low_beam_off" )
local fog_on = Material( "simfphys/hud/fog_light_on" )
local fog_off = Material( "simfphys/hud/fog_light_off" )
local cruise_on = Material( "simfphys/hud/cc_on" )
local cruise_off = Material( "simfphys/hud/cc_off" )
local hbrake_on = Material( "simfphys/hud/handbrake_on" )
local hbrake_off = Material( "simfphys/hud/handbrake_off" )
local HUD_1 = Material( "simfphys/hud/hud" )
local HUD_2 = Material( "simfphys/hud/hud_center" )
local HUD_3 = Material( "simfphys/hud/hud_center_red" )
local HUD_5 = file.Exists( "materials/simfphys/hud/hud_5.vmt", "GAME") and Material( "simfphys/hud/hud_5" ) or false
local ForceSimpleHud = not file.Exists( "materials/simfphys/hud/hud.vmt", "GAME" ) -- lets check if the background material exists, if not we will force the old hud to prevent fps drop
local smHider = 0

local ShowHud = false
local ShowHud_ms = false
local AltHud = false
local AltHudarcs = false
local Hudmph = false
local Hudmpg = false
local Hudreal = false
local isMouseSteer = false
local hasCounterSteerEnabled = false
local slushbox = false
local hudoffset_x = 0
local hudoffset_y = 0

local turnmenu = KEY_COMMA

local ms_sensitivity = 1
local ms_fade = 1
local ms_deadzone = 1.5
local ms_exponent = 2
local ms_key_freelook = KEY_Y

cvars.AddChangeCallback( "cl_simfphys_hud", function( convar, oldValue, newValue ) ShowHud = tonumber( newValue )~=0 end)
cvars.AddChangeCallback( "cl_simfphys_hud_offset_x", function( convar, oldValue, newValue ) hudoffset_x = newValue end)
cvars.AddChangeCallback( "cl_simfphys_hud_offset_y", function( convar, oldValue, newValue ) hudoffset_y = newValue end)
cvars.AddChangeCallback( "cl_simfphys_ms_hud", function( convar, oldValue, newValue ) ShowHud_ms = tonumber( newValue )~=0 end)
cvars.AddChangeCallback( "cl_simfphys_althud", function( convar, oldValue, newValue ) AltHud = tonumber( newValue )~=0 end)
cvars.AddChangeCallback( "cl_simfphys_althud_arcs", function( convar, oldValue, newValue ) AltHudarcs = tonumber( newValue )~=0 end)
cvars.AddChangeCallback( "cl_simfphys_hudmph", function( convar, oldValue, newValue ) Hudmph = tonumber( newValue )~=0 end)
cvars.AddChangeCallback( "cl_simfphys_hudmpg", function( convar, oldValue, newValue ) Hudmpg = tonumber( newValue )~=0 end)
cvars.AddChangeCallback( "cl_simfphys_hudrealspeed", function( convar, oldValue, newValue ) Hudreal = tonumber( newValue )~=0 end)
cvars.AddChangeCallback( "cl_simfphys_mousesteer", function( convar, oldValue, newValue ) isMouseSteer = tonumber( newValue )~=0 end)
cvars.AddChangeCallback( "cl_simfphys_ctenable", function( convar, oldValue, newValue ) hasCounterSteerEnabled = tonumber( newValue )~=0 end)
cvars.AddChangeCallback( "cl_simfphys_auto", function( convar, oldValue, newValue ) slushbox = tonumber( newValue )~=0 end)
cvars.AddChangeCallback( "cl_simfphys_ms_sensitivity", function( convar, oldValue, newValue )  ms_sensitivity = tonumber( newValue ) end)
cvars.AddChangeCallback( "cl_simfphys_ms_return", function( convar, oldValue, newValue )  ms_fade = tonumber( newValue ) end)
cvars.AddChangeCallback( "cl_simfphys_ms_deadzone", function( convar, oldValue, newValue )  ms_deadzone = tonumber( newValue ) end)
cvars.AddChangeCallback( "cl_simfphys_ms_exponent", function( convar, oldValue, newValue ) ms_exponent = tonumber( newValue ) end)
cvars.AddChangeCallback( "cl_simfphys_ms_keyfreelook", function( convar, oldValue, newValue ) ms_key_freelook = tonumber( newValue ) end)
cvars.AddChangeCallback( "cl_simfphys_key_turnmenu", function( convar, oldValue, newValue ) turnmenu = tonumber( newValue ) end)

ShowHud = GetConVar( "cl_simfphys_hud" ):GetBool()
hudoffset_x = GetConVar( "cl_simfphys_hud_offset_x" ):GetFloat()
hudoffset_y = GetConVar( "cl_simfphys_hud_offset_y" ):GetFloat()
ShowHud_ms = GetConVar( "cl_simfphys_ms_hud" ):GetBool()
AltHud = GetConVar( "cl_simfphys_althud" ):GetBool()
AltHudarcs = GetConVar( "cl_simfphys_althud_arcs" ):GetBool()
Hudmph = GetConVar( "cl_simfphys_hudmph" ):GetBool()
Hudmpg = GetConVar( "cl_simfphys_hudmpg" ):GetBool()
Hudreal = GetConVar( "cl_simfphys_hudrealspeed" ):GetBool()
isMouseSteer = GetConVar( "cl_simfphys_mousesteer" ):GetBool()
hasCounterSteerEnabled = GetConVar( "cl_simfphys_ctenable" ):GetBool()
slushbox = GetConVar( "cl_simfphys_auto" ):GetBool()
turnmenu = GetConVar( "cl_simfphys_key_turnmenu" ):GetInt()

ms_sensitivity = GetConVar( "cl_simfphys_ms_sensitivity" ):GetFloat()
ms_fade = GetConVar( "cl_simfphys_ms_return" ):GetFloat()
ms_deadzone = GetConVar( "cl_simfphys_ms_deadzone" ):GetFloat()
ms_exponent = GetConVar( "cl_simfphys_ms_exponent" ):GetFloat()
ms_key_freelook = GetConVar( "cl_simfphys_ms_keyfreelook" ):GetInt()

local ms_pos_x = 0
local sm_throttle = 0

hook.Add( "StartCommand", "simfphysmove", function( ply, cmd )
	if ply ~= LocalPlayer() then return end

	local vehicle = ply:GetVehicle()
	if not IsValid(vehicle) then return end

	if isMouseSteer then
		local freelook = input.IsButtonDown( ms_key_freelook )
		ply.Freelook = freelook
		if not freelook then
			local frametime = FrameTime()

			local ms_delta_x = cmd:GetMouseX()
			local ms_return = ms_fade * frametime

			local Moving = math.abs(ms_delta_x) > 0

			ms_pos_x = Moving and math.Clamp(ms_pos_x + ms_delta_x * frametime * 0.05 * ms_sensitivity,-1,1) or (ms_pos_x + math.Clamp(-ms_pos_x,-ms_return,ms_return))

			SteerVehicle = ((math.max( math.abs(ms_pos_x) - ms_deadzone / 16, 0) ^ ms_exponent) / (1 - ms_deadzone / 16))  * ((ms_pos_x > 0) and 1 or -1)

		end
	else
		SteerVehicle = 0
	end

	net.Start( "simfphys_mousesteer" )
		net.WriteEntity( vehicle )
		net.WriteFloat( SteerVehicle )
	net.SendToServer()
end)

local function drawsimfphysHUD(vehicle,SeatCount)
	if isMouseSteer and ShowHud_ms then
		local MousePos = ms_pos_x
		local m_size = sizex * 0.15

		draw.SimpleText( "V", "simfphysfont", sizex * 0.5 + MousePos * m_size - 1, sizey * 0.45, Color( 240, 230, 200, 255 ), 1, 1 )
		draw.SimpleText( "[", "simfphysfont", sizex * 0.5 - m_size * 1.05, sizey * 0.45, Color( 240, 230, 200, 180 ), 1, 1 )
		draw.SimpleText( "]", "simfphysfont", sizex * 0.5 + m_size * 1.05, sizey * 0.45, Color( 240, 230, 200, 180 ), 1, 1 )

		if (ms_deadzone > 0) then
			draw.SimpleText( "^", "simfphysfont", sizex * 0.5 - (ms_deadzone / 16) * m_size, sizey * 0.453, Color( 240, 230, 200, 180 ), 1, 2 )
			draw.SimpleText( "^", "simfphysfont", sizex * 0.5 + (ms_deadzone / 16) * m_size, sizey * 0.453, Color( 240, 230, 200, 180 ), 1, 2 )
		else
			draw.SimpleText( "^", "simfphysfont", sizex * 0.5, sizey * 0.453, Color( 240, 230, 200, 180 ), 1, 2 )
		end
	end
end

local turnmode = 0
local turnmenu_wasopen = false

local function drawTurnMenu( vehicle )

	if input.IsKeyDown( GetConVar( "cl_simfphys_keyforward" ):GetInt() ) or  input.IsKeyDown( GetConVar( "cl_simfphys_key_air_forward" ):GetInt() ) then
		turnmode = 0
	end

	if input.IsKeyDown( GetConVar( "cl_simfphys_keyleft" ):GetInt() ) or input.IsKeyDown( GetConVar( "cl_simfphys_key_air_left" ):GetInt() ) then
		turnmode = 2
	end

	if input.IsKeyDown( GetConVar( "cl_simfphys_keyright" ):GetInt() ) or input.IsKeyDown( GetConVar( "cl_simfphys_key_air_right" ):GetInt() ) then
		turnmode = 3
	end

	if input.IsKeyDown( GetConVar( "cl_simfphys_keyreverse" ):GetInt() ) or input.IsKeyDown( GetConVar( "cl_simfphys_key_air_reverse" ):GetInt() ) then
		turnmode = 1
	end

	local cX = ScrW() / 2
	local cY = ScrH() / 2

	local sx = sizex * 0.065
	local sy = sizex * 0.065

	local selectorX = (turnmode == 2 and (-sx - 1) or 0) + (turnmode == 3 and (sx + 1) or 0)
	local selectorY = (turnmode == 0 and (-sy - 1) or 0)

	draw.RoundedBox( 8, cX - sx * 0.5 - 1 + selectorX, cY - sy * 0.5 - 1 + selectorY, sx + 2, sy + 2, Color( 240, 200, 0, 255 ) )
	draw.RoundedBox( 8, cX - sx * 0.5 + selectorX, cY - sy * 0.5 + selectorY, sx, sy, Color( 50, 50, 50, 255 ) )

	draw.RoundedBox( 8, cX - sx * 0.5, cY - sy * 0.5, sx, sy, Color( 0, 0, 0, 100 ) )
	draw.RoundedBox( 8, cX - sx * 0.5, cY - sy * 1.5 - 1, sx, sy, Color( 0, 0, 0, 100 ) )
	draw.RoundedBox( 8, cX - sx * 1.5 - 1, cY - sy * 0.5, sx, sy, Color( 0, 0, 0, 100 ) )
	draw.RoundedBox( 8, cX + sx * 0.5 + 1, cY - sy * 0.5, sx, sy, Color( 0, 0, 0, 100 ) )

	surface.SetDrawColor( 240, 200, 0, 100 )
	--X
	if turnmode == 0 then
		surface.SetDrawColor( 240, 200, 0, 255 )
	end
	surface.DrawLine( cX - sx * 0.3, cY - sy - sy * 0.3, cX + sx * 0.3, cY - sy + sy * 0.3 )
	surface.DrawLine( cX + sx * 0.3, cY - sy - sy * 0.3, cX - sx * 0.3, cY - sy + sy * 0.3 )
	surface.SetDrawColor( 240, 200, 0, 100 )

	-- <=
	if turnmode == 2 then
		surface.SetDrawColor( 240, 200, 0, 255 )
	end
	surface.DrawLine( cX - sx + sx * 0.3, cY - sy * 0.15, cX - sx + sx * 0.3, cY + sy * 0.15 )
	surface.DrawLine( cX - sx + sx * 0.3, cY + sy * 0.15, cX - sx, cY + sy * 0.15 )
	surface.DrawLine( cX - sx + sx * 0.3, cY - sy * 0.15, cX - sx, cY - sy * 0.15 )
	surface.DrawLine( cX - sx, cY - sy * 0.3, cX - sx, cY - sy * 0.15 )
	surface.DrawLine( cX - sx, cY + sy * 0.3, cX - sx, cY + sy * 0.15 )
	surface.DrawLine( cX - sx, cY + sy * 0.3, cX - sx - sx * 0.3, cY )
	surface.DrawLine( cX - sx, cY - sy * 0.3, cX - sx - sx * 0.3, cY )
	surface.SetDrawColor( 240, 200, 0, 100 )

	-- =>
	if turnmode == 3 then
		surface.SetDrawColor( 240, 200, 0, 255 )
	end
	surface.DrawLine( cX + sx - sx * 0.3, cY - sy * 0.15, cX + sx - sx * 0.3, cY + sy * 0.15 )
	surface.DrawLine( cX + sx - sx * 0.3, cY + sy * 0.15, cX + sx, cY + sy * 0.15 )
	surface.DrawLine( cX + sx - sx * 0.3, cY - sy * 0.15, cX + sx, cY - sy * 0.15 )
	surface.DrawLine( cX + sx, cY - sy * 0.3, cX + sx, cY - sy * 0.15 )
	surface.DrawLine( cX + sx, cY + sy * 0.3, cX + sx, cY + sy * 0.15 )
	surface.DrawLine( cX + sx, cY + sy * 0.3, cX + sx + sx * 0.3, cY )
	surface.DrawLine( cX + sx, cY - sy * 0.3, cX + sx + sx * 0.3, cY )
	surface.SetDrawColor( 240, 200, 0, 100 )

	-- ^
	if turnmode == 1 then
		surface.SetDrawColor( 240, 200, 0, 255 )
	end
	surface.DrawLine( cX, cY - sy * 0.4, cX + sx * 0.4, cY + sy * 0.3 )
	surface.DrawLine( cX, cY - sy * 0.4, cX - sx * 0.4, cY + sy * 0.3 )
	surface.DrawLine( cX + sx * 0.4, cY + sy * 0.3, cX - sx * 0.4, cY + sy * 0.3 )
	surface.DrawLine( cX, cY - sy * 0.26, cX + sx * 0.3, cY + sy * 0.24 )
	surface.DrawLine( cX, cY - sy * 0.26, cX - sx * 0.3, cY + sy * 0.24 )
	surface.DrawLine( cX + sx * 0.3, cY + sy * 0.24, cX - sx * 0.3, cY + sy * 0.24 )

	surface.SetDrawColor( 255, 255, 255, 255 )
end

local LockText = Material( "lfs_locked.png" )
local function PaintSeatSwitcher( ent, pSeats, SeatCount )
	if not ShowHud then return end

	local X = ScrW()
	local Y = ScrH()

	local me = LocalPlayer()

	if SeatCount <= 0 then return end

	pSeats[0] = ent:GetDriverSeat()

	draw.NoTexture()

	local MySeat = me:GetVehicle():GetNWInt( "pPodIndex", -1 )

	local Passengers = {}
	for _, ply in pairs( player.GetAll() ) do
		if ply:GetSimfphys() == ent then
			local Pod = ply:GetVehicle()
			Passengers[ Pod:GetNWInt( "pPodIndex", -1 ) ] = ply:GetName()
		end
	end

	me.SwitcherTime = me.SwitcherTime or 0
	me.oldPassengersmf = me.oldPassengersmf or {}

	local Time = CurTime()
	for k, v in pairs( Passengers ) do
		if me.oldPassengersmf[k] ~= v then
			me.oldPassengersmf[k] = v
			me.SwitcherTime = Time + 2
		end
	end

	for k, v in pairs( me.oldPassengersmf ) do
		if not Passengers[k] then
			me.oldPassengersmf[k] = nil
			me.SwitcherTime = Time + 2
		end
	end

	for _, v in pairs( simfphys.pSwitchKeysInv ) do
		if input.IsKeyDown(v) then
			me.SwitcherTime = Time + 2
		end
	end

	local Hide = me.SwitcherTime > Time
	smHider = smHider + ((Hide and 1 or 0) - smHider) * RealFrameTime() * 15
	local Alpha1 = 135 + 110 * smHider
	local HiderOffset = 300 * smHider
	local Offset = -50
	local yPos = Y - (SeatCount + 1) * 30 - 10

	if me:IsDrivingSimfphys() and (AltHud and not ForceSimpleHud and not ent:GetNWBool( "simfphys_NoRacingHud", false )) then
		Offset = -50 + hudoffset_x * screenw
		yPos = y + radius * 1.2 - (SeatCount + 1) * 30 - 10 + hudoffset_y * screenh
	end

	for _, Pod in pairs( pSeats ) do
		local I = Pod:GetNWInt( "pPodIndex", -1 )
		if I >= 0 then
			if I == MySeat then
				draw.RoundedBox(5, X + Offset - HiderOffset, yPos + I * 30, 35 + HiderOffset, 25, Color(0,127,255,100 + 50 * smHider) )
			else
				draw.RoundedBox(5, X + Offset - HiderOffset, yPos + I * 30, 35 + HiderOffset, 25, Color(0,0,0,100 + 50 * smHider) )
			end
			if I == SeatCount then
				if ent:GetIsVehicleLocked() then
					surface.SetDrawColor( 255, 255, 255, 255 )
					surface.SetMaterial( LockText  )
					surface.DrawTexturedRect( X + Offset - HiderOffset - 25, yPos + I * 30, 25, 25 )
				end
			end
			if Hide then
				if Passengers[I] then
					draw.DrawText( Passengers[I], "SimfphysFont_seatswitcher", X + 40 + Offset - HiderOffset, yPos + I * 30 + 2.5, Color( 255, 255, 255,  Alpha1 ), TEXT_ALIGN_LEFT )
				else
					draw.DrawText( "-", "SimfphysFont_seatswitcher", X + 40 + Offset - HiderOffset, yPos + I * 30 + 2.5, Color( 255, 255, 255,  Alpha1 ), TEXT_ALIGN_LEFT )
				end

				draw.DrawText( "["..I.."]", "SimfphysFont_seatswitcher", X + 17 + Offset - HiderOffset, yPos + I * 30 + 2.5, Color( 255, 255, 255, Alpha1 ), TEXT_ALIGN_CENTER )
			else
				if Passengers[I] then
					draw.DrawText( "[^"..I.."]", "SimfphysFont_seatswitcher", X + 17 + Offset - HiderOffset, yPos + I * 30 + 2.5, Color( 255, 255, 255, Alpha1 ), TEXT_ALIGN_CENTER )
				else
					draw.DrawText( "["..I.."]", "SimfphysFont_seatswitcher", X + 17 + Offset - HiderOffset, yPos + I * 30 + 2.5, Color( 255, 255, 255, Alpha1 ), TEXT_ALIGN_CENTER )
				end
			end
		end
	end
end

hook.Add( "HUDPaint", "simfphys_HUD", function()
	local ply = LocalPlayer()
	local turnmenu_isopen = false

	if not IsValid( ply ) or not ply:Alive() then turnmenu_wasopen = false return end

	local vehicle = ply:GetVehicle()
	local vehiclebase = ply:GetSimfphys()

	if not IsValid( vehicle ) or not IsValid( vehiclebase ) then
		ply.oldPassengersmf = {}

		turnmenu_wasopen = false
		smHider = 0
		return
	end

	local pSeats = vehiclebase:GetPassengerSeats()
	local SeatCount = table.Count( pSeats )

	PaintSeatSwitcher( vehiclebase, pSeats, SeatCount )

	if not ply:IsDrivingSimfphys() then turnmenu_wasopen = false return end

	drawsimfphysHUD( vehiclebase, SeatCount )

	if vehiclebase.HasTurnSignals and input.IsKeyDown( turnmenu ) then
		turnmenu_isopen = true

		drawTurnMenu( vehiclebase )
	end

	if turnmenu_isopen ~= turnmenu_wasopen then
		turnmenu_wasopen = turnmenu_isopen

		if turnmenu_isopen then
			turnmode = 0
		else
			net.Start( "simfphys_turnsignal" )
				net.WriteEntity( vehiclebase )
				net.WriteInt( turnmode, 32 )
			net.SendToServer()

			if turnmode == 1 or turnmode == 2 or turnmode == 3 then
				vehiclebase:EmitSound( "simulated_vehicles/sfx/turnsignal_start.ogg" )
			else
				vehiclebase:EmitSound( "simulated_vehicles/sfx/turnsignal_end.ogg" )
			end
		end
	end
end)

function drawsimfphysHUD_2( vehicle )

	local vehicledata = list.Get( 'simfphys_vehicles' )[ vehicle:GetSpawn_List() ]

	local offsetvec = vehicledata.HUDOffsetVector or Vector( 55, 45.5, 50 )
	local offsetang = Angle( -180, 90, 270 )

	local pos, ang = LocalToWorld( offsetvec, offsetang, vehicle:GetPos(), vehicle:GetAngles() )

	local maxrpm = vehicle:GetLimitRPM()
	local rpm = vehicle:GetRPM()
	local powerbandend = math.min( vehicle:GetPowerBandEnd(), maxrpm )
	local redline = math.max( rpm - powerbandend, 0 ) / ( maxrpm - powerbandend )

	local speed = vehicle:GetVelocity():Length()
	local kmh = math.Round( speed * 0.09144, 0 )

	local gear = vehicle:GetGear()
	local DrawGear = not slushbox and ( gear == 1 and 'R' or gear == 2 and 'N' or ( gear - 2 ) ) or ( gear == 1 and 'R' or gear == 2 and 'N' or '(' .. ( gear - 2 ) .. ')' )

	local fuel = vehicle:GetFuel() / vehicle:GetMaxFuel()
	local fueltype = vehicle:GetFuelType()
	local fueltype_color = Color( 0, 127, 255, 150 )

	if fueltype == 1 then
		fueltype_color = Color( 240, 200, 0, 150 )
	elseif fueltype == 2 then
		fueltype_color = Color( 255, 60, 0, 150 )
	end

	local LightsOn = vehicle:GetLightsEnabled()
	local LampsOn = vehicle:GetLampsEnabled()
	local HandBrakeOn = vehicle:GetHandBrakeEnabled()

	surface.SetFont( 'simfphysfont' )
	local w, h = surface.GetTextSize( kmh .. ' km/h' )

	surface.SetFont( 'simfphysfont' )
	local w2, h2 = surface.GetTextSize( 'GEAR: ' .. DrawGear )

	cam.Start3D2D( pos, ang, 0.15 )
		cam.IgnoreZ( true )

			surface.SetDrawColor( 0, 0, 0, 80 )
			surface.DrawRect( 0, 0, 5, 60 )

			surface.SetDrawColor( fueltype_color )
			surface.DrawRect( 0, 60, 5, -fuel * 60 )

			surface.SetDrawColor( 0, 0, 0, 80 )
			surface.DrawRect( 20, 20, 125, 20 )

			surface.SetDrawColor( 175, 175 * ( 1 - redline ), 175 * ( 1 - redline ) )
			surface.DrawRect( 20, 20, rpm / maxrpm * 125, 20 )

			draw.SimpleText( kmh .. ' km/h', 'simfphysfont', 25 + 75 - w * 0.5, 30 - h * 0.5, Color( 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
			draw.SimpleText( 'GEAR: ' .. DrawGear, 'simfphysfont', 125 + 30, 28 - h2 * 0.5, Color( 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )

			surface.SetDrawColor( 255, 255, 255, 255 )
			surface.SetMaterial( HandBrakeOn and hbrake_on or hbrake_off )
			surface.DrawTexturedRect( 240, 14, 32, 32 )

			surface.SetDrawColor( 255, 255, 255, 255 )
			surface.SetMaterial( LightsOn and ( LampsOn and lights_on2 or lights_on ) or lights_off )
			surface.DrawTexturedRect( 280, 14, 32, 32 )

		cam.IgnoreZ( false )
	cam.End3D2D()

end

hook.Add( 'PostDrawTranslucentRenderables', 'simfphys_HUD', function()

	local ply = LocalPlayer()

	if not IsValid( ply ) or not ply:Alive() then return end

	local vehicle = ply:GetVehicle()
	local vehiclebase = ply:GetSimfphys()

	if not IsValid( vehicle ) or not IsValid( vehiclebase ) then
		return
	end

	if not ply:IsDrivingSimfphys() then return end

	drawsimfphysHUD_2( vehiclebase, vehicle )

end )

local TipColor = Color( 0, 127, 255, 255 )
hook.Add("HUDPaint", "simfphys_vehicleditorinfo", function()
	local ply = LocalPlayer()

	if ply:InVehicle() then return end

	local wep = ply:GetActiveWeapon()
	if not IsValid( wep ) or wep:GetClass() ~= "gmod_tool" or ply:GetInfo("gmod_toolmode") ~= "simfphyseditor" then return end

	local trace = ply:GetEyeTrace()

	local Ent = trace.Entity

	if not simfphys.IsCar( Ent ) then return end

	local vInfo = Ent:GetVehicleInfo()

	if not istable( vInfo ) or not vInfo["maxspeed"] or not vInfo["horsepower"] or not vInfo["weight"] or not vInfo["torque"] then return end

	local SpeedMul = Hudmph and (Hudreal and 0.0568182 or 0.0568182 * 0.75) or (Hudreal and 0.09144 or 0.09144 * 0.75)
	local SpeedSuffix = Hudmph and "mph" or "km/h"
	local toSize = Hudreal and (1/0.75) or 1
	local nameSize = Hudreal and "\n\nNote: values are based on playersize" or ""
	local TopSpeed = math.Round( vInfo["maxspeed"] * SpeedMul )
	local HP = math.Round( vInfo["horsepower"] * toSize )
	local Weight = math.Round( vInfo["weight"] )
	local PowerToWeight = math.Round(Weight / HP,1)
	local PeakTorque = math.Round( vInfo["torque"] * toSize )

	local text = "Peak Power: "..HP.." HP".."\nPeak Torque: "..PeakTorque.." Nm\nTop Speed: "..tostring( TopSpeed )..SpeedSuffix.." (theoretical max)".."\nWeight: "..Weight.." kg ("..PowerToWeight.." kg / HP)"..nameSize

	local pos = Ent:LocalToWorld( Ent:OBBCenter() ):ToScreen()

	local black = Color( 255, 255, 255, 255 )
	local tipcol = Color( TipColor.r, TipColor.g, TipColor.b, 255 )

	local x = 0
	local y = 0
	local padding = 10
	local offset = 50

	surface.SetFont( "simfphysworldtip" )
	local w, h = surface.GetTextSize( text )

	x = pos.x - w
	y = pos.y - h

	x = x - offset
	y = y - offset

	draw.RoundedBox( 8, x-padding-2, y-padding-2, w+padding*2+4, h+padding*2+4, black )


	local verts = {}
	verts[1] = { x=x+w/1.5-2, y=y+h+2 }
	verts[2] = { x=x+w+2, y=y+h/2-1 }
	verts[3] = { x=pos.x-offset/2+2, y=pos.y-offset/2+2 }

	draw.NoTexture()
	surface.SetDrawColor( 255, 255, 255, tipcol.a )
	surface.DrawPoly( verts )


	draw.RoundedBox( 8, x-padding, y-padding, w+padding*2, h+padding*2, tipcol )

	local verts = {}
	verts[1] = { x=x+w/1.5, y=y+h }
	verts[2] = { x=x+w, y=y+h/2 }
	verts[3] = { x=pos.x-offset/2, y=pos.y-offset/2 }

	draw.NoTexture()
	surface.SetDrawColor( tipcol.r, tipcol.g, tipcol.b, tipcol.a )
	surface.DrawPoly( verts )


	draw.DrawText( text, "simfphysworldtip", x + w/2, y, black, TEXT_ALIGN_CENTER )
end)