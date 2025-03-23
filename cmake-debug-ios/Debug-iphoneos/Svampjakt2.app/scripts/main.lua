--local GameManager = require("game_manager")
--local game_manager = GameManager:new()

test = CreateSprite("gameover.png")
function OnRender(delta_time, width, height)
    --game_manager:update(delta_time, width, height)
    Translate(test, 100, 100, 1.0)
    Scale(test, 1000, 1000, 1.0)
end
