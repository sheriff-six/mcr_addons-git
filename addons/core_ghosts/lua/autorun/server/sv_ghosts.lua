util.AddNetworkString("respawn_g")

timer.Create("passive.second.remover", 1, 0, function()
    for _, v in pairs(player.GetAll()) do
        if v:GetNWBool("isGhost") then
            newtime = v:GetNWInt("respawnTime")
			newtime = newtime-1
			v:SetNWInt("respawnTime", newtime)
			-- print(v:GetNWInt("respawnTime"))
            if newtime <= -1 then 
                v:SetNWBool("isGhost", false)
                v:SetMaterial("")
                v:Spawn()
				v:SetAvoidPlayers(true)
                v:ScreenFade(SCREENFADE.IN, Color(255, 255, 255, 255), 1, 0.5)
            end
        end
    end
end)
local floor = math.floor
hook.Add( "PlayerDeath", "GlobalDeathMessage", function( ply, inflictor, attacker )

    ply:ScreenFade(SCREENFADE.OUT, Color(0, 0, 0, 255), 2, 4)
    local DefaultRagdoll = ply:GetRagdollEntity()
    if ( DefaultRagdoll and DefaultRagdoll:IsValid() ) then DefaultRagdoll:Remove() end
    local lastPos = ply:GetPos()
    local lastAng = ply:GetAngles()
    local Ragdoll = ents.Create("prop_ragdoll")
	Ragdoll:SetPos(ply:GetPos())
	Ragdoll:SetModel(ply:GetModel())
	Ragdoll:SetSkin(ply:GetSkin())
	for k, v in pairs(ply:GetBodyGroups()) do
		Ragdoll:SetBodygroup(v.id, ply:GetBodygroup(v.id))
	end
	
	Ragdoll:Spawn()
	Ragdoll:Activate()
	Ragdoll:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	Ragdoll:SetCreator(ply)
    ply:SetNWEntity("RagdollOfPlayer", Ragdoll)
    Ragdoll:SetNWBool("playerRag", true)
	for i=0, Ragdoll:GetPhysicsObjectCount()-1 do
		local PhysBone = Ragdoll:GetPhysicsObjectNum(i)
		if(PhysBone:IsValid()) then
			local pos, ang = ply:GetBonePosition( Ragdoll:TranslatePhysBoneToBone(i) )
			PhysBone:SetAngles(ang)
            if ply:LastHitGroup() == HITGROUP_HEAD then
			    PhysBone:AddVelocity(ply:GetVelocity() * .11)
                local head = Ragdoll:GetPhysicsObjectNum(12)
                head:AddVelocity(ply:GetVelocity() * .8)
            else
                PhysBone:AddVelocity(ply:GetVelocity())
            end
			PhysBone:SetPos(pos)
		end
	end

    local physPly = ply:GetPhysicsObject()
    local phys = Ragdoll:GetPhysicsObject()
    phys:AddVelocity(ply:GetVelocity() * 0.8)

    timer.Simple(4, function()
        ply:SetNWBool("isGhost", true)
        ply:Spawn()
        ply:SetPos(lastPos)
        ply:SetMaterial("models/effects/vol_lightmask02")
        ply:SetCustomCollisionCheck(true)
        ply:SetNWInt("respawnTime", 900)
        ply:ScreenFade(SCREENFADE.IN, Color(0, 0, 0, 255), 2, 0)
        timer.Start("passive.second.remover")
		timer.Simple(1.1, function()
			ply:StripWeapons()	
		end)
    end)
    
    timer.Simple(120, function() Ragdoll:Remove() end)

end )
hook.Add("PlayerDeathThink", "", function(ply)
    return false
end)
net.Receive("respawn_g", function(_, ply)
	if ply:IsSuperAdmin() then
    	ply:SetNWBool("isGhost", false)
    	ply:SetMaterial("")
    	ply:Spawn()
	end
end)

-- Запреты
hook.Add("PlayerSpawnProp", "prop.restrict", function(player, model)
    return not player:GetNWBool("isGhost")
end)

hook.Add("PlayerCanPickupWeapon", "pickupwep.restrict", function(player)
    return not player:GetNWBool("isGhost")
end)

hook.Add("PlayerCanPickupItem", "pickupitem.restrict", function(player)
    return not player:GetNWBool("isGhost")
end)

-- Конец запретов на спавны

hook.Add("PlayerCanHearPlayersVoice", "restrict.voices", function(listener, talker)
    if talker:GetNWBool("isGhost") && not listener:GetNWBool("isGhost") then
        return false
    end
end)

hook.Add("PlayerCanSeePlayersChat", "restrict.chat", function(text, tmOnly, listener, talker)
    if talker:GetNWBool("isGhost") && not listener:GetNWBool("isGhost") then
        return false
    end
end)

hook.Add("PlayerShouldTakeDamage", "AntiDamage2Ghosts", function(playre, attacker)
    if playre:GetNWBool("isGhost") then
        return false
    end
    if attacker:GetNWBool("isGhost") then
        return false
    end
end)
hook.Add("PlayerUse", "RestrictFromUsing", function(plaety, ent)
    if plaety:GetNWBool("isGhost") then
        return false
    end
end)

hook.Add('EntityEmitSound', 'ghosts', function(data)
    local ent = data.Entity
    if IsValid(ent) and ent:IsPlayer() and ent:GetNWBool('isGhost') then return false end
end)

hook.Add("PlayerDeathSound", "ghosts", function(ply)
    return true
end)