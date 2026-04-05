-- asteroids.lua --
local asteroids = {}
local bullets = require("bullets")
local utils = require("utils")

asteroids.list = {}

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
        if a.size == 3 then
            love.graphics.circle("fill", a.x, a.y, 30)
        elseif a.size == 2 then
            love.graphics.circle("fill", a.x, a.y, 20)
        elseif a.size == 1 then
            love.graphics.circle("fill", a.x, a.y, 10)
        end
    end
end

return asteroids