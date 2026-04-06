-- main.lua --
local player = require("player")
local bullets = require("bullets")
local asteroids = require("asteroids")
local collisions = require("collisions")
local ui = require("ui")

local gameState = "menu"

function love.load()
    player:load()
end

function love.update(dt)
    if gameState == "playing" then
        -- Game is playing
        player:update(dt)
        bullets:update(dt)
        asteroids:update(dt)
        collisions.check()

        -- No more lives, set game to gameover
        if player.lives <= 0 then
            gameState = "gameover"
        end
    
    elseif gameState == "menu" or gameState == "gameover" then
        -- Check and start game on ENTER key
        if love.keyboard.isDown("return") then
            resetGame()
            gameState = "playing"
        end
    end
end

function love.draw()
    if gameState == "menu" then
        ui:drawMenu()
    elseif gameState == "playing" then
        player:draw()
        bullets:draw()
        asteroids:draw()
        ui:drawHUD()
    elseif gameState == "gameover" then
        ui:drawGameOver()
    end
end

function resetGame()
    score = 0
    player:load() -- reset player
    bullets.list = {} -- reset bullets
    asteroids.list = {} -- reset asteroids

    -- Spawn placeholder asteroids until spawn function is made
    asteroids:spawn(50, 20, 1, 100, 3)
    asteroids:spawn(200, 150, 0.5, 120, 2)
    asteroids:spawn(700, 500, 2, 200, 1)
end