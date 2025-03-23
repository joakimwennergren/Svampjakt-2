local Mushroom = require("mushroom")

local MushroomSpawner = {}

function MushroomSpawner:new(level_manager, mushroom_inspector)
    local obj = {
        mushrooms = {},
        level_manager = level_manager,
        mushroom_inspector = mushroom_inspector,
        has_init = false,
        used_positions = {},
        should_spawn = true
    }

    setmetatable(obj, self)
    self.__index = self
    return obj
end

function MushroomSpawner:getUniquePosition()
    local index
    local attempts = 0
    local max_attempts = 10 -- limit the number of attempts to avoid infinite loops
    local positions = self.level_manager.current_level:GetMushroomPositions()

    repeat
        index = math.random(#positions)
        attempts = attempts + 1
    until not self.used_positions[positions[index]] or attempts >= max_attempts

    -- Mark the position as used
    self.used_positions[positions[index]] = true
    return positions[index]
end

function MushroomSpawner:init()
    if self.has_init == false then
        for i = 1, 5 do
            self:AddMushrooom()
        end
        this = self
        self.mushroom_inspector.on_choice = function(mi)
            for i, mushroom in ipairs(this.mushrooms) do
                --SetColor(this.mushrooms[i].sprite, 1.0, 1.0, 1.0, 1.0)
                this.mushrooms[i].disabled = false
                --self.mushrooms[i].direction = 1
            end
            for i, mushroom in ipairs(this.mushrooms) do
                if mushroom.id == mi.current_mushroom.id then
                    Delete(this.mushrooms[i].sprite)
                    table.remove(this.mushrooms, i)
                    this:AddMushrooom()
                    break
                end
            end
            this.mushroom_inspector.current_mushroom = nil
        end
        self.has_init = true
    end
end

function MushroomSpawner:AddMushrooom()
    local this = self
    --local positions = self.level_manager.current_level:GetMushroomPositions()
    --local index = math.random(#positions)

    local position = self:getUniquePosition()

    local mushroom = Mushroom:new(
        position.x,
        position.y,
        position.z,
        self
    )

    mushroom.on_timeout = function(m)
        for i, mushroom in ipairs(this.mushrooms) do
            if mushroom.id == m.id then
                Delete(this.mushrooms[i].sprite)
                table.remove(this.mushrooms, i)
                this:AddMushrooom()
                break
            end
        end
    end
    table.insert(self.mushrooms, mushroom)
end

function MushroomSpawner:on_click(m)
    -- Remove mushroom based on unique ID

    for i = 1, #self.mushrooms do
        --SetColor(self.mushrooms[i].sprite, 1.0, 1.0, 1.0, 0.2)
        if self.mushrooms[i].id ~= m.id then
            --self.mushrooms[i].direction = 0
            self.mushrooms[i].disabled = true
        end
    end

    m.disabled = true
    m.is_selected = false
    self.mushroom_inspector.current_mushroom = m
    self.mushroom_inspector.fade_in_timer:Reset()
    self.mushroom_inspector.direction = 1
    self.mushroom_inspector.time_scale = 0.0
    self.mushroom_inspector.scale_x = m.scale_x
    self.mushroom_inspector.scale_y = m.scale_y
    PlaySound(1)
end

function MushroomSpawner:stop()
    self.should_spawn = false
end

function MushroomSpawner:update(delta_time, width, height)
    if not self.should_spawn then
        for i, mushroom in ipairs(self.mushrooms) do
            self.mushrooms[i].direction = 0
            self.mushrooms[i].opacity = 0.0
            self.mushrooms[i]:update(delta_time, width, height)
            --self.mushrooms[i].disabled = true
        end
        return
    end


    for i = 1, #self.mushrooms do
        if self.mushrooms[i] ~= nil then
            self.mushrooms[i]:update(delta_time, width, height)
        end

        if self.mushrooms[i].is_selected then
            self:on_click(self.mushrooms[i])
        end
    end
end

return MushroomSpawner
