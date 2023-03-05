-- Define a function to spawn police NPCs on the server-side
function SpawnPoliceOnServer()
    local policeModel = "s_m_y_cop_01"
    local policeModelHash = GetHashKey(policeModel)
    ESX.Game.SpawnPed(policeModelHash, vector3(100.0, 100.0, 100.0), 0.0, function(ped)
        -- Set the police ped's default walking style to "normal"
        SetPedDefaultWalkingStyle(ped)
        -- Set the police ped's relationship group to "POLICE"
        SetPedRelationshipGroupHash(ped, GetHashKey("POLICE"))
        -- Add the spawned ped to a table of active NPCs
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