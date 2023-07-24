radio = radio or {}

local PLAYER = FindMetaTable('Player')

function PLAYER:HaveRadio()
	return self:GetNWString('radio', false)
end

function PLAYER:IsSpeakToRadio()
	return self:GetNWBool('speakToRadio', false)
end

function PLAYER:GetRadioFreq()
	return self:GetNWString('radioFreq', nil)
end

function PLAYER:HaveEnabledRadio()
	return self:HaveRadio() and self:GetNWBool('radioEnabled', true)
end

function PLAYER:RadioCanSpeakTo(listener)
	return ( self:HaveEnabledRadio() and listener:HaveEnabledRadio() ) and ( self:GetRadioFreq() == listener:GetRadioFreq() ) and ( self:IsSpeakToRadio() )
end

function PLAYER:RadioCanChatTo(listener)
	return ( self:HaveEnabledRadio() and listener:HaveEnabledRadio() ) and ( self:GetRadioFreq() == listener:GetRadioFreq() )
end