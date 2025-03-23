local lato = require("font")
local lato_big = require("lato_big")
local MushroomInspector = {}

function Button(path, x, y, w, h, o, i)
    return {
        sprite = CreateSprite(path),
        x = x,
        y = y,
        w = w,
        h = h,
        opacity = o,
        index = i,
        has_been_touched = false,
        timeout = 200,
        right_answer = -1
    }
end

function UpdateButton(inspector, button, width, height, opacity)
    Scale(button.sprite, width / (100 / button.w), height / (100 / button.h), 0)
    Translate(button.sprite, width * (button.x / 100), height * ((button.y) / 100), 150.0)
    SetColor(button.sprite, 1.0, 1.0, 1.0, opacity)
    Rotate(button.sprite, 0.0, 1.0, 0.0, 180)

    if button.right_answer ~= -1 then
        if button.right_answer == true then
            Scale(inspector.check, width / (100 / button.w / 0.8), height / (100 / button.h * 0.5), 0)
            Translate(inspector.check, width * (button.x / 100), height * ((button.y) / 100), 160.0)
            SetColor(inspector.check, 1.0, 1.0, 1.0, opacity)
            Rotate(inspector.check, 0.0, 1.0, 0.0, 180)
        else
            Scale(inspector.cross, width / (100 / button.w / 0.8), height / (100 / button.h * 0.5), 0)
            Translate(inspector.cross, width * (button.x / 100), height * ((button.y) / 100), 160.0)
            SetColor(inspector.cross, 1.0, 1.0, 1.0, opacity)
            Rotate(inspector.cross, 0.0, 1.0, 0.0, 180)
        end
    end


    local mouse = GetMouse()
    local mousePosition = mouse:GetPosition()
    if (mousePosition:x() >= ((width * (button.x / 100)) - (width / (100 / button.w))) and
            mousePosition:x() <= ((width * (button.x / 100)) + (width / (100 / button.w))) and
            (height - mousePosition:y()) >= ((height * ((button.y) / 100)) - (height / (100 / button.h))) and
            (height - mousePosition:y()) <= ((height * ((button.y) / 100)) + (height / (100 / button.h)))

        ) then
        if not inspector.choices_disabled then
            button.has_been_touched = true
            inspector.choices_disabled = true
        end
    else
        if button.has_been_touched == true then
            local mushroom_handle = inspector.current_mushroom.handle
            if mushroom_handle.is_deadly and button.index == 1 then
                inspector.point_system.is_gameover = true
            end

            -- IS DEADLY
            if mushroom_handle.is_deadly and button.index == 5 then
                inspector.point_system:add_points(mushroom_handle.points)
                button.right_answer = true
            end

            if mushroom_handle.is_deadly and button.index == 4 then
                inspector.point_system:add_points(-mushroom_handle.points)
                button.right_answer = false
            end

            if mushroom_handle.is_deadly and button.index == 3 then
                inspector.point_system:add_points(-mushroom_handle.points)
                button.right_answer = false
            end

            if mushroom_handle.is_deadly and button.index == 2 then
                inspector.point_system:add_points(-mushroom_handle.points)
                button.right_answer = false
            end

            if mushroom_handle.is_deadly and button.index == 1 then
                inspector.point_system:add_points(-mushroom_handle.points)
                button.right_answer = false
            end
            -- END IS DEADLY

            -- IS POISONOUS
            if mushroom_handle.is_poison and button.index == 5 then
                inspector.point_system:add_points(-mushroom_handle.points)
                button.right_answer = false
            end

            if mushroom_handle.is_poison and button.index == 4 then
                inspector.point_system:add_points(mushroom_handle.points)
                button.right_answer = true
            end

            if mushroom_handle.is_poison and button.index == 3 then
                inspector.point_system:add_points(-mushroom_handle.points)
                button.right_answer = false
            end

            if mushroom_handle.is_poison and button.index == 2 then
                inspector.point_system:add_points(-mushroom_handle.points)
                button.right_answer = false
            end

            if mushroom_handle.is_poison and button.index == 1 then
                inspector.point_system:add_points(-mushroom_handle.points)
                button.right_answer = false
            end
            -- END IS POISONOUS

            -- IS UNEDIBLE
            if mushroom_handle.is_unedible and button.index == 5 then
                inspector.point_system:add_points(-mushroom_handle.points)
                button.right_answer = false
            end

            if mushroom_handle.is_unedible and button.index == 4 then
                inspector.point_system:add_points(-mushroom_handle.points)
                button.right_answer = false
            end

            if mushroom_handle.is_unedible and button.index == 3 then
                inspector.point_system:add_points(-mushroom_handle.points)
                button.right_answer = false
            end

            if mushroom_handle.is_unedible and button.index == 2 then
                inspector.point_system:add_points(mushroom_handle.points)
                button.right_answer = true
            end

            if mushroom_handle.is_unedible and button.index == 1 then
                inspector.point_system:add_points(-mushroom_handle.points)
                button.right_answer = false
            end
            -- END IS UNEDIBLE

            -- IS RARE
            if mushroom_handle.is_rare and button.index == 5 then
                inspector.point_system:add_points(-mushroom_handle.points)
                button.right_answer = false
            end

            if mushroom_handle.is_rare and button.index == 4 then
                inspector.point_system:add_points(-mushroom_handle.points)
                button.right_answer = false
            end

            if mushroom_handle.is_rare and button.index == 3 then
                inspector.point_system:add_points(mushroom_handle.points)
                button.right_answer = true
            end

            if mushroom_handle.is_rare and button.index == 2 then
                inspector.point_system:add_points(-mushroom_handle.points)
                button.right_answer = false
            end

            if mushroom_handle.is_rare and button.index == 1 then
                inspector.point_system:add_points(-mushroom_handle.points)
                button.right_answer = false
            end
            -- END IS RARE

            -- IS GOOD
            if mushroom_handle.is_good and button.index == 5 then
                inspector.point_system:add_points(-mushroom_handle.points)
                button.right_answer = false
            end

            if mushroom_handle.is_good and button.index == 4 then
                inspector.point_system:add_points(-mushroom_handle.points)
                button.right_answer = false
            end

            if mushroom_handle.is_good and button.index == 3 then
                inspector.point_system:add_points(-mushroom_handle.points)
                button.right_answer = false
            end

            if mushroom_handle.is_good and button.index == 2 then
                inspector.point_system:add_points(-mushroom_handle.points)
                button.right_answer = false
            end

            if mushroom_handle.is_good and button.index == 1 then
                inspector.point_system:add_points(mushroom_handle.points)
                button.right_answer = true
            end
            -- END IS RARE
            inspector.choice_made = true
            inspector.answer_timer:Reset()
            button.has_been_touched = false
        end
    end
