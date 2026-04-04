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

return utils