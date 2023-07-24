--[[
        © AsterionStaff 2022.
        This script was created from the developers of the AsterionTeam.
        You can get more information from one of the links below:
            Site - https://asterion.games
            Discord - https://discord.gg/CtfS8r5W3M
        
        developer(s):
            Selenter - https://steamcommunity.com/id/selenter

        ——— Chop your own wood and it will warm you twice.
]]--


-- Отправляем только что подключившимуся игроку все картинки на карте
hook.Add("PlayerInitialSpawn", "image.PlayerInitialSpawn", function(client)
    local config = ImageTool:GetConfig() or {}
    local map = game.GetMap()

    config[map] = config[map] or {}

    for k, v in pairs(config[map]) do
        ImageTool:SendImage(client, k, v)
    end
end)