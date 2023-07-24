CreateClientConVar( "pp_ambient_occlusion",                 0,      true, true, "Enable/disable ambient occlusion" );
CreateClientConVar( "pp_ambient_occlusion_shadows",         0,      true, true, "Enable/disable rendering shadows only" );
CreateClientConVar( "pp_ambient_occlusion_threshold",       0.99,   true, true, "Threshold of edge detection" );
CreateClientConVar( "pp_ambient_occlusion_strength",        0.80,   true, true, "Strength of shadows" );
CreateClientConVar( "pp_ambient_occlusion_blur_radius",     2.20,   true, true, "Radius of shadows blur" );
CreateClientConVar( "pp_ambient_occlusion_blur_passes",     6,      true, true, "Number of shadows blur passes" );

local RenderBuffer = RenderBuffer or GetRenderTarget( "AmbientOcclusionBuffer", ScrW(), ScrH(), false );
local MaterialRenderBuffer = MaterialRenderBuffer or CreateMaterial( "AmbientOcclusionScreen", "UnlitGeneric", {
    ['$basetexture'] = RenderBuffer:GetName(),
} );

local MaterialDepth = MaterialDepth or CreateMaterial( "AmbientOcclusionDepth", "UnlitGeneric", {
    ['$basetexture'] = render.GetResolvedFullFrameDepth():GetName(),
} );

local DepthPass = false;

function DrawAmbientOcclusion( shadows, threshold, strength, radius, passes )

    DepthPass = true;

    render.PushRenderTarget( RenderBuffer );
    render.Clear( 0, 0, 0, 255 );
    render.ClearDepth();

    -- render scene without lighting
    render.SetLightingMode( 2 );

    render.RenderView({

        x = 0, 
        y = 0,
        w = ScrW(), 
        h = ScrH(),
        origin = EyePos(),
        angles = EyeAngles(),
        drawhud = false,
        drawviewmodel = true,
        dopostprocess = false,
        bloomtone = false

    })

    render.SetLightingMode( 0 );
    
    DrawSobel( threshold );

    -- scale white color
    DrawColorModify( {

        [ "$pp_colour_addr" ] = 0,
        [ "$pp_colour_addg" ] = 0,
        [ "$pp_colour_addb" ] = 0,
        [ "$pp_colour_brightness" ] = 0,
        [ "$pp_colour_contrast" ] = 45,
        [ "$pp_colour_colour" ] = 0,
        [ "$pp_colour_mulr" ] = 0,
        [ "$pp_colour_mulg" ] = 0,
        [ "$pp_colour_mulb" ] = 0

    })

    render.BlurRenderTarget( RenderBuffer, radius, radius, passes );

    -- sky culling by depth map
    render.OverrideBlend( true, BLEND_ONE, 2, BLENDFUNC_ADD, BLEND_ONE, BLEND_ZERO, BLENDFUNC_ADD )

    render.SetMaterial( MaterialDepth );
    render.DrawScreenQuad();

    render.OverrideBlend( false );

    -- shadow modulation
    DrawColorModify( {

        [ "$pp_colour_addr" ] = 0,
        [ "$pp_colour_addg" ] = 0,
        [ "$pp_colour_addb" ] = 0,
        [ "$pp_colour_brightness" ] = 1 - strength,
        [ "$pp_colour_contrast" ] = 1,
        [ "$pp_colour_colour" ] = 0,
        [ "$pp_colour_mulr" ] = 0,
        [ "$pp_colour_mulg" ] = 0,
        [ "$pp_colour_mulb" ] = 0

    })
    
    render.PopRenderTarget();

    DepthPass = nil;

    -- contrast compensation before blending
    DrawColorModify( {

        [ "$pp_colour_addr" ] = 0,
        [ "$pp_colour_addg" ] = 0,
        [ "$pp_colour_addb" ] = 0,
        [ "$pp_colour_brightness" ] = 0,
        [ "$pp_colour_contrast" ] = 0.8,
        [ "$pp_colour_colour" ] = 1,
        [ "$pp_colour_mulr" ] = 0,
        [ "$pp_colour_mulg" ] = 0,
        [ "$pp_colour_mulb" ] = 0

    })

    if !shadows then

        render.OverrideBlend( true, BLEND_DST_COLOR, BLEND_DST_COLOR, BLENDFUNC_ADD, BLEND_ONE, BLEND_ZERO, BLENDFUNC_ADD );

    end

    render.SetMaterial( MaterialRenderBuffer );
    render.DrawScreenQuad();

    render.OverrideBlend( false );

    -- brigness compensation after blending
    DrawColorModify( {

        [ "$pp_colour_addr" ] = 0,
        [ "$pp_colour_addg" ] = 0,
        [ "$pp_colour_addb" ] = 0,
        [ "$pp_colour_brightness" ] = 0.02,
        [ "$pp_colour_contrast" ] = 1,
        [ "$pp_colour_colour" ] = 1,
        [ "$pp_colour_mulr" ] = 0,
        [ "$pp_colour_mulg" ] = 0,
        [ "$pp_colour_mulb" ] = 0

    })

