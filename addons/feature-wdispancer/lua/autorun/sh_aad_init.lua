AddCSLuaFile("autorun/sh_aad_init.lua")

if SERVER then

	aad_globaldata = aad_globaldata or {} 

	util.AddNetworkString( "aad.netSend.toServer.config" )
	util.AddNetworkString( "aad.NetReq.ToServer.SendConfig" )
	util.AddNetworkString( "aad.NetSend.ToClient.Config" )

	local aad_default_config = {}
		aad_default_config.model = "models/items/ammocrate_smg1.mdl"
		aad_default_config.dynamic = true
		aad_default_config.static = 30
		aad_default_config.secondary = true
		aad_default_config.fallback = 5
		aad_default_config.cooldown = 2
		aad_default_config.maxammo = 300
		aad_default_config.maxammosecondary = 30
		aad_default_config.cooldownsound = true

	local function aad_init_config(tbl)
		tbl = tbl or aad_default_config 
		file.CreateDir( "advanced_ammo_dispenser" )
		file.Write("advanced_ammo_dispenser/config.txt", util.TableToJSON(tbl, true))
	end	

	local function ammobox_convertconfig() --for backwards compatibility only
		local tbl = { } 
		local file_string = { } 
		local str = file.Read("ammobox_config/config.txt", "DATA") 

		file_string = string.Explode("<NEXT>",str) 
		for k,v in pairs(file_string) do 
			local tmp = string.Explode("<VALUE>",file_string[k]) tbl[tmp[1]] = tmp[2] 
		end 
		

		local fallback = {}
		fallback.model = tbl.Model or aad_default_config.model
		fallback.dynamic = tbl.DynamicAmmo or aad_default_config.dynamic
		fallback.static = tbl.StaticAmmo or aad_default_config.static
		fallback.secondary = tbl.Secondary or aad_default_config.secondary
		fallback.fallback = aad_default_config.fallback
		fallback.cooldown = tbl.Cooldown or  aad_default_config.cooldown
		fallback.maxammo = aad_default_config.maxammo
		fallback.maxammosecondary = aad_default_config.maxammosecondary
		fallback.cooldownsound = aad_default_config.cooldownsound


		aad_init_config(fallback)

		file.Delete("ammobox_config/config.txt")
		file.Delete("ammobox_config")

		print("[AAD] Old config successfully converted. Old config has been deleted")

		return tbl	
	end

	local function aad_create_config()
		if !file.Exists( "advanced_ammo_dispenser", "DATA" ) then
			file.CreateDir( "advanced_ammo_dispenser" )
			aad_init_config()
		end

		return true
	end

	function aad_globaldata.read_config()
		local tbl = {}
		if aad_create_config() then
			tbl = util.JSONToTable(file.Read("advanced_ammo_dispenser/config.txt"))
		else
			return
		end
		
		return tbl
	end

	hook.Add( "Initialize", "aad_validate_config", function()
		if file.Exists( "ammobox_config/config.txt", "DATA") then
			print("[AAD] Advanced Ammo Dispenser: WARNING: Old config found, trying to convert it")
			ammobox_convertconfig()
		end
	end )

	net.Receive("AAD.netSend.toServer.config", function(len, ply)
		if ply:IsSuperAdmin() then
			local tbl = net.ReadTable()
			aad_init_config(tbl)
			print("[AAD] Config successfully updated by", ply:Nick())
		else
			game.KickID(ply:SteamID(), "Trying to exploit the Advanced Ammo Dispenser config")	
		end
	end)

	net.Receive("aad.NetReq.ToServer.SendConfig", function(len, ply)
		if ply:IsSuperAdmin() then

			net.Start("aad.NetSend.ToClient.Config")
			net.WriteTable(aad_globaldata.read_config())
			net.Send(ply)
			
		else
			game.KickID(ply:SteamID(), "Trying to exploit the Advanced Ammo Dispenser config")	
		end
	end)

end

	

