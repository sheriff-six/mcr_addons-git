util.AddNetworkString('radio-sync-vars')
util.AddNetworkString('radio-setFreq')
util.AddNetworkString('radio-setEnabled')

hook.Add('PlayerCanHearPlayersVoice', 'radio-speak', function(listener, talker)
	if talker:RadioCanSpeakTo(listener) then
		return true
	end
end)

hook.Add('PlayerDroppedWeapon', 'radio-dropped', function(ply, wep)
	if wep:GetClass() == 'radio' then
		ply:DisconnectRadio()
	end
end)

concommand.Add('+radio', function(ply)
	if not ply:HaveEnabledRadio() or ply:IsSpeakToRadio() then return end
	ply:StartSpeakToRadio()
end)

concommand.Add('-radio', function(ply)
	if not ply:IsSpeakToRadio() then return end
	ply:StopSpeakToRadio()
end)

local PLAYER = FindMetaTable('Player')

local function syncVars(ply)
	local vars = {
		ply:GetNWBool('radio'),
		ply:GetNWBool('radioEnabled'),
		ply:GetNWString('radioFreq'),
		ply:GetNWBool('speakToRadio'),
	}

	net.Start('radio-sync-vars')
		net.WriteTable(vars)
		net.WriteEntity(ply)
	net.Broadcast()
end

function PLAYER:ConnectRadio(freq)
	self:SetNWBool('radio', true)
	self:SetNWBool('radioEnabled', true)
	self:SetNWString('radioFreq', freq or 'EMS')

	syncVars(self)
end

function PLAYER:DisconnectRadio()
	self:SetNWBool('radio', nil)
	self:SetNWBool('radioEnabled', nil)
	self:SetNWString('radioFreq', nil)

	self:StopSpeakToRadio()

	syncVars(self)
end

function PLAYER:ChangeRadioFreq(freq)
	self:SetNWString('radioFreq', freq)
	syncVars(self)
end

function PLAYER:SetRadioEnabled(bool)
	self:SetNWBool('radioEnabled', bool)
	syncVars(self)
end

local radio_sounds = {
    on = {
        'npc/combine_soldier/vo/on1.wav',
        'npc/combine_soldier/vo/on2.wav'
    },

    off = {
        'npc/combine_soldier/vo/off1.wav',
        'npc/combine_soldier/vo/off2.wav'
    }
}

function PLAYER:StartSpeakToRadio()
	self:SetNWBool('speakToRadio', true)
	local snd = tostring(table.Random(radio_sounds.on))
	self:EmitSound(snd)
	syncVars(self)
end

function PLAYER:StopSpeakToRadio()
	self:SetNWBool('speakToRadio', false)
	local snd = tostring(table.Random(radio_sounds.off))
	self:EmitSound(snd)
	syncVars(self)
end

net.Receive('radio-setEnabled', function(len, ply)
	local bool = net.ReadBool()
	ply:SetRadioEnabled(bool)
end)

net.Receive('radio-setFreq', function(len, ply)
	local freq = net.ReadString()
	ply:ChangeRadioFreq(freq)
end)