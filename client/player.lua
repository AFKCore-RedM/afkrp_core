local spawnPos = vector3(-200.2464, 791.0803, 126.3565)
AFK = {}
AFK.PlayerData = {}

CreateThread(function()
	while true do
		Wait(100)

		if NetworkIsPlayerActive(PlayerId()) then
			DoScreenFadeOut(0)
			Wait(500)
			TriggerServerEvent('afk:onPlayerJoined')
			break
		end
	end
end)

RegisterNetEvent('afk:playerLoaded')
AddEventHandler('afk:playerLoaded', function(xPlayer)
    AFK.PlayerData = xPlayer

    exports.spawnmanager:spawnPlayer({
        x = spawnPos.x,
        y = spawnPos.y,
        z = spawnPos.z + 0.25,
        heading = 0,
        skipFade = false
    }, function()
    end)
end)

RegisterCommand("afk", function(source, args, rawCommand)
    print(json.encode(AFK.PlayerData.characters, {indent = true, sort_keys = true}))
end, false --[[this command is not restricted, everyone can use this.]])