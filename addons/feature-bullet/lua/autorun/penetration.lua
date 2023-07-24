-- Convars
local maxTargetsConvar = CreateConVar("p_max_targets", 1, {
    FCVAR_NOTIFY,
    FCVAR_REPLICATED,
    FCVAR_SERVER_CAN_EXECUTE,
    FCVAR_ARCHIVE
    }) -- Максимальное количество поражаемых целей
    
    local distanceConvar = CreateConVar("p_dist", 5, {
    FCVAR_NOTIFY,
    FCVAR_REPLICATED,
    FCVAR_SERVER_CAN_EXECUTE,
    FCVAR_ARCHIVE
    }) -- Дистанция, на которой работает прострел
    
    local damageConvar = CreateConVar("p_damage", 0.5, {
    FCVAR_NOTIFY,
    FCVAR_REPLICATED,
    FCVAR_SERVER_CAN_EXECUTE,
    FCVAR_ARCHIVE
    }) -- Урон в простреле
    
    -- Code (Do not touch)
    local function MaximumPenetration(attacker, bullet)
    if bullet.Callback ~= nil then
    return
    end
    local dir = bullet.Dir
local maxTargets = maxTargetsConvar:GetInt()

if attacker:IsPlayer() then
    dir = attacker:GetAimVector()
end

bullet.Callback = function(atk, tr, dmg)
    local distance = distanceConvar:GetInt() * dmg:GetDamage() / 4
    local hitEntities = {}

    for k, v in pairs(ents.FindAlongRay(tr.HitPos, tr.HitPos + dir * distance, Vector(-5, -5, -5), Vector(5, 5, 5))) do
        if IsValid(v) and v ~= attacker and v ~= tr.Entity and SERVER and not hitEntities[v] then
            hitEntities[v] = true
            dmg:ScaleDamage(damageConvar:GetFloat())
            v:TakeDamageInfo(dmg)
        end

        if table.Count(hitEntities) >= maxTargets then
            break
        end
    end
end

return true
end

hook.Add("EntityFireBullets", "MaximumPenetration", MaximumPenetration)