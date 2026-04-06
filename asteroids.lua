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
        local newSpeed = a.speed * 1.3 -- add some speed
        asteroids:spawn(a.x, a.y, a.angle + math.pi/4, newSpeed, newSize)
        asteroids:spawn(a.x, a.y, a.angle - math.pi/4, newSpeed, newSize)
    end
    table.remove(asteroids.list, index)
end

return asteroids