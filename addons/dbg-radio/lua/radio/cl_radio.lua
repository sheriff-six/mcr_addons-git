hook.Add('PlayerButtonDown', 'radio-on', function(ply, key)
	if key == KEY_B and ply:HaveEnabledRadio() then
		permissions.EnableVoiceChat(true)
		RunConsoleCommand('+radio')
	end
end)

hook.Add('PlayerButtonUp', 'radio-off', function(ply, key)
	if key == KEY_B then
		permissions.EnableVoiceChat(false)
		RunConsoleCommand('-radio')
	end
end)

net.Receive('radio-sync-vars', function()
	local vars = net.ReadTable()
	local ply = net.ReadEntity()

	ply:SetNWBool('radio', vars[1])
	ply:SetNWBool('radioEnabled', vars[2])
	ply:SetNWString('radioFreq', vars[3])
	ply:SetNWBool('speakToRadio', vars[4])
end)