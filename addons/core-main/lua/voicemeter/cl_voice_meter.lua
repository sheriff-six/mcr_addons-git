surface.CreateFont( "Jack_VoiceFont", {
 font = "Play",
 size = VoiceChatMeter.FontSize or 17,
 weight = 550,
 blursize = 0,
 scanlines = 0,
 antialias = true,
 underline = false,
 italic = false,
 strikeout = false,
 symbol = false,
 rotary = false,
 shadow = true,
 additive = false,
 outline = true
} )

/*---------------------------------------------------------------------------
           DarkRP хуйня
---------------------------------------------------------------------------*/

surface.CreateFont("DarkRPHUD1", {font = "Play", size = 100, extended = true,})

local receivers
local currentChatText = {}
local receiverConfigs = {
	[""] = { -- The default config decides who can hear you when you speak normally
		text = "talk",
		hearFunc = function(ply)
			if GAMEMODE.Config.alltalk then return nil end

			return LocalPlayer():GetPos():Distance(ply:GetPos()) < 250
		end
	}
}

local currentConfig = receiverConfigs[""] -- Default config is normal talk

local function AddChatReceiver(prefix, text, hearFunc)
	receiverConfigs[prefix] = {
		text = text,
		hearFunc = hearFunc
	}
end

AddChatReceiver("speak", "speak", function(ply)
	if not LocalPlayer().DRPIsTalking then return nil end
	if LocalPlayer():GetPos():Distance(ply:GetPos()) > 550 then return false end

	return not GAMEMODE.Config.dynamicvoice or ((ply.IsInRoom and ply:IsInRoom()) or (ply.isInRoom and ply:isInRoom()))
end)

