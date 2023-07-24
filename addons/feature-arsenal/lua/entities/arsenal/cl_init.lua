include("shared.lua")

surface.CreateFont( "Font_Weapons", {
    font = "roboto",
    size = 75,
    weight = 750
} )

function ENT:Draw()
	self:DrawModel()

	local Pos = self:GetPos()
	local Ang = self:GetAngles()

	Ang:RotateAroundAxis(Ang:Forward(), 90)
	Ang:RotateAroundAxis(Ang:Right(), 270)

	local txt = "А Р С Е Н А Л"
	local key = input.LookupBinding( "+use", true ) or "unbound"
	local txt2 = "Press " .. string.upper( key ) .. " to change weapon"

	surface.SetFont("DermaLarge")
	local TextWidth = surface.GetTextSize(txt)
	surface.SetFont( "Trebuchet18" )
	local TextWidth2 = surface.GetTextSize(txt2)

	cam.Start3D2D(Pos - Ang:Right() + Ang:Up() * 15, Ang, 0.16)
		draw.WordBox(4, -TextWidth*0.5 - 5, -200, txt, "DermaLarge", Color(0, 0, 0, 255), Color(255,255,255,255))
		draw.WordBox(4, -TextWidth2*0.5 - 5, -160, txt2, "Trebuchet18", Color(0, 0, 0, 255), Color(255,255,255,255))
	cam.End3D2D()
end

