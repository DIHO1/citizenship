ESX = exports['es_extended']:getSharedObject()

-- Event do sprawdzania statusu gracza po jego załadowaniu
RegisterNetEvent('esx_character_creation:checkStatus')
AddEventHandler('esx_character_creation:checkStatus', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return end
    local identifier = xPlayer.identifier

    -- Sprawdzenie, czy gracz już dokonał wyboru
    MySQL.Async.fetchAll('SELECT character_choice FROM users WHERE identifier = @identifier', {
        ['@identifier'] = identifier
    }, function(result)
        if result[1] and (result[1].character_choice == nil or result[1].character_choice == '') then
            -- Jeśli wybór nie został dokonany, otwórz menu
            TriggerClientEvent('esx_character_creation:openMenu', source)
        elseif not result[1] then
             print(('[esx_character_creation] Błąd: Nie znaleziono użytkownika o identyfikatorze: %s'):format(identifier))
        end
    end)
end)

-- Event do zapisu wyboru gracza w bazie danych
RegisterNetEvent('esx_character_creation:saveChoice')
AddEventHandler('esx_character_creation:saveChoice', function(choice)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return end
    local identifier = xPlayer.identifier

    if Config.Options[choice] then
        MySQL.Async.execute('UPDATE users SET character_choice = @choice WHERE identifier = @identifier', {
            ['@identifier'] = identifier,
            ['@choice'] = choice
        }, function(rowsChanged)
            if rowsChanged > 0 then
                print(('[esx_character_creation] Zapisano wybór "%s" dla gracza: %s'):format(choice, xPlayer.name))
            else
                print(('[esx_character_creation] Błąd podczas zapisu wyboru dla gracza: %s'):format(xPlayer.name))
            end
        end)
    else
        print(('[esx_character_creation] Otrzymano nieprawidłowy wybór "%s" od gracza: %s'):format(choice, xPlayer.name))
    end
end)
