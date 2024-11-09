-- Function to check if a job is a police job
function isPoliceJob(jobName)
    for _, department in ipairs(Config.PoliceJobs) do
        if jobName == department then
            return true
        end
    end
    return false
end

-- Function to notify all police job players
function notifyPolice(incidents)
    if Config.Debug then
        print("Checking all players for police jobs...")
    end
    local allPlayerIds = GetPlayers()  -- FiveM native to get all player server IDs

    if Config.Debug then
        print("All player IDs:", allPlayerIds)  -- Log all retrieved player IDs
    end

    local policeOfficers = {}

    for _, playerId in ipairs(allPlayerIds) do
        if Config.Debug then
            print("Current player ID being checked:", playerId)  -- Log each player ID being processed
        end

        local player = NDCore.getPlayer(tonumber(playerId))  -- Convert to number if necessary

        if player then
            local job = player.getData("job")  -- Get the player's job data
            if job and isPoliceJob(job) then
                table.insert(policeOfficers, player)
                if Config.Debug then
                    print("Police officer found:", player.getData("fullname") or "Unknown", "with job:", job)
                end
            end
        else
            if Config.Debug then
                print("No player data found for player ID:", playerId, ". They may have disconnected.")
            end
        end
    end

    if #policeOfficers > 0 then
        for _, officer in ipairs(policeOfficers) do
            for _, incident in ipairs(incidents) do
                if Config.Debug then
                    print("Notifying officer", officer.getData("fullname") or officer.source, "about incident ID:", incident.id)
                end
                TriggerClientEvent('notifyIncident', officer.source, incident)
            end
        end
    else
        if Config.Debug then
            print("No police officers available to notify.")
        end
    end
end

-- Function to fetch new incidents from the database
local lastChecked = os.time()  -- Initialize lastChecked to current time on script start
function fetchNewIncidents()
    if Config.Debug then
        print("Fetching new incidents since last check at: " .. os.date('%Y-%m-%d %H:%M:%S', lastChecked))
    end
    local query = "SELECT * FROM incidents WHERE UNIX_TIMESTAMP(created_at) > ?"
    exports.oxmysql:execute(query, {lastChecked}, function(incidents)
        if #incidents > 0 then
            if Config.Debug then
                print("Found " .. #incidents .. " new incidents.")
            end
            notifyPolice(incidents)
            lastChecked = os.time() -- Update lastChecked to current time after fetching
        else
            if Config.Debug then
                print("No new incidents found.")
            end
        end
    end)
end

-- Periodically check for new incidents
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)  -- Check every 5 seconds
        fetchNewIncidents()
    end
end)
