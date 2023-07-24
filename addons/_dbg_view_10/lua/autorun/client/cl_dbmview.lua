
dbmView = dbmView or {}
d = false
local rwe
dbmView.lookOff = Angle()
dbmView.lookAngles = Angle()
resource.AddFile( "materials/scopes/scope_dbm.png" )
i = 90



hook.Add('CreateMove', 'dbm-view', function(cmd)
        
    local ply = LocalPlayer()
    local wpn = ply:GetActiveWeapon()
	if input.WasMousePressed(109) and LocalPlayer():KeyDown(IN_ATTACK2) then 
        if rwe != true then
            timer.Simple(0.2, function()
            rwe = true            
            end)
        elseif rwe != false then
            timer.Simple(0.2, function()
            rwe = false
            end)
        end
    end
    if ply:KeyDown(IN_ATTACK2) and wpn.Category == "Либерти-Оружие" and wpn:GetReady() then
        cmd:RemoveKey(IN_SPEED)
    else
        return
    end
end)

hook.Add("InputMouseApply", "dbg-view", function(n, o, e, a)
    if d or false then
        if d then
            dbmView.lookOff.p = math.Clamp(dbmView.lookOff.p + e * i / 200, -45, 45)
            dbmView.lookOff.y = math.Clamp(dbmView.lookOff.y - o * i / 200, -60, 60)
        end
        if false then
            dbmView.lookAngles = dbmView.lookAngles + Angle(e, -o, 0) * i / 200
            dbmView.lookAngles.pitch = math.Clamp(dbmView.lookAngles.pitch, -65, 90)
        end
        n:SetMouseX(0)
        n:SetMouseY(0)
        return true
    elseif dbmView.lookOff.p ~= 0 or dbmView.lookOff.y ~= 0 then
        dbmView.lookOff.p =
            math.Approach(dbmView.lookOff.p, 0, math.max(math.abs(dbmView.lookOff.p), .2) * FrameTime() * 10)
        dbmView.lookOff.y =
            math.Approach(dbmView.lookOff.y, 0, math.max(math.abs(dbmView.lookOff.y), .2) * FrameTime() * 10)
    end
end)

local function hidehead(pl, s)
    if s then
        pl:ManipulateBoneScale(pl:LookupBone("ValveBiped.Bip01_Head1"), Vector(0.1,0.1,0.1))
    else
        pl:ManipulateBoneScale(pl:LookupBone("ValveBiped.Bip01_Head1"), Vector(1,1,1))
    end
end

local function inOutQuad(t, b, c, d)
    t = t / d * 2
    if t < 1 then return c / 2 * math.pow(t, 2) + b end
    return -c / 2 * ((t - 1) * (t - 3) - 1) + b
end

local whitelistweps = {
    ["weapon_physgun"] = true,
    ["gmod_tool"] = true,
    ["gmod_camera"] = true,
    ["weapon_357"] = true,
    ["sf2_tool"] = true,
    ["weapon_crossbow"] = true,
    ["weapon_shotgun"] = true,
    ["weapon_nkc"] = true,
    ["weapon_keypadchecker"] = true,
    ["arcticvr_glock"] = true,
    ["arcticvr_tmp"] = true,
    ["arcticvr_aniv_usptactical"] = true,
    ["weapon_mp52"] = true,
    ["arcticvr_mac10"] = true,
    ["re_hands"] = true,
}
local whitelistPhys = {
    ["weapon_physgun"] = true,
    ["gmod_tool"] = true,
    ["gmod_camera"] = true,
    ["itemstore_checker"] = true,
}
local melee = {
    ["weapon_octo_pot"] = true,
    ["weapon_octo_pickaxe"] = true,
    ["weapon_octo_bottle"] = true,
    ["weapon_octo_axe"] = true,
    ["weapon_octo_pipe"] = true,
    ["weapon_octo_knife"] = true,
    ['weapon_octo_hook'] = true,
    ["weapon_octo_shovel"] = true,
    ["weapon_octo_bottle_broken"] = true,
    ["weapon_octo_pan"] = true
}

