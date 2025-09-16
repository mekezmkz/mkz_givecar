--[[
    MKZ GiveCar Script
    Supporta sia permessi ACE di FiveM che gruppi QBCore/QBox
    
    Permessi supportati:
    - ACE: group.admin (configurato in server.cfg con add_principal)
    - QBCore/QBox: gruppi 'admin' e 'god' nel database
--]]

-- Funzione per controllare i permessi admin
local function HasAdminPermission(source)
    -- Controlla permessi ACE (group.admin, etc.)
    if IsPlayerAceAllowed(source, "group.admin") or IsPlayerAceAllowed(source, "command") then
        return true
    end
    
    -- Controlla gruppi QBCore/QBox
    local player = exports.qbx_core:GetPlayer(source)
    if player and (player.PlayerData.group == 'admin' or player.PlayerData.group == 'god') then
        return true
    end
    
    return false
end

-- Funzione per dare veicolo
local function GiveVehicle(src, targetId, model, plate)
    local target = exports.qbx_core:GetPlayer(targetId)
    if not target then
        TriggerClientEvent('okokNotify:Alert', src, "Errore", "Player non trovato", 5000, 'error')
        return
    end

    if not plate then
        plate = string.upper(string.sub(model,1,3) .. math.random(1000,9999))
    end

    MySQL.insert('INSERT INTO player_vehicles (citizenid, vehicle, hash, mods, plate, garage, state) VALUES (?, ?, ?, ?, ?, ?, ?)', {
        target.PlayerData.citizenid,
        model,
        GetHashKey(model),
        '{}',
        plate,
        'pillboxgarage', -- garage default
        1
    })

    TriggerClientEvent('okokNotify:Alert', targetId, "Garage", "Hai ricevuto un veicolo: "..model.." ["..plate.."]", 8000, 'success')
    TriggerClientEvent('okokNotify:Alert', src, "Admin", "Hai dato un veicolo a "..target.PlayerData.charinfo.firstname.." "..target.PlayerData.charinfo.lastname, 8000, 'success')
end

-- Funzione per eliminare veicolo
local function DelVehicle(src, plate)
    MySQL.scalar('SELECT citizenid FROM player_vehicles WHERE plate = ?', {plate}, function(citizenid)
        if not citizenid then
            TriggerClientEvent('okokNotify:Alert', src, "Errore", "Veicolo con targa ["..plate.."] non trovato", 5000, 'error')
            return
        end

        MySQL.query('DELETE FROM player_vehicles WHERE plate = ?', {plate}, function(result)
            if result.affectedRows > 0 then
                -- Trova il proprietario per notifica
                local owner = exports.qbx_core:GetPlayerByCitizenId(citizenid)
                if owner then
                    TriggerClientEvent('okokNotify:Alert', owner.PlayerData.source, "Garage", "Il tuo veicolo ["..plate.."] è stato rimosso da un admin", 8000, 'error')
                end
                TriggerClientEvent('okokNotify:Alert', src, "Admin", "Veicolo ["..plate.."] eliminato con successo", 8000, 'success')
            else
                TriggerClientEvent('okokNotify:Alert', src, "Errore", "Errore durante l'eliminazione del veicolo", 5000, 'error')
            end
        end)
    end)
end

-- /givecar [model] [playerId]
RegisterCommand('givecar', function(source, args)
    if not HasAdminPermission(source) then
        TriggerClientEvent('okokNotify:Alert', source, "Errore", "Non hai i permessi per questo comando", 5000, 'error')
        return
    end

    if not args[1] or not args[2] then
        TriggerClientEvent('okokNotify:Alert', source, "Uso", "/givecar [model] [playerId]", 5000, 'info')
        return
    end

    local model, targetId = args[1], tonumber(args[2])
    GiveVehicle(source, targetId, model)
end)

-- /givecarplate [model] [plate] [playerId]
RegisterCommand('givecarplate', function(source, args)
    if not HasAdminPermission(source) then
        TriggerClientEvent('okokNotify:Alert', source, "Errore", "Non hai i permessi per questo comando", 5000, 'error')
        return
    end

    if not args[1] or not args[2] or not args[3] then
        TriggerClientEvent('okokNotify:Alert', source, "Uso", "/givecarplate [model] [plate] [playerId]", 5000, 'info')
        return
    end

    local model, plate, targetId = args[1], args[2], tonumber(args[3])
    GiveVehicle(source, targetId, model, plate)
end)

-- /delcar [plate]
RegisterCommand('delcar', function(source, args)
    if not HasAdminPermission(source) then
        TriggerClientEvent('okokNotify:Alert', source, "Errore", "Non hai i permessi per questo comando", 5000, 'error')
        return
    end

    if not args[1] then
        TriggerClientEvent('okokNotify:Alert', source, "Uso", "/delcar [plate]", 5000, 'info')
        return
    end

    local plate = string.upper(args[1])
    DelVehicle(source, plate)
end)
