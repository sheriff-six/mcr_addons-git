
local hooks = {
    "Effect",
    "NPC",
    "Ragdoll",
    "SENT",
    "Vehicle"
}


for _, v in pairs (hooks) do


    hook.Add("PlayerSpawn"..v, "Disallow_user_"..v, function(client)
        if (client:IsUserGroup("founder") or (client:IsUserGroup("admin")) or (client:IsUserGroup("senior_admin")) or (client:IsUserGroup("senior_game_master"))or (client:IsUserGroup("deputy_admin")) or (client:IsUserGroup("game_master")) )then
            return true
        end
        
        return false
    end)
    
end

hook.Add( "PlayerSpawnSWEP", "SpawnBlockSWEP", function( ply, class, info )
	if ( ply:IsUserGroup("user") or LocalPlayer():IsUserGroup("cmd")) then
		return false
	end
end )

--
--Spawn restriction for users

hook.Add( "PlayerSpawnProp", "SpawnPropRestriction", function()
	if (LocalPlayer():IsUserGroup("user") or LocalPlayer():IsUserGroup("cmd"))  then
		return false
	end
end )

hook.Add( "PlayerSpawnSENT", "SpawnEntityRestriction", function()
	if (LocalPlayer():IsUserGroup("user") or LocalPlayer():IsUserGroup("cmd"))  then
		return false
	end
end )

hook.Add( "PlayerSpawnVehicle", "SpawnVehicleRestriction", function()
	if (LocalPlayer():IsUserGroup("user") or LocalPlayer():IsUserGroup("cmd"))  then
		return false
	end
end )

--Q and context menu open restriction
--
local function DisallowSpawnMenuOpen( )
	if (LocalPlayer():IsUserGroup("user") ) then
	return false
	end
end

hook.Add( "ContextMenuOpen", "DisallowSpawnMenuOpen", DisallowSpawnMenuOpen)

local function DisallowSpawnQMenuOpen( )
	if (LocalPlayer():IsUserGroup("user")) then
	return false
	end
end

hook.Add( "SpawnMenuOpen", "DisallowSpawnQMenuOpen", DisallowSpawnQMenuOpen)



hook.Add("ContextMenuOpen", "ModifyContextMenu", function(menu, command, data)
    if command == "menu" then
        local ply = LocalPlayer() -- Get the local player
        local options = menu:AddSubMenu("#spawnmenu.menu.props")
        
        -- Loop through all options in the sub-menu
        for _, option in pairs(options:GetChildren()) do
            if option.Text == "#spawnmenu.menu.ignite" and ply:GetUserGroup() == "cmd" then
                option.DoClick = nil -- Remove the "Ignite" button's click functionality
                option:SetEnabled(false) -- Disable the "Ignite" button
                option:SetVisible(false) -- Hide the "Ignite" button
                option:SetMouseInputEnabled(false) -- Disable mouse interaction for the "Ignite" button
                break
            end
        end
    end
end)


