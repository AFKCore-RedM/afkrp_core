local MenuData = exports.vorp_menu:GetMenuData()

function openSelectionMenu()
    MenuData.CloseAll()
    local elements = {}

    for k, v in ipairs(AFK.PlayerData.characters) do
        elements[#elements + 1] = {
            label = v.firstname .. " " .. v.lastname,
            value = "choose",
            desc = "IMAGE",
            index = 1,
        }
    end

    elements[#elements + 1] = {
        label = "NEW CHARACTER",
        value = "create",
        desc = "IMAGE",
        index = 1,
    }

    elements[#elements + 1] = {
        label = "NEW CHARACTER",
        value = "create",
        desc = "IMAGE",
        index = 2,
    }

    MenuData.Open('default', GetCurrentResourceName(), 'character_select',
		{
			title = "Select Character",
			subtext = "Character Menu",
			align = "top-left",
			elements = elements,
			itemHeight = "4vh",
		},

		function(data, menu)
			if (data.current.value == "choose") and not WhileSwaping then
				-- UiFeedClearChannel()
				-- WhileSwaping = true
				-- SetCamFocusDistance(mainCam, 4.0)
				-- selectedChar = data.current.index
				-- local dataConfig = Config.SpawnPosition[random].positions[selectedChar]
				-- local cam = dataConfig.Cam
				-- SetCamActiveWithInterp(cam, mainCam or LastCam, 1500, 500, 500)
				-- LastCam = cam
				-- SetCamMotionBlurStrength(cam, 30.0)
				-- SetCamFocusDistance(cam, 4.0)

				-- if IsCamActive(mainCam) then
				-- 	SetCamActive(mainCam, false)
				-- 	mainCam = nil
				-- end

				-- Wait(800)
				-- PlaySoundFrontend("TITLE_SCREEN_ENTER", "DEATH_FAIL_RESPAWN_SOUNDS", true, 0)
				-- repeat Wait(0) until not IsCamInterpolating(cam)
				-- AnimpostfxPlay('PedKill')
				-- EnableSelectionPrompts(menu)
                print(data.current.index)
                print("choose")

                local ped = PlayerPedId()
                EquipMetaPedOutfit(ped, 0x86155956)
                UpdatePedVariation(ped, false, true, true, true, false)
			end

			if (data.current.value == "create") then
				-- UiFeedClearChannel()
				-- WhileSwaping = true
				-- AnimpostfxPlay('PhotoMode_FilterGame06')
				-- finishSelection(true)
				-- Wait(2000)
				-- AnimpostfxStop('PhotoMode_FilterGame06')
				-- TriggerEvent("vorpcharacter:startCharacterCreator")
                print(data.current.index)
                print("create")

                local ped = PlayerPedId()
                EquipMetaPedOutfit(ped, 0x74D74B1C)
                UpdatePedVariation(ped, false, true, true, true, false)
			end
		end, function(menu, data)

	end)

end

RegisterCommand("ping", function(source, args, rawCommand)
    print("ran")
    openSelectionMenu()
end, false --[[this command is not restricted, everyone can use this.]])

AddEventHandler("playerSpawned", function(spawnInfo)
    openSelectionMenu()
end)