AddCSLuaFile("shared.lua")
include("shared.lua")

util.AddNetworkString("ammobox_sendConfig")
util.AddNetworkString("ammobox_giveConfig")
util.AddNetworkString("ammobox_reqestConfig")

aad_globaldata = aad_globaldata or {}

function ENT:Draw()
	self:DrawModel()
	
	local Pos = self:GetPos()
	local Ang = self:GetAngles()
	
	Ang:RotateAroundAxis(Ang:Forward(), 90)
	Ang:RotateAroundAxis(Ang:Right(), 270)
	
	local txt = "А Р С Е Н А Л"
	local key = input.LookupBinding( "+use", true ) or "unbound"
	local txt2 = "Нажмите " .. string.upper( key ) .. " чтобы открыть"
	
	surface.SetFont("DermaLarge")
	local TextWidth = surface.GetTextSize(txt)
	surface.SetFont( "Trebuchet18" )
	local TextWidth2 = surface.GetTextSize(txt2)
	
	cam.Start3D2D(Pos - Ang:Right() + Ang:Up() * 15.2, Ang, 0.15)
		draw.WordBox(2, -TextWidth*0.5 - 3, -200, txt, "DermaLarge", Color(20, 26, 11), Color(217, 13, 3))
		draw.WordBox(2, -TextWidth2*0.75 - 5, -165, txt2, "DermaLarge", Color(20, 26, 11), Color(255, 255, 255))
	cam.End3D2D()
end

function ENT:Initialize()
	self.config = aad_globaldata.read_config()
	self:SetModel( self.config.model )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	if ( SERVER ) then
		self:PhysicsInit( SOLID_VPHYSICS )
	end
	local phys = self:GetPhysicsObject()
	if ( IsValid( phys ) ) then phys:Wake() end
end

function ENT:SpawnFunction( ply, tr, ClassName )
	if ( !tr.Hit ) then return end
	local ent = ents.Create( ClassName )
	ent:SetPos( ply:GetShootPos() + ply:GetForward() * 80 )
	ent:Spawn()
	ent:Activate()
	return ent
end



function ENT:Use(activator, caller)

	if ( activator.AmmoDispenser_cooldown == nil ) then
		activator.AmmoDispenser_cooldown = os.time() - 2000
	end

	if ( activator.AmmoDispenser_cooldown + self.config.cooldown >= os.time () and self.config.cooldown != 0  ) then
		if self.config.cooldownsound then self:EmitSound( "weapons/clipempty_pistol.wav", 70, 90) end
		return false
	end

	activator.AmmoDispenser_cooldown = os.time()

    
    
	local aad_weapons = activator:GetWeapons()
	local aad_ammo = 30

	if ( self.config.dynamic ) then
		for k,v in pairs(aad_weapons) do
			if v:GetMaxClip1() == -1 then
				aad_ammo = self.config.fallback --fallback in case MaxClip can't be detected (for some special weapons)
			else
				aad_ammo = v:GetMaxClip1() or 30
			end

			if (activator:GetAmmoCount(v:GetPrimaryAmmoType()) < self.config.maxammo or self.config.maxammo == 0 ) then
				activator:GiveAmmo(aad_ammo,v:GetPrimaryAmmoType())
			end

			if (self.config.secondary) then
				if ( activator:GetAmmoCount(v:GetSecondaryAmmoType()) < self.config.maxammosecondary or self.config.maxammosecondary == 0 ) then
					activator:GiveAmmo(1,v:GetSecondaryAmmoType())
				end
			end
		end
	else
		aad_ammo = self.config.static or 30

		for k,v in pairs(aad_weapons) do

			if ( activator:GetAmmoCount(v:GetPrimaryAmmoType()) < self.config.maxammo or self.config.maxammo == 0 ) then
				activator:GiveAmmo(aad_ammo, v:GetPrimaryAmmoType())
			end

			if ( self.config.secondary ) then
				if ( activator:GetAmmoCount(v:GetSecondaryAmmoType()) < self.config.maxammosecondary or self.config.maxammosecondary == 0 ) then
					activator:GiveAmmo(1,v:GetSecondaryAmmoType())
				end
			end
		end
	end

end
