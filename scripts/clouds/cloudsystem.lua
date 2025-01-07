local Primitives = require("entropy/primitives")

local CloudSystem = {}

local Cloud = {}

local NUM_CLOUDS = 20
local BASE_DIR = "/Users/joakimwennergren/Entropia/"

function randomFloat(lower, greater)
    return lower + math.random() * (greater - lower);
end

-- Initialize Cloud
function Cloud:new(xpos, ypos, speed, zindex, scale)
    local paths = {
        "resources/sprites/cloud_1.png",
        "resources/sprites/cloud_2.png",
        "resources/sprites/cloud_3.png",
        "resources/sprites/cloud_4.png"
    }
    local obj = {
        sprite = nil,
        speed = speed,
        xpos = xpos,
        ypos = ypos,
        zindex = zindex,
        scale = scale
    }

    local cloud = Primitives.CreateSprite(BASE_DIR .. paths[math.random(#paths)])
    Translate(cloud, 0, 0, 2)
    Scale(cloud, 142, 64, 0.0)
    obj.sprite = cloud

    setmetatable(obj, self)
    self.__index = self
    return obj
end

-- Initialize the CameraController
function CloudSystem:new()
    local obj = {
        clouds = {},
    }

    for i = 1, NUM_CLOUDS do
        local cloud = Cloud:new(600 + math.random(1000, 4000), 400 + math.random(100, 600), randomFloat(0.2, 2.0), i,
            randomFloat(0.1, 2.0))
        table.insert(obj.clouds, cloud)
    end

    setmetatable(obj, self)
    self.__index = self
    return obj
end

function CloudSystem:update(width, height)
    for i = 1, NUM_CLOUDS do
        Translate(self.clouds[i].sprite, self.clouds[i].xpos, self.clouds[i].ypos + height * 1.2,
            self.clouds[i].zindex + 100)
        Scale(self.clouds[i].sprite, 142 * self.clouds[i].scale, 64 * self.clouds[i].scale, 0.0)
        self.clouds[i].xpos = self.clouds[i].xpos - 0.1 * self.clouds[i].speed
    end
end

return CloudSystem
