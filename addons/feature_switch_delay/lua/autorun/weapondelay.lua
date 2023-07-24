--[[
addons/func_switchdelay/lua/autorun/weaponswitchdelay.lua
--]]
-- SETTINGS

-- Time to equip the weapon in seconds.
local EquipTime = 1.1

-- Show the count down timer next to the progress bar.
local ShowCountdownTimer = false
-- How many decimals you want to show (default = 2 so it will be this: 1.59)
local CountdownTimerDecimals = 2

-- View model when player is switching weapons.
local ShouldViewModel = false
-- If ShouldViewModel is true then it will show this model.
local WeaponSwitchModel = "models/weapons/w_pist_elite.mdl"

-- Key to cancel the switching. If you want to disable this change it to nil.
local SwitchingCancelKey = IN_RELOAD
-- First reload will tell the player how to cancel the switching, this will need a name. To disable this change it to nil.
local SwitchingCancelKeyName = "Reload"

-- Allow the player to switch to a white listed weapon while switching. (This will not stop the switching to the other weapon)
local CanSwitchToWsWhileSwitching = true

-- Send a chat message to the player when the weapon is switched.
local EnableSendChatMessage = false
local function SendChatMessage( ply, weaponName )
    -- If you do not know what this does, leave it as it is.
    -- Feel free to change this to anything you'd like.
    -- Server side, so make sure to use server sided stuff only.
    
    if DarkRP then
        ply:ConCommand( "say /me достал " .. weaponName .. "!" )
    else
        ply:ChatPrint( "Switched to " .. weaponName .. "!" )
    end
    
end

-- This is a temporary fix for the FAS weapons.
-- Only use this if you really need to.
local FAS_Temp_Fix = false

-- Weapons that will skip the timer.
local Whitelist = {
    "weapon_physgun",
    "weapon_physcannon",
    "gmod_tool",
    "mcr_hands",
    "salute",
    "gmod_camera",
    "stunstick",
    "arrest_stick",
    "gred_emp_kord",
    "re_hands",
    "weapon_handcuffed",
    "act3_flashlight",
    "admingun",
    "weapon_cuff_police",
    "act3_laser",
    "weapon_simfillerpistol",
    "lockpick",
    'dradio',
    'med_kit',
    'weaponchecker',
    'weapon_rdo_radio',
    'weapon_keypadchecker',
    'itemstore_pickup',
    'weapon_medkit',
    "cityworker_wrench",
    "cityworker_shovel",
    "cityworker_pliers",
    "itemstore_checker",
    "act3_axe",
    "glorifiedhandcuffs_restrained",
    "weapon_357",
    "weapon_flashlight",
    "weapon_cuff_rope",
    "arcticvr_aniv_usptactical",
    "weapon_shotgun",
    "weapon_vrmod_empty",
    "arcticvr_fisttest",
    "harm_weapon_revolver",
    "weapon_frag",
    "arcticvr_glock",
    "arcticvr_m4a1",
    "arcticvr_m1014",
    "arcticvr_ak47",
    "milsim_hands",
}

local DifferentTimeWeapons = {
    {"act3_nade_stun", 1},
    {"harm_weapon_p220", 1},
    {"harm_weapon_glock27", 1.5},
    {"stungun", 1},
    {"harm_weapon_usp", 1.2},
    {"harm_weapon_usp_s", 1.5},
    {"harm_weapon_fiveseven", 1.2},
    {"harm_weapon_beretta", 1},
    {"harm_weapon_dualelites", 1},
    {"harm_weapon_deagle", 1.1},
    {"harm_weapon_mac10", 1.2},
    {"harm_weapon_mp5", 2},
    {"harm_weapon_p90", 2},
    {"harm_weapon_tmp", 1.5},
    {"harm_weapon_ump45", 2},
    {"harm_weapon_ak47", 3},
    {"harm_weapon_awp", 3},
    {"harm_weapon_beanbang", 1},
    {"harm_weapon_famas", 3},
    {"harm_weapon_galil", 3},
    {"harm_weapon_m3", 2},
    {"harm_weapon_m4a1", 2},
    {"harm_weapon_m249", 6},
    {"harm_weapon_scout", 3},
    {"harm_weapon_sg550", 3},
    {"harm_weapon_sg552", 3},
    {"harm_weapon_xm1014", 2},
    {"harm_weapon_glock18", 1},
    {"act3_ar", 2},
    {"act3_m3", 2},
    {"harm_weapon_beanbang", 1},
    {"act3_p90", 2},
    {"act3_m249", 3},
}   

