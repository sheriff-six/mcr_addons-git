--[[
Original code and idea by - SweptThr.one (https://steamcommunity.com/id/SweptThrone)
I chagned the effect and the way it works with the addition of the sound from ins2 also with the settings and all
okay bye now 
-kait
]]
local suppression_viewpunch = CreateConVar("suppression_viewpunch", 1, FCVAR_ARCHIVE + FCVAR_REPLICATED)
local suppression_viewpunch_intensity = CreateConVar("suppression_viewpunch_intensity", 1, FCVAR_ARCHIVE + FCVAR_REPLICATED)
local suppression_buildupspeed = CreateConVar("suppression_buildupspeed", 1, FCVAR_ARCHIVE + FCVAR_REPLICATED)
local suppression_sharpen = CreateConVar("suppression_sharpen", 1, FCVAR_ARCHIVE + FCVAR_REPLICATED)
local suppression_sharpen_intensity = CreateConVar("suppression_sharpen_intensity", 1, FCVAR_ARCHIVE + FCVAR_REPLICATED)
local suppression_bloom = CreateConVar("suppression_bloom", 1, FCVAR_ARCHIVE + FCVAR_REPLICATED)
local suppression_blur = CreateConVar("suppression_blur", 1, FCVAR_ARCHIVE + FCVAR_REPLICATED)
local supression_blur_style = CreateConVar("supression_blur_style", 1, FCVAR_ARCHIVE + FCVAR_REPLICATED)
local supression_blur_intensity = CreateConVar("supression_blur_intensity", 1, FCVAR_ARCHIVE + FCVAR_REPLICATED)
local suppression_bloom_intensity = CreateConVar("suppression_bloom_intensity", 1, FCVAR_ARCHIVE + FCVAR_REPLICATED)
local suppression_enabled = CreateConVar("suppression_enabled", 1, FCVAR_ARCHIVE + FCVAR_REPLICATED)
local suppression_gasp_enabled = CreateConVar("suppression_gasp_enabled", 1, FCVAR_ARCHIVE + FCVAR_REPLICATED)
local suppression_enable_vehicle = CreateConVar("suppression_enable_vehicle", 1, FCVAR_ARCHIVE + FCVAR_REPLICATED)

function ApplySuppressionEffect(at, hit, start)
	bruh = start or at:EyePos()
	bruhh = hit
	for _,v in pairs(player.GetAll()) do
		local distance, sup_point = util.DistanceToLine( bruh, bruhh, v:GetPos() )
		if v:IsPlayer() and v:Alive() and (suppression_enabled:GetBool()) and distance < 100 and !(v == at) then
			if (v:InVehicle() and !suppression_enable_vehicle:GetBool()) then return end
			v:SetNWInt("EffectAMT", math.Clamp(v:GetNWInt("EffectAMT"), 0, 1) + 0.05 * (suppression_buildupspeed:GetFloat()))
			sound.Play("bul_snap/supersonic_snap_" .. math.random(1,18) .. ".wav", sup_point, 75, 100, 1)
			sound.Play("bul_flyby/subsonic_" .. math.random(1,27) .. ".wav", sup_point, 75, 100, 1)
			if (suppression_viewpunch:GetBool()) then
			v:ViewPunch( Angle( math.Rand(-1, 1) * (v:GetNWInt("EffectAMT")) * (suppression_viewpunch_intensity:GetFloat()), math.Rand(-1, 1) * (v:GetNWInt("EffectAMT")) * (suppression_viewpunch_intensity:GetFloat()), math.Rand(-1, 1) * (v:GetNWInt("EffectAMT")) * (suppression_viewpunch_intensity:GetFloat()) ) ) 
			end
			timer.Remove(v:Name() .. "blurreset")
			timer.Create(v:Name() .. "blurreset", 4, 1, function()
				for i=1,(v:GetNWInt("EffectAMT") / 0.05) + 1 do
					timer.Simple(0.1 * i, function()
						v:SetNWInt("EffectAMT", math.Clamp(v:GetNWInt("EffectAMT") - 0.1, 0, 100000))
					end)
				end 
				if v:Alive() and suppression_gasp_enabled:GetBool() then
					v:EmitSound("gasp/focus_gasp_0".. math.random(1,6) ..".wav", 75, math.random(90,110) )
				end
			end) --end timer function
		end --end alive test
	end --end for
end -- end function
hook.Add("EntityFireBullets", "SupperssionFunc", function(at, bul)
	local oldcb = bul.Callback
	bul.Callback = function( at, tr, dm)
		if oldcb then 
			oldcb( at, tr, dm ) 
		end
		if SERVER then 
			ApplySuppressionEffect(at, tr.HitPos, tr.StartPos)
		end
	end
	return true
end)
local sharpen_lerp = 0
local bloom_lerp = 0
local effect_lerp = 0
hook.Add("RenderScreenspaceEffects", "ApplySuppression", function()
	if (suppression_sharpen:GetBool()) then
	sharpen_lerp = Lerp(6 * FrameTime(), sharpen_lerp, LocalPlayer():GetNWInt("EffectAMT") * (suppression_sharpen_intensity:GetFloat()))
	DrawSharpen( sharpen_lerp , 0.4 )
	end
	if (suppression_bloom:GetBool()) then
	bloom_lerp = Lerp(6 * FrameTime(), bloom_lerp, LocalPlayer():GetNWInt("EffectAMT") * 0.5 * (suppression_bloom_intensity:GetFloat()) )
	DrawBloom( 0.30, bloom_lerp , 0.33, 4.5, 1, 0, 1, 1, 1 )
	end
	if (suppression_blur:GetBool()) then
	effect_lerp = Lerp(6 * FrameTime(), effect_lerp, LocalPlayer():GetNWInt("EffectAMT") )
		if (supression_blur_style:GetFloat()) == 0 then
			DrawBokehDOF( effect_lerp * supression_blur_intensity:GetFloat(), 0, 0 )
		else
			DrawBokehDOF( effect_lerp * supression_blur_intensity:GetFloat(), 0.05, 0.25 )
		end
	end
end)
hook.Add("PlayerInitialSpawn", "Initialize", function(ply)
	ply:SetNWInt("EffectAMT", 0)

end)

hook.Add("PlayerDeath", "ClearDeath", function(ply, i, a)
	ply:SetNWInt("EffectAMT", 0)

end)
