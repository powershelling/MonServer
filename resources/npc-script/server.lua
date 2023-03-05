local npcModel = "a_m_m_skater_01"
local npcCoords = vector3(2257.872, 1594.293, 68.06812)
local npcVehicle = nil
local npc = nil

RegisterCommand("letsgo", function(source, args, rawCommand)
    if npcVehicle == nil then
        AddModel(npcModel)
        while not IsModelInCdimage(npcModel) or not IsModelValid(npcModel) do
            Citizen.Wait(1)
        end

        AddModel("taxi")
        while not IsModelInCdimage("taxi") or not IsModelValid("taxi") do
            Citizen.Wait(1)
        end

        RequestModel("taxi")
        while not HasModelLoaded("taxi") do
            Citizen.Wait(1)
        end

        npcVehicle = CreateVehicle("taxi", npcCoords, 0.0, true, true)
        npc = CreatePed(4, npcModel, npcCoords, 0.0, true, true)

        SetEntityAsMissionEntity(npcVehicle, true, true)
        SetEntityAsMissionEntity(npc, true, true)

        SetVehicleOnGroundProperly(npcVehicle)
        SetPedIntoVehicle(npc, npcVehicle, -1)
        SetPedCanBeDraggedOut(npcVehicle, false)
        SetVehicleDoorsLocked(npcVehicle, 4)
        SetVehicleEngineOn(npcVehicle, true, true)

        local driver = GetPedInVehicleSeat(npcVehicle, -1)
        DeleteEntity(driver)

        local playerId = tonumber(args[1])
        local player = GetPlayerPed(playerId)

        if player then
            TaskWarpPedIntoVehicle(player, npcVehicle, -1)
        end
    else
        DeleteVehicle(npcVehicle)
        npcVehicle = nil
        DeleteEntity(npc)
        npc = nil
    end
end)