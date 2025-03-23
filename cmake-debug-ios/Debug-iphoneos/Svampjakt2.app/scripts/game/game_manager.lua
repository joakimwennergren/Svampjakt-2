--[[
    GameManager.lua

    This module is responsible for managing the overall game state and coordinating
    different subsystems, such as level management, mushroom spawning, point tracking,
    and visual effects like fireflies. It ensures smooth transitions between game states,
    including starting, updating, and handling game over conditions.

    Responsibilities:
    - Initializes all key game components (LevelManager, MushroomSpawner, StartScreen, etc.).
    - Listens for game start events and updates the game state accordingly.
    - Manages game updates by calling update functions for all subsystems.
    - Handles game-over logic, resetting systems when the game restarts.
    - Controls the start screen transitions and ensures smooth level progression.

    Dependencies:
    - MushroomSpawner: Spawns mushrooms dynamically during gameplay.
    - LevelManager: Controls level progression and loading.
    - StartScreen: Manages the game’s start screen.
    - MushroomInspector: Handles interactions with mushrooms.
    - Fireflies: Manages firefly visual effects.
    - Points: Tracks player score and game-over conditions.
]] --

local MushroomSpawner = require("mushroom_spawner")
local LevelManager = require("level_manager")
local StartScreen = require("startscreen")
local MushroomInspector = require("mushroom_inspector")
local Fireflies = require("fireflies")
local Points = require("points")

local GameManager = {}

function GameManager:new()
    -- Seed the RND generator
    math.randomseed(os.time() + tonumber(tostring(os.clock()):reverse():sub(1, 6)))
    -- Initialize dependencies
    local ps = Points:new()
    local inspector = MushroomInspector:new(ps)
    local level_manager = LevelManager:new()

    local obj = {
        mushroom_spawner   = MushroomSpawner:new(level_manager, inspector),
        firefly_system     = Fireflies:new(),
        start_screen       = StartScreen:new(),
        point_system       = ps,
        level_manager      = level_manager,
        mushroom_inspector = inspector,
        old_gameover       = false,
    }
    obj = {}
    --PlaySound(3)
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
