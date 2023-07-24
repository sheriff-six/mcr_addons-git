--
octolib = octolib or {}

local tween = {}

local pow, sin, cos, pi, sqrt, abs, asin = math.pow, math.sin, math.cos, math.pi, math.sqrt, math.abs, math.asin

-- linear
local function linear(t, b, c, d) return c * t / d + b end

-- quad
local function inQuad(t, b, c, d) return c * pow(t / d, 2) + b end
local function outQuad(t, b, c, d)
    t = t / d
    return -c * t * (t - 2) + b
end
local function inOutQuad(t, b, c, d)
    t = t / d * 2
    if t < 1 then return c / 2 * pow(t, 2) + b end
    return -c / 2 * ((t - 1) * (t - 3) - 1) + b
end
local function outInQuad(t, b, c, d)
    if t < d / 2 then return outQuad(t * 2, b, c / 2, d) end
    return inQuad((t * 2) - d, b + c / 2, c / 2, d)
end

-- cubic
local function inCubic (t, b, c, d) return c * pow(t / d, 3) + b end
local function outCubic(t, b, c, d) return c * (pow(t / d - 1, 3) + 1) + b end
local function inOutCubic(t, b, c, d)
    t = t / d * 2
    if t < 1 then return c / 2 * t * t * t + b end
    t = t - 2
    return c / 2 * (t * t * t + 2) + b
end
local function outInCubic(t, b, c, d)
    if t < d / 2 then return outCubic(t * 2, b, c / 2, d) end
    return inCubic((t * 2) - d, b + c / 2, c / 2, d)
end

-- quart
local function inQuart(t, b, c, d) return c * pow(t / d, 4) + b end
local function outQuart(t, b, c, d) return -c * (pow(t / d - 1, 4) - 1) + b end
local function inOutQuart(t, b, c, d)
    t = t / d * 2
    if t < 1 then return c / 2 * pow(t, 4) + b end
    return -c / 2 * (pow(t - 2, 4) - 2) + b
end
local function outInQuart(t, b, c, d)
    if t < d / 2 then return outQuart(t * 2, b, c / 2, d) end
    return inQuart((t * 2) - d, b + c / 2, c / 2, d)
end

-- quint
local function inQuint(t, b, c, d) return c * pow(t / d, 5) + b end
local function outQuint(t, b, c, d) return c * (pow(t / d - 1, 5) + 1) + b end
local function inOutQuint(t, b, c, d)
    t = t / d * 2
    if t < 1 then return c / 2 * pow(t, 5) + b end
    return c / 2 * (pow(t - 2, 5) + 2) + b
end
local function outInQuint(t, b, c, d)
    if t < d / 2 then return outQuint(t * 2, b, c / 2, d) end
    return inQuint((t * 2) - d, b + c / 2, c / 2, d)
end

-- sine
local function inSine(t, b, c, d) return -c * cos(t / d * (pi / 2)) + c + b end
local function outSine(t, b, c, d) return c * sin(t / d * (pi / 2)) + b end
local function inOutSine(t, b, c, d) return -c / 2 * (cos(pi * t / d) - 1) + b end
local function outInSine(t, b, c, d)
    if t < d / 2 then return outSine(t * 2, b, c / 2, d) end
    return inSine((t * 2) -d, b + c / 2, c / 2, d)
end

-- expo
local function inExpo(t, b, c, d)
    if t == 0 then return b end
    return c * pow(2, 10 * (t / d - 1)) + b - c * 0.001
end
local function outExpo(t, b, c, d)
    if t == d then return b + c end
    return c * 1.001 * (-pow(2, -10 * t / d) + 1) + b
end
local function inOutExpo(t, b, c, d)
    if t == 0 then return b end
    if t == d then return b + c end
    t = t / d * 2
    if t < 1 then return c / 2 * pow(2, 10 * (t - 1)) + b - c * 0.0005 end
    return c / 2 * 1.0005 * (-pow(2, -10 * (t - 1)) + 2) + b
