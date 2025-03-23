local StartScreen = {}

function StartScreen:new()
    local obj = {
        bg = CreateSprite("start_screen.png"),
        banner = CreateSprite("banner.png"),
        banner_time = 0.0,
        start = CreateSprite("start.png"),
        active = true,
        opacity = 0.0,
        on_start = nil,
        has_pressed_start = false,
        transition_done = false,
    }
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function StartScreen:set_active(active)
    self.active = active
end

function StartScreen:update(delta_time, width, height)
    if self.active then
        SetVisible(self.banner, true)
        SetVisible(self.start, true)
        self.transition_done = false

        if self.opacity < 1.0 then
            self.opacity = self.opacity + 0.03
        end

        Scale(self.bg, width / 2.0, height / 2.0, 0)
        Translate(self.bg, width / 2.0, height / 2.0, 1.0)
        Rotate(self.bg, 0.0, 1.0, 0.0, 180)
        SetColor(self.bg, 1.0, 1.0, 1.0, self.opacity)

        self.banner_time = self.banner_time + 0.02
        local yPos = EaseInOutSine(self.banner_time)

        Scale(self.banner, width / 3.4, height / 4.8, 0)
        Translate(self.banner, width / 2.0, (height / 1.6) + (yPos * 15), 80.0)
        Rotate(self.banner, 0.0, 1.0, 0.0, 180)
        SetColor(self.banner, 1.0, 1.0, 1.0, self.opacity)

        local start_scale_x = width / 16
        local start_scale_y = height / 8
        local start_pos_x = width / 2.0
        local start_pos_y = height / 3.4

        Scale(self.start, start_scale_x, start_scale_y, 0)
        Translate(self.start, start_pos_x, start_pos_y, 80.0)
        Rotate(self.start, 0.0, 1.0, 0.0, 180)
        SetColor(self.start, 1.0, 1.0, 1.0, self.opacity)

        local mouse = GetMouse()
        local mousePosition = mouse:GetPosition()

        if (mousePosition:x() >= (start_pos_x - start_scale_x) and
                mousePosition:x() <= (start_pos_x + start_scale_x) and
                (height - mousePosition:y()) >= (start_pos_y - start_scale_y) and
                (height - mousePosition:y()) <= (start_pos_y + start_scale_y)
            ) then
            --SetColor(self.start, 1.0, 1.0, 1.0, 0.9)
            self.has_pressed_start = true
        else
            if self.has_pressed_start then
                self.active = false
                self.has_pressed_start = false
            end
        end
    else
        if self.opacity > 0.0 then
            self.opacity = self.opacity - 0.03
        else
            SetVisible(self.banner, false)
            SetVisible(self.start, false)
            self.transition_done = true
        end

        self.banner_time = self.banner_time + 0.02
        local yPos = EaseInOutSine(self.banner_time)

        Scale(self.banner, width / 3.4, height / 4.8, 0)
        Translate(self.banner, width / 2.0, (height / 1.6) + (yPos * 15), 30.0)

        SetColor(self.start, 1.0, 1.0, 1.0, self.opacity)
        SetColor(self.banner, 1.0, 1.0, 1.0, self.opacity)
        SetColor(self.bg, 1.0, 1.0, 1.0, self.opacity)
    end
end

return StartScreen
