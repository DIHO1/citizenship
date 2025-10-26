ESX = exports['es_extended']:getSharedObject()

local hasChosen = false

Citizen.CreateThread(function()
    -- Poczekaj na załadowanie danych gracza
    while not ESX.IsPlayerLoaded() do
        Citizen.Wait(100)
    end

    -- Dodatkowe opóźnienie dla pewności
    Citizen.Wait(1000)

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
        SendNUIMessage({ action = "close" })

        ESX.ShowNotification('Twój wybór został zapisany. Witaj w nowym życiu!')
    end
    cb({ ok = true })
end)

-- Callback NUI na zamknięcie (np. klawiszem ESC)
RegisterNUICallback('close', function(data, cb)
    SetNuiFocus(false, false)
    ESX.ShowNotification('Musisz dokonać wyboru, aby kontynuować.')
    cb({ ok = true })
end)