end
local function outInExpo(t, b, c, d)
    if t < d / 2 then return outExpo(t * 2, b, c / 2, d) end
    return inExpo((t * 2) - d, b + c / 2, c / 2, d)
end

-- circ
local function inCirc(t, b, c, d) return(-c * (sqrt(1 - pow(t / d, 2)) - 1) + b) end
local function outCirc(t, b, c, d)  return(c * sqrt(1 - pow(t / d - 1, 2)) + b) end
local function inOutCirc(t, b, c, d)
    t = t / d * 2
    if t < 1 then return -c / 2 * (sqrt(1 - t * t) - 1) + b end
    t = t - 2
    return c / 2 * (sqrt(1 - t * t) + 1) + b
end
local function outInCirc(t, b, c, d)
    if t < d / 2 then return outCirc(t * 2, b, c / 2, d) end
    return inCirc((t * 2) - d, b + c / 2, c / 2, d)
end

-- elastic
local function calculatePAS(p,a,c,d)
    p, a = p or d * 0.3, a or 0
    if a < abs(c) then return p, c, p / 4 end -- p, a, s
    return p, a, p / (2 * pi) * asin(c/a) -- p,a,s
end
local function inElastic(t, b, c, d, a, p)
    local s
    if t == 0 then return b end
    t = t / d
    if t == 1  then return b + c end
    p,a,s = calculatePAS(p,a,c,d)
    t = t - 1
    return -(a * pow(2, 10 * t) * sin((t * d - s) * (2 * pi) / p)) + b
end
local function outElastic(t, b, c, d, a, p)
    local s
    if t == 0 then return b end
    t = t / d
    if t == 1 then return b + c end
    p,a,s = calculatePAS(p,a,c,d)
    return a * pow(2, -10 * t) * sin((t * d - s) * (2 * pi) / p) + c + b
end
local function inOutElastic(t, b, c, d, a, p)
    local s
    if t == 0 then return b end
    t = t / d * 2
    if t == 2 then return b + c end
    p,a,s = calculatePAS(p,a,c,d)
    t = t - 1
    if t < 0 then return -0.5 * (a * pow(2, 10 * t) * sin((t * d - s) * (2 * pi) / p)) + b end
    return a * pow(2, -10 * t) * sin((t * d - s) * (2 * pi) / p ) * 0.5 + c + b
end
local function outInElastic(t, b, c, d, a, p)
    if t < d / 2 then return outElastic(t * 2, b, c / 2, d, a, p) end
    return inElastic((t * 2) - d, b + c / 2, c / 2, d, a, p)
end

-- back
local function inBack(t, b, c, d, s)
    s = s or 1.70158
    t = t / d
    return c * t * t * ((s + 1) * t - s) + b
end
local function outBack(t, b, c, d, s)
    s = s or 1.70158
    t = t / d - 1
    return c * (t * t * ((s + 1) * t + s) + 1) + b
end
local function inOutBack(t, b, c, d, s)
    s = (s or 1.70158) * 1.525
    t = t / d * 2
    if t < 1 then return c / 2 * (t * t * ((s + 1) * t - s)) + b end
    t = t - 2
    return c / 2 * (t * t * ((s + 1) * t + s) + 2) + b
end
local function outInBack(t, b, c, d, s)
    if t < d / 2 then return outBack(t * 2, b, c / 2, d, s) end
    return inBack((t * 2) - d, b + c / 2, c / 2, d, s)
end

-- bounce
local function outBounce(t, b, c, d)
    t = t / d
    if t < 1 / 2.75 then return c * (7.5625 * t * t) + b end
    if t < 2 / 2.75 then
        t = t - (1.5 / 2.75)
        return c * (7.5625 * t * t + 0.75) + b
    elseif t < 2.5 / 2.75 then
        t = t - (2.25 / 2.75)
        return c * (7.5625 * t * t + 0.9375) + b
    end
    t = t - (2.625 / 2.75)
    return c * (7.5625 * t * t + 0.984375) + b
