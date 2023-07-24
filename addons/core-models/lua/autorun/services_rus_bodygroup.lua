--- State service RUS ---
---  KERRY.inc  ---
--- Update v2.0 ---

local mdl_service =
{ 
	"models/kerry/mvdfr/emercom_fire_npc.mdl",
	"models/kerry/mvdfr/emercom_npc.mdl",
	"models/kerry/mvdfr/medic_npc.mdl",

}
			
hook.Add( "PlayerSpawnedNPC","RandomBodyGroupService", function( ply, npc )
	if table.HasValue( mdl_service, npc:GetModel() ) 					
		then npc:SetSkin( math.random( 0, 8 ) )
			 npc:SetBodygroup( 1, math.random( 14 ) )
			 npc:SetBodygroup( 2, math.random( 7 ) )
			 npc:SetBodygroup( 3, math.random( 7 ) )
			 npc:SetBodygroup( 4, math.random( 7 ) )
			 npc:SetBodygroup( 5, math.random( 7 ) )
			 npc:SetBodygroup( 6, math.random( 7 ) )
		end
end)