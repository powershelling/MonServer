local taxiModel = "taxi"
local npcModel = "a_m_m_skater_01"

RegisterCommand("taxi", function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local playerHeading = GetEntityHeading(playerPed)

    -- Spawn the taxi next to the player
    local taxiHandle = CreateVehicle(taxiModel, playerCoords.x + 3.0, playerCoords.y, playerCoords.z, playerHeading, true, false)

    -- Check if the taxi was spawned successfully
    if DoesEntityExist(taxiHandle) then
        -- Add the skater ped to the driver seat
        RequestModel(npcModel)
        while not HasModelLoaded(npcModel) do
            Citizen.Wait(1)
        end

        local npcHandle = CreatePedInsideVehicle(taxiHandle, 4, npcModel, -1, true, false)
        SetPedCanSwitchWeapon(npcHandle, false)
        SetPedConfigFlag(npcHandle, 100, true)
        SetPedFleeAttributes(npcHandle, 0, false)
        SetPedCombatAttributes(npcHandle, 17, true)
        SetEntityAsMissionEntity(npcHandle, true, true)

        -- Warp the player into the back seat of the taxi
        local playerSeat = 1 -- 1 is the index for the back seat of the taxi
        TaskWarpPedIntoVehicle(playerPed, taxiHandle, playerSeat)

        -- Set the taxi as mission entity and lock the doors
        SetEntityAsMissionEntity(taxiHandle, true, true)
        SetVehicleDoorsLocked(taxiHandle, 4)
        SetVehicleEngineOn(taxiHandle, true, true)
    else
        print("Failed to spawn the taxi.")
    end
end)