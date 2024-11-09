local display = false

RegisterNUICallback('close', function(data)
    SetDisplay(false)
    SetNuiFocus(false, false)
end)
RegisterNetEvent('closeNui')
AddEventHandler('closeNui', function()
    print("Server received the close command.")
    SetNuiFocus(false, false) 
end)

RegisterNUICallback('open', function(data)
    SetDisplay(true)
    SetNuiFocus(true, true)
end)



RegisterCommand('911', function()
    SetDisplay(true)
    display = true
end, false)

function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "iui",
        status = bool
    })
end