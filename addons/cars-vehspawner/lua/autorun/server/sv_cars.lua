include('autorun/sh_cars.lua')
util.AddNetworkString("SpawnCar")
util.AddNetworkString("SpawnGVP")
util.AddNetworkString("SpawnVVS")
util.AddNetworkString("SpawnVVS1")
util.AddNetworkString("SpawnVVS2")
util.AddNetworkString("SpawnVVS3")
util.AddNetworkString("SpawnVVS4")
util.AddNetworkString("SpawnVVS5")
util.AddNetworkString("SpawnSHTAB")
util.AddNetworkString("SpawnVP")
util.AddNetworkString("SpawnVP1")
util.AddNetworkString("SpawnVP2")
util.AddNetworkString("ararat")
util.AddNetworkString("Spawn313")
util.AddNetworkString("Spawn3131")

net.Receive("SpawnCar", function(_,p)
	--if not p:GetUserGroup("commander") then p:SendLua("chat.AddText(Color(255,255,255), 'Смените профессию!')") return false end
	--if not Cars.Teams[p:Team()] then p:SendLua("chat.AddText(Color(255,255,255), 'Смените профессию!')") return false end
	local car = net.ReadString()
	simfphys.SpawnVehicleSimple(car, Cars.SpawnPosVector, Cars.SpawnPosAngle)
end)

net.Receive("SpawnGVP", function(_,p, Entity)
	simfphys.SpawnVehicleSimple("gred_simfphys_gaz2975_nomg", Vector(-10133.177734375, 9807.40234375, 70.03125), Cars.SpawnPosAngle)
	local gvpv = ents.FindByModel("models/cars/rus/gaz/gaz2975_nomg.mdl")
	local playe = net.ReadString()
	for k, v in ipairs( ents.FindByModel("models/cars/rus/gaz/gaz2975_nomg.mdl") ) do
		if v:GetPos():DistToSqr(Vector(-10133.177734375, 9807.40234375, 70.03125)) < 100*2 then
			v:SetSubMaterial(0,"models/gvpg")
			timer.Simple(3, function() v:SetSkin(0) end)
			
		end
	end



end)


net.Receive("SpawnSHTAB", function(_,p, Entity)
	simfphys.SpawnVehicleSimple("simfphys_uaz3151", Vector(-10133.177734375, 9807.40234375, 70.03125), Cars.SpawnPosAngle)
end)

net.Receive("SpawnVP", function(_,p, Entity)
	simfphys.SpawnVehicleSimple("gred_simfphys_gaz2975_nomg", Vector(-5365.6630859375, 13601.276367188, 70.03125), Cars.SpawnPosAngle)
	for k, v in ipairs( ents.FindByModel("models/cars/rus/gaz/gaz2975.mdl") ) do
		if v:GetPos():DistToSqr(Vector(-5365.6630859375, 13601.276367188, 70.03125)) < 100*2 then
			v:SetSubMaterial(0,"models/vpgg")
			timer.Simple(2, function() v:SetSkin(2) end)
		end
	end
end)

net.Receive("SpawnVP1", function(_,p, Entity)
	simfphys.SpawnVehicleSimple("gred_simfphys_gaz2975_kord", Vector(-5365.6630859375, 13601.276367188, 70.03125), Cars.SpawnPosAngle)
	for k, v in ipairs( ents.FindByModel("models/cars/rus/gaz/gaz2975.mdl") ) do
		if v:GetPos():DistToSqr(Vector(-5365.6630859375, 13601.276367188, 70.03125)) < 100*2 then
			v:SetSubMaterial(0,"models/vpgg")
			timer.Simple(3, function() v:SetSkin(0) end)
		end
	end
	
end)

net.Receive("SpawnVP2", function(_,p, Entity)
	simfphys.SpawnVehicleSimple("simfphys_btr80", Vector(-5365.6630859375, 13601.276367188, 70.03125), Cars.SpawnPosAngle)
	for k, v in ipairs( ents.FindByModel("models/btr-80.mdl") ) do
		if v:GetPos():DistToSqr(Vector(-5365.6630859375, 13601.276367188, 70.03125)) < 100*2 then
			v:SetSkin(2)
		end
	end

end)

net.Receive("Spawn313", function(_,p, Entity)
	simfphys.SpawnVehicleSimple("gred_simfphys_gaz2975_ags", Vector(-6544.8256835938, 9735.685546875, 17.03125), Cars.SpawnPosAngle)
	for k, v in ipairs( ents.FindByModel("models/cars/rus/gaz/gaz2975_ags.mdl") ) do
		if v:GetPos():DistToSqr(Vector(-6544.8256835938, 9735.685546875, 19.03125)) < 100*2 then
			v:SetSubMaterial(0,"models/medgg")
			timer.Simple(3, function() v:SetSkin(0) end)
		end
	end

end)

net.Receive("Spawn3131", function(_,p, Entity)
	simfphys.SpawnVehicleSimple("simfphys_uaz3151", Vector(-6544.8256835938, 9735.685546875, 17.03125), Cars.SpawnPosAngle)
	for k, v in ipairs( ents.FindByModel("models/russian/uaz3151/uaz3151.mdl") ) do
		if v:GetPos():DistToSqr(Vector(-6544.8256835938, 9735.685546875, 19.03125)) < 100*2 then
			v:SetSubMaterial(0,"models/medgg")
			timer.Simple(1, function() v:SetSkin(1) end)
		end
	end

end)