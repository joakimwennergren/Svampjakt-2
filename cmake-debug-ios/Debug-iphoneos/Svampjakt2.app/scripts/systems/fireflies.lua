local Fireflies = {}

function randomFloat(min, max)
    return min + (max - min) * math.random()
end

function Fireflies:new()
    local obj = {
        has_been_initialized = false,
        particles = {},
        should_run = true
    }
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function Fireflies:createParticle(w, h)
    return {
        s = CreateBasicRectangle(),
        x = math.random(0, w),
        y = math.random(0, h),

        radius = math.random(1, 2),
        alpha = randomFloat(0.1, 0.5),
        lifespan = math.random(2, 5),
        decay = randomFloat(0.02, 0.05),

        speedX = math.random(-20, 20) / 10,
        speedY = math.random(-20, 20) / 10,
        flicker = randomFloat(0.5, 1.5),

        time = 0.0
    }
end

function Fireflies:update(delta_time, w, h)
    if not self.has_been_initialized then
        for i = 1, 100 do
            table.insert(self.particles, self:createParticle(w, h))
        end
        self.has_been_initialized = true
    end


    for i = 1, #self.particles do
        local p = self.particles[i]
        p.x = p.x + p.speedX
        p.y = p.y + p.speedY


        if (p.x > w or p.x < 1.0 or p.y > h or p.y < 1.0) then
            Delete(p.s)
            table.remove(self.particles, i)
            table.insert(self.particles, self:createParticle(w, h))
        end

        if self.should_run then
            SetColor(p.s, 1.0, 1.0, 1.0, 0.8)
            Translate(p.s, p.x, p.y, 60.0)
            Scale(p.s, p.radius, p.radius, 0.0)
        else
            SetColor(p.s, 1.0, 1.0, 1.0, 0.0)
            Translate(p.s, p.x, p.y, 60.0)
            Scale(p.s, p.radius, p.radius, 0.0)
        end
    end
end

return Fireflies
