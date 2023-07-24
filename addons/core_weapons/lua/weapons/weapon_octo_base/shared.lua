--[[
Server Name: [&] Пригород Добермана
Server IP:   157.90.209.42:7009
File Path:   addons/core_weapons/lua/weapons/weapon_octo_base/shared.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

SWEP.Base = 'weapon_base' -- base 
SWEP.Passive = 'passive'
SWEP.Active = 'ar2'
SWEP.Primary.Sound = Sound('')
SWEP.Primary.Cone = 0.2
SWEP.Primary.Damage = 100
SWEP.Primary.Spread = 0.1
SWEP.Primary.NumShots = 1
SWEP.Primary.RPM = 0
SWEP.Primary.ClipSize = 0
SWEP.Primary.DefaultClip = 0
SWEP.Primary.KickUp = 0
SWEP.Primary.KickDown = 0
SWEP.Primary.KickHorizontal = 0
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = 'none'
SWEP.DrawCrosshair = true
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = 'none'
SWEP.GraftonWeapon = true

SWEP.Slot = 3
SWEP.SlotPos = 1
SWEP.Spawnable = false

local barrelAngles = {
    _default = {Vector(10,.65,3.5),Angle(-2,5,0)},
   	revolver = {Vector(8,.65,4),Angle(-2,5,0)},
    pistol = {Vector(10,.25,3.5),Angle(-2,5,0)},
    ar2 = {Vector(25,-1,7.5),Angle(-9,0,0)},
    smg = {Vector(11,-0.9,7.5),Angle(-8,1.5,0)},
    duel = {Vector(9,1,3.5),Angle(0,11,0)}
}

function SWEP:SetupDataTables()
    self:NetworkVar('Bool', 0, 'Ready')
    self:NetworkVar('Bool', 1, 'Reloading')
end

function SWEP:Initialize()
    self:SetHoldType(self.Passive)
    self:SetReady(false)
    self:SetVar('Ready', false)
    self:SetReloading(false)
end

function SWEP:CanFire()
    if CurTime() < self:GetNextPrimaryFire() or self.Owner:WaterLevel() == 3 then
        return false
    end
    local t = self.Owner
    local e = {}
    e.start = t:GetShootPos()
    e.endpos = self:GetShootPos()
    e.filter = t
    return not util.TraceLine(e).Hit
end

function SWEP:GetShootPos()
    local ply = self:GetOwner()
    local lookAtt = ply:LookupAttachment('anim_attachment_rh')
    if lookAtt then
        local att = ply:GetAttachment(lookAtt)
        local mPos, mAng = self.MuzzlePos, self.MuzzleAng
        if not mPos then
            if barrelAngles[self.Active] then
                mPos, mAng = unpack(barrelAngles[self.Active])
            else
                mPos, mAng = unpack(barrelAngles._default)
            end
        end
        local pos, dir = LocalToWorld(mPos, mAng, att.Pos, att.Ang)
        return pos, dir:Forward()
    else
        return ply:GetShootPos(), (ply.viewAngs or ply:EyeAngles()):Forward()
    end
end

function SWEP:Reload()
    return
end

function SWEP:Think()
    if IsValid(self) and IsValid(self:GetOwner()) and self:GetOwner():Alive() then
        
        self:SelfWrittenReload()

        if self:GetVar('Reloading') == true then
            if self:GetOwner():KeyDown(IN_ATTACK2) then
                hook.Remove("HUDPaint", "PaintScope")
            end
        end

        if self:GetReloading() == true then return end

        if self:GetReady() == false and self:GetOwner():KeyDown(IN_ATTACK2) then
            self.aimProgress = 0
            self:SetReady(true)
            self:SetVar('Ready', true)
            self:SetHoldType(self.Active)
			self.aimProgress = 0
            if CLIENT then
                
                hook.Add("HUDPaint", "PaintScope", function()
                    local hitpos = LocalPlayer():GetEyeTrace().HitPos
                    local data2D = hitpos:ToScreen()
                    draw.RoundedBox(0, data2D.x, data2D.y, 0, 0, Color(231, 231, 231))
                end)
            end
        end

        if self:GetReady() == true and self:GetOwner():KeyReleased(IN_ATTACK2) then
            self.aimProgress = 0
            self:SetReady(false)
            self:SetVar('Ready', false)
            self:SetHoldType(self.Passive)
            hook.Remove("HUDPaint", "PaintScope")
            self.aimProgress = 0
        end
    end
end

hook.Add('PlayerPostThink', 'weapons', function(player)
    if not player:Alive() or not IsValid(player:GetActiveWeapon()) or not IsValid(player) then
        timer.Destroy('reload_act' .. player:SteamID64())
        timer.Destroy('reload_act2' .. player:SteamID64())
    end
end)

function SWEP:PrimaryAttack() 
    if IsValid(self) and IsValid(self:GetOwner()) and self:GetOwner():Alive() then
        self:SetNextPrimaryFire(CurTime() + 1.5 / (self.Primary.RPM / 70))

        if self:Clip1() <= 0 then
            self:EmitSound('weapons/clipempty_rifle.wav')
            self:SetNextPrimaryFire(CurTime() + 0.3)

            return
        end

        self:EmitSound(self.Primary.Sound)
        self:ShotBullet(self.Primary.Damage, self.Primary.NumShots, self.Primary.Spread)
        self:TakePrimaryAmmo(1)
    end
end

function SWEP:SecondaryAttack()
    return
end

function SWEP:ShotBullet(dmg, numbul, cone)
    if not IsValid(self:GetOwner()) then return end

    numbul = numbul or 1
    cone = cone or 0.01

    local bullet = {}
    local pos, dir = self:GetShootPos()
    bullet.Num = numbul or 1
    bullet.Src = pos -- self:GetOwner():GetShootPos()
    bullet.Dir = dir -- self.Owner:GetEyeTraceNoCursor().Normal --self.Owner:GetAimVector()
    bullet.Spread = Vector(cone, cone, 0)
    bullet.Tracer = 4
    bullet.Force = 5
    bullet.Damage = dmg

    self:GetOwner():FireBullets(bullet)
    self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
    self:GetOwner():MuzzleFlash()
    self:GetOwner():SetAnimation(PLAYER_ATTACK1)
    
    local anglo1 = Angle(math.Rand(-self.Primary.KickDown, -self.Primary.KickUp), math.Rand(-self.Primary.KickHorizontal, self.Primary.KickHorizontal), 0)
    self.Owner:ViewPunch(anglo1)

    if SERVER and game.SinglePlayer() and not self.Owner:IsNPC() then
        local offlineeyes = self.Owner:EyeAngles()
        offlineeyes.pitch = offlineeyes.pitch + anglo1.pitch
        offlineeyes.yaw = offlineeyes.yaw + anglo1.yaw
        self.Owner:SetEyeAngles(offlineeyes)
    end

    if CLIENT and not game.SinglePlayer() and not self.Owner:IsNPC() then
        local anglo = Angle(math.Rand(-self.Primary.KickDown, -self.Primary.KickUp), math.Rand(-self.Primary.KickHorizontal, self.Primary.KickHorizontal), 0)
        local eyes = self.Owner:EyeAngles()
        eyes.pitch = eyes.pitch + (anglo.pitch / 3)
        eyes.yaw = eyes.yaw + (anglo.yaw / 3)
        self.Owner:SetEyeAngles(eyes)
    end
end

hook.Add('SetupMove', 'donotrush', function(ply, mv)
    local w = ply:GetActiveWeapon()

    if IsValid(ply) and IsValid(w) and ply:Alive() then
        if (w:GetVar('Ready') == true and not w:GetVar('Reloading') == true) or (not w:GetVar('Ready') == true and w:GetVar('Reloading') == true) then
            mv:SetMaxClientSpeed(mv:GetMaxClientSpeed() / 2)
        end
    end
end)

function SWEP:SelfWrittenReload()
    if (IsValid(self) and IsValid(self:GetOwner())) and self:GetOwner():Alive() and IsValid(self:GetOwner():GetActiveWeapon()) then
        if self:Ammo1() == 0 and self:GetOwner():KeyPressed(IN_RELOAD) then return end

        if self:Clip1() < self.Primary.ClipSize and self:GetOwner():KeyPressed(IN_RELOAD) and self:GetReloading() == false then
            self:GetOwner():SetAmmo(self:Ammo1() + self:Clip1(), self.Primary.Ammo)
            self:SetClip1(0)
            self:SetVar('Ready', false)
            self:SetReady(false)

            timer.Create('reload_act' .. self:GetOwner():SteamID64(), 0.1, 1, function()
                self:SetReady(false)
                self:SetVar('Ready', false)
                self:SetVar('Reloading', true)
                self:SetReloading(true)
                self:SetHoldType(self.Active)
                self:GetOwner():SetAnimation(PLAYER_RELOAD)

                timer.Create('reload_act2' .. self:GetOwner():SteamID64(), self.ReloadTime, 1, function()
                    if self:Ammo1() < self.Primary.ClipSize then
                        self:SetClip1(self:Ammo1())
                    else
                        self:SetClip1(self.Primary.ClipSize)
                    end

                    self:GetOwner():SetAmmo(self:Ammo1() - self.Primary.ClipSize, self.Primary.Ammo)

                    if self:GetOwner():KeyDown(IN_ATTACK2) then
                        self:SetReady(true)
                        self:SetHoldType(self.Active)
                        self:SetReloading(false)
                        self:SetVar('Ready', true)

                        if CLIENT then
                            hook.Add("HUDPaint", "PaintScope", function()
                                local hitpos = LocalPlayer():GetEyeTrace().HitPos
                                local data2D = hitpos:ToScreen()
                                draw.RoundedBox(0, data2D.x, data2D.y, 0, 0, Color(231, 231, 231))
                            end)
                        end

                        self:SetVar('Reloading', false)
                    end

                    if not self:GetOwner():KeyDown(IN_ATTACK2) then
                        self:SetReady(false)
                        self:SetHoldType(self.Passive)
                        self:SetReloading(false)
                        self:SetVar('Ready', false)
                        self:SetVar('Reloading', false)
                    end
                end)
            end)
        end
    end
end


if CLIENT then
    hook.Add('gt_view.WepTrace', 'gt_wepTrace', function()

        local wep = LocalPlayer():GetActiveWeapon()
        if not IsValid(wep) or not wep.GraftonWeapon then return end
    
        local pos, dir = wep:GetShootPos()
        return util.TraceLine({
            start = pos,
            endpos = pos + dir * 2000,
            filter = function(ent)
                return ent ~= ply and ent:GetRenderMode() ~= RENDERMODE_TRANSALPHA
            end
        })
    
    end)
    
    function SWEP:DrawWorldModel()
        self:DrawModel()
    
        --local pos, dir = self:GetShootPos()
        --render.DrawLine(pos, pos + dir * 200, color_white, true)
        --render.DrawWireframeSphere(pos, 1, 5, 5, color_white, true)
    end
end