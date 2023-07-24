function OpenFreeBodyGrouprMenu()

	local RefreshBodygroups
	local cleanupElements = {}

	local ClosetWindow = vgui.Create( "DFrame" )
	ClosetWindow:SetSize( ScrW() * 0.9, ScrH() * 0.9 )
	ClosetWindow:Center()
	ClosetWindow:SetSize( ScrW() * 0.45, ScrH() * 0.9 )
	ClosetWindow:SetTitle( "" )
	ClosetWindow:MakePopup()
	ClosetWindow:SetDraggable( false )
	ClosetWindow:ShowCloseButton( false )
	function ClosetWindow:Paint( w, h )
		draw.RoundedBox( 5, 0, 0, w, h, Color( 84,66,84,255 ) )
		draw.RoundedBox( 5, 0, 0, w, 24, Color( 29,21,29,255 ) )
		draw.RoundedBox( 5, 0, h-48, w, 48, Color( 29,21,29,255 ) )
	end
	local cwsizew, cwsizeh = ClosetWindow:GetSize()
    gui.OpenURL('http://mcr-rp.ru/ru/dresscode')
	
	local ModelRotSlider = vgui.Create( "DNumSlider", ClosetWindow )
	ModelRotSlider:SetPos( 0, cwsizeh - 50 )
	ModelRotSlider:SetSize( cwsizew * 0.75, 50 )
	ModelRotSlider:SetMin( 0 )
	ModelRotSlider:SetMax( 360 )
	ModelRotSlider:SetDecimals( 2 )
	ModelRotSlider.OnValueChanged = function( self, val )
		if val == 360 then
			ModelRotSlider:SetValue(0)
		end
	end
	
	local YourModel = vgui.Create( "DModelPanel", ClosetWindow )
	YourModel:SetSize( cwsizew, cwsizeh * 0.9 )
	YourModel:SetPos( 0, cwsizeh * 0.025 )
	YourModel:SetModel( LocalPlayer():GetModel() )
	function YourModel:LayoutEntity( ent )

		if ( self.bAnimated ) then
			self:RunAnimation()
		end

		ent:SetAngles( Angle( 0, ModelRotSlider:GetValue(), 0 ) )

	end
	function YourModel:PostDrawModel( ent )
		for k,v in pairs( ent:GetBodyGroups() ) do
			ent:SetBodygroup( k - 1, LocalPlayer():GetBodygroup( k - 1 ) )
		end
	end
	
	local TitleLabel = vgui.Create( "DLabel", ClosetWindow )
	TitleLabel:SetText( "Гардероб" )
	TitleLabel:SetPos( 5, 3 )
	TitleLabel:SetFont( "Default" )
	TitleLabel:SizeToContents()
	TitleLabel:SetTextColor( Color( 255, 255, 255 ) )
	-------------------------------------
	local BodyGroupWindow = vgui.Create( "DFrame" )
	BodyGroupWindow:SetSize( ScrW() * 0.45, ScrH() * 0.9 )
	BodyGroupWindow:SetPos( ScrW() * 0.5, ScrH() * 0.05 )
	BodyGroupWindow:SetTitle( "" )
	BodyGroupWindow:MakePopup()
	BodyGroupWindow:SetDraggable( false )
	BodyGroupWindow:ShowCloseButton( false )
	local bgsizew, bgsizeh = BodyGroupWindow:GetSize()
	function BodyGroupWindow:Paint( w, h )
		draw.RoundedBox( 5, 0, 0, w, h, Color( 70,54,70,255  ) )
		draw.RoundedBox( 5, 0, 0, w, 24, Color( 29,21,29,255 ) )
		draw.RoundedBox( 5, 0, h-48, w, 48, Color( 29,21,29,255 ) )
	end
	
	local function ConstructBGString()
		local bodygroups = {}
		for k,v in pairs( LocalPlayer():GetBodyGroups() ) do
			bodygroups[k] = LocalPlayer():GetBodygroup( k - 1 )
		end
		return table.concat( bodygroups )
	end
	
	local ModelLabel
	local ModelCombo

	if DarkRP then
		if type( LocalPlayer():getJobTable().model ) == "table" then
			ModelCombo = vgui.Create( "DComboBox", BodyGroupWindow )
			ModelCombo:SetValue( LocalPlayer():GetModel() )
			ModelCombo:SetPos( bgsizew * 0.01, 32 )
			ModelCombo:SetSize( bgsizew * 0.4, 20 )
			ModelCombo:SetFont( "Trebuchet18" )
			for k,v in pairs( LocalPlayer():getJobTable().model ) do
				ModelCombo:AddChoice( v )
			end
			ModelCombo.OnSelect = function( self, index, value )
				net.Start( "update_store_freebodygroupr" )
					net.WriteInt( -10, 32 )
					net.WriteInt( -10, 32 ) --dude, fuck
					net.WriteString( ModelCombo:GetValue() )
				net.SendToServer()
				function YourModel:PostDrawModel( ent )
					self:SetModel( ModelCombo:GetValue() )
				end
				
				RefreshBodygroups()
			end
		else
			ModelLabel = vgui.Create( "DLabel", BodyGroupWindow )
			ModelLabel:SetText( LocalPlayer():GetModel() )
			ModelLabel:SetPos( bgsizew * 0.01, 32 )
			ModelLabel:SetFont( "Default" )
			ModelLabel:SizeToContents()
			ModelLabel:SetTextColor( Color( 255, 255, 255 ) )
		end
	else
		ModelLabel = vgui.Create( "DLabel", BodyGroupWindow )
		ModelLabel:SetText( "Current model: " .. LocalPlayer():GetModel() )
		ModelLabel:SetPos( bgsizew * 0.01, 32 )
		ModelLabel:SetFont( "Trebuchet18" )
		ModelLabel:SizeToContents()
		ModelLabel:SetTextColor( Color( 255, 255, 255 ) )
	end
	
	local CloseButton = vgui.Create( "DButton", BodyGroupWindow )
	CloseButton:SetText( "" )
	CloseButton:SetSize( 24, 24 )
	CloseButton:SetPos( bgsizew - 24, 0 )
	CloseButton:SetTextColor( Color( 193, 0, 0 ) )
	function CloseButton:DoClick()
		surface.PlaySound( "ui/buttonclick.wav" )
		BodyGroupWindow:Close()
		ClosetWindow:Close()
	end
	function CloseButton:Paint( w, h )
		if CloseButton:IsHovered() then
			draw.RoundedBox( 100, 0, 0, w, h, Color( 96, 0, 0, 255 ) )
			CloseButton:SetTextColor(Color(255,255,255))
		else
			draw.RoundedBox( 100, 0, 0, w, h, Color( 193, 0, 0, 255 ) )
			CloseButton:SetTextColor(Color(0,0,0))
		end
	end
	
	local ModelScroller = vgui.Create( "DScrollPanel", BodyGroupWindow )
	ModelScroller:SetSize( bgsizew, bgsizeh * ( bgsizeh / ( ScrH() * 1.1 ) ) )
	ModelScroller:SetPos( 0, 54 )
	
	--######################################################################
	RefreshBodygroups = function()
		-- clean up shit
		local gridx, gridy = 0, 0
		local labx, laby = 0, 0
		local rows = 0
		for k,v in pairs( cleanupElements ) do
			v:Remove()
		end

		for k,v in pairs( LocalPlayer():GetBodyGroups() ) do
			gridx, gridy = math.max( 0, gridx ), math.max( 0, gridy )
			
			local BGLabel = ModelScroller:Add( "DLabel" )
			BGLabel:SetText( v.id .. ": " .. v.name )
			BGLabel:SizeToContents()
			local buttonSize = bgsizeh * 0.025 --sanity var
			BGLabel:SetPos( bgsizew * 0.025, gridy + ( ( rows * buttonSize ) + ( rows * (bgsizeh * 0.008)  ) ) )
			BGLabel:SetTextColor( Color( 255, 255, 255 ) )
			labx, laby = BGLabel:GetPos()
			
			table.insert( cleanupElements, BGLabel )

			local BGGrid = ModelScroller:Add( "DGrid" )
			BGGrid:SetPos( bgsizew * 0.05, laby + 20 )
			BGGrid:SetSize( bgsizew * 0.8, buttonSize * rows )
			BGGrid:SetCols( 4 )
			BGGrid:SetRowHeight( bgsizeh * 0.03 )
			BGGrid:SetColWide( bgsizew * 0.225 )
			gridx, gridy = BGGrid:GetPos()
			
			table.insert( cleanupElements, BGGrid )
			
			for i=1, v.num do
				local BGButt = ModelScroller:Add( "DButton" )
				BGButt:SetText( i - 1 )
				BGButt:SetSize( bgsizew * 0.225, bgsizeh * 0.025 )
				BGGrid:AddItem( BGButt )
				BGButt.bgparent = k - 1
				BGButt.DoClick = function( self )
					net.Start( "update_store_freebodygroupr" )
						net.WriteInt( self.bgparent, 32 )
						net.WriteInt( self:GetValue(), 32)
					net.SendToServer()
					surface.PlaySound( "garrysmod/ui_click.wav" )
					function YourModel:PostDrawModel( ent )
						local bodygroups = {}
					
						ent:SetBodygroup( BGButt.bgparent, tonumber(BGButt:GetValue()) )
					end
					--[[
					timer.Simple( 0.1, function()
						ModelLabel:SetText( "Current model: " .. LocalPlayer():GetModel() .. " with bodygroups " .. ConstructBGString() .. " and skin " .. LocalPlayer():GetSkin() )
						ModelLabel:SizeToContents()
					end )
					]]
				end
				function BGButt:Paint( w, h )
					if BGButt:IsHovered() then
						draw.RoundedBox( 0, 0, 0, w, h, Color( 29,21,29,255 ) )
						BGButt:SetTextColor(Color(255,255,255))
					else
						draw.RoundedBox( 0, 0, 0, w, h, Color( 84,66,84,255 ) )
						BGButt:SetTextColor(Color(255,255,255))
					end
				end
				table.insert( cleanupElements, BGButt )
			end
			
			rows = math.ceil( v.num / 4 )
			
		end
		
		--skins
		local SLabel = ModelScroller:Add( "DLabel" )
		SLabel:SetText( "Skin" )
		local buttonSize = bgsizeh * 0.025 --sanity var
		SLabel:SetPos( bgsizew * 0.025, math.max(50, gridy) + ( ( rows * buttonSize ) + ( rows * (bgsizeh * 0.008)  ) ) )
		SLabel:SetTextColor( Color( 255, 255, 255 ) )
		labx, laby = SLabel:GetPos()
		table.insert( cleanupElements, SLabel )
		
		local BGGrid = ModelScroller:Add( "DGrid" )
		BGGrid:SetPos( bgsizew * 0.05, laby + 20 )
		BGGrid:SetSize( bgsizew * 0.8, buttonSize * rows )
		BGGrid:SetCols( 4 )
		BGGrid:SetColWide( bgsizew * 0.225 )
		gridx, gridy = BGGrid:GetPos()
		table.insert( cleanupElements, BGGrid )
		
		for i=1, LocalPlayer():SkinCount() do
			local BGButt = ModelScroller:Add( "DButton" )
			BGButt:SetText( i - 1 )
			BGButt:SetSize( bgsizew * 0.225, bgsizeh * 0.025 )
			BGGrid:AddItem( BGButt )
			--BGButt.bgparent = k - 1
			BGButt.DoClick = function( self )
				surface.PlaySound( "garrysmod/ui_click.wav" )
				net.Start( "update_store_freebodygroupr" )
					net.WriteInt( -5, 32 )
					net.WriteInt( self:GetValue(), 32)
				net.SendToServer()
				function YourModel:PostDrawModel( ent )
					ent:SetSkin( tonumber(BGButt:GetValue() ) )
				end
				--[[
				timer.Simple( 0.1, function()
					ModelLabel:SetText( "Current model: " .. LocalPlayer():GetModel() .. " with bodygroups " .. ConstructBGString() .. " and skin " .. LocalPlayer():GetSkin() )
					ModelLabel:SizeToContents()
				end )
				]]
			end
			function BGButt:Paint( w, h )
				if BGButt:IsHovered() then
					draw.RoundedBox( 0, 0, 0, w, h, Color( 29,21,29,255 ) )
					BGButt:SetTextColor(Color(255,255,255))
				else
					draw.RoundedBox( 0, 0, 0, w, h, Color( 84,66,84,255 ) )
					BGButt:SetTextColor(Color(255,255,255))
				end
			end
			table.insert( cleanupElements, BGButt )
		end
		--end skins
	end
	--######################################################################
	
	RefreshBodygroups()

	ClosetWindow.OnClose = function()
		if IsValid(BodyGroupWindow) then BodyGroupWindow:Close() end
	end
	BodyGroupWindow.OnClose = function()
		if IsValid(ClosetWindow) then ClosetWindow:Close() end
	end
	
end

concommand.Add( "bodygroupwardrobe", OpenFreeBodyGrouprMenu, nil, "Open the Bodygroup Wardrobe menu." )