end;

hook.Add( "RenderScreenspaceEffects", "AmbientOcclusion:RenderScreenspaceEffects", function()

    if GetConVar( "pp_ambient_occlusion" ):GetBool() then

        if ( !render.SupportsPixelShaders_2_0() ) then return end
        if ( !GAMEMODE:PostProcessPermitted( "bloom" ) ) then return end

        DrawAmbientOcclusion(
            GetConVar( "pp_ambient_occlusion_shadows" ):GetBool(),
            GetConVar( "pp_ambient_occlusion_threshold" ):GetFloat(), 
            GetConVar( "pp_ambient_occlusion_strength" ):GetFloat(),
            GetConVar( "pp_ambient_occlusion_blur_radius" ):GetFloat(),
            GetConVar( "pp_ambient_occlusion_blur_passes" ):GetInt()
        );

    end

end )

hook.Add( "NeedsDepthPass", "AmbientOcclusion:NeedsDepthPass", function()

    if GetConVar( "pp_ambient_occlusion" ):GetBool() then
        
        return DepthPass;

    end

end )

list.Set( "PostProcess", "#ambient_occlusion", {

    icon = "gui/postprocess/ambient_occlusion.png",
    convar = "pp_ambient_occlusion",
    category = "#shaders_pp",
    cpanel = function( CPanel )

        CPanel:AddControl( 
            "Header", {
                    Description = "#ambient_occlusion.description" 
            } )

        CPanel:AddControl( 
            "CheckBox", 
            { 
                Label = "#ambient_occlusion.enable", 
                Command = "pp_ambient_occlusion" 
            } )

        CPanel:AddControl( "ComboBox", {

            Options = {
                ["#preset.default"] = {
                    pp_ambient_occlusion_shadows = "0",
                    pp_ambient_occlusion_threshold = "0.99",
                    pp_ambient_occlusion_strength = "0.80",
                    pp_ambient_occlusion_blur_radius = "2.2",
                    pp_ambient_occlusion_blur_passes = "6"
                }
            },
            CVars = {
                pp_ambient_occlusion_shadows = "0",
                pp_ambient_occlusion_threshold = "0.99",
                pp_ambient_occlusion_strength = "0.80",
                pp_ambient_occlusion_blur_radius = "2.2",
                pp_ambient_occlusion_blur_passes = "6"
                
            },
            Folder = "ambient_occlusion",
            MenuButton = "1"

        } )

        CPanel:AddControl( 
            "CheckBox", 
            { 
                Label = "#ambient_occlusion.shadows", 
                Command = "pp_ambient_occlusion_shadows" 
            } )
    
        CPanel:AddControl( 
            "Slider", 
            { 
                Label = "#ambient_occlusion.threshold", 
                Command = "pp_ambient_occlusion_threshold", 
                Type = "Float", 
                Min = "0.01", 
                Max = "2" 
            } )

        CPanel:AddControl( 
            "Slider", 
            { 
                Label = "#ambient_occlusion.strength", 
                Command = "pp_ambient_occlusion_strength", 
                Type = "Float", 
                Min = "0", 
                Max = "1" 
            } )

        CPanel:AddControl( 
            "Slider", 
            { 
                Label = "#ambient_occlusion.blur_radius", 
                Command = "pp_ambient_occlusion_blur_radius", 
                Type = "Float", 
                Min = "0", 
                Max = "16"
            } )

        CPanel:AddControl( 
            "Slider", 
            { 
                Label = "#ambient_occlusion.blur_passes", 
                Command = "pp_ambient_occlusion_blur_passes", 
                Type = "Integer", 
                Min = "0", 
                Max = "32" 
            } )

    end

} )