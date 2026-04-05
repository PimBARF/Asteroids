-- asteroids.lua --
local asteroids = {}
local utils = require("utils")

asteroids.list = {}

local sizes = {
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
        love.graphics.circle("fill", a.x, a.y, sizes[a.size])
    end
end

return asteroids