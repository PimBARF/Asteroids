-- collisions.lua --
local player = require("player")
local bullets = require("bullets")
local asteroids = require("asteroids")
local utils = require("utils")

local collisions = {}

function collisions.check()
    local pointsEarned = 0

    -- Bullet vs Asteroid
    for i = #bullets.list, 1, -1 do
        local b = bullets.list[i]
        for j = #asteroids.list, 1, -1 do
            local a = asteroids.list[j]
            if utils.isColliding(b, a) then
                table.remove(bullets.list, i)
                pointsEarned = pointsEarned + 1
                asteroids:split(a, j)
                break
            end
        end
    end

    -- Player vs Asteroid
    for i = #asteroids.list, 1, -1 do
        local a = asteroids.list[i]
        if utils.isColliding(player, a) and player.invincible <= 0 then
            player.lives = player.lives - 1
            player.invincible = 2
            player.x = love.graphics.getWidth() / 2
            player.y = love.graphics.getHeight() / 2
            player.vx = 0
            player.vy = 0
            break
        end
    end

    return pointsEarned
end

return collisions