local ReducedTimeGroups = {
    -- Group, Reduced time (e.g. 0.5 makes it half the normal time, Reduced time times the normal time)
    -- This will also reduce the time of different time weapons.
    {"EXAMPLEGROUP1", 2},
    {"EXAMPLEGROUP2", 0.75}
}

-- Color of the text.
local TextColor = Color(255, 255, 255, 255)

-- Change the color of the text to black or white depending on the pixel color of the screen.
-- This lags a lot, so do not enable this.
local ChangeColorText = false

-- Size of the delay bar.
local barWidth = 200
local barHeight = 6

-- If you find any bugs or encounter any problems feel free to contact me.
-- http://steamcommunity.com/id/ikefi

-- END OF SETTINGS

local WeaponSwitch = {}

if SERVER then

    local function GetEquipTime(ply, NewWeapon)
        
        local NewEquipTime = EquipTime
    
        for _, weapon in pairs(DifferentTimeWeapons) do
            if NewWeapon:GetClass() == weapon[1] then
                NewEquipTime = weapon[2]
            end
        end
        
        for _, group in pairs(ReducedTimeGroups) do
            if group[1] == ply:GetUserGroup() then
                return NewEquipTime * group[2]
            end
        end
        
        return NewEquipTime
    end

    util.AddNetworkString("WepSwitch_EnableSwitch")
    util.AddNetworkString("WepSwitch_DisableSwitch")
    util.AddNetworkString("WepSwitch_Switching")
    util.AddNetworkString("WepSwitch_EnableSwitch_received")
    util.AddNetworkString("WepSwitch_SendSwitchingPly")

    function WeaponSwitch:DelayEquip(ply, weapon, oldweapon)
    
        ply.IsSwitchingWeapons = true -- Player is switching weapon.
        ply.CantSwitch = true -- Player can't switch weapon now.
        ply.SwitchingToWeapon = weapon
        ply.SwitchingFromWeapon = oldweapon
        
        local NewEquipTime = GetEquipTime(ply, weapon)
        
        net.Start("WepSwitch_Switching")
            net.WriteString(weapon:GetClass())
            net.WriteString(tostring(NewEquipTime))
        net.Send(ply)
        
        if ShouldViewModel then
            net.Start("WepSwitch_SendSwitchingPly")
                net.WriteString(ply:SteamID())
                net.WriteBit(true)
            net.Broadcast()
        end
    
        timer.Create("Wep_Equip_Timer" .. ply:SteamID(), NewEquipTime, 1, function()
        
            if IsValid(ply) then
                
                if ShouldViewModel then
                    net.Start("WepSwitch_SendSwitchingPly")
                        net.WriteString(ply:SteamID())
                        net.WriteBit(false)
                    net.Broadcast()
                end
            
                net.Start("WepSwitch_EnableSwitch")
                    if not IsValid(weapon) then
                        -- Weapon doesn't exist anymore, tell the client to do nothing.
                        net.WriteString("NULL")
                        -- We want the player to be able to switch again ofcourse.
                        ply.IsSwitchingWeapons = false
                        ply.CantSwitch = false
                    else
                        -- Tell the client to enable weaponswitch.
                    end
                net.Send(ply)
                
            end
            
        end)
    end
    
    net.Receive("WepSwitch_EnableSwitch_received", function(len, ply)
    
        ply.weaponName = net.ReadString() or ""

        -- Now switch the weapon.
        if IsValid(ply) and ply:Alive() then
            if IsValid(ply.SwitchingToWeapon) and ply:HasWeapon(ply.SwitchingToWeapon:GetClass()) then
                ply.CantSwitch = false
                ply:SelectWeapon(ply.SwitchingToWeapon:GetClass())
                
                --ply.SwitchingFromWeapon:CallOnClient("Holster", ply.SwitchingToWeapon)
                
                if FAS_Temp_Fix then
                
                    ply.WepSwitchAttempts = 0
                    
                    local function HasSwitched()
                    
                        if ply.SwitchingToWeapon ~= ply:GetActiveWeapon() then
                        
                            ply.IsSwitchingWeapons = true
                            ply.CantSwitch = true
                            
                            ply.WepSwitchAttempts = ply.WepSwitchAttempts + 1
                        
                            timer.Simple(0.02, function()
                            
                                ply.CantSwitch = false
                                    
                                ply:SelectWeapon(ply.SwitchingToWeapon:GetClass())
                            
                                -- We don't want it to get stuck in an infinite loop.
                                if ply.WepSwitchAttempts < 100 then
                                    HasSwitched()
                                else
                                    ply.CantSwitch = false
                                    ply.IsSwitchingWeapons = false
                                    
                                    -- Tell client to disable CanSwitch
                                    net.Start("WepSwitch_DisableSwitch")
                                    net.Send(ply)
                                end
                                
                            end)
                            
                        else

                            -- Tell client to disable CanSwitch
                            net.Start("WepSwitch_DisableSwitch")
                            net.Send(ply)
                        
                        end
                    
                    end
                    
                    HasSwitched()
                    
                else
                
                    -- Tell client to disable CanSwitch
                    net.Start("WepSwitch_DisableSwitch")
                    net.Send(ply)
                
                end
            
            else
            
                -- Tell client to disable CanSwitch
                net.Start("WepSwitch_DisableSwitch")
                net.Send(ply)
                
            end
            
        else
        
            -- Tell client to disable CanSwitch
            net.Start("WepSwitch_DisableSwitch")
            net.Send(ply)
            
        end
        
    end)
    
    local function KeyPressed(ply, key)
        if key ~= SwitchingCancelKey then return end
        if ply.IsSwitchingWeapons then
        local delays = {}
            if timer.Exists("Wep_Equip_Timer" .. ply:SteamID()) then
                timer.Destroy("Wep_Equip_Timer" .. ply:SteamID())
            end
            
            ply.CantSwitch = false
            ply.IsSwitchingWeapons = false
        
            net.Start("WepSwitch_DisableSwitch")
            net.Send(ply)
            
            if ShouldViewModel then
                net.Start("WepSwitch_SendSwitchingPly")
                    net.WriteString(ply:SteamID())
                    net.WriteBit(false)
                net.Broadcast()
            end
            
        end
    end
    hook.Add("KeyPress", "WeaponSwitch_CancelSwitch", KeyPressed)
    
