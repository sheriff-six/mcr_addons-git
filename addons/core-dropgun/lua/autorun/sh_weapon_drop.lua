////////////////////////////////////////
////////// MADE BY TOPHER III //////////
////////////////////////////////////////

if SERVER then

	function AdminCheck( ply )
		if GetConVar("topher_weapondrop_adminbypass"):GetInt() == 1 then
			if ply:IsAdmin() then
				return false
			end
			return true
		end
		return true
	end

	function WeaponDrop(ply, weapon )
		local dropped = ents.Create("weapon_dropped")
			if weapon:GetWeaponWorldModel() != "" then
			dropped:SetModel(weapon:GetWeaponWorldModel())
			else
			dropped:SetModel("models/props_junk/PopCan01a.mdl")	
			end 
			dropped.weapon = weapon:GetClass()
			dropped.clip1 = weapon:Clip1()
			dropped.clip2 = weapon:Clip2()
			dropped.clip1ammo = weapon:GetPrimaryAmmoType()
			dropped.clip2ammo = weapon:GetSecondaryAmmoType()
			dropped:SetPos(ply:GetPos() + (ply:GetForward() * 35) + (ply:GetUp() * 50))
			dropped:Spawn()
	end
	
hook.Add("PlayerSay","dropcommand",function(ply, text, team) 

	if text == "/drop" then

	local blacklist = file.Read("topher/dropweapon_blacklist.txt")
	blacklist = string.Explode(", ",blacklist)

		if table.HasValue(blacklist,ply:GetActiveWeapon():GetClass()) and AdminCheck( ply ) then ply:SendLua([[notification.AddLegacy("You can't drop this.",1,2)]]) return "" end

		if IsValid(ply:GetActiveWeapon()) then
			WeaponDrop(ply, ply:GetActiveWeapon() )
			ply:StripWeapon(ply:GetActiveWeapon():GetClass()) 
		end
	
		return ""
	end

end)

concommand.Add("dropweapon",function(ply, cmd, args, argStr)

	local blacklist = file.Read("topher/dropweapon_blacklist.txt")
	blacklist = string.Explode(", ",blacklist)

	if table.HasValue(blacklist,ply:GetActiveWeapon():GetClass()) and AdminCheck( ply ) then ply:SendLua([[notification.AddLegacy("You can't drop this.",1,2)]]) return end

	if IsValid(ply:GetActiveWeapon()) then
		WeaponDrop(ply, ply:GetActiveWeapon() )
		ply:StripWeapon(ply:GetActiveWeapon():GetClass()) 
	end		

	end)

hook.Add("DoPlayerDeath","DropOnDeath",function(ply) 

	blacklist = file.Read("topher/dropweapon_blacklist.txt")
	blacklist = string.Explode(", ",blacklist)

	if GetConVar("topher_weapondrop_dropondeath"):GetInt() == 1 then

	if table.HasValue(blacklist,ply:GetActiveWeapon():GetClass()) and AdminCheck( ply ) then return end

	if IsValid(ply:GetActiveWeapon())  then
		WeaponDrop(ply, ply:GetActiveWeapon() )
	end

	elseif GetConVar("topher_weapondrop_dropondeath"):GetInt() == 2 then

	for k,v in pairs(ply:GetWeapons()) do
	
		if not table.HasValue(blacklist,v:GetClass()) then WeaponDrop(ply, v ) end
		
	end
	end

end)


	if !file.Exists("topher/dropweapon_blacklist.txt","DATA") then
		file.CreateDir("topher")
		file.Write("topher/dropweapon_blacklist.txt", "weapon_fists")
	end

	concommand.Add("topher_weapondrop_blacklist_add",function(ply, cmd, args, argStr)

		if !ply:IsAdmin() then print("You are not an Admin.") return end
		if table.Count(args) != 1 then print("Invalid weapon.") return end

		local blacklist = file.Read("topher/dropweapon_blacklist.txt")
		blacklist = string.Explode(", ",blacklist)

		if table.HasValue(blacklist,args[1]) then print("This is already Blacklisted.") return end

		file.Append("topher/dropweapon_blacklist.txt",", " .. args[1])
		print(args[1] .. " added to Blacklist.")
		

	end)

	concommand.Add("topher_weapondrop_blacklist_remove",function(ply, cmd, args, argStr)

		if !ply:IsAdmin() then print("You are not an Admin.") return end
		if table.Count(args) != 1 then print("Invalid weapon.") return end

		local blacklist = file.Read("topher/dropweapon_blacklist.txt")
		blacklist = string.Explode(", ",blacklist)
		file.Write("topher/dropweapon_blacklist.txt","")

		if !table.HasValue(blacklist,args[1]) then print("This is not Blacklisted.") return end

		table.RemoveByValue(blacklist,args[1])

		for k,v in pairs(blacklist) do
			if k == 1 then
				file.Append("topher/dropweapon_blacklist.txt",v)
			else
				file.Append("topher/dropweapon_blacklist.txt",", " .. v)
			end
		end

		print(args[1] .. " removed from Blacklist.")
		

	end, function(cmd,args)

		local blacklist = file.Read("topher/dropweapon_blacklist.txt")
		blacklist = string.Explode(", ",blacklist)

		local autocomplete = {}

		for k,v in pairs(blacklist) do
			autocomplete[k] = "topher_weapondrop_blacklist_remove " .. v
		end

		return autocomplete

	end)

	concommand.Add("topher_weapondrop_blacklist",function(ply, cmd, args, argStr)

		if !ply:IsAdmin() then print("You are not an Admin.") return end

		blacklist = file.Read("topher/dropweapon_blacklist.txt")
		print("The Blacklisted weapons for this server are:\n" .. blacklist)
		

	end)

end

CreateConVar("topher_weapondrop_dropondeath",0,{FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE},"0 - Don't Drop, 1 - Drop Active, 2 - Drop All")
CreateConVar("topher_weapondrop_adminbypass",0,{FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE},"0 - Admins can't drop Blacklisted weapons, 1 - Admins can drop Blacklisted weapons")
CreateConVar("topher_weapondrop_weapondecay",0,{FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE},"0 - Weapons dont decay, >0 - The time after the weapon drops before it decays")
CreateConVar("topher_weapondrop_droppedcollision",0,{FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE},"0 - Normal collisions, 1 - Doesn't collide with players")