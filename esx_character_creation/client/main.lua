ESX = nil
local hasChosen = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    -- Poczekaj na załadowanie danych gracza
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    -- Po załadowaniu, sprawdź status wyboru
    TriggerServerEvent('esx_character_creation:checkStatus')
end)

-- Event od serwera, aby otworzyć UI
RegisterNetEvent('esx_character_creation:openMenu')
AddEventHandler('esx_character_creation:openMenu', function()
    if not hasChosen then
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = "open",
            config = Config.Options -- Przekazanie konfiguracji do UI
        })
    end
end)

-- Callback NUI po dokonaniu wyboru
RegisterNUICallback('choice', function(data, cb)
    local choice = data.choice
    if choice then
        -- Zapisz wybór na serwerze
        TriggerServerEvent('esx_character_creation:saveChoice', choice)
        hasChosen = true -- Ustaw flagę, aby nie pokazywać menu ponownie w tej sesji

        -- Zamknij UI
        SetNuiFocus(false, false)
        SendNUIMessage({ action = "close" }) -- Można dodać obsługę 'close' w JS, jeśli potrzeba

        ESX.ShowNotification('Twój wybór został zapisany. Witaj w nowym życiu!')
    end
    cb({ ok = true })
end)

-- Callback NUI na zamknięcie (np. klawiszem ESC)
RegisterNUICallback('close', function(data, cb)
    SetNuiFocus(false, false)
    -- Tutaj można dodać logikę, np. informację dla gracza, że musi dokonać wyboru.
    -- Na razie po prostu zamykamy UI. Gracz zobaczy je ponownie po relogu.
    ESX.ShowNotification('Musisz dokonać wyboru, aby kontynuować.')
    cb({ ok = true })
end)
