simfphys = istable( simfphys ) and simfphys or {}

simfphys.ManagedVehicles = istable( simfphys.ManagedVehicles ) and simfphys.ManagedVehicles or {}
simfphys.Weapons = istable( simfphys.Weapons ) and simfphys.Weapons or {}
simfphys.weapon = {}

util.AddNetworkString( "kamazzu_register_tank" )

sound.Add( {
	name = "kamazzu_fire",
	channel = CHAN_WEAPON,
	volume = 0.5,
	level = 140,
	pitch = { 90, 100 },
	sound = {"weapons/zu23/zu23_01.wav"}
} )
