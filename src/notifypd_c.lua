RegisterNetEvent('notifyIncident')
AddEventHandler('notifyIncident', function(incident)
    -- Extract incident details
    local title = incident.title
    local description = incident.description or 'No further details provided.'

    -- Use lib.notify for enhanced UI notifications
    lib.notify({
        id = 'incidentNotification',  -- Unique identifier for the notification type
        title = "911 Report: " .. title,  -- Customize the title to reflect it's a 911 report
        description = description,
        position = 'top',  -- Position can be 'top', 'bottom', etc., depending on your UI setup
        style = {
            backgroundColor = '#141517',  -- Dark background color for the notification
            color = '#C1C2C5',  -- Light grey text color for better readability
            ['.description'] = {
                color = '#909296'  -- Slightly different grey for the description text
            }
        },
        icon = 'exclamation-triangle',  -- Use an appropriate icon; change as needed
        iconColor = '#C53030'  -- Red color for the icon indicating urgency or attention
    })
end)
