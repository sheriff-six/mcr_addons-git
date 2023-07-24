include("shared.lua")


function ENT:Draw()

    self:DrawModel()

    local Pos = self:GetPos()
	local Ang = self:GetAngles()

	Ang:RotateAroundAxis(Ang:Forward(), 180)
	Ang:RotateAroundAxis(Ang:Right(), 180)
	Ang:RotateAroundAxis(Ang:Up(), 90)

	local txt = "НАЖМИ НА E"
	

	surface.SetFont("DermaLarge")
	local TextWidth = surface.GetTextSize(txt)


	cam.Start3D2D(Pos - Ang:Right() + Ang:Up() * 31, Ang, 0.16)
		draw.WordBox(4, -TextWidth*0.5 - 5, -50, txt, "DermaLarge", Color(0, 0, 0, 255), Color(255,255,255,255))
	cam.End3D2D()

end



net.Receive( "sdat", function()
	local ply = net.ReadEntity(ply)
	local posa = net.ReadVector(posa)
	if ply:GetActiveWeapon():GetClass() == "weapon_doorlocker" then return end
	if ply:GetActiveWeapon():GetClass() == "mcr_hands" then return end
	if ply:GetActiveWeapon():GetClass() == "salute" then return end
	if ply:GetActiveWeapon():GetClass() == "weapon_flashlight" then return end

	timer.Create( "kekoftime", 1, 4, function() 
	
		chat.AddText( Color( 100, 100, 255 ), ply, " ваше оружие  ", Color( 100, 255, 100 ), ply:GetActiveWeapon():GetClass(),Color( 100, 100, 255 ), " будет сдано через 5 секунд. " )
	
	end )
	

	timer.Simple( 5, function() 
	if ply:GetPos():DistToSqr(posa) < 4000*4 then
	net.Start("abob")
	net.WriteEntity(ply)
	net.SendToServer()

	else
		chat.AddText( Color( 100, 100, 255 ), "Вы ушли слишком далеко от стола, поэтому оружие осталось в руках!" )
	end

	end)

	
	



end)