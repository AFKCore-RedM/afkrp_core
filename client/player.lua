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

function defaultPedSetup(ped)
    EquipMetaPedOutfitPreset(ped, 3)
    UpdatePedVariation()
end

function loadModel(sex)
    if not HasModelLoaded(sex) then
        RequestModel(sex, false)
        repeat Wait(0) until HasModelLoaded(sex)
    end
end

function createPlayerModel(model)
    loadModel(model)
    SetPlayerModel(PlayerId(), joaat(model), false)
    SetModelAsNoLongerNeeded(model)
    UpdatePedVariation(PlayerPedId())
    defaultPedSetup(PlayerPedId())
end

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

    createPlayerModel('mp_male')
end)

RegisterCommand("afk", function(source, args, rawCommand)
    print(json.encode(AFK.PlayerData.characters, {indent = true, sort_keys = true}))
end, false --[[this command is not restricted, everyone can use this.]])