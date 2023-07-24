hook.Add("ShouldCollide", "collideDisableOnGhosts", function(entity1,entity2)
    if entity1 ~= nil and entity2 ~= nil then
        if (entity1:IsPlayer() and entity1:GetNWBool('isGhost')) or (entity2:IsPlayer() and entity2:GetNWBool('isGhost')) then
            entity1:SetAvoidPlayers(false)
            return false
        end
    end
end)
hook.Add( "PlayerFootstep", "CustomFootstep", function( ply, pos, foot, sound, volume, rf )
    return ply:GetNWBool("isGhost") -- Don't allow default footsteps, or other addon footsteps
end )

--