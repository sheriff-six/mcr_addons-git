concommand.Add( "showdoc", function(ply)  
    print(LocalPlayer():GetEyeTrace().Entity)

    local geter = LocalPlayer():GetEyeTrace().Entity
    local shower = LocalPlayer()

    if geter:IsPlayer() == true then
        print(geter:GetName())
        net.Start("dox")
        net.WriteEntity(geter)
        net.WriteEntity(shower)
        net.SendToServer()
         chat.AddText(Color(243,79,79), "[Уведомление] ", Color(254,249,187),"Вы показали военный билет ", geter:GetName())
    else
        chat.AddText(Color(243,79,79), "[Уведомление] ", Color(254,249,187),"Вы не смотрите на игрока")
    end


end )

net.Receive( "show", function()
	local geter = net.ReadEntity(geter)
	local shower = net.ReadEntity(shower)
	print("Brickman")
	local player_data = shower:GetNVar('mo_data')

	chat.AddText(Color(243,79,79), "Вам показал военный билет ", color_white, shower:GetName(),Color(243,79,79), ", ", Color(243,79,79), "Звание: ",color_white, player_data.data.legion, Color(243,79,79), ", ", Color(243,79,79), "Подразделение: ", color_white, team.GetName( shower:Team() ), Color(243,79,79), ".")



	
end )






