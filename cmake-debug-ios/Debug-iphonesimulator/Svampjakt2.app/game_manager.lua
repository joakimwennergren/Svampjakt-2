local MushroomSpawner = require("mushroom_spawner")
local LevelManager = require("level_manager")
local StartScreen = require("startscreen")
local MushroomInspector = require("mushroom_inspector")
local Fireflies = require("fireflies")
local Points = require("points")

local GameManager = {}

function GameManager:new()
    math.randomseed(os.time() + tonumber(tostring(os.clock()):reverse():sub(1, 6)))
    local points = Points:new()
    local inspector = MushroomInspector:new(points)
    local level_manager = LevelManager:new()
    local start_screen = StartScreen:new()

    local obj = {
        level_manager      = level_manager,
        start_screen       = start_screen,
        mushroom_spawner   = MushroomSpawner:new(level_manager, inspector),
        firefly_system     = Fireflies:new(),
        point_system       = points,
        mushroom_inspector = inspector,
        old_gameover       = false,
    }
    PlaySound(3)
    obj.start_screen.on_start = self.on_start
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function GameManager:on_start(start_screen)
    start_screen:set_active(false)
end

function GameManager:update(delta_time, width, height)
    self.start_screen:update(delta_time, width, height)
    self.level_manager:update(delta_time, width, height)
    self.mushroom_spawner:update(delta_time, width, height)
    self.mushroom_inspector:update(delta_time, width, height)

    if self.point_system.is_gameover then
        self.level_manager:set_level(-1)
        self.mushroom_spawner:stop()
        self.firefly_system.should_run = false
        self.old_gameover = true
    end

    if self.old_gameover == true and self.point_system.is_gameover == false then
        self.start_screen.opacity            = 1.0
        self.start_screen.transition_done    = false
        self.start_screen.active             = true
        self.level_manager.has_loaded_level1 = false
        self.point_system.points             = 0
        self.mushroom_spawner.has_init       = false
        self.mushroom_spawner.should_spawn   = true
        self.point_system.has_gameovered     = false
        self.firefly_system.should_run       = true
        self.old_gameover                    = false
    end

    if self.start_screen.transition_done then
        self.level_manager:set_level(1)
        self.mushroom_spawner:init()
        self.firefly_system:update(delta_time, width, height)
        self.point_system:update(delta_time, width, height)
    end
end

return GameManager