hook.Add("CalcView", "Doberman.CopyRight.CalcView", function(ply, pos, ang)
    local whitelistweps = {
    ["weapon_physgun"] = true,
    ["gmod_tool"] = true,
    ["gmod_camera"] = true,
    ["sf2_tool"] = true,
    ["weapon_keypadchecker"] = true,
	}
        
   --if LocalPlayer():InVehicle() == true then return end

    if not IsValid(ply) then return end
   	local wep = LocalPlayer():GetActiveWeapon()
	if IsValid(LocalPlayer():GetActiveWeapon()) then
        if whitelistPhys[LocalPlayer():GetActiveWeapon():GetClass()] then
                
            return false
        end
    end
    
    local eyes = ply:GetAttachment(ply:LookupAttachment("eyes"))
    hidehead(ply, false)
    org = eyes.Pos + eyes.Ang:Forward() * 2.6
    anles = ang
    if not LocalPlayer():Alive() then
        if IsValid(LocalPlayer():GetNWEntity("RagdollOfPlayer")) then
            local ragEye = LocalPlayer():GetNWEntity("RagdollOfPlayer"):GetAttachment(LocalPlayer():GetNWEntity("RagdollOfPlayer"):LookupAttachment("eyes"))
            org = ragEye.Pos + ragEye.Ang:Forward() * 2.8
            anles = ragEye.Ang
        end
    end
    local wep = ply:GetActiveWeapon()
    if IsValid(wep) then
        if wep.Category == "Оружие" and !melee[wep:GetClass()] then
            if wep:GetReady() then
                if not wep.AimPos then
                    return
                end

                local e = math.Approach(wep.aimProgress or 0, 1, FrameTime() * 0.8)
                wep.aimProgress = e
                if e <= 0 then
                    return
                end
                local t = inOutQuad(e, 0, 1, 1)
                local handAtt = ply:GetAttachment(ply:LookupAttachment("anim_attachment_rh"))
                
                local worldVector, worldAngle = LocalToWorld(wep.AimPos, wep.AimAng, handAtt.Pos, handAtt.Ang)

                
                hidehead(ply, true)
                if rwe then
                 	org = LerpVector(t, eyes.Pos, worldVector)
                	anles = LerpAngle(t, ang, worldAngle)
            	else
                    org = eyes.Pos
            	end
             

                if IsValid(wep) and ply.CalcView then
                    local e = ply:CalcView(ply, pos, ang, fov)
                    if not e then
                        return
                    end
                    org = e.origin
                end  
           	end
        end
    end

    local view = {
        origin = org,
        angles = anles,
        znear = 1.5,
        drawviewer = true,
    }

    return view
end)


hook.Add("RenderScene","octoweapons",function(pos, angle, fov)

    local view = hook.Run("CalcView", LocalPlayer(), pos, angle, fov)
    
    if not view then
        return
    end

    render.Clear(0, 0, 0, 255, true, true, true)
    
    render.RenderView({
            x = 0,
            y = 0,
            w = ScrW(),
            h = ScrH(),
            angles = view.angles,
            origin = view.origin,
            drawhud = true,
            drawviewmodel = false,
            dopostprocess = true,
            drawmonitors = true
        })

    return true

end)



hook.Add("HUDPaint", "PiskaPopa", function()
    local posEye = LocalPlayer():GetAttachment(LocalPlayer():LookupAttachment("eyes")).Pos
    local posHand = LocalPlayer():GetAttachment(LocalPlayer():LookupAttachment("anim_attachment_rh")).Pos

    if LocalPlayer():KeyDown( IN_ATTACK2 ) and LocalPlayer():KeyDownLast( IN_ATTACK2 ) and LocalPlayer():IsValid() and LocalPlayer():Alive() and IsValid(LocalPlayer()) and IsValid(LocalPlayer():GetActiveWeapon()) then

        local tr = {
            start = posHand,
            endpos = posHand,
            mins = Vector( -5, -5, 0 ),
            maxs = Vector( 5, 5, 1 )
        }

        local hullTrace = util.TraceHull( tr )

    
        local tr = {
            start = posEye,
            endpos = posEye,
            mins = Vector( -1, -1, 0 ),
            maxs = Vector( 1, 1, 1 )
        }
        local hullTrace = util.TraceHull( tr )

    end
end)

