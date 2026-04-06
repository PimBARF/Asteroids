-- main.lua --
local player = require("player")
local bullets = require("bullets")
local asteroids = require("asteroids")
local collisions = require("collisions")

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
    collisions.check()
end

function love.draw()
    player:draw()
    bullets:draw()
    asteroids:draw()
end