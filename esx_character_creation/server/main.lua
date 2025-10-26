ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Event do sprawdzania statusu gracza po jego załadowaniu
RegisterNetEvent('esx_character_creation:checkStatus')
AddEventHandler('esx_character_creation:checkStatus', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.identifier

    -- Sprawdzenie, czy gracz już dokonał wyboru
    MySQL.Async.fetchAll('SELECT character_choice FROM users WHERE identifier = @identifier', {
        ['@identifier'] = identifier
    }, function(result)
        if result[1] and result[1].character_choice == nil then
            -- Jeśli wybór nie został dokonany, otwórz menu
            TriggerClientEvent('esx_character_creation:openMenu', source)
        elseif not result[1] then
             -- Sytuacja awaryjna, gdyby użytkownik nie istniał w tabeli (mało prawdopodobne z ESX)
             print(('[esx_character_creation] Błąd: Nie znaleziono użytkownika o identyfikatorze: %s'):format(identifier))
        end
    end)
end)

-- Event do zapisu wyboru gracza w bazie danych
RegisterNetEvent('esx_character_creation:saveChoice')
AddEventHandler('esx_character_creation:saveChoice', function(choice)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.identifier

    if Config.Options[choice] then
        MySQL.Async.execute('UPDATE users SET character_choice = @choice WHERE identifier = @identifier', {
            ['@identifier'] = identifier,
            ['@choice'] = choice
        }, function(rowsChanged)
            if rowsChanged > 0 then
                print(('[esx_character_creation] Zapisano wybór "%s" dla gracza: %s'):format(choice, xPlayer.name))
                -- Tutaj można dodać dodatkowe akcje po dokonaniu wyboru,
                -- np. przyznanie startowych itemów, pieniędzy etc.
                -- Przykład:
                -- if choice == 'citizen' then
                --     xPlayer.addMoney(500)
                -- elseif choice == 'legal_immigrant' then
                --     xPlayer.addMoney(250)
                -- elseif choice == 'illegal_immigrant' then
                --     xPlayer.addAccountMoney('black_money', 100)
                -- end
            else
                print(('[esx_character_creation] Błąd podczas zapisu wyboru dla gracza: %s'):format(xPlayer.name))
            end
        end)
    else
        print(('[esx_character_creation] Otrzymano nieprawidłowy wybór "%s" od gracza: %s'):format(choice, xPlayer.name))
    end
end)