local t = {}
local n, e, r, o
local d = Material('materials/scopes/scope_dbm.png')
local function a()
    e = 360
    r = GetRenderTarget('weaponSight-' .. e, e, e)
    if not t[e] then
        t[e] = CreateMaterial('weaponSight-' .. e, 'UnlitGeneric', {})
    end
    o = t[e]
    n = {}
    local r, o, t, e = 0, 0, e / 2, 24
    n[#n+1] = {
        x = r,
        y = o,
        u = .5,
        v = .5
    }
    for a = 0, e do
        local e = math.rad( (a/e)*-360 )
        n[#n+1] = {
            x = r+math.sin(e)*t,
            y = o+math.cos(e)*t,
            u = math.sin(e)/2+.5,
            v = math.cos(e)/2+.5
        }
    end
end

a()

local a = false
local function i(wep)
    a = true
    local n, t, o = wep:GetShootPos()
    render.PushRenderTarget(r)
    if util.TraceLine({start=n-t*25,endpos=n+t*((wep.SightZNear or 5)+5),filter=LocalPlayer(),}).Hit then
        render.Clear(0,0,0,255)
    else
        render.RenderView({
            origin = n,
            angles = o,
            fov = wep.SightFOV,
            znear = wep.SightZNear,
        })
    end
    render.PopRenderTarget()
    a = false
end

hook.Add("PostDrawOpaqueRenderables","", function()
    local wep = LocalPlayer():GetActiveWeapon()
    if wep.SightPos and wep.aimProgress and wep.aimProgress > 0 and wep:GetReady() then
        local t = wep:GetOwner()
        local a = t:LookupAttachment('anim_attachment_rh')
        if not a then return end
        local t = t:GetAttachment(a)
        local l, a = LocalToWorld(wep.SightPos, wep.SightAng, t.Pos, t.Ang)
        local t = e / -2
        cam.Start3D2D(l, a, wep.SightSize / e * 1.1)
            cam.IgnoreZ(true)
            render.ClearStencil()
            render.SetStencilEnable(true)
            render.SetStencilTestMask(255)
            render.SetStencilWriteMask(255)
            render.SetStencilReferenceValue(42)
            render.SetStencilCompareFunction(STENCIL_ALWAYS)
            render.SetStencilFailOperation(STENCIL_KEEP)
            render.SetStencilPassOperation(STENCIL_REPLACE)
            render.SetStencilZFailOperation(STENCIL_KEEP)
            surface.SetDrawColor(0,0,0,1)
            draw.NoTexture()
            surface.DrawPoly(n)
            render.SetStencilCompareFunction(STENCIL_EQUAL)
            render.SetStencilFailOperation(STENCIL_ZERO)
            render.SetStencilZFailOperation(STENCIL_ZERO)
            o:SetTexture('$basetexture',r)
            o:SetFloat('$alpha',math.Clamp(math.Remap(wep.aimProgress,.1,1,0,1),0,1))
            surface.SetMaterial(o)
            surface.DrawTexturedRect(t,t,e,e)
            surface.SetDrawColor(255,255,255)
            surface.SetMaterial(d)
            surface.DrawTexturedRect(t-10,t-10,e+20,e+20)
            render.SetStencilEnable(false)
            cam.IgnoreZ(false)
        cam.End3D2D()
    end
end)

hook.Add('PreDrawEffects', 'octoweapons', function()
    if a then return end
    local wep = LocalPlayer():GetActiveWeapon()
    if IsValid(wep) and wep.SightPos and LocalPlayer():KeyDown(IN_ATTACK2) and wep:GetReady() then
        i(wep)
    end
end)

hook.Add("RenderScene","octoweapons",function(pos, angle, fov)

    local view = hook.Run("CalcView", LocalPlayer(), pos, angle, fov)
    
    if not view then
        return
    end

    render.Clear(0, 0, 0, 255, true, true, true)
    
    render.RenderView({
            x = 0,
            y = 0,
            w = ScrW(),
            h = ScrH(),
            angles = view.angles,
            origin = view.origin,
            drawhud = true,
            drawviewmodel = false,
            dopostprocess = true,
            drawmonitors = true
        })

    return true
end)