local Level1 = {}

local mushroom_positions = {
    -- First layer
    { x = 5,  y = 8,  z = 41 },
    { x = 10, y = 7,  z = 41 },
    { x = 15, y = 7,  z = 41 },
    { x = 20, y = 11, z = 41 },
    { x = 25, y = 13, z = 41 },
    { x = 30, y = 11, z = 41 },
    { x = 35, y = 11, z = 41 },
    { x = 40, y = 12, z = 41 },
    { x = 45, y = 10, z = 41 },
    { x = 50, y = 9,  z = 41 },
    { x = 55, y = 6,  z = 41 },
    { x = 60, y = 6,  z = 41 },
    { x = 65, y = 7,  z = 41 },
    { x = 70, y = 9,  z = 41 },
    { x = 75, y = 6,  z = 41 },
    { x = 80, y = 5,  z = 41 },
    { x = 85, y = 4,  z = 41 },
    { x = 90, y = 4,  z = 41 },

    -- Second layer
    { x = 5,  y = 20, z = 31 },
    { x = 10, y = 20, z = 31 },
    { x = 15, y = 18, z = 31 },
    { x = 20, y = 16, z = 31 },
    { x = 25, y = 14, z = 31 },
    { x = 30, y = 15, z = 31 },
    { x = 35, y = 16, z = 31 },
    { x = 40, y = 17, z = 31 },
    { x = 45, y = 17, z = 31 },
    { x = 50, y = 18, z = 31 },
    { x = 55, y = 18, z = 31 },
    { x = 60, y = 17, z = 31 },
    { x = 65, y = 16, z = 31 },
    { x = 70, y = 16, z = 31 },
    { x = 75, y = 17, z = 31 },
    { x = 80, y = 14, z = 31 },
    { x = 85, y = 10, z = 31 },
    { x = 90, y = 10, z = 31 },

    -- Third layer
    { x = 10, y = 40, z = 21 },
    { x = 15, y = 41, z = 21 },
    { x = 20, y = 32, z = 21 },
    { x = 25, y = 31, z = 21 },
    { x = 30, y = 33, z = 21 },
    { x = 35, y = 34, z = 21 },
    { x = 40, y = 35, z = 21 },
    { x = 45, y = 34, z = 21 },
    { x = 50, y = 34, z = 21 },
    { x = 55, y = 34, z = 21 },
    { x = 60, y = 34, z = 21 },
    { x = 65, y = 35, z = 21 },
    { x = 70, y = 34, z = 21 },
    { x = 75, y = 33, z = 21 },
    { x = 90, y = 31, z = 21 },
}

function Level1:new()
    local obj = {
        layer1 = CreateSprite("layer1.png"),
        layer2 = CreateSprite("layer2.png"),
        layer3 = CreateSprite("layer3.png"),
        layer4 = CreateSprite("layer4.png"),
        layer5 = CreateSprite("layer5.png"),
        flare = CreateSprite("flare.png"),
        opacity = 0.0,
        flare_opacity = 0.0,
        flare_time = 0.0,
        should_end = false
    }
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function clamp(value, min, max)
    return math.max(min, math.min(max, value))
end

function Level1:stop()
    self.should_end = true
end

function Level1:update(deltaTime, width, height)
    if self.should_end and self.opacity > 0.0 then
        self.opacity = self.opacity - 0.03
    end

    if self.should_end == false and self.opacity < 1.0 then
        self.opacity = self.opacity + 0.03
    else
        self.flare_time    = self.flare_time + 0.008
        self.flare_opacity = clamp(EaseInOutSine(self.flare_time), 0.0, 0.4)
    end

    Scale(self.layer1, width / 2.0, height / 2.0, 0)
    Translate(self.layer1, width / 2.0, height / 2.0, 10.0)
    Rotate(self.layer1, 0.0, 1.0, 0.0, 180)
    SetColor(self.layer1, 1.0, 1.0, 1.0, self.opacity)

    Scale(self.layer2, width / 2.0, height / 2.0, 0)
    Translate(self.layer2, width / 2.0, height / 2.0, 20.0)
    Rotate(self.layer2, 0.0, 1.0, 0.0, 180)
    SetColor(self.layer2, 1.0, 1.0, 1.0, self.opacity)

    Scale(self.layer3, width / 2.0, height / 2.0, 0)
    Translate(self.layer3, width / 2.0, height / 2.0, 30.0)
    Rotate(self.layer3, 0.0, 1.0, 0.0, 180)
    SetColor(self.layer3, 1.0, 1.0, 1.0, self.opacity)

    Scale(self.layer4, width / 2.0, height / 2.0, 0)
    Translate(self.layer4, width / 2.0, height / 2.0, 40.0)
    Rotate(self.layer4, 0.0, 1.0, 0.0, 180)
    SetColor(self.layer4, 1.0, 1.0, 1.0, self.opacity)

    Scale(self.layer5, width / 2.0, height / 2.0, 0)
    Translate(self.layer5, width / 2.0, height / 2.0, 50.0)
    Rotate(self.layer5, 0.0, 1.0, 0.0, 180)
    SetColor(self.layer5, 1.0, 1.0, 1.0, self.opacity)

    Scale(self.flare, 400, 400, 0)
    Translate(self.flare, width * (35 / 100), height * (85 / 100), 60.0)
    Rotate(self.flare, 0.0, 1.0, 0.0, 180)
    SetColor(self.flare, 1.0, 1.0, 1.0, self.opacity - self.flare_opacity)
end

function Level1:GetMushroomPositions()
    return mushroom_positions
end

return Level1
