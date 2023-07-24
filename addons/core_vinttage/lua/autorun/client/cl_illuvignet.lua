
CreateClientConVar("vignette", "1", true, true, "Disable/enable vignette effect", 0, 1)
CreateClientConVar("vignettedarkness", "100", true, true, "Vignette effect intensity", 1, 255)

local alpha = GetConVarNumber("vignettedarkness")
hook.Add( "HUDPaintBackground", "illuvignet", function()
    alpha = math.Approach(alpha, 0, FrameTime() * 30)

    if GetConVarNumber("vignette") == 1 then
        surface.SetDrawColor(0, 0, 0, 150 + alpha)
        surface.SetMaterial(Material("illuvignet.png"))
        surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
    end
end)