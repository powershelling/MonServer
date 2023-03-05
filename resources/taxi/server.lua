ESX = nil

ESX = exports["es_extended"]:getSharedObject()

-- list of possible NPC ped models for taxi driver
local pedModels = {
    "s_m_y_blackops_01",
    "s_m_y_cop_01",
    "s_m_y_fireman_01",
    "s_m_y_hwaycop_01",
    "s_m_y_marine_01",
    "s_m_y_marine_02",
    "s_m_y_marine_03",
    "s_m_y_pestcont_01",
    "s_m_y_pilot_01",
    "s_m_y_prismuscl_01",
    "s_m_y_swat_01"
}

-- function to get a random ped model
function getRandomPedModel()
    local randomIndex = math.random(1, #pedModels)
    return pedModels[randomIndex]
end

-- function to spawn a taxi NPC
function spawnTaxiNPC(playerId)
    local pedHash = 999748158
				
			
    while not HasModelLoaded(pedHash) and RequestModel(pedHash) or not HasModelLoaded(data.current.model) and RequestModel(data.current.model) do
        RequestModel(pedHash)
        RequestModel(data.current.model)
        Citizen.Wait(0)
    end

    local playerPed = GetPlayerPed(playerId)
    local playerCoords = GetEntityCoords(playerPed)
    local spawnCoords = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 100.0, 0.0)
    local taxi = CreateVehicle(GetHashKey("taxi"), spawnCoords, 0.0, true, false)
    local driver = CreatePedInsideVehicle(taxi, 26, pedHash, -1, true, false)

    SetPedConfigFlag(driver, 184, true) -- disable ragdoll
    SetPedFleeAttributes(driver, 0, 0) -- disable fleeing
    SetPedCombatAttributes(driver, 17, 1) -- set driver as can drive by player
    SetPedAsGroupMember(driver, GetPedGroupIndex(playerPed))
    SetPedCanTeleportToGroupLeader(driver, false)
    TaskVehicleDriveToCoord(driver, taxi, playerCoords, 40.0, 0, GetEntityModel(taxi), 16777216, 1.0, -1.0)
    SetEntityAsMissionEntity(taxi, true, true)
    SetVehicleMissionCoorsTarget(taxi, playerCoords)

    -- create blip for the taxi driver
    local blip = AddBlipForEntity(driver)
    SetBlipSprite(blip, 198)
    SetBlipColour(blip, 5)
    SetBlipScale(blip, 0.7)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Taxi Driver")
    EndTextCommandSetBlipName(blip)

    -- remove blip and NPC when they arrive at the player's location
    while true do
        local taxiCoords = GetEntityCoords(taxi)
        if Vdist2(taxiCoords, playerCoords) < 100.0 then
            RemoveBlip(blip)
            DeletePed(driver)
            DeleteVehicle(taxi)
            break
        end
        Citizen.Wait(500)
    end
end

-- command to spawn a taxi NPC
RegisterCommand("heytaxi", function(source, args, raw)
    local playerId = source
    spawnTaxiNPC(playerId)
end, false)
