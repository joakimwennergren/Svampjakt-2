local Primitives = require("entropy/primitives")
local Luvent = require("libraries/luvent")
local CameraController = require("scripts/camera/camera_controller")
local CloudSystem = require("scripts/clouds/cloudsystem")
local Level1 = require("scripts/levels/level1")
local Player = require("scripts/player/player")

local quad = Primitives.CreateQuad()
Translate(quad, 0.0, 0.0, 1.0)
Scale(quad, 100, 100, 0.0)
SetColor(quad, 1.0, 0.0, 0.0, 1.0)

--local BASE_DIR = "/Users/joakimwennergren/Entropia/"

--local pressedKey = -1

-- Create Player
--local player = Player:new()

-- Create a camera controller
--local camera = CameraController:new(player, { x = -2000, y = 0 }, 0.05)

-- Create Level 1
--local level1 = Level1:new()

-- Create Cloud system
--local cloudSystem = CloudSystem:new()

--Enemy = {}

--Enemy.onDie = Luvent.newEvent()

--Enemy.onDie:addAction(
--    function()
--        print("Enemy died!")
--    end
--)

--local quad = Primitives.CreateQuad()
--local quad2 = Primitives.CreateQuad()



--local grass_foreground = Primitives.CreateSprite(BASE_DIR .. "resources/sprites/grass_4.png")


--local dyn = Create2DDynamicBody(200, 200, 10, 10)
--local dyn2 = Create2DDynamicBody(400, 200, 10, 10)
--local dyn2 = Create2DDynamicBody(700, 200, 10, 10)


--SetCameraZoom(-0.5)
--SetCameraPosition(-1000, 0)

function OnRender(deltaTime, width, height)

    Translate(quad, width /2.0, height / 2.0, 1.0)
    --Scale(background2, width, height / 2.0, 0)
    --Translate(background2, width * 3.0, height / 2.0, 2)

    --Scale(grass_foreground, width, 80.0, 0.0)
    --Translate(grass_foreground, width, 60.0, 100)

    -- Update the camera
    --camera:update(deltaTime)

    --local camPos = camera:getPosition()
    --SetCameraPosition(camPos.x, 0.0)


    --cloudSystem:update(width, height)
    --level1:update(deltaTime, width, height)
    --player:update(deltaTime, width, height, pressedKey)
end

--function OnInput(key)
    --pressedKey = key
--ends
