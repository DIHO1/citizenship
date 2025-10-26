ESX = exports['es_extended']:getSharedObject()

-- Event do sprawdzania statusu gracza po jego załadowaniu
RegisterNetEvent('esx_character_creation:checkStatus')
AddEventHandler('esx_character_creation:checkStatus', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end
    local identifier = xPlayer.identifier

    -- Sprawdzenie, czy gracz już dokonał wyboru przy użyciu oxmysql
    local result = exports.oxmysql:fetch('SELECT character_choice FROM users WHERE identifier = ?', { identifier })

    if result and (result.character_choice == nil or result.character_choice == '') then
        -- Jeśli wybór nie został dokonany, otwórz menu
        TriggerClientEvent('esx_character_creation:openMenu', src)
    elseif not result then
        print(('[esx_character_creation] Błąd: Nie znaleziono użytkownika o identyfikatorze: %s'):format(identifier))
    end
end)

-- Event do zapisu wyboru gracza w bazie danych
RegisterNetEvent('esx_character_creation:saveChoice')
AddEventHandler('esx_character_creation:saveChoice', function(choice)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end
    local identifier = xPlayer.identifier

    if Config.Options[choice] then
        -- Zapis wyboru przy użyciu oxmysql
        local affectedRows = exports.oxmysql:execute('UPDATE users SET character_choice = ? WHERE identifier = ?', { choice, identifier })

        if affectedRows > 0 then
            print(('[esx_character_creation] Zapisano wybór "%s" dla gracza: %s'):format(choice, xPlayer.name))
        else
            print(('[esx_character_creation] Błąd podczas zapisu wyboru dla gracza: %s'):format(xPlayer.name))
        end
    else
        print(('[esx_character_creation] Otrzymano nieprawidłowy wybór "%s" od gracza: %s'):format(choice, xPlayer.name))
    end
end)
