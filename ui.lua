-- ui.lua --
local ui = {}

local player = require("player")

-- Make fonts
local bigFont = love.graphics.newFont(36)
local mediumFont = love.graphics.newFont(18)
local smallFont = love.graphics.newFont(12)

-- Get screen size
local screenWidth, screenHeight = love.graphics.getDimensions()

-- Draw the menu when first starting the game
function ui:drawMenu()
    love.graphics.setFont(bigFont)
    love.graphics.printf("ASTEROIDS", 0, 20, screenWidth, "center")
    love.graphics.setFont(mediumFont)
    love.graphics.printf("Press ENTER to start", 0, screenHeight / 2, screenWidth, "center")
    love.graphics.setFont(smallFont)
    love.graphics.printf("Created by Pim Jong", 0, screenHeight - 30, screenWidth, "center")
end

-- Draw the HUD during the game
function ui:drawHUD()
    love.graphics.setFont(smallFont)
    love.graphics.print("Lives: " .. player.lives, 0, 0)
end

-- Draw the Game Over screen
function ui:drawGameOver()
    love.graphics.setFont(bigFont)
    love.graphics.printf("GAME OVER", 0, screenHeight / 2 - 50, screenWidth, "center")
    love.graphics.setFont(mediumFont)
    love.graphics.printf("Press ENTER to restart", 0, screenHeight / 2 + 20, screenWidth, "center")
end

return ui