-- bullets.lua --
local bullets = {}
local utils = require("utils")
local sounds = require("sounds")

bullets.list = {}

-- Spawn a bullet (insert it into bullets.list)
function bullets:spawn(x, y, angle, shipVx, shipVy)
    local bulletSpeed = 600
    local b = {
        x = x,
        y = y,
        angle = angle,
        vx = shipVx + math.cos(angle) * bulletSpeed,
        vy = shipVy + math.sin(angle) * bulletSpeed,
        life = 1.5 -- seconds
    }
    b.collider = { type = "circle", radius = 2 }
    table.insert(self.list, b)
    sounds:play("shoot")
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