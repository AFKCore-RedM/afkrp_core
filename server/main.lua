AFK = {}
AFK.Players = {}

MySQL.query.await("CREATE TABLE IF NOT EXISTS `users` (`identifier` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_bin',`group` VARCHAR(50) NULL DEFAULT 'user' COLLATE 'utf8mb4_general_ci',`warnings` INT(11) NULL DEFAULT '0',`banned` TINYINT(1) NULL DEFAULT NULL,`banneduntil` INT(10) NULL DEFAULT '0',`char` INT(11) NULL DEFAULT '5',PRIMARY KEY (`identifier`) USING BTREE,UNIQUE INDEX `Index 2` (`identifier`) USING BTREE)")
MySQL.query.await("CREATE TABLE IF NOT EXISTS `characters` (`identifier` VARCHAR(50) NOT NULL DEFAULT '' COLLATE 'utf8mb4_bin',UNIQUE INDEX `Index 1` (`identifier`) USING BTREE,CONSTRAINT `FK_characters_users` FOREIGN KEY (`identifier`) REFERENCES `users` (`identifier`) ON UPDATE NO ACTION ON DELETE NO ACTION)")

function GetSteamID(src)
    local steamId = GetPlayerIdentifierByType(src, 'steam')
    return steamId
end

function GetLicenseID(src)
    local sid = GetPlayerIdentifiers(src)[2] or false
    if (sid == false or sid:sub(1, 5) ~= "license") then
        return false
    end
    return sid
end

RegisterNetEvent('afk:onPlayerJoined')
AddEventHandler('afk:onPlayerJoined', function()
    local source = source
    local xPlayer = CreatePlayer(source)

    AFK.Players[source] = xPlayer
    TriggerClientEvent('afk:playerLoaded', source, xPlayer)
end)

function AFK.GetPlayerFromId(source)
    return AFK.Players[tonumber(source)]
end

AddEventHandler("playerConnecting", function(playerName, setKickReason, deferrals)
    local _source = source
    deferrals.defer()
    local steamIdentifier = GetSteamID(_source)

    if not steamIdentifier then
        deferrals.done("Steam account not found.")
        setKickReason("Steam account not found, please open the steam client.")
        return CancelEvent()
    end

    deferrals.update("Loading User")

    local user = loadUser(_source, setKickReason, deferrals, steamIdentifier, GetLicenseID(_source))
    if playerName then
        print(json.encode(user, {indent = true, sort_keys = true}))
    end

end)

AddEventHandler('playerDropped', function (reason)
    local _source = source
    local steamIdentifier = GetSteamID(_source)

    if AFK.Players[steamIdentifier] then
        AFK.Players[steamIdentifier] = nil
    end

    print(json.encode(players, {indent = true, sort_keys = true}))
end)