net.Receive( "OpenMenuArsenal", function()

	local white = Color( 255, 255, 255, 255 )
	local grey = Color( 78,60,78,255 )
	local white_grey = Color( 78,60,78,255 )
	local red = Color( 78,60,78,255 )
	local background = Color( 84,66,84,255 )

	local pPlayer = LocalPlayer()

	local weapons_table = {
	"АСВал",--1
	"АК74",
    "СВД-С",
    "ПМ",
    "ППВитязь",
    "РПК74",
    "РПГ-7",
    "АК-74У",
    "Наручники",
    "Веревка",
   	"Аптечка", --13
	"Инструменты",
	"Дубинка",

	}

	Derma_WeaponMenu = vgui.Create ( "DFrame" )
	Derma_WeaponMenu:SetSize( 400, 350 )
	Derma_WeaponMenu:SetPos( ScrW() * 0.205, ScrH() * 0.15 )
	Derma_WeaponMenu:SetTitle( "Арсенал" )
	Derma_WeaponMenu:Center()
	Derma_WeaponMenu:ShowCloseButton( true )
	Derma_WeaponMenu:MakePopup()

	local DPanel = vgui.Create( "DPanel", Derma_WeaponMenu )
    DPanel:SetPos( 5, 150 ) -- Set the position of the panel
    DPanel:SetSize( 390, 190 ) -- Set the size of the panel
    local DLabelAR = vgui.Create("DLabel", Derma_WeaponMenu )
    DLabelAR:SetText( "Арсенал" )
    DLabelAR:SetFont( "dbg-hud.normal" )
    DLabelAR:SetPos( 160, 150 )
    DLabelAR:SizeToContents() 
	local DLabel3 = vgui.Create("DLabel", Derma_WeaponMenu )
    DLabel3:SetText( "Выберите оружие из списка ниже:\nАвтоматическое оружие\nПистолеты\nПулеметы\nСнайперские винтовки\nНожи" )
    DLabel3:SetFont( "dbg-hud.small" )
    DLabel3:SetPos( 10, 180 )
    DLabel3:SizeToContents()

	--SwitchWeapon
--=================================================542==========================================================================
--командир (мор1)
if pPlayer:Team() == TEAM_MOR1 then 
	Combo_Weapon = vgui.Create( "DComboBox", Derma_WeaponMenu )
	Combo_Weapon:SetPos(5, 30)
	Combo_Weapon:SetSize(390, 20)
	Combo_Weapon:SetValue( "Выберите Основное Вооружение" )
	Combo_Weapon:AddChoice( weapons_table[1] )
	Combo_Weapon:AddChoice( weapons_table[2] )
	function Combo_Weapon:OnSelect( self, index, value )
		name_rifle = index
	end

	Combo_Pistol = vgui.Create( "DComboBox", Derma_WeaponMenu )
	Combo_Pistol:SetPos(5, 60)
	Combo_Pistol:SetSize(390, 20)
	Combo_Pistol:SetValue( "Выберите Второстепенное Вооружение" )
	Combo_Pistol:AddChoice( weapons_table[4] )
	function Combo_Pistol:OnSelect( self, index, value )
		name_pistol = index
	end

	Combo_Other = vgui.Create( "DComboBox", Derma_WeaponMenu )
	Combo_Other:SetPos(5, 90)
    Combo_Other:SetSize(390, 20)
	Combo_Other:SetValue( "Выберите Прочее Снаряжение" )
	Combo_Other:AddChoice( weapons_table[11] )
	function Combo_Other:OnSelect( self, index, value )
		name_other = index
	end
end
--стрелок (мор2)
if pPlayer:Team() == TEAM_MOR2 then 
	Combo_Weapon = vgui.Create( "DComboBox", Derma_WeaponMenu )
	Combo_Weapon:SetPos(5, 30)
	Combo_Weapon:SetSize(390, 20)
	Combo_Weapon:SetValue( "Выберите Основное Вооружение" )
	Combo_Weapon:AddChoice( weapons_table[2] )
	function Combo_Weapon:OnSelect( self, index, value )
		name_rifle = index
	end
end

--медик (mor3)
if pPlayer:Team() == TEAM_MOR3 then 
	Combo_Weapon = vgui.Create( "DComboBox", Derma_WeaponMenu )
	Combo_Weapon:SetPos(5, 30)
	Combo_Weapon:SetSize(390, 20)
	Combo_Weapon:SetValue( "Выберите Основное Вооружение" )
	Combo_Weapon:AddChoice( weapons_table[8] )
	function Combo_Weapon:OnSelect( self, index, value )
		name_rifle = index
	end

	Combo_Pistol = vgui.Create( "DComboBox", Derma_WeaponMenu )
	Combo_Pistol:SetPos(5, 60)
	Combo_Pistol:SetSize(390, 20)
	Combo_Pistol:SetValue( "Выберите Второстепенное Вооружение" )
	Combo_Pistol:AddChoice( weapons_table[4] )
	function Combo_Pistol:OnSelect( self, index, value )
		name_pistol = index
	end

	Combo_Other = vgui.Create( "DComboBox", Derma_WeaponMenu )
	Combo_Other:SetPos(5, 90)
	Combo_Other:SetSize(390, 20)
	Combo_Other:SetValue( "Выберите Прочее Снаряжение" )
	Combo_Other:AddChoice( weapons_table[11] )
	function Combo_Other:OnSelect( self, index, value )
		name_other = index
	end
end

--снайпер(mor4)
if pPlayer:Team() == TEAM_MOR4 then 
	Combo_Weapon = vgui.Create( "DComboBox", Derma_WeaponMenu )
	Combo_Weapon:SetPos(5, 30)
	Combo_Weapon:SetSize(390, 20)
	Combo_Weapon:SetValue( "Выберите Основное Вооружение" )
	Combo_Weapon:AddChoice( weapons_table[3] )
	function Combo_Weapon:OnSelect( self, index, value )
		name_rifle = index
	end

	Combo_Pistol = vgui.Create( "DComboBox", Derma_WeaponMenu )
	Combo_Pistol:SetPos(5, 60)
	Combo_Pistol:SetSize(390, 20)
	Combo_Pistol:SetValue( "Выберите Второстепенное Вооружение" )
	Combo_Pistol:AddChoice( weapons_table[4] )
	function Combo_Pistol:OnSelect( self, index, value )
		name_pistol = index
	end
end

--пулеметчик(mor5)
if pPlayer:Team() == TEAM_MOR5 then 
	Combo_Weapon = vgui.Create( "DComboBox", Derma_WeaponMenu )
	Combo_Weapon:SetPos(5, 30)
	Combo_Weapon:SetSize(390, 20)
	Combo_Weapon:SetValue( "Выберите Основное Вооружение" )
	Combo_Weapon:AddChoice( weapons_table[6] )
	function Combo_Weapon:OnSelect( self, index, value )
		name_rifle = index
	end

	Combo_Pistol = vgui.Create( "DComboBox", Derma_WeaponMenu )
	Combo_Pistol:SetPos(5, 60)
	Combo_Pistol:SetSize(390, 20)
	Combo_Pistol:SetValue( "Выберите Второстепенное Вооружение" )
	Combo_Pistol:AddChoice( weapons_table[4] )
	function Combo_Pistol:OnSelect( self, index, value )
		name_pistol = index
	end
end

--гранатометчик(mor6)
if pPlayer:Team() == TEAM_MOR6 then 
	Combo_Weapon = vgui.Create( "DComboBox", Derma_WeaponMenu )
	Combo_Weapon:SetPos(5, 30)
	Combo_Weapon:SetSize(390, 20)
	Combo_Weapon:SetValue( "Выберите Основное Вооружение" )
	Combo_Weapon:AddChoice( weapons_table[2] )
	function Combo_Weapon:OnSelect( self, index, value )
		name_rifle = index
	end

	Combo_Pistol = vgui.Create( "DComboBox", Derma_WeaponMenu )
	Combo_Pistol:SetPos(5, 60)
	Combo_Pistol:SetSize(390, 20)
	Combo_Pistol:SetValue( "Выберите Второстепенное Вооружение" )
	Combo_Pistol:AddChoice( weapons_table[4] )
	function Combo_Pistol:OnSelect( self, index, value )
		name_pistol = index
	end

	Combo_Other = vgui.Create( "DComboBox", Derma_WeaponMenu )
	Combo_Other:SetPos(5, 90)
	Combo_Other:SetSize(390, 20)
	Combo_Other:SetValue( "Выберите Прочее Снаряжение" )
	Combo_Other:AddChoice( weapons_table[7] )
	function Combo_Other:OnSelect( self, index, value )
		name_other = index
	end
end

--танкисты
if pPlayer:Team() == TEAM_MOR7 then 
	Combo_Weapon = vgui.Create( "DComboBox", Derma_WeaponMenu )
	Combo_Weapon:SetPos(5, 30)
	Combo_Weapon:SetSize(390, 20)
	Combo_Weapon:SetValue( "Выберите Основное Вооружение" )
	Combo_Weapon:AddChoice( weapons_table[5] )
	Combo_Weapon:AddChoice( weapons_table[8] )
	function Combo_Weapon:OnSelect( self, index, value )
		name_rifle = index
	end

	Combo_Pistol = vgui.Create( "DComboBox", Derma_WeaponMenu )
	Combo_Pistol:SetPos(5, 60)
	Combo_Pistol:SetSize(390, 20)
	Combo_Pistol:SetValue( "Выберите Второстепенное Вооружение" )
	Combo_Pistol:AddChoice( weapons_table[4] )
	function Combo_Pistol:OnSelect( self, index, value )
		name_pistol = index
	end

	Combo_Other = vgui.Create( "DComboBox", Derma_WeaponMenu )
	Combo_Other:SetPos(5, 90)
	Combo_Other:SetSize(390, 20)
	Combo_Other:SetValue( "Выберите Прочее Снаряжение" )
	Combo_Other:AddChoice( weapons_table[12] )
	function Combo_Other:OnSelect( self, index, value )
		name_other = index
	end
end

if pPlayer:Team() == TEAM_MOR8 then 
	Combo_Weapon = vgui.Create( "DComboBox", Derma_WeaponMenu )
	Combo_Weapon:SetPos(5, 30)
	Combo_Weapon:SetSize(390, 20)
	Combo_Weapon:SetValue( "Выберите Основное Вооружение" )
	Combo_Weapon:AddChoice( weapons_table[5] )
	Combo_Weapon:AddChoice( weapons_table[8] )
	function Combo_Weapon:OnSelect( self, index, value )
		name_rifle = index
	end

	Combo_Pistol = vgui.Create( "DComboBox", Derma_WeaponMenu )
	Combo_Pistol:SetPos(5, 60)
	Combo_Pistol:SetSize(390, 20)
	Combo_Pistol:SetValue( "Выберите Второстепенное Вооружение" )
	Combo_Pistol:AddChoice( weapons_table[4] )
	function Combo_Pistol:OnSelect( self, index, value )
		name_pistol = index
	end

	Combo_Other = vgui.Create( "DComboBox", Derma_WeaponMenu )
	Combo_Other:SetPos(5, 90)
	Combo_Other:SetSize(390, 20)
	Combo_Other:SetValue( "Выберите Прочее Снаряжение" )
	Combo_Other:AddChoice( weapons_table[12] )
	function Combo_Other:OnSelect( self, index, value )
		name_other = index
	end
end


--===========================================ШТАБ=======================
if pPlayer:Team() == TEAM_SHTAB1 then 
	Combo_Pistol = vgui.Create( "DComboBox", Derma_WeaponMenu )
	Combo_Pistol:SetPos(5, 30)
	Combo_Pistol:SetSize(390, 20)
	Combo_Pistol:SetValue( "Выберите Второстепенное Вооружение" )
	Combo_Pistol:AddChoice( weapons_table[4] )
	function Combo_Pistol:OnSelect( self, index, value )
		name_pistol = index
	end
end

if pPlayer:Team() == TEAM_SHTAB2 then 
	Combo_Pistol = vgui.Create( "DComboBox", Derma_WeaponMenu )
	Combo_Pistol:SetPos(5, 30)
	Combo_Pistol:SetSize(390, 20)
	Combo_Pistol:SetValue( "Выберите Второстепенное Вооружение" )
	Combo_Pistol:AddChoice( weapons_table[4] )
	function Combo_Pistol:OnSelect( self, index, value )
		name_pistol = index
	end
end

if pPlayer:Team() == TEAM_SHTAB3 then 
	Combo_Pistol = vgui.Create( "DComboBox", Derma_WeaponMenu )
	Combo_Pistol:SetPos(5, 30)
	Combo_Pistol:SetSize(390, 20)
	Combo_Pistol:SetValue( "Выберите Второстепенное Вооружение" )
	Combo_Pistol:AddChoice( weapons_table[4] )
	function Combo_Pistol:OnSelect( self, index, value )
		name_pistol = index
	end
end
--===========================================ВВС=======================
if pPlayer:Team() == TEAM_VVS then 
	Combo_Weapon = vgui.Create( "DComboBox", Derma_WeaponMenu )
	Combo_Weapon:SetPos(5, 30)
	Combo_Weapon:SetSize(390, 20)
	Combo_Weapon:SetValue( "Выберите Основное Вооружение" )
	Combo_Weapon:AddChoice( weapons_table[5] )
	Combo_Weapon:AddChoice( weapons_table[8] )
	function Combo_Weapon:OnSelect( self, index, value )
		name_rifle = index
	end

	Combo_Pistol = vgui.Create( "DComboBox", Derma_WeaponMenu )
	Combo_Pistol:SetPos(5, 60)
	Combo_Pistol:SetSize(390, 20)
	Combo_Pistol:SetValue( "Выберите Второстепенное Вооружение" )
	Combo_Pistol:AddChoice( weapons_table[4] )
	function Combo_Pistol:OnSelect( self, index, value )
		name_pistol = index
	end
end

if pPlayer:Team() == TEAM_VVS1 then 
	Combo_Weapon = vgui.Create( "DComboBox", Derma_WeaponMenu )
	Combo_Weapon:SetPos(5, 30)
	Combo_Weapon:SetSize(390, 20)
	Combo_Weapon:SetValue( "Выберите Основное Вооружение" )
	Combo_Weapon:AddChoice( weapons_table[5] )
	Combo_Weapon:AddChoice( weapons_table[8] )
	function Combo_Weapon:OnSelect( self, index, value )
		name_rifle = index
	end

	Combo_Pistol = vgui.Create( "DComboBox", Derma_WeaponMenu )
	Combo_Pistol:SetPos(5, 60)
	Combo_Pistol:SetSize(390, 20)
	Combo_Pistol:SetValue( "Выберите Второстепенное Вооружение" )
	Combo_Pistol:AddChoice( weapons_table[4] )
	function Combo_Pistol:OnSelect( self, index, value )
		name_pistol = index
	end
end

if pPlayer:Team() == TEAM_VVS2 then 

	Combo_Pistol = vgui.Create( "DComboBox", Derma_WeaponMenu )
	Combo_Pistol:SetPos(5, 30)
	Combo_Pistol:SetSize(390, 20)
	Combo_Pistol:SetValue( "Выберите Второстепенное Вооружение" )
	Combo_Pistol:AddChoice( weapons_table[4] )
	function Combo_Pistol:OnSelect( self, index, value )
		name_pistol = index
	end
end
--===========================================45=======================
if pPlayer:Team() == TEAM_VDV1 then 
	Combo_Weapon = vgui.Create( "DComboBox", Derma_WeaponMenu )
	Combo_Weapon:SetPos(5, 30)
	Combo_Weapon:SetSize(390, 20)
	Combo_Weapon:SetValue( "Выберите Основное Вооружение" )
	Combo_Weapon:AddChoice( weapons_table[1] )
	Combo_Weapon:AddChoice( weapons_table[2] )
	function Combo_Weapon:OnSelect( self, index, value )
		name_rifle = index
	end

	Combo_Pistol = vgui.Create( "DComboBox", Derma_WeaponMenu )
	Combo_Pistol:SetPos(5, 60)
	Combo_Pistol:SetSize(390, 20)
	Combo_Pistol:SetValue( "Выберите Второстепенное Вооружение" )
	Combo_Pistol:AddChoice( weapons_table[4] )
	function Combo_Pistol:OnSelect( self, index, value )
		name_pistol = index
	end

	Combo_Other = vgui.Create( "DComboBox", Derma_WeaponMenu )
	Combo_Other:SetPos(5, 90)
	Combo_Other:SetSize(390, 20)
	Combo_Other:SetValue( "Выберите Прочее Снаряжение" )
	Combo_Other:AddChoice( weapons_table[11] )
	function Combo_Other:OnSelect( self, index, value )
		name_other = index
	end
end

if pPlayer:Team() == TEAM_VDV2 then 
	Combo_Weapon = vgui.Create( "DComboBox", Derma_WeaponMenu )
	Combo_Weapon:SetPos(5, 30)
	Combo_Weapon:SetSize(390, 20)
	Combo_Weapon:SetValue( "Выберите Основное Вооружение" )
	Combo_Weapon:AddChoice( weapons_table[1] )
	Combo_Weapon:AddChoice( weapons_table[2] )
	function Combo_Weapon:OnSelect( self, index, value )
		name_rifle = index
	end
end

if pPlayer:Team() == TEAM_VDV3 then 
	Combo_Weapon = vgui.Create( "DComboBox", Derma_WeaponMenu )
	Combo_Weapon:SetPos(5, 30)
	Combo_Weapon:SetSize(390, 20)
	Combo_Weapon:SetValue( "Выберите Основное Вооружение" )
	Combo_Weapon:AddChoice( weapons_table[1] )
	Combo_Weapon:AddChoice( weapons_table[2] )
	function Combo_Weapon:OnSelect( self, index, value )
		name_rifle = index
	end

	Combo_Pistol = vgui.Create( "DComboBox", Derma_WeaponMenu )
	Combo_Pistol:SetPos(5, 60)
	Combo_Pistol:SetSize(390, 20)
	Combo_Pistol:SetValue( "Выберите Второстепенное Вооружение" )
	Combo_Pistol:AddChoice( weapons_table[4] )
	function Combo_Pistol:OnSelect( self, index, value )
		name_pistol = index
	end
end

if pPlayer:Team() == TEAM_VDV4 then 
	Combo_Weapon = vgui.Create( "DComboBox", Derma_WeaponMenu )
	Combo_Weapon:SetPos(5, 30)
	Combo_Weapon:SetSize(390, 20)
	Combo_Weapon:SetValue( "Выберите Основное Вооружение" )
	Combo_Weapon:AddChoice( weapons_table[1] )
	Combo_Weapon:AddChoice( weapons_table[2] )
	function Combo_Weapon:OnSelect( self, index, value )
		name_rifle = index
	end

	Combo_Pistol = vgui.Create( "DComboBox", Derma_WeaponMenu )
	Combo_Pistol:SetPos(5, 60)
	Combo_Pistol:SetSize(390, 20)
	Combo_Pistol:SetValue( "Выберите Второстепенное Вооружение" )
	Combo_Pistol:AddChoice( weapons_table[4] )
	function Combo_Pistol:OnSelect( self, index, value )
		name_pistol = index
	end

	Combo_Other = vgui.Create( "DComboBox", Derma_WeaponMenu )
	Combo_Other:SetPos(5, 90)
	Combo_Other:SetSize(390, 20)
	Combo_Other:SetValue( "Выберите Прочее Снаряжение" )
	Combo_Other:AddChoice( weapons_table[11] )
	function Combo_Other:OnSelect( self, index, value )
		name_other = index
	end
end

if pPlayer:Team() == TEAM_VDV5 then 
	Combo_Weapon = vgui.Create( "DComboBox", Derma_WeaponMenu )
	Combo_Weapon:SetPos(5, 30)
	Combo_Weapon:SetSize(390, 20)
	Combo_Weapon:SetValue( "Выберите Основное Вооружение" )
	Combo_Weapon:AddChoice( weapons_table[1] )
	Combo_Weapon:AddChoice( weapons_table[2] )
	function Combo_Weapon:OnSelect( self, index, value )
		name_rifle = index
	end

	Combo_Pistol = vgui.Create( "DComboBox", Derma_WeaponMenu )
	Combo_Pistol:SetPos(5, 60)
	Combo_Pistol:SetSize(390, 20)
	Combo_Pistol:SetValue( "Выберите Второстепенное Вооружение" )
	Combo_Pistol:AddChoice( weapons_table[4] )
	function Combo_Pistol:OnSelect( self, index, value )
		name_pistol = index
	end

	Combo_Other = vgui.Create( "DComboBox", Derma_WeaponMenu )
	Combo_Other:SetPos(5, 90)
	Combo_Other:SetSize(390, 20)
	Combo_Other:SetValue( "Выберите Прочее Снаряжение" )
	Combo_Other:AddChoice( weapons_table[7] )
	function Combo_Other:OnSelect( self, index, value )
		name_other = index
	end
end

--==================ВОЕННАЯ ПОЛИЦИЯ========================

if pPlayer:Team() == TEAM_VP1 then 
	Combo_Weapon = vgui.Create( "DComboBox", Derma_WeaponMenu )
	Combo_Weapon:SetPos(5, 30)
	Combo_Weapon:SetSize(390, 20)
	Combo_Weapon:SetValue( "Выберите Основное Вооружение" )
	Combo_Weapon:AddChoice( weapons_table[2] )
	function Combo_Weapon:OnSelect( self, index, value )
		name_rifle = index
	end

	Combo_Pistol = vgui.Create( "DComboBox", Derma_WeaponMenu )
	Combo_Pistol:SetPos(5, 60)
	Combo_Pistol:SetSize(390, 20)
	Combo_Pistol:SetValue( "Выберите Второстепенное Вооружение" )
	Combo_Pistol:AddChoice( weapons_table[4] )
	function Combo_Pistol:OnSelect( self, index, value )
		name_pistol = index
	end

	Combo_Other = vgui.Create( "DComboBox", Derma_WeaponMenu )
	Combo_Other:SetPos(5, 90)
	Combo_Other:SetSize(390, 20)
	Combo_Other:SetValue( "Выберите Прочее Снаряжение" )
	Combo_Other:AddChoice( weapons_table[9] )
	Combo_Other:AddChoice( weapons_table[13] )
	function Combo_Other:OnSelect( self, index, value )
		name_other = index
	end
end

if pPlayer:Team() == TEAM_VP2 then 
	Combo_Weapon = vgui.Create( "DComboBox", Derma_WeaponMenu )
	Combo_Weapon:SetPos(5, 30)
	Combo_Weapon:SetSize(390, 20)
	Combo_Weapon:SetValue( "Выберите Основное Вооружение" )
	Combo_Weapon:AddChoice( weapons_table[2] )
	function Combo_Weapon:OnSelect( self, index, value )
		name_rifle = index
	end

	Combo_Pistol = vgui.Create( "DComboBox", Derma_WeaponMenu )
	Combo_Pistol:SetPos(5, 60)
	Combo_Pistol:SetSize(390, 20)
	Combo_Pistol:SetValue( "Выберите Второстепенное Вооружение" )
	Combo_Pistol:AddChoice( weapons_table[4] )
	function Combo_Pistol:OnSelect( self, index, value )
		name_pistol = index
	end

	Combo_Other = vgui.Create( "DComboBox", Derma_WeaponMenu )
	Combo_Other:SetPos(5, 90)
	Combo_Other:SetSize(390, 20)
	Combo_Other:SetValue( "Выберите Прочее Снаряжение" )
	Combo_Other:AddChoice( weapons_table[9] )
	Combo_Other:AddChoice( weapons_table[13] )
	function Combo_Other:OnSelect( self, index, value )
		name_other = index
	end
end

if pPlayer:Team() == TEAM_VP3 then 
	Combo_Weapon = vgui.Create( "DComboBox", Derma_WeaponMenu )
	Combo_Weapon:SetPos(5, 30)
	Combo_Weapon:SetSize(390, 20)
	Combo_Weapon:SetValue( "Выберите Основное Вооружение" )
	Combo_Weapon:AddChoice( weapons_table[2] )
	function Combo_Weapon:OnSelect( self, index, value )
		name_rifle = index
	end

	Combo_Pistol = vgui.Create( "DComboBox", Derma_WeaponMenu )
	Combo_Pistol:SetPos(5, 60)
	Combo_Pistol:SetSize(390, 20)
	Combo_Pistol:SetValue( "Выберите Второстепенное Вооружение" )
	Combo_Pistol:AddChoice( weapons_table[4] )
	function Combo_Pistol:OnSelect( self, index, value )
		name_pistol = index
	end

	Combo_Other = vgui.Create( "DComboBox", Derma_WeaponMenu )
	Combo_Other:SetPos(5, 90)
	Combo_Other:SetSize(390, 20)
	Combo_Other:SetValue( "Выберите Прочее Снаряжение" )
	Combo_Other:AddChoice( weapons_table[13] )
	Combo_Other:AddChoice( weapons_table[9] )
	function Combo_Other:OnSelect( self, index, value )
		name_other = index
	end
end

if pPlayer:Team() == TEAM_VP4 then 
	Combo_Weapon = vgui.Create( "DComboBox", Derma_WeaponMenu )
	Combo_Weapon:SetPos(5, 30)
	Combo_Weapon:SetSize(390, 20)
	Combo_Weapon:SetValue( "Выберите Основное Вооружение" )
	Combo_Weapon:AddChoice( weapons_table[2] )
	function Combo_Weapon:OnSelect( self, index, value )
		name_rifle = index
	end

	Combo_Pistol = vgui.Create( "DComboBox", Derma_WeaponMenu )
	Combo_Pistol:SetPos(5, 60)
	Combo_Pistol:SetSize(390, 20)
	Combo_Pistol:SetValue( "Выберите Второстепенное Вооружение" )
	Combo_Pistol:AddChoice( weapons_table[4] )
	function Combo_Pistol:OnSelect( self, index, value )
		name_pistol = index
	end

	Combo_Other = vgui.Create( "DComboBox", Derma_WeaponMenu )
	Combo_Other:SetPos(5, 90)
	Combo_Other:SetSize(390, 20)
	Combo_Other:SetValue( "Выберите Прочее Снаряжение" )
	Combo_Other:AddChoice( weapons_table[13] )
	Combo_Other:AddChoice( weapons_table[9] )
	function Combo_Other:OnSelect( self, index, value )
		name_other = index
	end
end
	--Button
	Button_WeaponMenu = vgui.Create( "DButton", Derma_WeaponMenu )
	Button_WeaponMenu:SetPos( 65, 300 )
	Button_WeaponMenu:SetSize( 250, 30 )
	Button_WeaponMenu:SetText( "Получить вооружение" )


	function Button_WeaponMenu:DoClick()
		net.Start( "GetPlayer" )
			net.WriteType(pPlayer)
		net.SendToServer()

		net.Start( "GiveWeapon" )
			net.WriteType(name_rifle)
		net.SendToServer()

		net.Start( "GivePistol" )
			net.WriteType(name_pistol)
		net.SendToServer()

		net.Start( "GiveOther" )
			net.WriteType(name_other)
		net.SendToServer()
		--
		Derma_WeaponMenu:Close()
	end
end)
