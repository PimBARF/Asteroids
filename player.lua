---- player.lua ----
-- Declare player
local player = {}

local screenWidth = love.graphics.getWidth()
local screenHeight = love.graphics.getHeight()

function player:load()
    self.x = screenWidth / 2
    self.y = screenHeight / 2
    self.angle = 0
    self.shape = {20, 0, -10, -10, -10, 10}
    self.vx = 0
    self.vy = 0
    self.speed = 100
end

function player:update(dt)
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
    if self.x < 0 then
        self.x = screenWidth
    elseif self.x > screenWidth then
        self.x = 0
    end
    if self.y < 0 then
        self.y = screenHeight
    elseif self.y > screenHeight then
        self.y = 0
    end
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