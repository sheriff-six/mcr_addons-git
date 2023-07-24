include('autorun/sh_cars.lua')

local function SendNet(car)
	net.Start("SpawnCar")
	net.WriteString(car)
	net.SendToServer()
end

surface.CreateFont('ui.20', { font = 'Roboto Mono', size = 20, weight = 500, extended = true})

surface.CreateFont('ui.25', { font = 'Roboto Mono', size = 25, weight = 500, extended = true})

function garagemenu()
	if LocalPlayer():Team() == TEAM_SHTAB1 then 
	local fr = vgui.Create("DFrame")
	fr:SetSize(ScrW() * .525, ScrH() * .560)
	fr:Center()
	fr:SetTitle('')
	fr:MakePopup()
	local scr = vgui.Create("DScrollPanel", fr)
	scr:Dock(FILL)
	scr:DockMargin(0, 50, 0, 0)
	scr.Paint = function(s,w,h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0,0,0,100))
	end
	for k,v in ipairs(Cars.List) do
		local but = vgui.Create("DButton", scr)
		but:Dock(TOP)
		but:DockMargin(5, 5, 5, 5)
		but:SetTall(50)
		but:SetText('')
		but.Paint = function(s,w,h)
			draw.RoundedBox(0, 0, 0, w, h, Color(0,0,0,150))
			draw.SimpleText(v.n, "ui.25", w * .5, h * .5, color_white, 1, 1)
		end
		but.DoClick = function()
			SendNet(v.vehicle)
		end
		local model = vgui.Create("DModelPanel", but)
		model:SetModel(v.m)
		model:Dock(LEFT)
	end
        end