if CLIENT then

	local aad_menu_opened = false

	concommand.Add("ammobox_menu",  function() 
		chat.AddText(Color(255,0,0), "[AAD] The old config has been deprecated as of february 2021, please use the new config: Q > Utilities > Advanced Ammo Dispenser. All settings from the old version persist!")
	end)

	hook.Add( "AddToolMenuCategories", "AADCustomCategory", function()
		spawnmenu.AddToolCategory( "Utilities", "aad_menu", "#Advanced Ammo Dispenser" )
	end )

	hook.Add( "PopulateToolMenu", "AADCustomMenuSettings", function()
		spawnmenu.AddToolMenuOption( "Utilities", "aad_menu", "aad_config", "#Advanced Ammo Dispenser", "", "", function( panel )
			panel:ClearControls()

		if !LocalPlayer():IsSuperAdmin() then
			panel:Help("Only superadmins can view this menu.")
			return
		end

			panel:ControlHelp("(Only superadmins can view & edit the config!)")

			local aad_cfg_01 = vgui.Create( "DTextEntry")
				aad_cfg_01:SetValue("models/items/ammocrate_smg1.mdl")
				panel:Help("Model")
				panel:AddItem(aad_cfg_01)
				panel:ControlHelp( "path to model, like'models/items/ammocrate_smg1.mdl' " )


			local aad_cfg_02 = vgui.Create( "DCheckBoxLabel")
				aad_cfg_02:SetText("Dynamic Ammo")
				aad_cfg_02:SetValue( true )
				aad_cfg_02:SetTextColor(Color(0,0,0))
				panel:AddItem(aad_cfg_02)
				panel:ControlHelp( "Try to give the player one full mag instead of a fixed amount of ammo" )

			local aad_cfg_03 = vgui.Create( "DNumSlider")
				aad_cfg_03:SetText("Static Ammo")
				aad_cfg_03:SetValue( 30 )
				aad_cfg_03:SetDefaultValue( 30 )
				aad_cfg_03:SetDecimals( 0 )
				aad_cfg_03:SetMinMax(1, 150)
				aad_cfg_03:SetDark( true )
				panel:AddItem(aad_cfg_03)
				panel:ControlHelp( "If dynamic ammo is disabled, players get this fixed amount for every weapon" )


			local aad_cfg_04 = vgui.Create( "DCheckBoxLabel")
				aad_cfg_04:SetText("Secondary Ammo")
				aad_cfg_04:SetValue( true )
				aad_cfg_04:SetTextColor(Color(0,0,0))
				panel:AddItem(aad_cfg_04)
				panel:ControlHelp( "Also give players secondary ammo (for example AR2 Orbs)" )

			local aad_cfg_05 = vgui.Create( "DNumSlider")
				aad_cfg_05:SetText("Fallback Ammo")
				aad_cfg_05:SetValue( 5 )
				aad_cfg_05:SetDefaultValue( 5 )
				aad_cfg_05:SetDecimals( 0 )
				aad_cfg_05:SetMinMax(0, 50)
				aad_cfg_05:SetDark( true )
				panel:AddItem(aad_cfg_05)
				panel:ControlHelp( "If clip size can't be detected, players get this amount" )

			local aad_cfg_06 = vgui.Create( "DNumSlider")
				aad_cfg_06:SetText("Cooldown")
				aad_cfg_06:SetValue( 3 )
				aad_cfg_06:SetDefaultValue( 3 )
				aad_cfg_06:SetDecimals( 1 )
				aad_cfg_06:SetMinMax(0, 180)
				aad_cfg_06:SetDark( true )
				panel:AddItem(aad_cfg_06)
				panel:ControlHelp( "Cooldown in seconds. 0 to disable." )

			local aad_cfg_09 = vgui.Create( "DCheckBoxLabel")
				aad_cfg_09:SetText("Cooldown Sound")
				aad_cfg_09:SetValue( true )
				aad_cfg_09:SetTextColor(Color(0,0,0))
				panel:AddItem(aad_cfg_09)
				panel:ControlHelp( "Play a short sound when the ammo dispenser is on cooldown" )


			local aad_cfg_07 = vgui.Create( "DNumSlider")
				aad_cfg_07:SetText("Max Ammo")
				aad_cfg_07:SetValue( 300 )
				aad_cfg_07:SetDefaultValue( 300 )
				aad_cfg_07:SetDecimals( 0 )
				aad_cfg_07:SetMinMax(0, 2000)
				aad_cfg_07:SetDark( true )
				panel:AddItem(aad_cfg_07)
				panel:ControlHelp( "Maximum ammo amount a player can get per weapon" )

			local aad_cfg_08 = vgui.Create( "DNumSlider")
				aad_cfg_08:SetText("Max Secondary Ammo")
				aad_cfg_08:SetValue( 30 )
				aad_cfg_08:SetDefaultValue( 30 )
				aad_cfg_08:SetDecimals( 0 )
				aad_cfg_08:SetMinMax(0, 100)
				aad_cfg_08:SetDark( true )
				panel:AddItem(aad_cfg_08)
				panel:ControlHelp( "Maximum secondary ammo amount a player can get per weapon" )



			local aad_cfg_10 = vgui.Create( "DButton" )
				aad_cfg_10:SetText( "SAVE CONFIG" )	
				aad_cfg_10.DoClick = function() 
					local tbl = {}
					tbl.model = aad_cfg_01:GetValue()
					tbl.dynamic = aad_cfg_02:GetChecked()
					tbl.static = math.Round(aad_cfg_03:GetValue())
					tbl.secondary = aad_cfg_04:GetChecked()
					tbl.fallback = math.Round(aad_cfg_05:GetValue())
					tbl.cooldown = math.Round(aad_cfg_06:GetValue(), 1)
					tbl.maxammo = math.Round(aad_cfg_07:GetValue())
					tbl.maxammosecondary = math.Round(aad_cfg_08:GetValue())
					tbl.cooldownsound = aad_cfg_09:GetChecked()

					net.Start("aad.netSend.toServer.config")
					net.WriteTable(tbl)
					net.SendToServer()
				end
				panel:AddItem(aad_cfg_10)

				if LocalPlayer():IsSuperAdmin() then
					net.Start("aad.NetReq.ToServer.SendConfig")
					net.SendToServer()
				end

				net.Receive( "aad.NetSend.ToClient.Config", function()
					local tbl = net.ReadTable()
					aad_cfg_01:SetValue(tbl.model) 
					aad_cfg_02:SetValue(tbl.dynamic)
					aad_cfg_03:SetValue(tbl.static)
					aad_cfg_04:SetValue(tbl.secondary)
					aad_cfg_05:SetValue(tbl.fallback)
					aad_cfg_06:SetValue(tbl.cooldown)
					aad_cfg_07:SetValue(tbl.maxammo)
					aad_cfg_08:SetValue(tbl.maxammosecondary)
					aad_cfg_09:SetValue(tbl.cooldownsound)
				end )

				aad_menu_opened = true


		end )
	end )

	hook.Add("OnSpawnMenuOpen", "aad_refresh_config", function()
		if LocalPlayer():IsSuperAdmin() and aad_menu_opened then
			net.Start("aad.NetReq.ToServer.SendConfig")
			net.SendToServer()
		end
	end )

end

