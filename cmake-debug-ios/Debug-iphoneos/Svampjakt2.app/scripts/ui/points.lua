local lato = require("font")

local Points = {}

function Points:new()
    local obj = {
        label = CreateLabel(lato, "-1 poäng", Vec3:new(0, -100, 150)),
        new_point_label = CreateLabel(lato, "+0p", Vec3:new(0, -100, 200)),
        gameover_sprite = CreateSprite("gameover.png"),
        points = 0,
        new_points = 0,
        should_animate = false,
        time = 0,
        opacity = 1.0,
        go_opacity = 0.0,
        is_gameover = false,
        has_gameovered = false,
        timer = Timer:new(1.0)
    }
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function Points:add_points(points)
    self.should_animate = true
    self.time = 0
    self.opacity = 1.0
    self.new_points = points
    self.points = self.points + points
end

function Points:update(delta_time, width, height)
    if self.should_animate == true then
        self.time = self.time + 0.001
        self.opacity = self.opacity - 0.01
        if self.new_points > 0 then
            UpdateText(self.new_point_label, "+" .. tostring(self.new_points) .. "p", width * 0.838,
                height * (0.80 - self.time))
        else
            UpdateText(self.new_point_label, tostring(self.new_points) .. "p", width * 0.838,
                height * (0.80 - self.time))
        end
        SetColor(self.new_point_label, 1.0, 1.0, 1.0, self.opacity)
        if self.opacity <= 0.0 then
            self.should_animate = false
            self.new_points = 0
        end
    end

    if self.is_gameover == true and self.has_gameovered == false then
        self.timer:Reset()
        self.has_gameovered = true
    end

    if not self.is_gameover then
        UpdateText(self.label, tostring(self.points) .. " poäng", width * 0.85, height * 0.85)
    end

    local mouse = GetMouse()
    local mousePosition = mouse:GetPosition()

    if (mousePosition:x() >= ((width / 2.0) - (width / 5.0)) and
            mousePosition:x() <= ((width / 2.0) + (width / 5.0)) and
            (height - mousePosition:y()) >= ((height / 1.5) - (height / 5.0)) and
            (height - mousePosition:y()) <= ((height / 1.5) + (height / 5.0))

        ) then
        self.is_gameover = false
        self.timer:Reset()
        self.timer:Stop()
        SetColor(self.gameover_sprite, 1.0, 1.0, 1.0, 0.0)
    end

    if self.timer:GetTick() >= 3000 then
        UpdateText(self.label, tostring(self.points) .. " poäng", width * 5.0, height * 0.85)
        Translate(self.gameover_sprite, width / 2.0, height / 1.5, 150.0)
        Scale(self.gameover_sprite, width / 5.0, height / 5.0, 1.0)
        Rotate(self.gameover_sprite, 0, 1, 0, 180)
        SetColor(self.gameover_sprite, 1.0, 1.0, 1.0, 1.0)
    end
end

return Points