end
local function inBounce(t, b, c, d) return c - outBounce(d - t, 0, c, d) + b end
local function inOutBounce(t, b, c, d)
    if t < d / 2 then return inBounce(t * 2, 0, c, d) * 0.5 + b end
    return outBounce(t * 2 - d, 0, c, d) * 0.5 + c * .5 + b
end
local function outInBounce(t, b, c, d)
    if t < d / 2 then return outBounce(t * 2, b, c / 2, d) end
    return inBounce((t * 2) - d, b + c / 2, c / 2, d)
end

tween.easing = {
    linear    = linear,
    inQuad    = inQuad,    outQuad    = outQuad,    inOutQuad    = inOutQuad,    outInQuad    = outInQuad,
    inCubic   = inCubic,   outCubic   = outCubic,   inOutCubic   = inOutCubic,   outInCubic   = outInCubic,
    inQuart   = inQuart,   outQuart   = outQuart,   inOutQuart   = inOutQuart,   outInQuart   = outInQuart,
    inQuint   = inQuint,   outQuint   = outQuint,   inOutQuint   = inOutQuint,   outInQuint   = outInQuint,
    inSine    = inSine,    outSine    = outSine,    inOutSine    = inOutSine,    outInSine    = outInSine,
    inExpo    = inExpo,    outExpo    = outExpo,    inOutExpo    = inOutExpo,    outInExpo    = outInExpo,
    inCirc    = inCirc,    outCirc    = outCirc,    inOutCirc    = inOutCirc,    outInCirc    = outInCirc,
    inElastic = inElastic, outElastic = outElastic, inOutElastic = inOutElastic, outInElastic = outInElastic,
    inBack    = inBack,    outBack    = outBack,    inOutBack    = inOutBack,    outInBack    = outInBack,
    inBounce  = inBounce,  outBounce  = outBounce,  inOutBounce  = inOutBounce,  outInBounce  = outInBounce
}



-- private stuff

local function copyTables(destination, keysTable, valuesTable)
    valuesTable = valuesTable or keysTable
    local mt = getmetatable(keysTable)
    if mt and getmetatable(destination) == nil then
        setmetatable(destination, mt)
    end
    for k,v in pairs(keysTable) do
        if type(v) == 'table' then
            destination[k] = copyTables({}, v, valuesTable[k])
        else
            destination[k] = valuesTable[k]
        end
    end
    return destination
end

local function checkSubjectAndTargetRecursively(subject, target, path)
    path = path or {}
    local targetType, newPath
    for k,targetValue in pairs(target) do
        targetType, newPath = type(targetValue), copyTables({}, path)
        table.insert(newPath, tostring(k))
        if targetType == 'number' then
            assert(type(subject[k]) == 'number', "Parameter '" .. table.concat(newPath,'/') .. "' is missing from subject or isn't a number")
        elseif targetType == 'table' then
            checkSubjectAndTargetRecursively(subject[k], targetValue, newPath)
        else
            assert(targetType == 'number', "Parameter '" .. table.concat(newPath,'/') .. "' must be a number or table of numbers")
        end
    end
end

local function checkNewParams(duration, subject, target, easing)
    assert(type(duration) == 'number' and duration > 0, "duration must be a positive number. Was " .. tostring(duration))
    local tsubject = type(subject)
    assert(tsubject == 'table' or tsubject == 'userdata', "subject must be a table or userdata. Was " .. tostring(subject))
    assert(type(target)== 'table', "target must be a table. Was " .. tostring(target))
    assert(type(easing)=='function', "easing must be a function. Was " .. tostring(easing))
    checkSubjectAndTargetRecursively(subject, target)
end

local function getEasingFunction(easing)
    easing = easing or "linear"
    if type(easing) == 'string' then
        local name = easing
        easing = tween.easing[name]
        if type(easing) ~= 'function' then
            error("The easing function name '" .. name .. "' is invalid")
        end
    end
    return easing
end

local function performEasingOnSubject(subject, target, initial, clock, duration, easing)
    local t,b,c,d
    for k,v in pairs(target) do
        if type(v) == 'table' then
            performEasingOnSubject(subject[k], v, initial[k], clock, duration, easing)
        else
            t,b,c,d = clock, initial[k], v - initial[k], duration
            subject[k] = easing(t,b,c,d)
        end
    end
