local Easing = require("entropy/easing")
local Primitives = require("entropy/primitives")

local BASE_DIR = "/Users/joakimwennergren/Entropia/"

local Player = {}

-- Quad In-Out Easing Function
function easeInOutQuad(t)
    if t < 0.5 then
        return 2 * t * t              -- Ease In (quadratic acceleration)
    else
        return -2 * t * t + 4 * t - 1 -- Ease Out (quadratic deceleration)
    end
end

-- Ease In-Out Bounce Function (same as before)
function easeInOutBounce(t)
    if t < 0.5 then
        return 0.5 * (1 - easeOutBounce(1 - 2 * t)) -- Ease In
    else
        return 0.5 * (1 + easeOutBounce(2 * t - 1)) -- Ease Out
    end
end

-- Ease Out Bounce Function (same as before)
function easeOutBounce(t)
    if t < (1 / 2.75) then
        return 7.5625 * t * t
    elseif t < (2 / 2.75) then
        t = t - (1.5 / 2.75)
        return 7.5625 * t * t + 0.75
    elseif t < (2.5 / 2.75) then
        t = t - (2.25 / 2.75)
        return 7.5625 * t * t + 0.9375
    else
        t = t - (2.625 / 2.75)
        return 7.5625 * t * t + 0.984375
    end
end

-- Initialize Cloud
function Player:new()
    local player = Primitives.CreateSprite(BASE_DIR .. "resources/sprites/player_4.png")
    Scale(player, 110, 88, 0.0)
    Translate(player, 100.0, 100.0, 5) -- Starting position
    Rotate(player, 0, 1, 0, 180)

    local obj = {
        sprite = player,
        time = 0,        -- Start time
        duration = 1000, -- Duration of one full bounce cycle (in seconds, e.g. 2 seconds)
        totalTime = 5,   -- Total time to animate (can be adjusted)
        direction = 0,
        xPos = 0.0
    }

    setmetatable(obj, self)
    self.__index = self
    return obj
end

function Player:update(deltaTime, width, height, pressedKey)
    if (pressedKey == 68) then
        self.xPos = self.xPos + 5.0
        Rotate(self.sprite, 0, 1, 0, 180)
    end

    if (pressedKey == 65) then
        self.xPos = self.xPos - 5.0
        Rotate(self.sprite, 0, 1, 0, 0)
    end

    -- Normalize time to a value between 0 and 1, looping the time within the duration
    local normalizedTime = (self.time) / self.duration

    if (self.time >= 1860) then
        normalizedTime = 0.0
        self.time = 0.0
    end


    -- Get the easing result and scale it for movement (e.g., move it between 0 and 100 pixels)
    local bounceValue = Easing.sineInOut(normalizedTime) * 60

    -- Print or visualize the bounce value (useful for debugging)
    --print("Bounce Position: " .. bounceValue)

    self.time = self.time + deltaTime

    -- Apply the new y-position based on the bounce value
    Translate(self.sprite, self.xPos, 140.0 + bounceValue, 5) -- Vertical movement using ease
end

return Player
