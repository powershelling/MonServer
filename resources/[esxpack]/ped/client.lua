-- Register the "newped2" command handler
RegisterCommand("newped2", function(source, args)
    -- Get the player's coordinates
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)

    -- Define the NPC model hash and position
    local npcModel = GetHashKey("s_m_y_hwaycop_01")
    local npcPos = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 5.0, 0.0)

    -- Request the NPC model
    RequestModel(npcModel)
    while not HasModelLoaded(npcModel) do
        Citizen.Wait(0)
    end

    -- Spawn the NPC
    local npcPed = CreatePed(4, npcModel, npcPos, 0.0, true, true)
    SetPedCombatAttributes(npcPed, 46, true)
    SetPedFleeAttributes(npcPed, 0, 0)
    TaskCombatPed(npcPed, playerPed, 0, 16)

    -- Set the NPC as persistent
    SetEntityAsMissionEntity(npcPed, true, true)

    -- Check if a player is near the NPC
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(1000)
            local npcCoords = GetEntityCoords(npcPed)
            local distance = #(npcCoords - playerCoords)
            if distance > 50.0 then -- Change 50.0 to the desired distance
                DeletePed(npcPed)
                break
            end
        end
    end)
end, false)