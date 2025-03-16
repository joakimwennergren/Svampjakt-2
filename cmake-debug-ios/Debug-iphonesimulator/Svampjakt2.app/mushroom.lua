local Mushroom = {}
local mushrooms_clicked = {}
local clicked_mushrooms = {}

-- Function to calculate distance
function calculateDistance(x1, y1, x2, y2)
    return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2)
end

function shuffleTable(tbl)
    for i = #tbl, 2, -1 do
        local j = math.random(i)
        tbl[i], tbl[j] = tbl[j], tbl[i]
    end
end

local iterations = 0
function Mushroom:new(x, y, z, s)
    local mushrooms = {
        {
            path = "flugsvamp.png",
            name = "Flugsvamp",
            sx = 5,
            sy = 10,
            points = 5,
            is_deadly = false,
            is_poison = true,
            is_edible = false,
            is_rare = false,
            is_good = false,
        },
        {
            path = "stensopp.png",
            name = "Stensopp",
            sx = 2,
            sy = 5,
            points = 5,
            is_deadly = false,
            is_poison = false,
            is_edible = false,
            is_rare = false,
            is_good = true,
        },
        {
            path = "svart_trumpetsvamp.png",
            name = "Svart trumpetsvamp",
            sx = 3,
            sy = 5,
            points = 5,
            is_deadly = false,
            is_poison = false,
            is_edible = false,
            is_rare = false,
            is_good = true,
        },
        {
            path = "tegelsopp.png",
            name = "Tegelsopp",
            sx = 4,
            sy = 8,
            points = 3,
            is_deadly = false,
            is_poison = false,
            is_edible = false,
            is_rare = false,
            is_good = true,
        },
        {
            path = "vit_flugsvamp.png",
            name = "Vit flugsvamp",
            sx = 3,
            sy = 6,
            points = 5,
            is_deadly = true,
            is_poison = false,
            is_edible = false,
            is_rare = false,
            is_good = false,
        },
        {
            path = "fjallig_blacksvamp.png",
            name = "Fjällig bläcksvamp",
            sx = 1,
            sy = 8,
            points = 4,
            is_deadly = false,
            is_poison = false,
            is_edible = false,
            is_rare = false,
            is_good = true,
        },
        {
            path = "fjallsopp.png",
            name = "Fjällsopp",
            sx = 2,
            sy = 6,
            points = 5,
            is_deadly = false,
            is_poison = false,
            is_edible = false,
            is_rare = true,
            is_good = false,
        },
        {
            path = "kantarell.png",
            name = "Kantarell",
            sx = 3,
            sy = 4,
            points = 5,
            is_deadly = false,
            is_poison = false,
            is_edible = false,
            is_rare = false,
            is_good = true,
        },
        {
            path = "citrongul_slemskivling.png",
            name = "Citrongul slemskivling",
            sx = 2,
            sy = 5,
            points = 3,
            is_deadly = false,
            is_poison = false,
            is_edible = false,
            is_rare = false,
            is_good = true,
        },
        {
            path = "lomsk_flugsvamp.png",
            name = "Lömsk flugsvamp",
            sx = 2,
            sy = 5,
            points = 5,
            is_deadly = true,
            is_poison = false,
            is_edible = false,
            is_rare = false,
            is_good = false,
        },
        {
            path = "slidsilkesskivling.png",
            name = "Slidsilkesskivling",
            sx = 3,
            sy = 4,
            points = 5,
            is_deadly = false,
            is_poison = false,
            is_edible = false,
            is_rare = true,
            is_good = false,
        },
        {
            path = "stolt_fjallskivling.png",
            name = "Stolt fjällskivling",
            sx = 5,
            sy = 15,
            points = 5,
            is_deadly = false,
            is_poison = false,
            is_edible = false,
            is_rare = false,
            is_good = true,
        },
        {
            path = "toppig_giftspindelskivling.png",
            name = "Toppig giftspindelskivling",
            sx = 3,
            sy = 5,
            points = 5,
            is_deadly = true,
            is_poison = false,
            is_edible = false,
            is_rare = false,
            is_good = false,
        },
        {
            path = "narrkantarell.png",
            name = "Narrkantarell",
            sx = 2,
            sy = 4,
            points = 5,
            is_deadly = false,
            is_poison = false,
            is_unedible = true,
            is_rare = false,
            is_good = false,
        },
        {
            path = "gronkremla.png",
            name = "Grönkremla",
            sx = 3.5,
            sy = 3.5,
            points = 2,
            is_deadly = false,
            is_poison = false,
            is_unedible = false,
            is_rare = false,
            is_good = true,
        },
        {
            path = "stjarnrodhatting.png",
            name = "Stjärnrödhatting",
            sx = 1,
            sy = 3,
            points = 5,
            is_deadly = false,
            is_poison = false,
            is_unedible = true,
            is_rare = false,
            is_good = false,
        },
        {
            path = "kungschampion.png",
            name = "Kungschampion",
            sx = 3,
            sy = 7,
            points = 5,
            is_deadly = false,
            is_poison = false,
            is_unedible = false,
            is_rare = false,
            is_good = true,
        },
        {
            path = "laxskivling.png",
            name = "Laxskivling",
            sx = 2,
            sy = 4,
            points = 5,
            is_deadly = false,
            is_poison = false,
            is_unedible = true,
            is_rare = false,
            is_good = false,
        },
        {
            path = "varmusseron.png",
            name = "Vårmusseron",
            sx = 2,
            sy = 3,
            points = 2,
            is_deadly = false,
            is_poison = false,
            is_unedible = false,
            is_rare = false,
            is_good = true,
        },
        {
            path = "gifthatting.png",
            name = "Gifthätting",
            sx = 2,
            sy = 6,
            points = 5,
            is_deadly = true,
            is_poison = false,
            is_unedible = false,
            is_rare = false,
            is_good = false,
        },
        {
            path = "blek_kantarell.png",
            name = "Blek kantarell",
            sx = 2,
            sy = 5,
            points = 5,
            is_deadly = false,
            is_poison = false,
            is_unedible = false,
            is_rare = false,
            is_good = true,
        },
        {
            path = "tallsopp.png",
            name = "Tallsopp",
            sx = 2,
            sy = 7,
            points = 3,
            is_deadly = false,
            is_poison = false,
            is_unedible = false,
            is_rare = false,
            is_good = true,
        },
        {
            path = "rimskivling.png",
            name = "Rimskivling",
            sx = 2,
            sy = 9,
            points = 4,
            is_deadly = false,
            is_poison = false,
            is_unedible = false,
            is_rare = false,
            is_good = true,
        },
        {
            path = "hostmusseron.png",
            name = "Höstmusseron",
            sx = 3,
            sy = 5,
            points = 2,
            is_deadly = false,
            is_poison = false,
            is_unedible = false,
            is_rare = false,
            is_good = true,
        },
        {
            path = "sammetssopp.png",
            name = "Sammetssopp",
            sx = 2,
            sy = 5,
            points = 3,
            is_deadly = false,
            is_poison = false,
            is_unedible = false,
            is_rare = false,
            is_good = true,
        },
        {
            path = "toppmurkla.png",
            name = "Toppmurkla",
            sx = 2,
            sy = 10,
            points = 4,
            is_deadly = false,
            is_poison = false,
            is_unedible = false,
            is_rare = false,
            is_good = true,
        },
        {
            path = "smorsopp.png",
            name = "Smörsopp",
            sx = 2,
            sy = 4,
            points = 3,
            is_deadly = false,
            is_poison = false,
            is_unedible = false,
            is_rare = false,
            is_good = true,
        },
        {
            path = "ametistskivling.png",
            name = "Ametistskivling",
            sx = 2,
            sy = 4,
            points = 3,
            is_deadly = false,
            is_poison = true,
            is_unedible = false,
            is_rare = false,
            is_good = false,
        },
        {
            path = "arg_gron_kragskivling.png",
            name = "Ärggrön kragskivling",
            sx = 2,
            sy = 4,
            points = 3,
            is_deadly = false,
            is_poison = false,
            is_unedible = true,
            is_rare = false,
            is_good = false,
        },
        {
            path = "blodhatta.png",
            name = "Blodhätta",
            sx = 2,
            sy = 4,
            points = 3,
            is_deadly = false,
            is_poison = false,
            is_unedible = true,
            is_rare = false,
            is_good = false,
        },
        {
            path = "blodsopp.png",
            name = "Blodsopp",
            sx = 2,
            sy = 4,
            points = 4,
            is_deadly = false,
            is_poison = false,
            is_unedible = false,
            is_rare = false,
            is_good = true,
        },
        {
            path = "blodvax_skivling.png",
            name = "Blodvaxskivling",
            sx = 2,
            sy = 4,
            points = 3,
            is_deadly = false,
            is_poison = false,
            is_unedible = false,
            is_rare = false,
            is_good = true,
        },
        {
            path = "bombmurkla.png",
            name = "Bombmurkla",
            sx = 2,
            sy = 4,
            points = 3,
            is_deadly = false,
            is_poison = false,
            is_unedible = false,
            is_rare = true,
            is_good = false,
        },
        {
            path = "eldsop.png",
            name = "Eldsopp",
            sx = 2,
            sy = 4,
            points = 2,
            is_deadly = false,
            is_poison = false,
            is_unedible = false,
            is_rare = false,
            is_good = true,
        },
        {
            path = "goliatmusseron.png",
            name = "Goliatmusseron",
            sx = 2,
            sy = 4,
            points = 5,
            is_deadly = false,
            is_poison = false,
            is_unedible = false,
            is_rare = false,
            is_good = true,
        },
        {
            path = "grafotad_flugsvamp.png",
            name = "Gråfotad flugsvamp",
            sx = 2,
            sy = 4,
            points = 3,
            is_deadly = false,
            is_poison = false,
            is_unedible = true,
            is_rare = false,
            is_good = false,
        },
        {
            path = "lovviolspindling.png",
            name = "Lövviolspindling",
            sx = 2,
            sy = 4,
            points = 3,
            is_deadly = false,
            is_poison = false,
            is_unedible = true,
            is_rare = false,
            is_good = false,
        },
        {
            path = "prickmusseron.png",
            name = "Prickmusseron",
            sx = 2,
            sy = 4,
            points = 3,
            is_deadly = false,
            is_poison = false,
            is_unedible = true,
            is_rare = false,
            is_good = false,
        },
        {
            path = "rabarber_svamp.png",
            name = "Rabarbersvamp",
            sx = 2,
            sy = 4,
            points = 3,
            is_deadly = false,
            is_poison = false,
            is_unedible = true,
            is_rare = false,
            is_good = false,
        },
        {
            path = "rattigmusseron.png",
            name = "Rättigmusseron",
            sx = 2,
            sy = 4,
            points = 3,
            is_deadly = false,
            is_poison = false,
            is_unedible = true,
            is_rare = false,
            is_good = false,
        },
        {
            path = "rodbrun_stensopp.png",
            name = "Rödbrun stensopp",
            sx = 2,
            sy = 4,
            points = 5,
            is_deadly = false,
            is_poison = false,
            is_unedible = false,
            is_rare = false,
            is_good = true,
        },
        {
            path = "sammetsfotad_pluggskivling.png",
            name = "Sammetsfotad pluggskivling",
            sx = 2,
            sy = 4,
            points = 3,
            is_deadly = false,
            is_poison = false,
            is_unedible = true,
            is_rare = false,
            is_good = false,
        },
        {
            path = "scharlakans_vaxskivling.png",
            name = "Scharlakansvaxskivling",
            sx = 2,
            sy = 4,
            points = 3,
            is_deadly = false,
            is_poison = false,
            is_unedible = false,
            is_rare = false,
            is_good = true,
        },
        {
            path = "sprod_vaxskivling.png",
            name = "Spröd vaxskivling",
            sx = 2,
            sy = 4,
            points = 3,
            is_deadly = false,
            is_poison = false,
            is_unedible = false,
            is_rare = false,
            is_good = true,
        },
        {
            path = "svavelmusseron.png",
            name = "Svavelmusseron",
            sx = 2,
            sy = 4,
            points = 3,
            is_deadly = false,
            is_poison = true,
            is_unedible = false,
            is_rare = false,
            is_good = false,
        },
    }
    --shuffleTable(mushrooms)
    local index = math.random(#mushrooms)
    local scale_variant = 1

    local obj = {
        sprite = CreateSprite(mushrooms[index].path),
        xpos = x,
        ypos = y,
        z_index = z,
        id = math.random(0, 9999999),
        flip = math.random(0, 1),
        scale_x = mushrooms[index].sx * scale_variant,
        scale_y = mushrooms[index].sy * scale_variant,
        on_click = nil,
        on_timeout = nil,
        has_been_clicked = false,
        ttl = math.random(10, 15),
        time = 0.0,
        disabled = false,
        opacity = 0.0,
        direction = 1,
        handle = mushrooms[index],
        is_selected = false,
        index = index,
        spawner = s,
    }
    setmetatable(obj, self)
    self.__index = self
    return obj
end

--[[
function Mushroom:on_click()

    local retval = nil

    if #mushrooms_clicked == 1 then
        retval = mushrooms_clicked[1]
        for k = 1, #mushrooms_clicked do
            mushrooms_clicked[k] = nil
        end
    end

    else
        for k = 1, #mushrooms_clicked do
            if k < #mushrooms_clicked then
                local ax = GetPosition(mushrooms_clicked[k].sprite):x()
                local bx = GetPosition(mushrooms_clicked[k + 1].sprite):x()
                local ay = GetPosition(mushrooms_clicked[k].sprite):y()
                local by = GetPosition(mushrooms_clicked[k + 1].sprite):y()
                local dist_a = calculateDistance(ax, ay, mousePosition:x(), height - mousePosition:y())
                local dist_b = calculateDistance(bx, by, mousePosition:x(), height - mousePosition:y())
                if (dist_a <= dist_b) then
                    retval = mushrooms_clicked[k]
                else
                    retval = mushrooms_clicked[k + 1]
                end
            end
        end
        for k = 1, #mushrooms_clicked do
            mushrooms_clicked[k] = nil
        end
    end
    return clicked_mushroom
end
    --]]

function Mushroom:update(delta_time, width, height)
    self.time = self.time + 1

    if self.time >= ((self.ttl - 1) * 60) then
        --self:on_timeout(self)
        self.time = 0.0
    end

    local image_xscale = width / (100 / self.scale_x)
    local image_yscale = height / (100 / self.scale_y)

    -- Calculate pivot offset for bottom-center
    local pivotX = image_xscale -- Center of the sprite in X
    local pivotY = image_yscale -- Bottom of the sprite in Y

    -- Add pivot offset to position
    local finalPositionX = width * (self.xpos / 100) + pivotX
    local finalPositionY = height * ((self.ypos + 2) / 100) + pivotY

    Scale(self.sprite, image_xscale, image_yscale, 0)
    Translate(self.sprite, finalPositionX, finalPositionY, self.z_index)
    SetColor(self.sprite, 1.0, 1.0, 1.0, self.opacity)

    if self.opacity < 1.0 and self.direction == 1 then
        self.opacity = self.opacity + 0.08
    end

    if self.opacity > 0.4 and self.direction == 0 then
        self.opacity = self.opacity - 0.08
    end

    --Rotate(self.sprite, 0, 0, 1.0, 180)

    local mouse = GetMouse()
    local mousePosition = mouse:GetPosition()

    if (mousePosition:x() >= (finalPositionX - image_xscale) and
            mousePosition:x() <= (finalPositionX + image_xscale) and
            (height - mousePosition:y()) >= (finalPositionY - image_yscale) and
            (height - mousePosition:y()) <= (finalPositionY + image_yscale)

        ) then
        if self.disabled == false then
            self.has_been_clicked = true
        end
    else
        if self.has_been_clicked then
            --table.insert(clicked_mushrooms, self)
            self.is_selected = true
            self.has_been_clicked = false
        end
    end
end

return Mushroom
