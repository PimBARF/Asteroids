-- sounds.lua --
local sounds = {}

-- Load the sounds
function sounds:load()
    --self.music = love.audio.newSource("sounds/music.wav", "stream")
    self.shoot = love.audio.newSource("sounds/shoot.wav", "static")
    self.explode = love.audio.newSource("sounds/explode.wav", "static")
    --self.thrust = love.audio.newSource("sounds/thrust.wav", "static")

    -- Set thrust to loop since we hold the button down
    --self.thrust:setLooping(true)
    --self.thrust:setVolume(0.5)
end

-- Play a sound
function sounds:play(name)
    if self[name] then
        self[name]:stop()
        self[name]:play()
    end
end

return sounds