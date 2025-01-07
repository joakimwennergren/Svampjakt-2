local Primitives = require("entropy/primitives")
local Globals = require("scripts/globals/globals")

local Level1 = {}

function Level1:new()
    local obj = {
        hasGeneratedBackgrounds = false
    }

    self:PlaceTrees()
    self:PlaceMushrooms()

    setmetatable(obj, self)
    self.__index = self
    return obj
end

function Level1:CreateSprite(p, x, y, z, w, h)
    local sprite = Primitives.CreateSprite(Globals.BaseDir .. p)
    Translate(sprite, x, y, z)
    Scale(sprite, w, h, 0.0)
    return sprite
end

function Level1:GenerateBackgrounds(width, height)
    if not self.hasGeneratedBackgrounds then
        background = Primitives.CreateSprite(Globals.BaseDir .. "resources/sprites/background_4.png")
        quad = Primitives.CreateQuad()
        self.hasGeneratedBackgrounds = true
    end
    Scale(background, width * 6.0, height - 400.0, 0)
    Scale(quad, width * 8.0, height * 2.0, 0)
    Translate(quad, 0, 0, 0)
    SetColor(quad, 107.0 / 255.0, 213.0 / 255.0, 242.0 / 237.0, 1.0)
    Translate(background, width, height - 400.0, 1)
    Rotate(background, 0, 1, 0, 180)
end

function Level1:PlaceTrees()
    local paths = {
        "resources/sprites/tree_4.png",
        "resources/sprites/tree_6.png"
    }
    for i = 1, 20 do
        local scale = math.random(300, 600)
        self:CreateSprite(paths[math.random(1, #paths)], 500 + i * math.random(500, 2000), 400, 10, scale, scale + 100)
    end
end

function Level1:PlaceMushrooms()
    local paths = {
        "resources/sprites/mushroom_1.png",
    }
    for i = 1, 20 do
        local scale = math.random(60, 100)
        self:CreateSprite(paths[math.random(1, #paths)], 500 + i * math.random(500, 2000), 60, 10, scale, scale)
    end
end

function Level1:PlaceForegroundGrass()
    local paths = {
        "resources/sprites/grass_4.png",
    }
    for i = 1, 20 do
        local scale = math.random(60, 100)
        self:CreateSprite(paths[math.random(1, #paths)], 500 + i * math.random(500, 2000), 60, 10, scale, scale)
    end
end

function Level1:update(deltaTime, width, height)
    self:GenerateBackgrounds(width, height)
end

return Level1
