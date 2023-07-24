include("shared.lua")


function ENT:Draw()

    self:DrawModel()

    local Pos = self:GetPos()
	local Ang = self:GetAngles()

	Ang:RotateAroundAxis(Ang:Forward(), 90)
	Ang:RotateAroundAxis(Ang:Right(), 180)

	local txt = "ГАРАЖ"
	

	surface.SetFont("DermaLarge")
	local TextWidth = surface.GetTextSize(txt)


	cam.Start3D2D(Pos - Ang:Right() + Ang:Up() * 1, Ang, 0.16)
		draw.WordBox(4, -TextWidth*0.5 - 5, -50, txt, "DermaLarge", Color(0, 0, 0, 255), Color(255,255,255,255))
	cam.End3D2D()

end

net.Receive( "OpenMOR", function()


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
	abutton:SetText( "Урал" )					
    abutton:SetPos( 72, 50 )					
    abutton:SetSize( 250, 30 )					
    abutton.DoClick = function()				
	  net.Start("URAL")
	  net.SendToServer()
	  local ply = LocalPlayer()
      chat.AddText( Color( 100, 100, 255 ), "| Конаненко А.В: ", "Выкатил машину, брат! ", Color( 100, 255, 100 ), "Удачи!" )			
    end

    abutton.DoRightClick = function()
		net.Start("URALDEL")
		net.SendToServer()	
		local ply = LocalPlayer()
		chat.AddText( Color( 100, 100, 255 ), "| Конаненко А.В: ", "Закатил машину! Обращайся!! " )
    end

	local dbutton = vgui.Create("DButton", TextFrame)
	dbutton:SetText( "БТР-80" )					
    dbutton:SetPos( 72, 100 )					
    dbutton:SetSize( 250, 30 )					
    dbutton.DoClick = function()				
	  net.Start("BTR80")
	  net.SendToServer()	
	  local ply = LocalPlayer()
      chat.AddText( Color( 100, 100, 255 ), "| Конаненко А.В: ", "Выкатил машину, брат! ", Color( 100, 255, 100 ), "Удачи!" )		
    end

    dbutton.DoRightClick = function()
		net.Start("BTR80DEL")
		net.SendToServer()	
		local ply = LocalPlayer()
		chat.AddText( Color( 100, 100, 255 ), "| Конаненко А.В: ", "Закатил машину! Обращайся!! " )
    end


	local richtext = vgui.Create("RichText", TextFrame)

	richtext:Dock(BOTTOM)


	richtext:InsertColorChange(192, 192, 192, 255)
    richtext:AppendText("ЛКМ - заспавнить. ПКМ - убрать. ")

    


end)