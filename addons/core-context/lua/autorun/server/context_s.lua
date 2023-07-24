
util.AddNetworkString("context.ChangePosition")
util.AddNetworkString("MayDay")

net.Receive("context.ChangePosition", function (len, ply)
	if not ply:IsSuperAdmin() then return ply:Kick("[Context Menu] Possible Cheater!") end

	local x, y = net.ReadString(), net.ReadString()
	local string_to_write = x.." "..y

	local q = file.Write("pos.txt", string_to_write)


end)

hook.Add("OnGamemodeLoaded", "checkForStupidPeopleWhoCantChangePositionOfMenu!", function ()
	if file.Exists("pos.txt", "DATA") then
		local data = file.Read("pos.txt", "DATA")

		local data_2 = string.Explode(" ", data)

		local x, y = data_2[1], data_2[2]


		SetGlobalInt("XContext", x)
		SetGlobalInt("YContext", y)
	end
end)


concommand.Add("read_file_test", function (ply)
	if not ply:IsSuperAdmin() then return end
	local data = file.Read("pos.txt", "DATA")

	local data_2 = string.Explode(" ", data)

	local x, y = data_2[1], data_2[2]


	SetGlobalInt("XContext", x)
	SetGlobalInt("YContext", y)
end)

