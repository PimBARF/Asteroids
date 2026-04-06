-- main.lua --
local player = require("player")
local bullets = require("bullets")
local asteroids = require("asteroids")
local collisions = require("collisions")
local ui = require("ui")
local sounds = require("sounds")

local gameState = "menu"
local score = 0

local function resetGame()
    score = 0
    player:load() -- reset player
    bullets.list = {} -- reset bullets
    asteroids.list = {} -- reset asteroids

    -- Generate 3 asteroids
    asteroids:generate(3, player.x, player.y)
end

function love.load()
    math.randomseed(os.time())
    player:load()
    sounds:load()
end

function love.update(dt)
    if gameState == "playing" then
        -- Game is playing
        player:update(dt)
        bullets:update(dt)
        asteroids:update(dt)
        local points = collisions.check()
        score = score + points

        -- If all asteroids are gone, generate new asteroids
        if #asteroids.list == 0 then
            -- Generate minimum of 3 asteroids based on score
            local count = (score / 20) + 3
            asteroids:generate(count, player.x, player.y)
        end

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
        ui:drawHUD(score)
    elseif gameState == "gameover" then
        ui:drawGameOver(score)
    end
end
