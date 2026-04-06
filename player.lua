-- player.lua --
local player = {}
local bullets = require("bullets")
local utils = require("utils")

local screenWidth = love.graphics.getWidth()
local screenHeight = love.graphics.getHeight()

function player:load()
    self.x = screenWidth / 2
    self.y = screenHeight / 2
    self.angle = 0
    self.shape = {20, 0, -10, -10, -10, 10}
    self.collider = { type = "circle", radius = 15 }
    self.vx = 0
    self.vy = 0
    self.speed = 100
    self.fireTimer = 0
    self.fireRate = 0.5
    self.lives = 3
    self.invincible = 0
end

function player:update(dt)
    self.fireTimer = self.fireTimer - dt
    self.invincible = math.max(0, self.invincible - dt)

    -- Keyboard space for shooting
    if love.keyboard.isDown("space") and self.fireTimer <= 0 then
        bullets:spawn(self.x, self.y, self.angle)
        self.fireTimer = self.fireRate
    end

    -- Keyboard left and right for angle
    if love.keyboard.isDown("left") then
        self.angle = self.angle - 5 * dt
    elseif love.keyboard.isDown("right") then
        self.angle = self.angle + 5 * dt
    end

    -- Keyboard up for movement
    if love.keyboard.isDown("up") then
        self.vx = self.vx + math.cos(self.angle) * self.speed * dt
        self.vy = self.vy + math.sin(self.angle) * self.speed * dt
    end

    -- Apply velocity
    self.x = self.x + self.vx * dt
    self.y = self.y + self.vy * dt

    -- Screen wrapping
    utils.wrap(self)
end

function player:draw()
    -- Draw the player
    love.graphics.push()
        love.graphics.translate(self.x, self.y)
        love.graphics.rotate(self.angle)
        love.graphics.polygon("fill", self.shape)
    love.graphics.pop()
end

return player