end

local CanSwitch, Switching, SwitchingToWeapon

if CLIENT then

    local NewEquipTime = EquipTime
    local TimerW = 0
    local FirstSwitch = true
    local WeaponName = ""

    CanSwitch, Switching = false, false
    SwitchingToWeapon = ""
    
    local function KeyPressed(ply, key)
        if key ~= IN_RELOAD then return end
        if ply.IsSwitchingWeapons then
        local delays = {}

            
        end
    end
    hook.Add("KeyPress", "WeaponSwitch_CancelSwitch1", KeyPressed)
    net.Receive("WepSwitch_Switching", function()

        SwitchingToWeapon = net.ReadString()
        NewEquipTime = tonumber(net.ReadString())
        
        -- Get the print name of the weapon.
        WeaponName = SwitchingToWeapon -- If there is no weapon found, just in case.
        for _, weapon in pairs(ents.FindByClass(SwitchingToWeapon)) do
            WeaponName = weapon:GetPrintName() or weapon.PrintName or WeaponName
        end
        
        if not WeaponName then
            WeaponName = "undefined"
        end
        
        Switching = true
        
        -- Reset the width of the timer bar.
        TimerW = 0
    end)
    dbgView = dbgView or {}
dbgView.mods = dbgView.mods or {}

dbgView.disabledWeps = {
    gmod_camera = true,
    gmod_tool = true,
    weapon_physgun = true,
    dbg_admingun = true,
    octo_camera = true,
}
local ply, anc, prevang, lookOffActive, blind = NULL, NULL, Angle(), false, false
local ply = LocalPlayer()
local chPosOff, chAngOff, chDefault = Vector(0, 0, 0), Angle(0, 90, 90), Material('octoteam/icons/percent0.png')
local sens, lastModel, lastVeh = GetConVar('sensitivity'):GetFloat(), '', NULL
local traceMaxs, traceMins = Vector(5, 5, 3), Vector(-5, -5, -3)
local angle_zero = Angle()
local function postDrawTranslucentRenderables()
	local ply = LocalPlayer()
    local override = hook.Run('dbg-view.chShouldDraw', ply)
    if override == nil then
        local wep, veh = ply:GetActiveWeapon(), ply:GetVehicle()
        if IsValid(wep) and not dbgView.disabledWeps[wep:GetClass()] and wep.DrawCrosshair then
            override = not IsValid(veh) or ply:GetAllowWeaponsInVehicle()
        end
    end

    if not override then
        return
    end

    local aim = ply:EyeAngles():Forward()
    local tr = hook.Run('dbg-view.chTraceOverride')
    if not tr then
        local pos = ply:GetShootPos()
        local endpos = pos + aim * 2000
        tr = util.TraceLine({
            start = pos,
            endpos = endpos,
            filter = function(ent)
                return ent ~= ply and ent:GetRenderMode() ~= RENDERMODE_TRANSALPHA
            end
        })
    end

    local _icon, _alpha, _scale = hook.Run('dbg-view.chOverride', tr)
    local n = tr.Hit and tr.HitNormal or -aim
    if math.abs(n.z) > 0.98 then
        n:Add(-aim * 0.01)
    end
    local chPos, chAng = LocalToWorld(chPosOff, chAngOff, tr.HitPos or endpos, n:Angle())
    cam.Start3D2D(chPos, chAng, math.pow(tr.Fraction, 0.5) * (_scale or 0.2))
    cam.IgnoreZ(true)
    if not hook.Run('dbg-view.chPaint', tr, _icon) then
        if _icon then
            surface.SetDrawColor(255, 255, 255, _alpha or 150)
        else
            local clr = color_white
            surface.SetDrawColor(clr.r, clr.g, clr.b, _alpha or 150)
        end
        surface.SetMaterial(_icon or chDefault)
        surface.DrawTexturedRect(-32, -32, 64, 64)
    end
    cam.IgnoreZ(false)
    cam.End3D2D()

