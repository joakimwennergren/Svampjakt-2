local GameManager = require("game_manager")
local game_manager = GameManager:new()

function OnRender(delta_time, width, height)
    game_manager:update(delta_time, width, height)
end
