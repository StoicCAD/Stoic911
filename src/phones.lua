-- Define options for phone interactions
local phoneOptions = {
    {
        name = "interactWithPhone",
        icon = "fa fa-phone",  -- Font Awesome icon for phone
        label = "Use Phone",
        iconColor = "white",
        distance = 2.0,  -- Interaction distance in meters
        onSelect = function(data)
            SetDisplay(true)
            display = true
        end
    }
}

-- List of phone model hashes
local phoneModels = {
    -1207579608, -433280915, -1605837712, 94130617, 789652940, -921000564,
    -1559354806, -429560270, 974883178, -1387053364, 810403723, 960152042,
    -1585551192, 933500565, -1038739674, 1407197773, 124188622, 148141454,
    1534100734, 413312110, -746954904, -511116411, 485673473, -1645196294,
    -1348538537, 127083682, -2017357667, -1599936665, 1525904360, 1511539537,
    1158960338, 12181992692, 1281992692
}

-- Adding each phone model to the targetable list
Citizen.CreateThread(function()
    for _, model in ipairs(phoneModels) do
        exports.ox_target:addModel(model, phoneOptions)
    end
end)