end
hook.Add('PostDrawTranslucentRenderables', 'dbg-view', postDrawTranslucentRenderables)
local delays = {}

surface.CreateFont('octolib.use', {
    font = 'Calibri',
    extended = true,
    size = 82,
    weight = 350,
})

surface.CreateFont('octolib.use-sh', {
    font = 'Calibri',
    extended = true,
    size = 82,
    weight = 350,
    blursize = 5,
})
local cx, cy = 0, 0
local size = 40
local p1, p2 = {}, {}
for i = 1, 36 do
    local a1 = math.rad((i - 1) * -10 + 180)
    local a2 = math.rad(i * -10 + 180)
    p1[i] = {
        x = cx + math.sin(a1) * size,
        y = cy + math.cos(a1) * size
    }
    p2[i] = {
        {
            x = cx,
            y = cy
        },
        {
            x = cx + math.sin(a1) * size,
            y = cy + math.cos(a1) * size
        },
        {
            x = cx + math.sin(a2) * size,
            y = cy + math.cos(a2) * size
        },
    }
end
local override
hook.Add('dbg-view.chShouldDraw', 'octolib.delay', function()
    override = table.Count(delays) > 0
    if override then
        return true          
    end
end)

hook.Add('dbg-view.chPaint', 'octolib.delay', function(tr, icon)
    for id, data in pairs(delays) do
        local segs = math.min(math.ceil((CurTime() - data.start) / data.time * 36), 36)
        local text = data.text .. ('.'):rep(math.floor(CurTime() * 2 % 4))
        draw.SimpleText(text, 'octolib.use-sh', 0 + 60, 0, color_black, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(text, 'octolib.use', 0 + 60, 0, Color(255, 255, 255, 200), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.NoTexture()
        surface.SetDrawColor(255, 255, 255, 25)
        surface.DrawPoly(p1)
        surface.SetDrawColor(255, 255, 255, 150)
        for i = 1, segs do
            surface.DrawPoly(p2[i])
        end
        return true
    end
end)
hook.Add('dbg-view.chOverride', 'octolib.delay', function(tr, icon)
    local ply = LocalPlayer()
    if override and (not tr.Hit or tr.Fraction > 0.03) then
        local aim = (ply.viewAngs or ply:EyeAngles()):Forward()
        tr.HitPos = ply:GetShootPos() + aim * 60
        tr.HitNormal = -aim
        tr.Fraction = 0.03
    end
end)

    net.Receive("WepSwitch_EnableSwitch", function()
        
        local weapon = net.ReadString()
        
        if weapon == "NULL" then
            CanSwitch = false
            Switching = false
            return
        end
        
        CanSwitch = true
        
        net.Start("WepSwitch_EnableSwitch_received")
            net.WriteString( WeaponName or "" )
        net.SendToServer()
    end)

    net.Receive("WepSwitch_DisableSwitch", function()
        CanSwitch = false
        Switching = false
        FirstSwitch = false
        
    end)
    
    net.Receive("WepSwitch_SendSwitchingPly", function()
        local SteamID = net.ReadString()
        local bool = net.ReadBit()

        for _, ply in pairs(player.GetAll()) do
            if ply:SteamID() == SteamID then
                if bool == 1 then
                    ply.SwitchingWeapon = true
                else
                    ply.SwitchingWeapon = false
                end
            end
        end
        
    end)
    
    local CanChangeColor = 1
    
    local function PaintTimer()
        if Switching then
            local id = 1
            local time = NewEquipTime 
            local text = 'Смена оружия'
	        if (cd or 0) < CurTime() then
	            cd = CurTime() + time * 2
	            delays[id] = {
	                text = text,
	                start = CurTime(),
	                time = time,
	            }
	        end
        else
        	cd = 0
        	local id = 1
 			local time = NewEquipTime
 			delays[id] = nil
        end
    end

    hook.Add("DrawOverlay", "WeaponSwitch_Paint", PaintTimer)
    
end

local function IsWhitelisted(weapon)
    if table.HasValue(Whitelist, weapon:GetClass()) then return true end
    return false
end

local switchsound = {
    "npc/combine_soldier/gear1.wav",
    "npc/combine_soldier/gear2.wav",
}

local function OnWeaponSwitch(ply, old, new)

    if IsWhitelisted(new) then -- Skip the weapon switch.
        
        if not CanSwitchToWsWhileSwitching then
        
            if SERVER then
                
                if ply.IsSwitchingWeapons then
                    return true
                end
                
            else
            
                if Switching then
                    return true
                end
                
            end
        end
        
    else
    
        if SERVER then

            ply:DoAnimationEvent(ACT_GMOD_GESTURE_ITEM_PLACE)
            ply:EmitSound( switchsound[math.random(#switchsound)], 60, 100 )
            
            -- If player isn't switching these should both be false.
            if not ply.CantSwitch and not ply.IsSwitchingWeapons then
                WeaponSwitch:DelayEquip(ply, new, old)
            end

            -- Will be true after the timer succeeded, so we can switch the weapon.
            if not ply.CantSwitch then
            
                if EnableSendChatMessage then
                    if ply.weaponName and ply.weaponName != "" then
                        SendChatMessage( ply, ply.weaponName )
                        ply.weaponName = ""
                    end
                end
                
                ply.IsSwitchingWeapons = false
                return false
            else
                return true
            end
            
        else

            --LocalPlayer():EmitSound("physics/cardboard/cardboard_box_break1.wav",50)
            LocalPlayer():DoAnimationEvent(ACT_GMOD_GESTURE_ITEM_PLACE)
        
            if not CanSwitch then
                return true
            end

            if SwitchingToWeapon == new:GetClass() then -- Should be, just to make sure.
                
                SwitchingToWeapon = ""
                CanSwitch = false
                return false
            else
                return true
            end
            
        end
    end
    
end
hook.Add("PlayerSwitchWeapon", "WeaponSwitch_Hook", OnWeaponSwitch)

