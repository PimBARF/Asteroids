-- main.lua --
local player = require("player")
local bullets = require("bullets")
local asteroids = require("asteroids")
local utils = require("utils")

local asteroidSizes = {
    [1] = 10,
    [2] = 20,
    [3] = 30
}

function love.load()
    player:load()
    asteroids:spawn(50, 20, 1, 100, 3)
    asteroids:spawn(200, 150, 0.5, 120, 2)
    asteroids:spawn(700, 500, 2, 200, 1)
end

function love.update(dt)
    player:update(dt)
    bullets:update(dt)
    asteroids:update(dt)

    -- Collision checking
    for i = #bullets.list, 1, -1 do
        local b = bullets.list[i]
        for j = #asteroids.list, 1, -1 do
            local a = asteroids.list[j]

            -- Calculate distance between bullet and asteroid center
            local dist = utils.distance(b.x, b.y, a.x, a.y)

            -- If the distance is smaller then the bullet + asteroid radius
            if dist < (2 + asteroidSizes[a.size]) then
                -- Remove the bullet
                table.remove(bullets.list, i)
                -- Decrease the asteroid size
                a.size = a.size - 1
                -- If the size is 0 remove the asteroid
                if a.size <= 0 then
                    table.remove(asteroids.list, j)
                end
                break
            end
        end
    end
end

function love.draw()
    player:draw()
    bullets:draw()
    asteroids:draw()
end