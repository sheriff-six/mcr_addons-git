surface.CreateFont('defFontbebra', {
    font = 'Calibri',
    extended = true,
    size = 60,
    weight = 350,
})

hook.Add("PostDrawOpaqueRenderables", "s", function()
if LocalPlayer():GetNWBool("isGhost") or team.GetName(LocalPlayer():Team()) == "Администратор" then
    for _, v in pairs(player.GetAll()) do
        v:SetRenderMode( RENDERMODE_TRANSCOLOR )
        if v:GetNWBool("isGhost") then
            v:SetColor(Color(255,255,255,30))
        else
            v:SetColor(Color(255,255,255,255))
        end
    end
else
    for _, v in pairs(player.GetAll()) do
        v:SetRenderMode( RENDERMODE_TRANSCOLOR )
        if v:GetNWBool("isGhost") then
            v:SetColor(Color(255,255,255,0))
        else
            v:SetColor(Color(255,255,255,255))
        end
    end
end
end)

local scrw, scrh = ScrW(), ScrH()

local function LetMeTime(time)
local m, s
m = math.floor(time / 60) % 60
s = math.floor(time) % 60
return string.format('%02i:%02i', m, s)
end

hook.Add("HUDPaint", "ShowAnTimer", function()
    local nexter = LetMeTime(LocalPlayer():GetNWInt("respawnTime"))
    if LocalPlayer():GetNWBool("isGhost") then
        surface.SetTextColor(255, 255, 255, 255)
        surface.SetTextPos(scrw * .46, scrh * .9)
        surface.SetFont("defFontbebra")
        surface.DrawText(nexter)
    end
end)

hook.Add( "HUDShouldDraw", "RemoveThatShit", function( name ) 
    if ( name == "CHudDamageIndicator" ) then 
       return false 
    end
end )


hook.Add( "RenderScreenspaceEffects", "color_modify_example", function()
if LocalPlayer():GetNWBool("isGhost") then
    DrawColorModify( {
        [ "$pp_colour_addr" ] = 0,
        [ "$pp_colour_addg" ] = 0,
        [ "$pp_colour_addb" ] = 0.04,
        [ "$pp_colour_brightness" ] = 0,
        [ "$pp_colour_contrast" ] = 0.94,
        [ "$pp_colour_colour" ] = 0.48,
        [ "$pp_colour_mulr" ] = 0,
        [ "$pp_colour_mulg" ] = 0,
        [ "$pp_colour_mulb" ] = 0
    } )
else
    DrawColorModify( {
        [ "$pp_colour_addr" ] = 0,
        [ "$pp_colour_addg" ] = 0,
        [ "$pp_colour_addb" ] = 0,
        [ "$pp_colour_brightness" ] = 0,
        [ "$pp_colour_contrast" ] = 1,
        [ "$pp_colour_colour" ] = 1,
        [ "$pp_colour_mulr" ] = 0,
        [ "$pp_colour_mulg" ] = 0,
        [ "$pp_colour_mulb" ] = 0
    } )
    return
end
end )