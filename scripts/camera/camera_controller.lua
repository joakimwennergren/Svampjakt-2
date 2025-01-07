local CameraController = {}

-- Initialize the CameraController
function CameraController:new(target, offset, smoothness)
    local obj = {
        target = target,                     -- The object the camera follows
        offset = offset or { x = 0, y = 0 }, -- Offset between the camera and the target
        smoothness = smoothness or 0.1,      -- How smoothly the camera follows the target
        position = { x = 0, y = 0 },         -- Initial camera position
    }
    setmetatable(obj, self)
    self.__index = self
    return obj
end

-- Update the camera position
function CameraController:update(deltaTime)
    --if not self.target or not self.target.xPos or not self.target.y then
    --    return
    --end

    -- Calculate the desired position with +1 adjustment
    local desiredX = self.target.xPos + self.offset.x + 1
    --local desiredY = self.target.y + self.offset.y + 1

    -- Smoothly move the camera towards the desired position
    self.position.x = self.position.x + (desiredX - self.position.x) * self.smoothness
    --self.position.y = self.position.y + (desiredY - self.position.y) * self.smoothness
end

-- Get the current camera position
function CameraController:getPosition()
    return self.position
end

return CameraController
