-- Define the esx variable
local esx = nil
Citizen.CreateThread(function()
    while esx == nil do
        TriggerEvent('esx:getSharedObject', function(obj) esx = obj end)
        Citizen.Wait(0)
    end
end)

-- Use the esx variable to spawn a police ped
function SpawnPoliceOnClient()
    local policeModel = "s_m_y_cop_01"
    local policeModelHash = GetHashKey(policeModel)
    ESX.Game.SpawnPed(policeModelHash, vector3(100.0, 100.0, 100.0), 0.0, function(ped)
        SetPedDefaultWalkingStyle(ped)
        SetPedRelationshipGroupHash(ped, GetHashKey("POLICE"))
        table.insert(activeNPCs, ped)
    end)
end

-- Register a command to spawn police NPCs on the server-side
RegisterCommand('spawnpolice', function(source, args, rawCommand)
    -- Clear the table of active NPCs
    activeNPCs = {}

    -- Spawn 10 police NPCs on the server-side
    for i = 1, 10 do
        SpawnPoliceOnServer()
    end
end, true)