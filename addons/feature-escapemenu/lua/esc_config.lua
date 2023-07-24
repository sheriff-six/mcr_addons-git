-- Hostbame
esc.cfg.Hostname 		= 'MCR:RP'

-- Background URL, comment this out to not use a background image
esc.cfg.BackgroundURL	= ''

-- MoTD URL
esc.cfg.MoTD 			= ''

-- Webiste URL
esc.cfg.Website			= ''
esc.cfg.ip2         = ''
esc.cfg.ip3         = ''

-- Donate URL
esc.cfg.Donate			= ' https://vk.com/mcr_gmod'

esc.cfg.Discord			= 'https://discord.gg/ZuxutAeM6H'

esc.cfg.Rules           = 'https://clck.ru/qCFcr '

esc.cfg.Content			= ''

-- Colors, It's best not to edit these; feel free to at risk of having it look bad.
esc.cfg.Bar 			= Color(84,66,84,255)
esc.cfg.Background 		= Color(0,0,0,150)
esc.cfg.Button 			= Color(0,0,0,200)
esc.cfg.ButtonHover		= Color(225,225,225)
esc.cfg.ButtonText		= Color(225,225,225)
esc.cfg.ButtonTextHover = Color(0,0,0)

--
-- Buttons, ADVANCED USERS ONLY. DO NOT OPEN A SUPPORT TICKET IF YOU EDIT THESE AND BREAK TI.
--
esc.addButton({
	Name = 'Отключиться',
	DoClick = function()
		RunConsoleCommand('disconnect')
	end,
})
esc.addButton({
	Name = 'Группа ВК',
	DoClick = function()
		gui.OpenURL(esc.cfg.Donate)
	end,
})
esc.addButton({
	Name = 'STEAM',
	DoClick = function()
		gui.OpenURL(esc.cfg.MoTD)
	end,
})
esc.addButton({
	Name = 'Правила',
	DoClick = function()
		gui.OpenURL(esc.cfg.Rules)
	end,
})
esc.addButton({
	Name = 'Дискорд',
	DoClick = function()
		gui.OpenURL(esc.cfg.Discord)
	end,
})
esc.addButton({
	Name = 'Настройки',
	DoClick = function()
        RunConsoleCommand("gamemenucommand", "openoptionsdialog")
        timer.Simple( 0, function() RunConsoleCommand("gameui_activate") end )
	end,
})
