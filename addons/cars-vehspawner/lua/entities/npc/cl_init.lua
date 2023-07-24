include("shared.lua");

surface.CreateFont('ui.60', {
	font = "Roboto Mono",
	size = 60,
	weight = 500,
	extended = true
})

function ENT:DrawTranslucent()
	self:Draw();
end;

function ENT:BuildBonePositions(NumBones, NumPhysBones)
end;
 
function ENT:SetRagdollBones(bIn)
	self.m_bRagdollSetup = bIn;
end;

function ENT:DoRagdollBone(PhysBoneNum, BoneNum)
	--self:SetBonePosition( BoneNum, Pos, Angle )
end;

function ENT:Draw()
	self:DrawModel()

	local pos = self:GetPos();
	local ang = self:GetAngles();

	ang:RotateAroundAxis(ang:Up(), 90);
	ang:RotateAroundAxis(ang:Forward(), 90);	
	ang:RotateAroundAxis(ang:Right(), 0);
	
	if (LocalPlayer():GetPos():Distance(self:GetPos()) < 300 or LocalPlayer():GetEyeTrace().Entity == self) then
		cam.Start3D2D(pos + ang:Up() * 1 + ang:Right() * 0, Angle(1, LocalPlayer():EyeAngles().y - 90, 90), 0.1)
		draw.SimpleText( "Гараж", 'ui.60', -5, -350, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
		cam.End3D2D()
	end
end