local Primitives = require("entropy/primitives")
local Luvent = require("libraries/luvent")
local CameraController = require("scripts/camera/camera_controller")
local CloudSystem = require("scripts/clouds/cloudsystem")
local Level1 = require("scripts/levels/level1")
local Player = require("scripts/player/player")

local banana = Primitives.CreateSprite("/Users/joakimwennergren/Entropia/resources/sprites/rb_30161.png")

local bg = Primitives.CreateRoundedRectangle(0.0, 0.0, 1.0, 3000, 3000, Vec4.new())


local quad = Primitives.CreateCircle(0.0, 0.0, 1.0, 30)
SetColor(quad, 1.0, 1.0, 1.0, 1.0)

local circles = {}

for i = 1, 1000 do
    local z = math.random(10, 104)
    local s = Primitives.CreateCircle(500, 300, z, 30)
    SetColor(s, math.random(1, 254) / 255, math.random(1, 254) / 255, math.random(1, 254) / 255, 1.0)
    local scale = math.random(10, 40)
    Scale(s, scale, scale, 0.0)
    local circle = {
        x = 0.0,
        y = 0.0,
        speed = math.random(1, 50),
        sprite = s,
        angle = 0.0,
        radius = math.random(80, 250),
        zIndex = z
    }
    table.insert(circles, circle)
end



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

local switch = 0.0

function OnRender(deltaTime, width, height)
    Translate(quad, (width / 2.0), (height / 2.0), 1.0)
    Scale(quad, 800, 800, 0.0)
    Translate(banana, (width / 2.0), (height / 2.0), 3.0)
    Scale(banana, 64, 64, 0.0)

    switch = switch + 1
    if switch > 100 then
        SetColor(bg, math.random(1, 254) / 255, math.random(1, 254) / 255, math.random(1, 254) / 255, 1.0)
        switch = 0
    end

    for i = 1, 1000 do
        circles[i].angle = circles[i].angle + circles[i].speed * 0.001
        circles[i].x = (width / 2.0) + circles[i].radius * math.cos(circles[i].angle)
        circles[i].y = (height / 2.0) + circles[i].radius * math.sin(circles[i].angle)
        Translate(circles[i].sprite, circles[i].x, circles[i].y, circles[i].zIndex)
    end
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
