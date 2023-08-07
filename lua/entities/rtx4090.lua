AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "RTX 4090"
ENT.Author = "Lambda Gaming"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "Fun + Games"

function ENT:Initialize()
    self:SetModel( "models/rtx4090.mdl" )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	if SERVER then
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetUseType( SIMPLE_USE )
	end
 
    local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
	self.Active = false
end

function ENT:Use( ply )
	if self.Active then return end
	self:Ignite( 10 )
	self:EmitSound( "gpufan.mp3" )
	self.Active = true
	timer.Simple( 10, function()
		if IsValid( self ) then
			local e = ents.Create( "env_explosion" )
			e:SetPos( self:GetPos() )
			e:Spawn()
			e:SetKeyValue( "iMagnitude", 250 )
			e:Fire( "Explode", 0, 0 )
			local ed = EffectData()
			ed:SetOrigin( self:GetPos() )
			util.Effect( "cball_explode", ed )
			self:Remove()
		end
	end )
end
