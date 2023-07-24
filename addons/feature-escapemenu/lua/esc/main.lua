esc.menus = {}

function esc.addButton(btn)
	esc.menus[#esc.menus + 1] = btn
end

hook.Add('PreRender', 'esc.PreRender', function()
	if input.IsKeyDown(KEY_ESCAPE) and gui.IsGameUIVisible() then
		if ValidPanel(fr) then
			gui.HideGameUI()
			esc.openMenu()
		else
			gui.HideGameUI()
			esc.openMenu()
		end
	end
end)

local fr
function esc.openMenu()
	if IsValid(fr) and not fr.Closed then
		fr:SetVisible(false)
		fr.Closed = true
		return
	elseif IsValid(fr) and fr.Closed then
		fr:SetVisible(true)
		fr.Closed = false
		return
	end

	fr = vgui.Create('DPanel')
	fr:SetSize(ScrW(), ScrH())
	fr:MakePopup()
	fr.Paint = function(self, w, h)
		--draw.Blur(self, 10)
		draw.Box(0, 0, w, h, esc.cfg.Background)
	end

	local p = fr
	if esc.cfg.Background then
		p = vgui.Create('DHTML', fr)
		p:SetSize(ScrW(), ScrH())
		p:SetHTML([[
			<body style=" margin:0; height:100%; overflow:hidden;">
	 			<img style="min-height:100%; min-width:100%; height:auto; width:auto; position:absolute; top:-50%; bottom:-50%; left:-50%; right:-50%; margin:auto;"" src="]] .. esc.cfg.BackgroundURL .. [[" alt="">
	 		</body>
		]])
	end

	local welcome = vgui.Create('DPanel', p)
	welcome:SetPos(20, ScrH() - (30 * #esc.menus) - 109)
	welcome:SetSize(ScrW() * .25, 30)
	welcome.Paint = function(self, w, h)
		--draw.Box(0, 0, w, h, esc.cfg.Bar)
		--draw.SimpleText('Главное меню', 'esc.20', 5, self:GetTall() * .5, esc.cfg.ButtonText, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	end

	for k, v in ipairs(esc.menus) do
		local btn = vgui.Create('DButton', p) -- I was going to make my own derma controls, but fuck it this works.
		btn:SetPos(20, ScrH() - 107 - ((k - 1) * 30))
		btn:SetSize(ScrW() * .25, 27)
		btn:SetText('')
		btn.Name = (v.Name or 'ERROR'):upper()
		btn.DoClick = v.DoClick
		btn.Paint = function(self, w, h)
			draw.Box(0, 0, w, h, self.Hovered and esc.cfg.ButtonHover or esc.cfg.Button)
			draw.SimpleText(self.Name, 'esc.20', 5, self:GetTall() * .5, self.Hovered and esc.cfg.ButtonTextHover or esc.cfg.ButtonText, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		end
	end

	local bar = vgui.Create('DPanel', p)
	bar:SetPos(20, ScrH() - 57)
	bar:SetSize(ScrW() - 40, 27)
	bar.Paint = function(self, w, h)
		--draw.Box(0, 0, w, h, esc.cfg.Button)
		--draw.SimpleText(esc.cfg.Hostname , 'esc.20', 5, self:GetTall() * .5, esc.cfg.ButtonText, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	end
end
