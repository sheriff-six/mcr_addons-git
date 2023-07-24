simfphys = istable( simfphys ) and simfphys or {}

simfphys.ManagedVehicles = istable( simfphys.ManagedVehicles ) and simfphys.ManagedVehicles or {}
simfphys.Weapons = istable( simfphys.Weapons ) and simfphys.Weapons or {}
simfphys.weapon = {}

util.AddNetworkString( "uaz469mg_register_tank" )

sound.Add( {
	name = "uaz469mg_fire",
	channel = CHAN_WEAPON,
	volume = 0.5,
	level = 140,
	pitch = { 90, 100 },
	sound = {"weapons/dshk/dshk_01.wav"}
} )