end

function MushroomInspector:new(ps)
    local table = {
        current_mushroom = nil,
        glass = CreateRoundedRectangle(0, 0, 100, 0, 0, Vec4:new(0, 0, 0, 0)),
        good = Button("good.png", 27, 17, 5, 5, 0.0, 1),
        unedible = Button("unedible.png", 38, 17, 5, 5, 0.0, 2),
        rare = Button("rare.png", 49, 17, 5, 5, 0.0, 3),
        poisonous = Button("poisonous.png", 60, 17, 5, 5, 0.0, 4),
        deadly = Button("deadly.png", 71, 17, 5, 5, 0.0, 5),
        scale_x = 0.0,
        scale_y = 0.0,
        scaling = 0.0,
        opacity_backdrop = 0.0,
        opacity_buttons = 0.0,
        time_scale = 0.0,
        direction = 1,
        has_transitioned = false,
        on_choice = nil,
        point_system = ps,
        choices_disabled = false,
        check = CreateSprite("check.png"),
        cross = CreateSprite("cross.png"),
        choice_made = false,
        name = CreateLabel(lato_big, "svamp", Vec3:new(0, -100, 200)),
        name_opacity = 0.0,
        --New props
        fade_in_timer = Timer:new(1.0),
        fade_out_timer = Timer:new(1.0),
        answer_timer = Timer:new(1.0),
    }
    setmetatable(table, self)
    self.__index = self
    return table
end

function MushroomInspector:update(delta_time, width, height)
    if self.current_mushroom ~= nil then
        if self.fade_in_timer:GetTick() < 1001.0 and self.direction == 1 then
            self.scaling = EaseInSine(self.fade_in_timer:GetTick() * 0.001) * 70.0
            if self.fade_in_timer:GetTick() > 1000.0 then
                self.fade_in_timer:Reset()
                self.fade_in_timer:Stop()
                self.direction = -1
            end
        end

        if self.fade_out_timer:GetTick() > 0.1 and self.direction == 0 then
            self.scaling = EaseInSine(self.fade_out_timer:GetTick() * -0.0001) * 70.0 + self.scaling
            if self.fade_out_timer:GetTick() > 1000.0 then
                self.fade_out_timer:Reset()
                self.fade_out_timer:Stop()
                self.direction = -1
                self.choices_disabled = false
                self:on_choice(self)
                self.good.right_answer = -1
                self.unedible.right_answer = -1
                self.rare.right_answer = -1
                self.poisonous.right_answer = -1
                self.deadly.right_answer = -1
            end
        end

        if self.choice_made == true then
            -- Show name
            UpdateText(self.name, self.current_mushroom.handle.name, 100, height * 0.80)
            if self.answer_timer:GetTick() > 2000.0 then
                self.direction = 0
                self.fade_out_timer:Reset()
                self.answer_timer:Stop()
                self.choice_made = false
                UpdateText(self.name, self.current_mushroom.handle.name, width * 1.5, height * 0.80)
            end
        end


        if self.opacity_backdrop < 0.82 and self.direction == 1 then
            self.opacity_backdrop = self.opacity_backdrop + 0.05
        end

        if self.opacity_buttons < 1.0 and self.direction == 1 then
            self.opacity_buttons = self.opacity_buttons + 0.05
        end

        if self.opacity_buttons > 0.0 and self.direction == 0 then
            self.opacity_buttons = self.opacity_buttons - 0.05
        end

        if self.opacity_backdrop > -0.1 and self.direction == 0 then
            self.opacity_backdrop = self.opacity_backdrop - 0.03
        end


        Scale(self.glass, width / 2.0, height / 2.0, 0)
        Translate(self.glass, width / 2.0, height / 2.0, 80)
        SetColor(self.glass, 0.0, 0.0, 0.0, self.opacity_backdrop)

        local image_xscale = (width / ((100 / (self.scaling - self.scale_x)) * 12.0))
        local image_yscale = (width / ((100 / (self.scaling - self.scale_y)) * 12.0)) * (self.scale_y / 5.0)

        Scale(self.current_mushroom.sprite, image_xscale, image_yscale, 0)
        Translate(self.current_mushroom.sprite, width / 2.0, height / 2.0, 140.0)
        SetColor(self.current_mushroom.sprite, 1.0, 1.0, 1.0, self.scaling / 80.0)

        UpdateButton(self, self.good, width, height, self.opacity_buttons)
        UpdateButton(self, self.unedible, width, height, self.opacity_buttons)
        UpdateButton(self, self.rare, width, height, self.opacity_buttons)
        UpdateButton(self, self.poisonous, width, height, self.opacity_buttons)
        UpdateButton(self, self.deadly, width, height, self.opacity_buttons)
    end
end

return MushroomInspector
