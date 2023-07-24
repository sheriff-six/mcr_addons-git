local function AddPlayerModel( name, model )

	list.Set( "PlayerOptionsModel", name, model )
	player_manager.AddValidModel( name, model )
	
end

AddPlayerModel( "ЦСН ФСБ", 			         "models/Knyaje Pack/FSB_ROSN/FSB_ROSN.mdl" )