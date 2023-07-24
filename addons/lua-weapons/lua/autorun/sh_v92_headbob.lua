
-----------------------------------------------------------
--	Head Bobbing Rewrite by V92
--	Original mod by LuaPineapple
--	Workshop Link:	http://steamcommunity.com/sharedfiles/filedetails/?id=572928034
-----------------------------------------------------------

AddCSLuaFile( )

-- Create all our convars if they don't already exist...
if not ConVarExists("VNT_HeadBob_CL_Toggle") then CreateConVar( "VNT_HeadBob_CL_Toggle", 1 , { FCVAR_ARCHIVE , FCVAR_USERINFO } , "(Boolean) Toggles the entire Head Bobbing script on/off" , 0 , 1 ) end
-- if not ConVarExists("VNT_HeadBob_CL_Breathing_Toggle") then CreateConVar( "VNT_HeadBob_CL_Breathing_Toggle", 1 , { FCVAR_ARCHIVE , FCVAR_USERINFO } , "(Boolean) Toggles idle breathing on/off" , 0 , 1 ) end
-- if not ConVarExists("VNT_HeadBob_CL_Breathing_Mul") then CreateConVar( "VNT_HeadBob_CL_Breathing_Mul", 1 , { FCVAR_ARCHIVE , FCVAR_USERINFO } , "(Float) Scale of idle breathing" , 0 , 1 ) end
if not ConVarExists("VNT_HeadBob_CL_Strafe_Toggle") then CreateConVar( "VNT_HeadBob_CL_Strafe_Toggle", 1 , { FCVAR_ARCHIVE , FCVAR_USERINFO } , "(Boolean) Toggles the strafe tilt on/off" , 0 , 1 ) end
if not ConVarExists("VNT_HeadBob_CL_Stand_Toggle") then CreateConVar( "VNT_HeadBob_CL_Stand_Toggle", 1 , { FCVAR_ARCHIVE , FCVAR_USERINFO } , "(Boolean) Toggles the standing head bob on/off" , 0 , 1 ) end
if not ConVarExists("VNT_HeadBob_CL_Stand_Mul") then CreateConVar( "VNT_HeadBob_CL_Stand_Mul", 0.5 , { FCVAR_ARCHIVE , FCVAR_USERINFO } , "(Float) Scale of head bob while walking" , 0 , 2 ) end 
if not ConVarExists("VNT_HeadBob_CL_Crouch_Toggle") then CreateConVar( "VNT_HeadBob_CL_Crouch_Toggle", 1 , { FCVAR_ARCHIVE , FCVAR_USERINFO } , "(Boolean) Toggles the crouching head bob on/off" , 0 , 1 ) end
if not ConVarExists("VNT_HeadBob_CL_Crouch_Mul") then CreateConVar( "VNT_HeadBob_CL_Crouch_Mul", 1 , { FCVAR_ARCHIVE , FCVAR_USERINFO } , "(Float) Scale of head bob while crouching" , 0 , 2 ) end
if not ConVarExists("VNT_HeadBob_CL_Prone_Toggle") then CreateConVar( "VNT_HeadBob_CL_Prone_Toggle", 1 , { FCVAR_ARCHIVE , FCVAR_USERINFO } , "(Boolean) Toggles the prone head bob on/off" , 0 , 1 ) end
if not ConVarExists("VNT_HeadBob_CL_Prone_Mul") then CreateConVar( "VNT_HeadBob_CL_Prone_Mul", 1.5 , { FCVAR_ARCHIVE , FCVAR_USERINFO } , "(Float) Scale of head bob while prone" , 0 , 2 ) end
if not ConVarExists("VNT_HeadBob_CL_Water_Toggle") then CreateConVar( "VNT_HeadBob_CL_Water_Toggle", 1 , { FCVAR_ARCHIVE , FCVAR_USERINFO } , "(Boolean) Toggles the prone head bob on/off" , 0 , 1 ) end
if not ConVarExists("VNT_HeadBob_CL_Water_Mul") then CreateConVar( "VNT_HeadBob_CL_Water_Mul", 1 , { FCVAR_ARCHIVE , FCVAR_USERINFO } , "(Float) Scale of head bob while swimming" , 0 , 2 ) end
if not ConVarExists("VNT_HeadBob_CL_Land_Toggle") then CreateConVar( "VNT_HeadBob_CL_Land_Toggle", 1 , { FCVAR_ARCHIVE , FCVAR_USERINFO } , "(Boolean) Toggles the landing tilt on/off" , 0 , 1 ) end
if not ConVarExists("VNT_HeadBob_CL_Land_Mul") then CreateConVar( "VNT_HeadBob_CL_Land_Mul", 0.1 , { FCVAR_ARCHIVE , FCVAR_USERINFO } , "(Float) Multiplier for landing tilts" , 0 , 1 ) end
if not ConVarExists("VNT_HeadBob_CL_Land_Frames") then CreateConVar( "VNT_HeadBob_CL_Land_Frames" , 10  , { FCVAR_ARCHIVE , FCVAR_USERINFO } , "(Int) Amount of frames to blend landing over" , 10 , 30 ) end
if not ConVarExists("VNT_HeadBob_CL_Blacklist_PhysGun") then CreateConVar( "VNT_HeadBob_CL_Blacklist_PhysGun", 0 , { FCVAR_ARCHIVE , FCVAR_USERINFO } , "(Boolean) Toggles head bobbing while using Physics Gun" , 0 , 1 ) end
if not ConVarExists("VNT_HeadBob_CL_Blacklist_ToolGun") then CreateConVar( "VNT_HeadBob_CL_Blacklist_ToolGun", 1 , { FCVAR_ARCHIVE , FCVAR_USERINFO } , "(Boolean) Toggles head bobbing while using Tool Gun" , 0 , 1 ) end
if not ConVarExists("VNT_HeadBob_CL_Blacklist_Camera") then CreateConVar( "VNT_HeadBob_CL_Blacklist_Camera", 0 , { FCVAR_ARCHIVE , FCVAR_USERINFO } , "(Boolean) Toggles head bobbing while using Camera" , 0 , 1 ) end

