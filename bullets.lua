-- bullets.lua --
local bullets = {}
local utils = require("utils")

bullets.list = {}

-- Spawn a bullet (insert it into bullets.list)
function bullets:spawn(x, y, angle)
    local b = {
        x = x,
        y = y,
        angle = angle,
        vx = math.cos(angle) * 500,
        vy = math.sin(angle) * 500,
        life = 1.5 -- seconds
    }
    table.insert(self.list, b)
end

function bullets:update(dt)
    for i = #self.list, 1, -1 do
        local b = self.list[i]
        b.x = b.x + b.vx * dt
        b.y = b.y + b.vy * dt
        b.life = b.life - dt

        -- Wrap bullets
        utils.wrap(b)

        -- Remove bullet if its life is over
        if b.life <= 0 then
            table.remove(self.list, i)
        end
    end
end

function bullets:draw()
    for _, b in ipairs(self.list) do
        love.graphics.circle("fill", b.x, b.y, 2)
    end
end

return bullets