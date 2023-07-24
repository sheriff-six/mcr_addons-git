local scrw, scrh = ScrW(), ScrH()
local text = ""
local str = ""
concommand.Add("DescriptionEdit", function()
	local MenuFrame = vgui.Create("DFrame")
    MenuFrame:SetSize(scrw * .35, scrh * .08)
    MenuFrame:SetTitle("Напишите описание вашего персонажа")
    MenuFrame:MakePopup()
    MenuFrame:Center()

    local DTextEntr = vgui.Create("DTextEntry", MenuFrame)
    DTextEntr:Dock(TOP)
    DTextEntr.OnEnter = function(s)
        text = s:GetValue()
        net.Start("SetCharacterDescription")
        net.WriteString(text)
        net.SendToServer()
        MenuFrame:Remove()
    end
end)

hook.Add("InitPostEntity", "GivePlayerADesc", function()
    if file.Exists("chr_desc.txt", "DATA") then
        str = file.Read("chr_desc.txt")
    else
        file.Write("chr_desc.txt", "Самый обычный человек.")
        str = file.Read("chr_desc.txt")
    end
    net.Start("CharacterDescr")
    net.WriteString(str)
    net.SendToServer()
end)

net.Receive("sonya", function()
    local text = net.ReadString()
    file.Write("chr_desc.txt", text)
end)