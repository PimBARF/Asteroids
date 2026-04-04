-- main.lua --
local player = require("player")
local bullets = require("bullets")

function love.load()
    player:load()
end

function love.update(dt)
    player:update(dt)
    bullets:update(dt)
end

function love.draw()
    player:draw()
    bullets:draw()
end