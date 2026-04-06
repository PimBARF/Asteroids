-- utils.lua --
local utils = {}

-- Screen wrapping function
-- Takes any object's x and y and wrap it
function utils.wrap(obj)
    local width = love.graphics.getWidth()
    local height = love.graphics.getHeight()

    -- Horizontal wrapping
    if obj.x < 0 then
        obj.x = width
    elseif obj.x > width then
        obj.x = 0
    end

    -- Vertical wrapping
    if obj.y < 0 then
        obj.y = height
    elseif obj.y > height then
        obj.y = 0
    end
end

-- Pythagorean distance calculation function
function utils.distance(x1, y1, x2, y2)
    return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end

-- Check for collisions
function utils.isColliding(objA, objB)
    local cA = objA.collider
    local cB = objB.collider

    -- Circle vs circle
    if cA.type == "circle" and cB.type == "circle" then
        return utils.circleToCircle(objA.x, objA.y, cA.radius, objB.x, objB.y, cB.radius)

    end
end

-- Circle collision function
function utils.circleToCircle(x1, y1, r1, x2, y2, r2)
    local dx, dy = x1 - x2, y1 - y2
    local distance = math.sqrt(dx*dx + dy*dy)
    return distance < (r1 + r2)
end

-- Rectangle (AABB) collision function
function utils.rectToRect(x1, y1, w1, h1, x2, y2, w2, h2)
    return x1 < x2 + w2 and
           x2 < x1 + w1 and
           y1 < y2 + h2 and
           y2 < y1 + h1
end

return utils