print("damage_ui loaded")

hook.Add("HUDPaint", "screenEffects", function ()
    if LocalPlayer():Alive() then
        local healthRatio = (LocalPlayer():Health()/LocalPlayer():GetMaxHealth())
        --LocalPlayer():ChatPrint("healthRatio: "..healthRatio)
        surface.SetDrawColor(156, 44, 44, 255*(1-healthRatio))
        surface.SetMaterial(Material("vgui/vignette.png"))
        surface.DrawTexturedRect( 0, 0, ScrW(), ScrH() )
        if (LocalPlayer():Health() <= 2*LocalPlayer():GetMaxHealth()/3) then
            LocalPlayer():EmitSound("player/heartbeat1.wav",75,100,1*(1-healthRatio))
        else
            LocalPlayer():StopSound("player/heartbeat1.wav")
        end
    end
end)