local function drawChatReceivers()
	if not receivers then return end

	local x, y = chat.GetChatBoxPos()
	y = y - 21

	-- No one hears you
	if #receivers == 0 then
		draw.WordBox(2, x, y, "Noone can hear you speak", "DarkRPHUD1", Color(0,0,0,160), Color(255,0,0,255))
		return
	-- Everyone hears you
	elseif #receivers == #player.GetAll() - 1 then
		draw.WordBox(2, x, y, "Everyone can hear you speak", "DarkRPHUD1", Color(0,0,0,160), Color(0,255,0,255))
		return
	end

	draw.WordBox(2, x, y - (#receivers * 21), "Players who can hear you speak:", "DarkRPHUD1", Color(0,0,0,160), Color(0,255,0,255))
	for i = 1, #receivers, 1 do
		if not IsValid(receivers[i]) then
			receivers[i] = receivers[#receivers]
			receivers[#receivers] = nil
			continue
		end

		draw.WordBox(2, x, y - (i - 1)*21, receivers[i]:Nick(), "DarkRPHUD1", Color(0,0,0,160), Color(255,255,255,255))
	end
end

local function chatGetRecipients()
	if not currentConfig then return end

	receivers = {}
	for _, ply in pairs(player.GetAll()) do
		if not IsValid(ply) or ply == LocalPlayer() then continue end

		local val = currentConfig.hearFunc(ply, currentChatText)

		-- Return nil to disable the chat recipients temporarily.
		if val == nil then
			receivers = nil
			return
		elseif val == true then
			table.insert(receivers, ply)
		end
	end
end
/*---------------------------------------------------------------------------
            Конец DarkRP хуйни
---------------------------------------------------------------------------*/

local Jack = {}
Jack.Talking = {}

function Jack.StartVoice(ply)
	if !ply:IsValid() or !ply.Team then return end
	for k,v in pairs(Jack.Talking) do if v.Owner == ply then v:Remove() Jack.Talking[k] = nil break end end

	if DarkRP and ply == LocalPlayer() then
		ply.DRPIsTalking = true
		currentConfig = receiverConfigs["speak"]
		hook.Add("Think", "DarkRP_chatRecipients", chatGetRecipients)
		hook.Add("HUDPaint", "DarkRP_DrawChatReceivers", drawChatReceivers)
		if !VoiceChatMeter.DarkRPSelfSquare then return end // No squares for yourself in DarkRP
	end

	local CurID = 1
	local W,H = VoiceChatMeter.SizeX or 250,VoiceChatMeter.SizeY or 40
	local TeamClr,CurName = Color(78, 60, 78)

	// TTT Specific stuff
	if VOICE and VOICE.SetSpeaking then
		local client = LocalPlayer()
		if ply:IsActiveDetective() then
			TeamClr = Color(5,0,200)
		end
		if client == ply then
			if client:IsActiveTraitor() then
				if (not client:KeyDown(IN_SPEED)) and (not client:KeyDownLast(IN_SPEED)) then
					client.traitor_gvoice = true
					RunConsoleCommand("tvog", "1")
				else
					client.traitor_gvoice = false
					RunConsoleCommand("tvog", "0")
				end
			end
			VOICE.SetSpeaking(true)
		end
		if ply:IsActiveTraitor() and (!ply.traitor_gvoice) then
			TeamClr = Color(180,0,0)
		end
	end
	// End TTT specific stuff

	// The name panel itself
	local ToAdd = 0

	if #Jack.Talking != 0 then
		for i=1,#Jack.Talking+3 do
			if !Jack.Talking[i] or !Jack.Talking[i]:IsValid() then
				ToAdd = -(i-1)*(H+4)
				CurID = i
				break
			end
		end
	end

	if !VoiceChatMeter.StackUp then ToAdd = -ToAdd end

	local NameBar,Fade,Go = vgui.Create("DPanel"),0,1
	NameBar:SetSize(W,H)
	local StartPos = (VoiceChatMeter.SlideOut and ((VoiceChatMeter.PosX < .5 and -W) or ScrW())) or (ScrW()*VoiceChatMeter.PosX-(VoiceChatMeter.Align == 1 and 0 or W))
	NameBar:SetPos(StartPos,ScrH()*VoiceChatMeter.PosY+ToAdd)
	if VoiceChatMeter.SlideOut then NameBar:MoveTo((ScrW()*VoiceChatMeter.PosX-(VoiceChatMeter.Align == 1 and 0 or W)),ScrH()*VoiceChatMeter.PosY+ToAdd,VoiceChatMeter.SlideTime) end
	NameBar.Paint = function(s,w,h)
		draw.RoundedBox(0,2,2,w-4,h-4,Color(TeamClr.r,TeamClr.g,TeamClr.b,220*Fade))
		-- draw.RoundedBox(0,2,2,w-4,h-4,Color(0,0,0,180*Fade))
	end
	NameBar.Owner = ply

	// Initialize stuff for this think function
	local NameTxt,Av = vgui.Create("DLabel",NameBar),vgui.Create("AvatarImage",NameBar)

	// How the voice volume meters work
	function NameBar:Think()
		if !ply:IsValid() then NameBar:Remove() Jack.Talking[CurID] = nil return false end
		if !Jack.Talking[CurID] then NameBar:Remove() return false end
		if self.Next and CurTime()-self.Next < .02 then return false end
		if Jack.Talking[CurID].fade then if Go != 0 then Go = 0 end if Fade <= 0 then Jack.Talking[CurID]:Remove() Jack.Talking[CurID] = nil end end
		if Fade < Go and Fade != 1 then Fade = Fade+VoiceChatMeter.FadeAm NameTxt:SetAlpha(Fade*255) Av:SetAlpha(Fade*255) elseif Fade > Go and Go != 1 then Fade = Fade-VoiceChatMeter.FadeAm NameTxt:SetAlpha(Fade*255) Av:SetAlpha(Fade*255) end

		self.Next = CurTime()
		local CurVol = ply:VoiceVolume()*1.05

		local VolBar,Clr = vgui.Create("DPanel",NameBar),Color(255*(CurVol),255*(1-CurVol),0,190)
		VolBar:SetSize(5,(self:GetTall()-6)*(CurVol))
		VolBar:SetPos(self:GetTall()-6,(self:GetTall()-6)*(1-CurVol)+3)
		VolBar.Think = function(sel)
			if sel.Next and CurTime()-sel.Next < .02 then return false end
			sel.Next = CurTime()

			local X,Y = sel:GetPos()
			if X > NameBar:GetWide()+14 then sel:Remove() return end

			sel:SetPos(X+6,Y)
		end
		VolBar.Paint = function(s,w,h)
			draw.RoundedBox(5,0,0,w,h,Color(Clr.r,Clr.g,Clr.b,Clr.a*Fade))
		end
		VolBar:MoveToBack()
		VolBar:SetZPos(5)
	end

	// The player's avatar
	Av:SetPos(2,2)
	Av:SetSize(NameBar:GetTall()-4,NameBar:GetTall()-4)
	Av:SetPlayer(ply)

	// Admin tags and the such
	local NameStr = ply:Name()
	if VoiceChatMeter.UseTags then
		local Is
		for k,v in pairs(VoiceChatMeter.Tags) do if ply:IsUserGroup(k) then Is = v end end
		if !Is and ply:IsSuperAdmin() then Is = "[SA]" elseif !Is and ply:IsAdmin() then Is = "[A]" end
		if Is then NameStr = Is .. " " .. NameStr end
	end

	// The player's name
	NameTxt:SetPos(NameBar:GetTall()+4,H*.25)
	NameTxt:SetAlpha(0)
	NameTxt:SetFont("Default")
	NameTxt:SetText(NameStr)
	NameTxt:SetSize(W-NameBar:GetTall()-9,20)
	NameTxt:SetColor(Color(255,255,255,240))
	NameTxt:SetZPos(8)
	NameTxt:MoveToFront()
	NameBar:MoveToBack()

	// Hand up-to-face animation
	if VOICE and (not (ply:IsActiveTraitor() and (not ply.traitor_gvoice))) then
		ply:AnimPerformGesture(ACT_GMOD_IN_CHAT)
	end

	Jack.Talking[CurID] = NameBar

	return false
end
hook.Add("PlayerStartVoice","Jack's Voice Meter Addon Start",Jack.StartVoice)

function Jack.EndVoice(ply)
	for k,v in pairs(Jack.Talking) do if v.Owner == ply then Jack.Talking[k].fade = true break end end

	if DarkRP and ply == LocalPlayer() then
		hook.Remove("Think", "DarkRP_chatRecipients")
		hook.Remove("HUDPaint", "DarkRP_DrawChatReceivers")
		ply.DRPIsTalking = false
	end

	// More TTT specific stuff
	if (VOICE and VOICE.SetStatus) then
		if IsValid(ply) and not no_reset then
			ply.traitor_gvoice = false
		end

		if ply == LocalPlayer() then
			VOICE.SetSpeaking(false)
		end
	end
end
hook.Add("PlayerEndVoice","Jack's Voice Meter Addon End",Jack.EndVoice)

hook.Add("HUDShouldDraw","Remove old voice cards",function(elem) if elem == "CHudVoiceStatus" || elem == "CHudVoiceSelfStatus" then return false end end)
