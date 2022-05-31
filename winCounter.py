from time import sleep

USERNAME = "Matooki1"
PATH_TO_LOG = "latest.log" #TODO update to actually use the log file
latestTime = 0
numberOfWins = 0
firstDetected = False
timeOfLatestWin = 0


def parseLog():
    #open the log file
    with open(PATH_TO_LOG, "r") as f:
        #read the file
        log = f.read()
        #split the file into lines
        lines = log.split('\n')
        #iterate through the lines
        for line in lines:
            parseLine(line)
        sleep(1)
        parseLog()

def parseLine(line):
    global latestTime
    global numberOfWins

    # line is in the format:
    # [23:49:42] line content

    #make sure the line is long enough to be a valid line
    if len(line) < 10:
        return
    
    #get the hours
    hours = line[1:3]
    #get the minutes
    minutes = line[4:6]
    #get the seconds
    seconds = line[7:9]

    #make sure the time is numbers
    if hours.isdigit() and minutes.isdigit() and seconds.isdigit():
        #convert the time to seconds
        time = int(hours) * 3600 + int(minutes) * 60 + int(seconds)
        #if the time is greater than or the same as the latest time
        if time >= latestTime:
            #update the latest time
            latestTime = time
            #print the line
            checkForWin(line, time)

def checkForWin(line, time):
    global firstDetected
    global numberOfWins
    global timeOfLatestWin

    #check if the line contains the username
    if "1st" in line:
        firstDetected = True
    elif firstDetected:
        if USERNAME in line and not timeOfLatestWin == time:
            numberOfWins += 1
            firstDetected = False
            updateWinCounter(numberOfWins)
            timeOfLatestWin = time
        else:
            firstDetected = False

def updateWinCounter(numberOfWins):
    print("Wins: " + str(numberOfWins))
    