
AddCSLuaFile()

ENT.Base = "base_anim"
ENT.Type = "anim"

--[[
function ENT:Initialize() end
function ENT:Think() end
function ENT:PreEntityCopy() end
function ENT:PostEntityCopy() end
function ENT:PostEntityPaste() end
]]

function ENT:PhysicsUpdatePatch( physobj )

	if ( CLIENT ) then return end

	local isConstrained = false
	for _, ent in pairs( self.Constraints ) do
		if ( IsValid( ent ) && ent:GetClass() != "ent_bonemerged" ) then
			isConstrained = true
		end
	end

	-- Don't do anything if the player isn't holding us
	if ( !self:IsPlayerHolding() && !isConstrained ) then

		physobj:SetVelocity( vector_origin )
		physobj:Sleep()

	end

end


if ( SERVER ) then return end

function ENT:Draw( flags )
	self:DrawModel( flags )
end

function ENT:DrawTranslucent( flags )
	self:Draw( flags )
end
