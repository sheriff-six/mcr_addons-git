local DarkRP = DarkRP

DarkRP.defineChatCommand('r', function(ply, args)
	local DoSay = function(text)
		if not ply:HaveEnabledRadio() then
			DarkRP.notify(ply, 1, 4, 'Для этого нужна рабочая рация!')
			return ''
		end

        if text == "" then
            DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("invalid_x", DarkRP.getPhrase("arguments"), ""))
            return ""
        end

		for k, v in ipairs(player.GetAll()) do
			if ply:RadioCanChatTo(v) then
				local name = v:isCP() and ply:Nick() or 'Кто-то'
				DarkRP.talkToPerson(v, Color(200, 214, 77), name .. ' говорит в рацию: ' .. text)
			end
		end
    end

    return args, DoSay
end)

DarkRP.defineChatCommand('lr', function(ply, args)
	local DoSay = function(text)
		if not ply:HaveEnabledRadio() then
			DarkRP.notify(ply, 1, 4, 'Для этого нужна рабочая рация!')
			return ''
		end

        if text == "" then
            DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("invalid_x", DarkRP.getPhrase("arguments"), ""))
            return ""
        end

		for k, v in ipairs(player.GetAll()) do
			if ply:RadioCanChatTo(v) then
				local name = v:isCP() and ply:Nick() or 'Кто-то'
				DarkRP.talkToPerson(v, Color(43, 52, 173), name .. ' говорит в рацию: ' .. text)
			end
		end
    end

    return args, DoSay
end)