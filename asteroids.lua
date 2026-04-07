-- asteroids.lua --
local asteroids = {}
local utils = require("utils")

asteroids.list = {}

asteroids.sizes = {
    [1] = 10,
    [2] = 20,
    [3] = 30
}

-- Spawn an asteroid (insert it into asteroids.list)
function asteroids:spawn(x, y, angle, speed, size)
    local a = {
        x = x,
        y = y,
        angle = angle,
        speed = speed,
        size = size,
        vx = math.cos(angle) * speed,
        vy = math.sin(angle) * speed
    }
    a.collider = { type = "circle", radius = self.sizes[a.size] }
    table.insert(self.list, a)
end

function asteroids:generate(count, playerX, playerY)
    local screenWidth, screenHeight = love.graphics.getDimensions()

    -- Target player OR center of screen if no player position is known
    local targetX = playerX or (screenWidth / 2)
    local targetY = playerY or (screenHeight / 2)

    local safeRadius = 200

    for i = 1, count do
        local x, y
        local isSafe = false

        -- Keep picking a spot until it's far enough from the center
        while not isSafe do
            x = math.random(0, screenWidth)
            y = math.random(0, screenHeight)
            local dist = utils.distance(x, y, targetX, targetY)

            -- If the random distance is farther than the safeRadius, it's safe
            if dist > safeRadius then
                isSafe = true
            end
        end

        -- Calculate a random direction and speed
        local angle = math.random() * math.pi * 2
        local speed = math.random(40, 100)

        -- Spawn the asteroid at size 3
        self:spawn(x, y, angle, speed, 3)
    end
end

function asteroids:update(dt)
    for i = #self.list, 1, -1 do
        local a = self.list[i]
        a.x = a.x + a.vx * dt
        a.y = a.y + a.vy * dt

        -- Wrap asteroids
        utils.wrap(a)
    end
end

function asteroids:draw()
    for _, a in ipairs(self.list) do
        love.graphics.circle("fill", a.x, a.y, self.sizes[a.size])
    end
end

-- Asteroid splitting function
function asteroids:split(a, index)
    if a.size > 1 then
        local newSize = a.size - 1
        local newSpeed = a.speed * 1.1 -- add some speed
        asteroids:spawn(a.x, a.y, a.angle + math.pi/4, newSpeed, newSize)
        asteroids:spawn(a.x, a.y, a.angle - math.pi/4, newSpeed, newSize)
    end
    table.remove(asteroids.list, index)
end

return asteroids