end
function vehmenu( )


    TextFrame = vgui.Create("DFrame")
	TextFrame:SetSize( 700, 400 )
	TextFrame:Center()
	TextFrame:SetTitle("Ангар техники")
	TextFrame:SetVisible( true )
	TextFrame:SetDraggable( true )
	TextFrame:ShowCloseButton( true )
	TextFrame:MakePopup()
	TextFrame:SetBackgroundBlur( true )-- Results in "Connection Refused - VAC"

	--[[local DPanel = vgui.Create( "DPanel", TextFrame )
    DPanel:SetPos( 400, 30 ) -- Set the position of the panel
    DPanel:SetSize( 295, 365 ) -- Set the size of the panel
    local DLabelAR = vgui.Create("DLabel", TextFrame )
    DLabelAR:SetText( "Ангар" )
    DLabelAR:SetFont( "dbg-hud.normal" )
    DLabelAR:SetPos( 515, 30 )
    DLabelAR:SizeToContents() 

	local DLabel3 = vgui.Create("DLabel", TextFrame )
    DLabel3:SetText( "Доступные транспортные средства:\n(для всех)\n\nГАЗ-469(Обычная версия)\nГАЗ-469(Медицинская версия)\nГАЗ-2975(Обычная версия)\nГАЗ-2975 (Военная полиция)\nГАЗ-2975 (ВАИ)\nГАЗ-2975 (АГС-30)\nГАЗ-2975 (Корд)\nКамаз Р-142\nУрал 4320(Грузовой)\nУрал 4320(БК)\nУрал АПА-5Д\nУрал 375(Топливозаправщик)" )
    DLabel3:SetFont( "dbg-hud.small" )
    DLabel3:SetPos( 410, 60 )
    DLabel3:SizeToContents()
]]--
	local sheet = vgui.Create( "DPropertySheet", TextFrame )
    sheet:SetPos( 5, 30 )
    sheet:SetSize( 390, 700 )

	local DPanel = vgui.Create( "DPanel", sheet )
    DPanel:SetPos( 5, 30 ) -- Set the position of the panel
    DPanel:SetSize( 390, 700 ) -- Set the size of the panel
    local DLabel1 = vgui.Create("DLabel", sheet )
    DLabel1:SetText( "Ангар" )
    DLabel1:SetFont( "dbg-hud.normal" )
    DLabel1:SetPos( 165, 30 )
    DLabel1:SizeToContents() 
	local DLabel3 = vgui.Create("DLabel", DPanel )
    DLabel3:SetText( "Доступные транспортные средства:\n(для всех)\n\nГАЗ-469(Обычная версия)\nГАЗ-469(Медицинская версия)\nГАЗ-2975(Обычная версия)\nГАЗ-2975 (Военная полиция)\nГАЗ-2975 (ВАИ)\nГАЗ-2975 (АГС-30)\nГАЗ-2975 (Корд)\nКамаз Р-142\nУрал 4320(Грузовой)\nУрал 4320(БК)\nУрал АПА-5Д\nУрал 375(Топливозаправщик)" )
    DLabel3:SetFont( "dbg-hud.small" )
    DLabel3:SetPos( 5, 50 )
    DLabel3:SizeToContents()
	sheet:AddSheet( "Доступный ТС", DPanel, "icon16/car.png" )
	
	local DermaImage = vgui.Create("DImageButton", sheet )
    DermaImage:SetImage( "mcr_tak/materials/mcr/mcr_vai.vtf" ) -- Set your .vtf image
    DermaImage:SetPos( 5, 30 )
	sheet:AddSheet( "ВАИ", DermaImage, "icon16/car.png" )


	if (LocalPlayer():Team() == TEAM_GVP) or (LocalPlayer():Team() == TEAM_GVP1) then 

	 local DermaButton = vgui.Create( "DButton", TextFrame ) 
       DermaButton:SetText( "Служебный тигр" )					
       DermaButton:SetPos( 400, 50 )						
       DermaButton:SetSize( 250, 30 )					
       DermaButton.DoClick = function(ply)	

		 net.Start("SpawnGVP")
		 net.SendToServer()			
		 RunConsoleCommand("say", "/r [RP] " ..LocalPlayer():GetName().. " расписался за ТИГР.") 

		 

		 hook.Add("HUDPaint", "GVPVH", function()
			 local scrw, scrh = ScrW(), ScrH()
			 local WaypointA = Vector(-10133.177734375, 9807.40234375, 70.03125)
			 WaypointA = WaypointA:ToScreen()

			 surface.SetDrawColor( 255, 255, 255, 255 ) -- Set the drawing color
			 surface.SetMaterial( Material("icon16/stop.png") ) -- Use our cached material
			 surface.DrawTexturedRect( WaypointA.x  , WaypointA.y , 30, 30 ) -- Actually draw the rectangle
								   
			  draw.SimpleText("МАШИНА", Trebuchet24, WaypointA.x + 15, WaypointA.y + 15, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		 end)

		 timer.Simple(10, function() hook.Remove("HUDPaint", "GVPVH") end)

        end
    end

	

	if (LocalPlayer():Team() == TEAM_SHTAB2) or (LocalPlayer():Team() == TEAM_SHTAB1) or (LocalPlayer():Team() == TEAM_SHTAB) then
		local DermaButton = vgui.Create( "DButton", TextFrame ) 
		DermaButton:SetText( "Служебный ГАЗ 24" )					
		DermaButton:SetPos( 400, 50 )						
		DermaButton:SetSize( 250, 30 )					
		DermaButton.DoClick = function()	
		  net.Start("SpawnSHTAB")
		  net.SendToServer()			
		  RunConsoleCommand("say", "/r [RP] " ..LocalPlayer():GetName().. " расписался за ГАЗ 24.") 
		  hook.Add("HUDPaint", "SHATB", function()
			local scrw, scrh = ScrW(), ScrH()
			local WaypointA = Vector(-10133.177734375, 9807.40234375, 70.03125)
			WaypointA = WaypointA:ToScreen()

			surface.SetDrawColor( 255, 255, 255, 255 ) -- Set the drawing color
			surface.SetMaterial( Material("icon16/stop.png") ) -- Use our cached material
			surface.DrawTexturedRect( WaypointA.x  , WaypointA.y , 30, 30 ) -- Actually draw the rectangle
								  
			 draw.SimpleText("МАШИНА", Trebuchet24, WaypointA.x + 15, WaypointA.y + 15, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end)

		timer.Simple(10, function() hook.Remove("HUDPaint", "SHATB") end)
 
		end
	end

	if (LocalPlayer():Team() == TEAM_VP2) or (LocalPlayer():Team() == TEAM_VP1) or (LocalPlayer():Team() == TEAM_VP3)or (LocalPlayer():Team() == TEAM_VP4) or (LocalPlayer():Team() == TEAM_VP5) then
		local DermaButton = vgui.Create( "DButton", TextFrame ) 
		DermaButton:SetText( "ГАЗ Тигр" )					
		DermaButton:SetPos( 400, 50 )						
		DermaButton:SetSize( 250, 30 )					
		DermaButton.DoClick = function()	
		  net.Start("SpawnVP")
		  net.SendToServer()			
		  RunConsoleCommand("say", "/r [RP] " ..LocalPlayer():GetName().. " расписался за ГАЗ Тигр.") 
		  hook.Add("HUDPaint", "SHATB", function()
			local scrw, scrh = ScrW(), ScrH()
			local WaypointA = Vector(-5365.6630859375, 13601.276367188, 70.03125)
			WaypointA = WaypointA:ToScreen()

			surface.SetDrawColor( 255, 255, 255, 255 ) -- Set the drawing color
			surface.SetMaterial( Material("icon16/stop.png") ) -- Use our cached material
			surface.DrawTexturedRect( WaypointA.x  , WaypointA.y , 30, 30 ) -- Actually draw the rectangle
								  
			 draw.SimpleText("МАШИНА", Trebuchet24, WaypointA.x + 15, WaypointA.y + 15, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end)

		timer.Simple(10, function() hook.Remove("HUDPaint", "SHATB") end)
 
		end

		local DermaButton = vgui.Create( "DButton", TextFrame ) 
		DermaButton:SetText( "ГАЗ КОРД" )					
		DermaButton:SetPos( 400, 100 )						
		DermaButton:SetSize( 250, 30 )					
		DermaButton.DoClick = function()	
		  net.Start("SpawnVP1")
		  net.SendToServer()			
		  RunConsoleCommand("say", "/r [RP] " ..LocalPlayer():GetName().. " расписался за ГАЗ КОРД") 
		  hook.Add("HUDPaint", "SHATB1", function()
			local scrw, scrh = ScrW(), ScrH()
			local WaypointA = Vector(-5365.6630859375, 13601.276367188, 70.03125)
			WaypointA = WaypointA:ToScreen()

			surface.SetDrawColor( 255, 255, 255, 255 ) -- Set the drawing color
			surface.SetMaterial( Material("icon16/stop.png") ) -- Use our cached material
			surface.DrawTexturedRect( WaypointA.x  , WaypointA.y , 30, 30 ) -- Actually draw the rectangle
								  
			 draw.SimpleText("МАШИНА", Trebuchet24, WaypointA.x + 15, WaypointA.y + 15, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end)

		timer.Simple(10, function() hook.Remove("HUDPaint", "SHATB1") end)
 
		end

		local DermaButton = vgui.Create( "DButton", TextFrame ) 
		DermaButton:SetText( "БТР ВП" )					
		DermaButton:SetPos( 75, 150 )					
		DermaButton:SetSize( 250, 30 )					
		DermaButton.DoClick = function()	
		  net.Start("SpawnVP2")
		  net.SendToServer()			
		  RunConsoleCommand("say", "/r [RP] " ..LocalPlayer():GetName().. " расписался за БТР ВП") 
		  hook.Add("HUDPaint", "SHATB2", function()
			local scrw, scrh = ScrW(), ScrH()
			local WaypointA = Vector(-5365.6630859375, 13601.276367188, 70.03125)
			WaypointA = WaypointA:ToScreen()

			surface.SetDrawColor( 255, 255, 255, 255 ) -- Set the drawing color
			surface.SetMaterial( Material("icon16/stop.png") ) -- Use our cached material
			surface.DrawTexturedRect( WaypointA.x  , WaypointA.y , 30, 30 ) -- Actually draw the rectangle
								  
			 draw.SimpleText("МАШИНА", Trebuchet24, WaypointA.x + 15, WaypointA.y + 15, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end)

		timer.Simple(10, function() hook.Remove("HUDPaint", "SHATB2") end)
 
		end
	end

	if (LocalPlayer():Team() == TEAM_313) or (LocalPlayer():Team() == TEAM_3131) then
		local DermaButton = vgui.Create( "DButton", TextFrame ) 
		DermaButton:SetText( "МЕД ТИГР" )					
		DermaButton:SetPos( 400, 50 )						
		DermaButton:SetSize( 250, 30 )					
		DermaButton.DoClick = function()	
		  net.Start("Spawn313")
		  net.SendToServer()			
		  RunConsoleCommand("say", "/r [RP] " ..LocalPlayer():GetName().. " расписался за ГАЗ АГС-30.") 
		end
		local DermaButton = vgui.Create( "DButton", TextFrame ) 
		DermaButton:SetText( "МЕД УАЗ" )					
		DermaButton:SetPos( 400, 100 )						
		DermaButton:SetSize( 250, 30 )					
		DermaButton.DoClick = function()	
		  net.Start("Spawn3131")
		  net.SendToServer()			
		  RunConsoleCommand("say", "/r [В/Ч-3944] " ..LocalPlayer():GetName().. " расписался за медицинский УАЗ")
		  chat.AddText(Color( 224, 72, 56 ), '[Уведомление] ', Color(231, 231, 231),'Ваш УАЗ ожидает вас неподалёку')
		end

	end

end






concommand.Add("givecar", garagemenu)
concommand.Add("mcrveh", vehmenu)
