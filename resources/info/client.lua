

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(0, 47) then -- "G" key
            local lastVehicle = GetLastDrivenVehicle()
            local lastDriver = GetPedInVehicleSeat(lastVehicle, -1)
            local firstName = GetPlayerName(PlayerId())
            local lastName = GetPlayerName(PlayerId())
            if (DoesEntityExist(lastDriver)) then
                firstName = GetPlayerName(NetworkGetPlayerIndexFromPed(lastDriver))
                lastName = GetPlayerName(NetworkGetPlayerIndexFromPed(lastDriver))
                print("Last driver was: " .. firstName .. " " .. lastName)
            else
                print("No driver found")
            end
        end
    end
end)






 --local playerPed = GetPlayerPed(-1)
           -- local playerCoords = GetEntityCoords(playerPed)
           -- local vehicleHash = GetHashKey("infernus")
          --  RequestModel(vehicleHash)
          --  while not HasModelLoaded(vehicleHash) do
           --     Citizen.Wait(100)
           -- end
            --spawnedCar = CreateVehicle(vehicleHash, playerCoords.x + 2, playerCoords.y + 2, playerCoords.z, GetEntityHeading(playerPed), true, false)
            --local npc = CreatePedInsideVehicle(spawnedCar, 4, "a_m_y_business_01", -1, true, false)
            --TaskVehicleDriveWander(npc, spawnedCar, 20.0, 786603)
