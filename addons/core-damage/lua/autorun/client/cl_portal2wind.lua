local WooshSound = nil
local cl_fallingwind_threshold = CreateClientConVar("cl_fallingwind_threshold", "650", true, false, "Threshold that determines when the wind will begin", 0, nil):GetInt()
local cl_fallingwind_limit = CreateClientConVar("cl_fallingwind_limit", "1500", true, false, "Threshold used to determine where the wind is at it's full volume and pitch", 0, nil):GetInt()
local cl_fallingwind_enable = CreateClientConVar("cl_fallingwind_enable", "1", true, false, "Enable or disable the wind sound", 0, 1):GetBool()
local cl_fallingwind_volume = CreateClientConVar("cl_fallingwind_volume", "0.75", true, false, "Alters the wind sound's volume", 0, 1):GetFloat()
local cl_fallingwind_altsoundenable = CreateClientConVar("cl_fallingwind_altsoundenable", "0", true, false, "Replaces the wind sound with Portal 1's one", 0, 1):GetBool()
local cl_fallingwind_xvelocityfactor = CreateClientConVar("cl_fallingwind_xvelocityfactor", "1", true, false, "How much of your X-Axis velocity factors in when calculating if your speed is over the specified threshold", 0, 1):GetFloat()
local cl_fallingwind_yvelocityfactor = CreateClientConVar("cl_fallingwind_yvelocityfactor", "1", true, false, "How much of your Y-Axis velocity factors in when calculating if your speed is over the specified threshold", 0, 1):GetFloat()
local cl_fallingwind_zvelocityfactor = CreateClientConVar("cl_fallingwind_zvelocityfactor", "1", true, false, "How much of your Z-Axis velocity factors in when calculating if your speed is over the specified threshold", 0, 1):GetFloat()
do
    local function GetWooshSound() 
        if not cl_fallingwind_altsoundenable then
            return "woosh/player_fall_whoosh_portal2.wav"
        else
            return "woosh/player_fall_whoosh_portal1.wav"
        end
    end
    local function doWind()
        if not cl_fallingwind_enable then return end
        if not IsValid(LocalPlayer()) then return end
        if WooshSound == nil then WooshSound = CreateSound( LocalPlayer(), GetWooshSound() ) end
        if LocalPlayer():GetMoveType() == 0 or LocalPlayer():GetMoveType() == 8 then WooshSound:Stop(); return; end

        local num = 0
        local vel = LocalPlayer():GetAbsVelocity()
        local vec = Vector(vel.x*cl_fallingwind_xvelocityfactor, vel.y*cl_fallingwind_yvelocityfactor, vel.z*cl_fallingwind_zvelocityfactor):Length()
        if vec > cl_fallingwind_threshold then
            if not WooshSound:IsPlaying() then WooshSound:PlayEx(0, 100) end
            num = vec-cl_fallingwind_threshold
        end
        WooshSound:ChangeVolume( cl_fallingwind_volume*math.Clamp(num/cl_fallingwind_limit, 0, 1) )
        WooshSound:ChangePitch( Lerp(num/cl_fallingwind_limit, 50, 150) )
	end

	if (cl_fallingwind_enable) then
		hook.Add("Think", "Portal2FallingWindSound", doWind)
	end

	cvars.AddChangeCallback("cl_fallingwind_enable", function(var, old, new)
        cl_fallingwind_enable = tobool(new or cl_fallingwind_enable)
		if cl_fallingwind_enable then
			hook.Add("Think", "Portal2FallingWindSound", doWind)
		else
			hook.Remove("Think", "Portal2FallingWindSound")
            if WooshSound != nil and WooshSound:IsPlaying() then WooshSound:Stop() end
		end
	end)
    cvars.AddChangeCallback("cl_fallingwind_limit", function (var, old, new)
        cl_fallingwind_limit = tonumber(new or cl_fallingwind_limit)
    end)
    cvars.AddChangeCallback("cl_fallingwind_threshold", function (var, old, new)
        cl_fallingwind_threshold = tonumber(new or cl_fallingwind_threshold)
    end)
    cvars.AddChangeCallback("cl_fallingwind_volume", function (var, old, new)
        cl_fallingwind_volume = tonumber(new or cl_fallingwind_volume)
    end)
    cvars.AddChangeCallback("cl_fallingwind_altsoundenable", function (var, old, new)
        cl_fallingwind_altsoundenable = tobool(new or cl_fallingwind_altsoundenable)
        --Make the sound regenerate again, since we're changing it!
        if WooshSound != nil then WooshSound:Stop() end
        WooshSound = nil
    end)
    cvars.AddChangeCallback("cl_fallingwind_xvelocityfactor", function (var, old, new)
        cl_fallingwind_xvelocityfactor = tonumber(new or cl_fallingwind_xvelocityfactor)
    end)
    cvars.AddChangeCallback("cl_fallingwind_yvelocityfactor", function (var, old, new)
        cl_fallingwind_yvelocityfactor = tonumber(new or cl_fallingwind_yvelocityfactor)
    end)
    cvars.AddChangeCallback("cl_fallingwind_zvelocityfactor", function (var, old, new)
        cl_fallingwind_zvelocityfactor = tonumber(new or cl_fallingwind_zvelocityfactor)
    end)
end