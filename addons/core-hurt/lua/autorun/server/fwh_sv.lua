include('autorun/fwh_sh.lua')

local function Hurt(victim)

	if victim:Health() <= 40 then
		victim:ConCommand('+duck')
		victim:SetCrouchedWalkSpeed(0.09)
		timer.Simple( 10, function() victim:ConCommand('-duck') victim:SetCrouchedWalkSpeed(0.5) end)
	end

end

hook.Add('PlayerHurt', 'Unique2', Hurt)