end

-- Tween methods

local Tween = {}
local Tween_mt = {__index = Tween}

function Tween:set(clock)
    assert(type(clock) == 'number', "clock must be a positive number or 0")

    local changed = clock ~= self.clock
    self.initial = self.initial or copyTables({}, self.target, self.subject)
    self.clock = clock

    if self.clock <= 0 then

        self.clock = 0
        self.progress = 0
        copyTables(self.subject, self.initial)

    elseif self.clock >= self.duration then -- the tween has expired

        self.clock = self.duration
        self.progress = 1
        copyTables(self.subject, self.target)

    else

        self.progress = self.clock / self.duration
        performEasingOnSubject(self.subject, self.target, self.initial, self.clock, self.duration, self.easing)

    end

    if changed then self:onUpdate() end
    if not self.finished and self.progress >= 1 then
        self.finished = true
        self:onFinish()
    end

    return self.clock >= self.duration
end

function Tween:reset()
    return self:set(0)
end

function Tween:update(dt)
    assert(type(dt) == 'number', "dt must be a number")
    return self:set(self.clock + dt)
end


local function createTween(duration, subject, target, easing)
    easing = getEasingFunction(easing)
    checkNewParams(duration, subject, target, easing)
    return setmetatable({
        duration  = duration,
        subject   = subject,
        target    = target,
        easing    = easing,
        clock     = 0,
        progress  = 0,
    }, Tween_mt)
end

--
-- OCTOLIB
-- adding progress, pause, callbacks, helper functions and
-- dependence on game's Think cycle
--

octolib.tween = tween
octolib.tween.active = {}

local activeTweens = octolib.tween.active

hook.Add('Think', 'octolib.tween', function()
    local ft = FrameTime()
    for i = #activeTweens, 1, -1 do
        local tw = activeTweens[i]
        if not tw.paused then
            tw:update(ft)
            if tw.progress >= 1 then
                table.remove(activeTweens, i)
            end
        end
    end
end)

function Tween:onUpdate()
    -- to be overridden
end

function Tween:onFinish()
    -- to be overridden
end

function Tween:setProgress(progress)
    self:set(self.duration * progress)
end

function Tween:toggle()
    self.paused = not self.paused
end

function Tween:resume()
    self.paused = false
end

function Tween:pause()
    self.paused = true
end

function Tween:remove()
    table.RemoveByValue(activeTweens, self)
end

