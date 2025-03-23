local Level1 = require("level1")

local LevelManager = {}

function LevelManager:new()
    local obj = {
        current_level = nil,
        has_loaded_level1 = false
    }
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function LevelManager:set_level(index)
    if index == 1 and self.has_loaded_level1 == false then
        self.current_level = Level1:new()
        self.has_loaded_level1 = true
        print("LOADED LEVEL 1")
    end

    if index == -1 then
        self.current_level:stop()
        --self.current_level = nil
    end
end

function LevelManager:update(delta_time, width, height)
    if (self.current_level ~= nil) then
        self.current_level:update(delta_time, width, height)
    end
end

return LevelManager
