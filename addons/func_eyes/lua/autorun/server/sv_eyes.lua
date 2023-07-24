--
hook.Add("PlayerSpawn", "mcr", function(ply)
    if ply:GetNWString("chr.desc") == "" then
        ply:SetNWString("desc", "Самый обычный человек")
    else
        ply:SetNWString("desc", ply:GetNWString("chr.desc"))
    end
    timer.Simple(3, function()
    ply:SetNWString("name", ply:GetName())
    print(ply:GetName())
    end)
end)

hook.Add("onPlayerChangedName", "logs", function(ply,name1,name2)
    if(not IsValid(ply))then return end
    ply:SetNWString("name", ply:GetName())
end)