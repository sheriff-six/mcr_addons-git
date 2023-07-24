hook.Add( "PlayerConnect", "JoinGlobalMessage", function( name, ip )
	PrintMessage( HUD_PRINTTALK, name .. " прибыл на авиабазу" )
end )
