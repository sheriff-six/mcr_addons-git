util.AddNetworkString("CharacterDescr")
util.AddNetworkString("SetCharacterDescription")
util.AddNetworkString("sonya")

net.Receive("CharacterDescr", function(_, ply)
	local text2 = net.ReadString()
	if string.len(text2) > 125 then 
		ply:SendLua("notification.AddLegacy('Ты изменял файл? Не делай так, изменяй описание через функцию.')")
		ply:SetNWString("chr.desc", "Самый обычный человек")
		ply:SendLua('file.Write("chr_desc.txt", "Самый обычный человек.")')
	else
		ply:SetNWString("chr.desc", text2)
	end
end)

net.Receive("SetCharacterDescription", function(_, ply)
	local text = net.ReadString()
	if string.len(text) > 125 then ply:SendLua("notification.AddLegacy('Слишком большое описание. Постарайся сделать его меньше')") return end
	ply:SendLua("notification.AddLegacy('Вы успешно поменяли описание персонажа')")
	ply:SetNWString("chr.desc", text)
	ply:SetNWString("desc", text)
	net.Start("sonya")
	net.WriteString(text)
	net.Send(ply)
end) 
