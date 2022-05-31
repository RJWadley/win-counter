USERNAME = "Matooki1"
PATH_TO_LOG = "./latest.log"
latestTime = 0
numberOfWins = 0
firstDetected = false
timeOfLatestWin = 0

function wait(seconds)
    local start = os.time()
    repeat until os.time() > start + seconds
end

function parseLog()

    -- Open the log file
    local file = io.open(PATH_TO_LOG, "r")

    -- Check if the file exists
    if file == nil then
        print("File does not exist")
        return
    end

    print("File exists")
end

function parseLine(line)
    -- line is in the format:
    -- [23:49:42] line content
    
    --make sure the line is long enough to be a valid line
    if string.len(line) < 10 then
        return
    end

    --get the hours
    local hours = string.sub(line, 2, 3)
    --get the minutes
    local minutes = string.sub(line, 5, 6)
    --get the seconds
    local seconds = string.sub(line, 8, 9)
    

    --make sure the time is numbers
    if tonumber(hours) and tonumber(minutes) and tonumber(seconds) then
        --convert the time to seconds
        local time = tonumber(hours) * 3600 + tonumber(minutes) * 60 + tonumber(seconds)
        --if the time is greater than or the same as the latest time
        if time >= latestTime then
            --update the latest time
            latestTime = time
            --print the line
            checkForWin(line, time)
    end
end
end

function checkForWin(line, time)
    --check if the line contains the username
    if string.find(line, "1st") then
        firstDetected = true
    elseif firstDetected then
        if string.find(line, USERNAME) and timeOfLatestWin ~= time then
            numberOfWins = numberOfWins + 1
            firstDetected = false
            updateWinCounter(numberOfWins)
            timeOfLatestWin = time
        else
            firstDetected = false
        end
    end
end

function updateWinCounter(numberOfWins)
    print("Wins: " .. numberOfWins)
end

parseLog()