if CLIENT then

	-------------------------
	-------------------------
	-- Options Panel
	-------------------------
	-------------------------

	hook.Add( "PopulateToolMenu", "VNTHeadBob", function()

		spawnmenu.AddToolMenuOption( "Options" , "V92" , "VNTHeadBob" , "Head Bobbing" , "" , "" , function( Panel )

			Panel:Help( "Options to control the amount/types of head bobbing in the mod.\n\nSee the mod page for more info:\nhttps://steamcommunity.com/sharedfiles/filedetails/?id=572928034" )

			Panel:AddControl("ComboBox", {

				["MenuButton"] = 1 ,
				["Folder"] = "vnt_headbob" ,
				["Options"] = {

					["#preset.default"] = {

						["VNT_HeadBob_CL_Toggle"] = 1 ,
						-- ["VNT_HeadBob_CL_Breathing_Toggle"] = 1 ,
						-- ["VNT_HeadBob_CL_Breathing_Mul"] = 1 ,
						["VNT_HeadBob_CL_Strafe_Toggle"] = 1 ,
						["VNT_HeadBob_CL_Stand_Toggle"] = 1 ,
						["VNT_HeadBob_CL_Stand_Mul"] = 0.5 ,
						["VNT_HeadBob_CL_Crouch_Toggle"] = 1 ,
						["VNT_HeadBob_CL_Crouch_Mul"] = 1 ,
						["VNT_HeadBob_CL_Prone_Toggle"] = 1 ,
						["VNT_HeadBob_CL_Prone_Mul"] = 1.5 ,
						["VNT_HeadBob_CL_Water_Toggle"] = 1 ,
						["VNT_HeadBob_CL_Water_Mul"] = 1 ,
						["VNT_HeadBob_CL_Land_Toggle"] = 1 ,
						["VNT_HeadBob_CL_Land_Mul"] = 0.1 ,
						["VNT_HeadBob_CL_Land_Frames"] = 10 ,
						["VNT_HeadBob_CL_Blacklist_PhysGun"] = 1 ,
						["VNT_HeadBob_CL_Blacklist_ToolGun"] = 1 ,
						["VNT_HeadBob_CL_Blacklist_Camera"] = 0 ,

					}

				}

			} )

			-- Master toggle
			Panel:CheckBox( "Master Toggle" , "VNT_HeadBob_CL_Toggle" )
			Panel:ControlHelp( "This option disables the entire mod for you." )

			-- Panel:ControlHelp( "Controls idle breathing toggle." )
			-- Panel:CheckBox( "Breathing Toggle" , "VNT_HeadBob_CL_Breathing_Toggle" )
			-- Panel:NumSlider( "Breathing Multiplier" , "VNT_HeadBob_CL_Breathing_Mul" , 0 , 2 , 1 )

			Panel:CheckBox( "Strafe Tilt" , "VNT_HeadBob_CL_Strafe_Toggle" )
			Panel:ControlHelp( "Controls strafe head tilt." )

			-- Standing options
			Panel:CheckBox( "Standing Toggle" , "VNT_HeadBob_CL_Stand_Toggle" )
			Panel:NumSlider( "Standing Multiplier" , "VNT_HeadBob_CL_Stand_Mul" , 0 , 2 , 1 )
			Panel:ControlHelp( "Controls movement while standing/running." )

			-- Crouching options
			Panel:CheckBox( "Crouching Toggle" , "VNT_HeadBob_CL_Crouch_Toggle" )
			Panel:NumSlider( "Crouching Multiplier" , "VNT_HeadBob_CL_Crouch_Mul" , 0 , 2 , 1 )
			Panel:ControlHelp( "Controls movement while crouching." )

			-- Prone options; requires prone mod linked in text
			Panel:CheckBox( "Prone Toggle" , "VNT_HeadBob_CL_Prone_Toggle" )
			Panel:NumSlider( "Prone Multiplier" , "VNT_HeadBob_CL_Prone_Mul" , 0 , 2 , 1 )
			Panel:ControlHelp( "Controls movement while prone.\n\nRequires the following prone mod:\nhttps://steamcommunity.com/sharedfiles/filedetails/?id=1100368137" )

			-- Water options
			Panel:CheckBox( "Water Toggle" , "VNT_HeadBob_CL_Water_Toggle" )
			Panel:NumSlider( "Water Multiplier" , "VNT_HeadBob_CL_Water_Mul" , 0 , 2 , 1 )
			Panel:ControlHelp( "Controls movement while swimming." )

			-- Landing tilt options
			Panel:CheckBox( "Landing Roll Toggle" , "VNT_HeadBob_CL_Land_Toggle" )
			Panel:NumSlider( "Landing Multiplier" , "VNT_HeadBob_CL_Land_Mul" , 0 , 1 , 1 )
			Panel:NumSlider( "Landing Frame Blend" , "VNT_HeadBob_CL_Land_Frames" , 10 , 30 , 0 )
			Panel:ControlHelp( "How much tilt to show when landing." )

			-- Blacklist options
			Panel:CheckBox( "Physics Gun" , "VNT_HeadBob_CL_Blacklist_PhysGun" )
			Panel:CheckBox( "Tool Gun" , "VNT_HeadBob_CL_Blacklist_ToolGun" )
			Panel:CheckBox( "Camera" , "VNT_HeadBob_CL_Blacklist_Camera" )
			Panel:ControlHelp( "Disable head bobbing for different weapons." )

		end)

	end)

	-------------------------
	-------------------------
	-- Tool Menu
	-------------------------
	-------------------------

	local PCalcT = {
		["VS"] = 0 ,
		["WT"] = 0 ,
		["Air"] = 0 ,
	}

	-- Big, meaty, functions!
	local function VNTHeadBobbing( ply , origin , angles , fov )

		-- Create the blacklist
		local blacklistWeapon

		-- Player is not alive OR invalid or they have a craptastic weapon, cancel out.
		if !ply:Alive( ) or !IsValid( ply ) or !IsValid( ply:GetActiveWeapon( ) ) then return end

		-- Headbob toggles for specific weapons
		local PhysGunToggle = GetConVar( "VNT_HeadBob_CL_Blacklist_PhysGun" ):GetBool( ) -- Physgun headbob toggle
		local ToolGunToggle = GetConVar( "VNT_HeadBob_CL_Blacklist_ToolGun" ):GetBool( ) -- Tool gun headbob toggle
		local CameraToggle = GetConVar( "VNT_HeadBob_CL_Blacklist_Camera" ):GetBool( ) -- Camera headbob toggle

		-- This is messy as shit, but the best way I know how to do it.
		if ( ply:GetActiveWeapon( ):GetClass( ) == "gmod_camera" and CameraToggle ) or ( ply:GetActiveWeapon( ):GetClass( ) == "gmod_tool" and ToolGunToggle ) or ( ply:GetActiveWeapon( ):GetClass( ) == "weapon_physgun" and PhysGunToggle ) then

			-- They're blasklisted, and can fuck right off
			blacklistWeapon = true

		end

		-- Create the headbob toggle cvar
		local HeadBobToggle = GetConVar( "VNT_HeadBob_CL_Toggle" ):GetBool( )

		-- If the cvar doesn't exist, or the weapon is blacklisted...
		if ( not HeadBobToggle ) or blacklistWeapon then

			-- Cancel out!
			return

		-- If the cvar DOES exist and the weapon is NOT blacklisted...
		else

			-- If player is in NOCLIP...
			if ply:GetMoveType( ) == 8 then

				-- Nullify!
				return

			-- They're in the air or in a car
			elseif ( !ply:IsOnGround( ) and ply:WaterLevel( ) == 0 ) or ply:InVehicle( ) then

				PCalcT.Air = math.Clamp( PCalcT.Air + 1 , 0 , 300 )
				return

			end

			-- Main script
			
			-- else

			local ang = ply:EyeAngles( ) -- Eye Angles
			local view = {
				["ply"] = ply ,
				["origin"] = origin ,
				["angles"] = angles ,
				["fov"] = fov ,
			}

			-- Toggle for Landing Angles
			if GetConVarNumber( "VNT_HeadBob_CL_Land_Toggle" ) != 0 and PCalcT.Air > 0 then

				local FrameCount

				-- If Landing Frame Blend is less than/equal to 10
				if GetConVarNumber( "VNT_HeadBob_CL_Land_Frames" ) <= 10 then

					-- Limit to 10 to prevent crashing
					FrameCount = 10 
					
				else

					-- If the number you passed it isn't bogus, set the frame count blend to the convar
					FrameCount = GetConVarNumber( "VNT_HeadBob_CL_Land_Frames" )

				end

				PCalcT.Air = PCalcT.Air - ( PCalcT.Air / FrameCount ) -- Make it end in some frames
				view.angles.p = view.angles.p + ( PCalcT.Air * ( GetConVarNumber( "VNT_HeadBob_CL_Land_Mul" ) / 10 ) ) -- Pitch Cam Shake on Land
				view.angles.r = view.angles.r + ( PCalcT.Air * ( GetConVarNumber( "VNT_HeadBob_CL_Land_Mul" ) / 5 ) ) * math.Rand( -1 , 1 ) -- Roll Cam Shake on Land

			end

			-- Toggle for Crouching Angles
			if GetConVarNumber( "VNT_HeadBob_CL_Crouch_Toggle" ) != 0 and ply:Crouching( ) then
				
				local velocityMultiplier = ( ply:GetVelocity( ) * ( 2 * GetConVarNumber( "VNT_HeadBob_CL_Crouch_Mul" ) ) )

				-------------------------
				-- Footstep Angles
				-------------------------

				PCalcT.VS = PCalcT.VS * 0.9 + velocityMultiplier:Length( ) * 0.1
				PCalcT.WT = PCalcT.WT + PCalcT.VS * FrameTime() * 0.1

				-------------------------
				-- Strafe Angles
				-------------------------

				if GetConVarNumber( "VNT_HeadBob_CL_Strafe_Toggle" ) != 0 then

					view.angles.r = angles.r + ang:Right():DotProduct(velocityMultiplier) * 0.03 -- Strafe Angles

				end

				view.angles.r = angles.r + math.sin( PCalcT.WT ) * PCalcT.VS * 0.001
				view.angles.p = angles.p + math.sin( PCalcT.WT * 0.5 ) * PCalcT.VS * 0.001

			-- Toggle for Prone Angles

			-- Programmed for use with "The Prone Mod"
			-- Standalone version: https://steamcommunity.com/sharedfiles/filedetails/?id=1100368137
			-- wOS version: https://steamcommunity.com/sharedfiles/filedetails/?id=775573383
				-- "prone" is the global name the mod uses, so if that doesn't exist, odds are the player doesn't have the mod
				-- IsProne is the name of the function used by the mod, so this wouldn't exist without it
			elseif prone and GetConVarNumber( "VNT_HeadBob_CL_Prone_Toggle" ) != 0 and ply:IsProne( ) then 

				local velocityMultiplier = ( ply:GetVelocity( ) * ( 5 * GetConVarNumber( "VNT_HeadBob_CL_Prone_Mul" ) ) )

				-------------------------
				-- Footstep Angles
				-------------------------

				PCalcT.VS = PCalcT.VS * 0.9 + velocityMultiplier:Length( ) * 0.1
				PCalcT.WT = PCalcT.WT + PCalcT.VS * FrameTime( ) / 24

				-------------------------
				-- Strafe Angles
				-------------------------

				if GetConVarNumber( "VNT_HeadBob_CL_Strafe_Toggle" ) != 0 then

					view.angles.r = angles.r + ang:Right():DotProduct(velocityMultiplier) * 0.02 -- Strafe Angles

				end

				view.angles.r = angles.r + math.sin( PCalcT.WT ) * PCalcT.VS * 0.001
				view.angles.p = angles.p + math.sin( PCalcT.WT * 0.5 ) * PCalcT.VS * 0.001

			-- Toggle for Movement Angles
			else

				-- Just keep swimming...
				if GetConVarNumber( "VNT_HeadBob_CL_Water_Toggle" ) != 0 and ply:WaterLevel( ) != 0 then 

					-- print("SWIMMING!")
					local velocityMultiplier = ( ply:GetVelocity( ) * ( 1 * GetConVarNumber( "VNT_HeadBob_CL_Water_Mul" ) ) )

					-----------------------
					-- Footstep Angles
					-----------------------

					PCalcT.VS = PCalcT.VS * 0.9 + velocityMultiplier:Length( ) * 0.1
					PCalcT.WT = PCalcT.WT + PCalcT.VS * FrameTime( ) * 0.1

					-----------------------
					-- Strafe Angles
					-----------------------

					if GetConVarNumber( "VNT_HeadBob_CL_Strafe_Toggle" ) != 0 then

						view.angles.r = angles.r + ang:Right():DotProduct(velocityMultiplier) * 0.01 -- Strafe Angles

					end

					view.angles.r = angles.r + math.sin( PCalcT.WT ) * PCalcT.VS * 0.001
					view.angles.p = angles.p + math.sin( PCalcT.WT * 0.5 ) * PCalcT.VS * 0.001

				-- Regular boring ass walking
				else

					if GetConVarNumber("VNT_HeadBob_CL_Stand_Toggle") != 1 then

						return

					end

					local velocityMultiplier = ( ply:GetVelocity( ) * ( 1 * GetConVarNumber( "VNT_HeadBob_CL_Stand_Mul" ) ) )

					-------------------------
					-- Footstep Angles
					-------------------------

					PCalcT.VS = PCalcT.VS * 0.9 + velocityMultiplier:Length( ) * 0.1
					PCalcT.WT = PCalcT.WT + PCalcT.VS * FrameTime( ) * 0.1

					-------------------------
					-- Strafe Angles
					-------------------------

					if GetConVarNumber( "VNT_HeadBob_CL_Strafe_Toggle" ) != 0 then

						view.angles.r = angles.r + ang:Right():DotProduct(velocityMultiplier) * 0.01 -- Strafe Angles

					end

					view.angles.r = angles.r + math.sin( PCalcT.WT ) * PCalcT.VS * 0.001
					view.angles.p = angles.p + math.sin( PCalcT.WT * 0.5 ) * PCalcT.VS * 0.001

				end

			end

		end

	end
	hook.Add("CalcView" , "VNTHeadBobbing" , VNTHeadBobbing )

end