function octolib.tween.create(time, subject, target, easing, onFinish, onUpdate)
    local tw = createTween(time, subject, target, easing)
    if onUpdate then tw.onUpdate = onUpdate end
    if onFinish then tw.onFinish = onFinish end
    activeTweens[#activeTweens + 1] = tw

    return tw
end

dbgView = dbgView or {}
dbgView.look = dbgView.look or {enabled = false, state = 0, cache = {}}
surface.CreateFont("dbg-hud.normal", {font = "Calibri", extended = true, size = 27, weight = 350, shadow = true})
surface.CreateFont("dbg-hud.normal-sh", {font = "Calibri", extended = true, size = 27, blursize = 5, weight = 350})
surface.CreateFont("dbg-hud.small", {font = "Roboto", extended = true, size = 17, weight = 350, shadow = true})
surface.CreateFont("dbg-hud.small-sh", {font = "Roboto", extended = true, size = 17, blursize = 4, weight = 350})
surface.CreateFont("octoinv.3d", {font = "Arial Bold", extended = true, size = 18, weight = 300, antialias = true})
surface.CreateFont(
    "octoinv.3d-sh",
    {font = "Arial Bold", extended = true, size = 18, weight = 300, blursize = 5, antialias = true}
)
local t = dbgView.look
CreateClientConVar("cl_dbg_key_look", "1")
local e = GetConVar("cl_dbg_key_look"):GetInt()
cvars.AddChangeCallback(
    "cl_dbg_key_look",
    function(o, o, t)
        e = tonumber(t)
    end
)
hook.Add(
    "PlayerBindPress",
    "dbg-look",
    function(t, e)
        if e == "+zoom" then
            return true
        end
    end
)
hook.Add(
    "PlayerButtonDown",
    "dbg-look",
    function(n, o)
        if o == e and IsFirstTimePredicted() then
            t.enable(true)
        end
    end
)
hook.Add(
    "PlayerButtonUp",
    "dbg-look",
    function(n, o)
        if o == e and IsFirstTimePredicted() then
            t.enable(false)
        end
    end
)
function t.enable(e)
    if e then
        t.enabled = true
        netstream.Start("dbg-look.enable", true)
        timer.Create("dbg-look", .4, 0, t.update)
        t.update()
    else
        t.enabled = false
        netstream.Start("dbg-look.enable", false)
        timer.Remove("dbg-look")
        for t, e in pairs(t.cache) do
            e.killing = true
        end
    end
end
local function r(o, e)
    local t, n = o:WorldSpaceCenter(), o:GetAngles()
    if e.bone then
        local e = o:LookupBone(e.bone)
        if e then
            t, n = o:GetBonePosition(e)
        end
    end
    if e.posRel then
        t = LocalToWorld(e.posRel, angle_zero, t, n)
    end
    if e.posAbs then
        t:Add(e.posAbs)
    end
    return t, n
end
local e = math.cos(math.rad(40))
function t.update()
    local n, l = LocalPlayer(), {}
    local d = n:EyePos()
    for o, e in pairs(ents.FindInCone(d, n:GetAimVector(),  300, e)) do
        local a = {
            ["name"] = e:GetNWString("name"),
            ["desc"] = e:GetNWString("chr.desc"),
            ["time"] = 1,
        }
        if a and not e:GetNoDraw() and not e:GetNWBool("isGhost") then
            local r = r(e, a)
            local o = {n}
            if n:InVehicle() then
                local e = n:GetVehicle()
                o[#o + 1] = e
                o[#o + 1] = e:GetParent()
            end
            if e:IsPlayer() and e:InVehicle() then
                local e = e:GetVehicle()
                o[#o + 1] = e
                o[#o + 1] = e:GetParent()
            end
            local o = util.TraceLine({start = d, endpos = r, filter = o})
            if not o.Hit or o.Entity == e then
                l[e] = true
                if not t.cache[e] then
                    t.cache[e] = {data = a, al = 0, rot = 0, descAl = 0, h = 0}
                end
            end
        end
    end
    for e, t in pairs(t.cache) do
        t.killing = not l[e]
    end
end
hook.Add(
    "EntityRemoved",
    "dbg-look",
    function(e)
        t.cache[e] = nil
    end
)
local A = Material("octoteam/icons/percent_inactive_white.png")
local o, l = 0, Material("overlays/vignette01")
local N, b = Color(0, 0, 0), Color(255, 255, 255)
CFG = CFG or {}
local g = CFG.skinColors
local a, e, f, d, T, _, i, E, n, p

hook.Add(
    "Think",
    "dbg-look",
    function()
        if not t.enabled and o == 0 then
            return
        end
        o = math.Approach(o, t.enabled and 1 or 0, FrameTime() * 1.5)
        t.state = octolib.tween.easing.outQuad(o, 0, 1, 1)
        a = LocalPlayer()
        d, T, _, i, E, seesName, seesTime, police, n, p =
            a:Alive(),
            a:Team() == TEAM_ADMIN,
            a:Team() == TEAM_PRIEST
    end
)
hook.Add(
    "HUDPaint",
    "dbg-look",
    function()
        if o == 0 then
            return
        end
        if hook.Run("HUDShouldDraw", "dbg-look") == false then
            return
        end
        l:SetFloat("$alpha", t.state)
        render.SetMaterial(l)
        render.DrawScreenQuad()
        local h, d, i = FrameTime(), ScrW() / 2, ScrH() / 2
        for c, e in pairs(t.cache) do
            if not IsValid(c) or (e.al <= 0 and e.killing) then
                t.cache[c] = nil
            else
                e.al = math.Approach(e.al, e.killing and 0 or 1, h * 3)
                local s = octolib.tween.easing.outQuad(e.al, 0, 1, 1)
                surface.SetAlphaMultiplier(s)
                local o = r(c, e.data) + Vector(0,0,38)
                o = o:ToScreen()
                local a, l = math.floor(o.x), math.floor(o.y)
                local o = Vector(a, l, 0)
                if e.data.lookOff then
                    local e = e.data.lookOff
                    o.x = o.x - e.x
                    o.y = o.y - e.y
                end
                local i = s * math.Clamp(220 - Vector(a, l, 0):DistToSqr(Vector(d, i, 0)) / 200, 0, 200) / 200
                local m, f = e.data.name, e.data.desc
                local u, o, r = i == 1, e.descAl, e.descOn
                local d = o
                if f and f ~= "" then
                    if r then
                        local t = e.data.descRender and t.render[f]
                        o = math.Approach(o, 1, h * 1.5)
                        d = s * octolib.tween.easing.outQuad(o, 0, 1, 1)
                        if isfunction(t) then
                            t(c, e, a, l, s, d)
                        else
                            e.mu = e.mu or markup.Parse(("<font=dbg-hud.small>%s</font>"):format(f), 250)
                            e.h = e.mu:GetHeight() / 2
                            local t = l + 5 * d
                            e.mu:Draw(a, t, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 255 * o)
                        end
                    elseif u and o == 1 then
                        o = 0
                        r = true
                        e.lookTime = 0
                    else
                        o = math.Approach(o, u and 1 or 0, n and h * 5 or h / (e.data.time or 3))
                    end
                    e.descAl = o
                    e.descOn = r
                    local t = e.data.checkLoader and t.render[e.data.checkLoader]
                    if not isfunction(t) or t(c, e) then
                        if r then
                            i = math.max(i - d, 0)
                        end
                        if i > 0 then
                            local t = (e.rot - h * (u and 240 or 90 * i)) % 360
                            e.rot = t
                            local e = r and (36 + 16 * d) or (36 * i)
                            surface.SetMaterial(A)
                            surface.SetDrawColor(38, 166, 154, i * 255)
                            surface.DrawTexturedRectRotated(a, l, e, e, t)
                        end
                    end
                end
                local t = e.data.nameRender and t.render[m]
                if isfunction(t) then
                    t(c, e, a, l, s, d, r)
                else
                    local e = r and l - d * (e.h + 5) or l
                    draw.Text {
                        text = m,
                        font = "dbg-hud.normal-sh",
                        pos = {a, e - 3},
                        color = N,
                        xalign = TEXT_ALIGN_CENTER,
                        yalign = TEXT_ALIGN_CENTER
                    }
                    draw.Text {
                        text = m,
                        font = "dbg-hud.normal",
                        pos = {a, e - 3},
                        color = b,
                        xalign = TEXT_ALIGN_CENTER,
                        yalign = TEXT_ALIGN_CENTER
                    }
                end
            end
        end
        surface.SetAlphaMultiplier(1)
    end
)
hook.Add(
    "PlayerFinishedLoading",
    "dbg-hud",
    function()
        hook.Remove("PreDrawHalos", "PropertiesHover")
    end
)
t.render = {
    playerLoader = function(e)
        return e.showInfo
    end,
    playerName = function(e, r, o, l, d, i, c)
        e.showInfo = e ~= a and (T or _ or e:GetRenderMode() ~= RENDERMODE_TRANSALPHA)
        if not e.showInfo then
            return
        end
        
        local t = e:GetAimVector()
        t.z = 0
        t:Normalize()
        local n = math.Clamp(1 - f:Dot(t) * 3, 0, 1)
        if n > 0 then
            surface.SetAlphaMultiplier(n * d)
            local n = c and l - i * (r.h + 5) or l
            local t = e:GetNetVar("currentAction")
            if t then
                local e = n - 22
                t = t .. ("."):rep(math.floor(CurTime() * 5) % 4)
                draw.SimpleText(t, "dbg-hud.small-sh", o, e, color_black, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                draw.SimpleText(t, "dbg-hud.small", o, e, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end
            local e = e:GetName()
            draw.Text {
                text = e,
                font = "dbg-hud.normal-sh",
                pos = {o, n - 3},
                color = N,
                xalign = TEXT_ALIGN_CENTER,
                yalign = TEXT_ALIGN_CENTER
            }
            draw.Text {
                text = e,
                font = "dbg-hud.normal",
                pos = {o, n - 3},
                color = b,
                xalign = TEXT_ALIGN_CENTER,
                yalign = TEXT_ALIGN_CENTER
            }
        end
        r.nameAl = n
    end,
    playerDesc = function(t, o, l, a, r, e)
        if not t.showInfo then
            return
        end
        surface.SetAlphaMultiplier(e)
        if o.mu then
            o.h = o.mu:GetHeight() / 2
            local t = a + 5 * e
            o.mu:Draw(l, t, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 255 * e)
        else
            local a, e = t:Health(), {}
            if a < 25 then
                e[#e + 1] = L.desc_nearly_dead
            elseif a < 60 then
                e[#e + 1] = L.desc_unhealthy_look
            end
            local a = t:GetTimeTotal()
            if a < 18e3 then
                e[#e + 1] = L.desc_newbie
            end
            if t:GetNetVar("ScareState", 0) > .6 then
                e[#e + 1] = L.desc_scared
            end
            if t:GetNetVar("Drunk") then
                e[#e + 1] = L.desc_drunk
            end
            if t:GetNetVar("belted") then
                e[#e + 1] = "- Пристегнут"
            end
            local a = t:GetNetVar("dbg.karma", 0)
            if p or n then
                e[#e + 1] = L.desc_karma:format(a)
            else
                if a > 200 then
                    e[#e + 1] = L.desc_has_to_itself
                elseif a < -100 then
                    e[#e + 1] = L.desc_looks_suspicious
                end
            end
            if n then
                local o = t:GetNetVar("watchList")
                if o then
                    e[#e + 1] = L.desc_watchlist:format(o)
                end
                local o = t:CheckCrimeDenied()
                if o == true then
                    e[#e + 1] = L.desc_nocrime_perm
                elseif o then
                    e[#e + 1] = L.desc_nocrime:format(octolib.time.formatIn(o))
                end
                local t = t:CheckPoliceDenied()
                if t == true then
                    e[#e + 1] = L.desc_nopolice_perm
                elseif t then
                    e[#e + 1] = L.desc_nopolice:format(octolib.time.formatIn(t))
                end
            end
            local t = t:GetNetVar("dbgDesc")
            if t and t ~= "" then
                e[#e + 1] = "- " .. t
            elseif #e == 0 then
                e[#e + 1] = L.desc_usual
            end
            o.mu = markup.Parse("<font=dbg-hud.small>" .. table.concat(e, "\n") .. "</font>", 300)
        end
    end,
    corpseDesc = function(l, o, a, t, r, e)
        surface.SetAlphaMultiplier(e)
        if o.mu then
            o.h = o.mu:GetHeight() / 2
            local t = t + 5 * e
            o.mu:Draw(a, t, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 255 * e)
        else
            local t, e = {}, l:GetNetVar("Corpse")
            if not e then
                return
            end
            if e.cause then
                t[#t + 1] = "- " .. e.cause
            end
            if E or n then
                if e.bullet and e.weapon then
                    t[#t + 1] = L.desc_caliber:format(e.weapon)
                end
            end
            if seesTime or n then
                if e.time then
                    t[#t + 1] = L.desc_time_death:format(e.time)
                end
            end
            if (seesName or n) and e.name then
                t[#t + 1] = L.desc_its:format(e.name)
            end
            if n and e.attacker then
                t[#t + 1] = L.desc_murderer:format(e.attacker)
            end
            o.mu = markup.Parse(("<font=dbg-hud.small>%s</font>"):format(table.concat(t, "\n")), 250)
        end
    end,
    }