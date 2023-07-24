include("shared.lua")


function ENT:Draw()

    self:DrawModel()

    local Pos = self:GetPos()
	local Ang = self:GetAngles()

	Ang:RotateAroundAxis(Ang:Forward(), 90)
	Ang:RotateAroundAxis(Ang:Right(), 180)

	local txt = "АНГАР"
	

	surface.SetFont("DermaLarge")
	local TextWidth = surface.GetTextSize(txt)


	cam.Start3D2D(Pos - Ang:Right() + Ang:Up() * 1, Ang, 0.16)
		draw.WordBox(4, -TextWidth*0.5 - 5, -50, txt, "DermaLarge", Color(0, 0, 0, 255), Color(255,255,255,255))
	cam.End3D2D()

end

net.Receive( "OpenVVS", function()


	surface.CreateFont("Font", {
		font = "Arial",
		extended = true,
		size = 20
	})
	
	local TextFrame = vgui.Create("DFrame")
	TextFrame:SetSize(400, 400)
	TextFrame:Center()
	TextFrame:SetTitle("Ангар ВКС")
	TextFrame:SetVisible( true )
	TextFrame:SetDraggable( true )
	TextFrame:ShowCloseButton( true )
	TextFrame:MakePopup()
	TextFrame:SetBackgroundBlur( true )-- Results in "Connection Refused - VAC"

	local abutton = vgui.Create("DButton", TextFrame)
	abutton:SetText( "МИ-8" )					
    abutton:SetPos( 72, 50 )					
    abutton:SetSize( 250, 30 )					
    abutton.DoClick = function()				
	  net.Start("MI-8")
	  net.SendToServer()
	  local ply = LocalPlayer()
      chat.AddText( Color( 100, 100, 255 ), "| Конаненко А.В: ", "Выкатил машину, брат! ", Color( 100, 255, 100 ), "Удачи!" )			
    end

    abutton.DoRightClick = function()
		net.Start("MI-8DEL")
		net.SendToServer()	
		local ply = LocalPlayer()
		chat.AddText( Color( 100, 100, 255 ), "| Конаненко А.В: ", "Закатил машину! Обращайся!! " )
    end

	local dbutton = vgui.Create("DButton", TextFrame)
	dbutton:SetText( "МИ-8 РАКЕТН" )					
    dbutton:SetPos( 72, 100 )					
    dbutton:SetSize( 250, 30 )					
    dbutton.DoClick = function()				
	  net.Start("MI-8R")
	  net.SendToServer()	
	  local ply = LocalPlayer()
      chat.AddText( Color( 100, 100, 255 ), "| Конаненко А.В: ", "Выкатил машину, брат! ", Color( 100, 255, 100 ), "Удачи!" )		
    end

    dbutton.DoRightClick = function()
		net.Start("MI-8RDEL")
		net.SendToServer()	
		local ply = LocalPlayer()
		chat.AddText( Color( 100, 100, 255 ), "| Конаненко А.В: ", "Закатил машину! Обращайся!! " )
    end

	local dbutton = vgui.Create("DButton", TextFrame)
	dbutton:SetText( "СУ-24" )					
    dbutton:SetPos( 72, 150 )					
    dbutton:SetSize( 250, 30 )					
    dbutton.DoClick = function()				
	  net.Start("SU-24")
	  net.SendToServer()
	  
	  local ply = LocalPlayer()
      chat.AddText( Color( 100, 100, 255 ), "| Конаненко А.В: ", "Выкатил машину, брат! ", Color( 100, 255, 100 ), "Удачи!" )

    end

    dbutton.DoRightClick = function()
		net.Start("SU-24DEL")
		net.SendToServer()	
		local ply = LocalPlayer()
		chat.AddText( Color( 100, 100, 255 ), "| Конаненко А.В: ", "Закатил машину! Обращайся!! " )
		
    end

	local fbutton = vgui.Create("DButton", TextFrame)
	fbutton:SetText( "МИ-28" )					
    fbutton:SetPos( 72, 200 )					
    fbutton:SetSize( 250, 30 )					
    fbutton.DoClick = function()				
	  net.Start("MI-28N")
	  net.SendToServer()
	  
	  local ply = LocalPlayer()
      chat.AddText( Color( 100, 100, 255 ), "| Конаненко А.В: ", "Выкатил машину, брат! ", Color( 100, 255, 100 ), "Удачи!" )

    end

    fbutton.DoRightClick = function()
		net.Start("MI-28NDEL")
		net.SendToServer()	
		local ply = LocalPlayer()
		chat.AddText( Color( 100, 100, 255 ), "| Конаненко А.В: ", "Закатил машину! Обращайся!! " )
		
    end

	local richtext = vgui.Create("RichText", TextFrame)

	richtext:Dock(BOTTOM)


	richtext:InsertColorChange(192, 192, 192, 255)
    richtext:AppendText("ЛКМ - заспавнить. ПКМ - убрать. ")

    


end)
local vvsm_table = {
    [TEAM_VVS] = true,
    [TEAM_VVS1] = true,
    [TEAM_VVS2] = true,

}

concommand.Add("maydaya", function(ply)
	if vvsm_table[ply:Team()] then
	if timer.Exists( "MAYDAYTIME" ) then return  end
	if not ply:InVehicle() then return end
	local abiba = ply:GetPos()

	net.Start("MAYDAY")
	net.WriteEntity(ply)
	net.WriteVector(abiba)
	net.SendToServer()

	timer.Create( "MAYDAYTIME", 1, 40, function() end)

	else
	
		print("no")
	end

end)

net.Receive("clmay", function()
	local aba = net.ReadEntity(ply)
	local abi = net.ReadVector(abibas)
	print(net.ReadVector())
	
	hook.Add("HUDPaint", "MAYDAY", function()
		local scrw, scrh = ScrW(), ScrH()
		local WaypointA = abi
		WaypointA = WaypointA:ToScreen()
		

		surface.SetDrawColor( 255, 255, 255, 255 ) -- Set the drawing color
		surface.SetMaterial( Material("icon16/stop.png") ) -- Use our cached material
		surface.DrawTexturedRect( WaypointA.x  , WaypointA.y , 30, 30 ) -- Actually draw the rectangle
							  
		 draw.SimpleText("MAYDAY", Trebuchet24, WaypointA.x + 15, WaypointA.y + 15, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end)

	timer.Simple(40, function() hook.Remove("HUDPaint", "MAYDAY") end)

	chat.AddText( Color( 178, 34, 34 ), "| УВД: ", "Поступил сигнал тревоги от летчиков ВКС! " )



end)