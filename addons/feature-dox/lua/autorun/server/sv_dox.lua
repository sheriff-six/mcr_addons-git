
util.AddNetworkString( "dox" )
util.AddNetworkString( "show" )

net.Receive( "dox", function()
	local geter = net.ReadEntity(geter)
	local shower = net.ReadEntity(shower)
	print("Bravo")
	net.Start("show")
	net.WriteEntity(geter)
	net.WriteEntity(shower)
	net.Send(geter)


	
end )



