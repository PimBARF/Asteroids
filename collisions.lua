-- collisions.lua --
local player = require("player")
local bullets = require("bullets")
local asteroids = require("asteroids")
local utils = require("utils")

local collisions = {}

function collisions.check()
    -- Bullet vs Asteroid
    for i = #bullets.list, 1, -1 do
        local b = bullets.list[i]
        for j = #asteroids.list, 1, -1 do
            local a = asteroids.list[j]
            if utils.isColliding(b, a) then
                table.remove(bullets.list, i)
                asteroids:split(a, j)
                break
            end
        end
    end

    -- Player vs Asteroid
    for i = #asteroids.list, 1, -1 do
        local a = asteroids.list[i]
        if utils.isColliding(player, a) then
            -- player loses life
        end
    end
end

return collisions