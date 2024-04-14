import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

local gfx <const> = playdate.graphics
local inSession = false
local clientVersion = 1

local menu = playdate.getSystemMenu()
local bgmusic = playdate.sound.fileplayer.new("/assets/bg.wav")

function CheckSession()

end

function FirstSetUp()
    print("Starting Statolumn...")

    local appdata = playdate.datastore.read()
    if appdata then
        if clientVersion == appdata.clientVersion then
            print("Data found, loading...")
            CheckSession()
        else
            print("Data found, but client version is outdated, updating...")
            appdata.clientVersion = clientVersion
            playdate.datastore.write(appdata)
            
            CheckSession()
        end
        printTable(appdata)
    else
        print("No data found, creating data...")

        local data = {
            clientVersion = clientVersion,
            session = {
                username = "",
                token = ""
            }
        }

        playdate.datastore.write(data)
    end
end

FirstSetUp()

function playdate.update()

    playdate.display.setScale(1)
    local statFont = playdate.graphics.getSystemFont()
    playdate.graphics.setFont(statFont)

    bgmusic:play()

    statFont:drawTextAligned("Connecting to Statolumn Services...", 200, 110, kTextAlignment.center)

    gfx.sprite.update()
    playdate.timer.updateTimers()

end