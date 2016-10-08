local SpriteSystem = tiny.processingSystem(class "SpriteSystem")

function SpriteSystem:init()
    self.filter = tiny.requireAll("sprite", "pos")
end

function SpriteSystem:postProcess(dt)
    love.graphics.setColor(255, 255, 255, 255)
end

function SpriteSystem:process(e, dt)
    if e.visible == false then
        return
    end

    local an = e.animation

    local alpha = e.alpha or 1
    local pos, sprite, scale, rot, offset = e.pos, e.sprite, e.scale, e.angle, e.offset
    local sx, sy, r, ox, oy = scale and scale.x or 1, scale and scale.y or 1, rot or 0, offset and offset.x or 0, offset and offset.y or 0
    love.graphics.setColor(255, 255, 255, math.max(0, math.min(1, alpha)) * 255)

    if an then
        -- love.graphics.setShader(whiteShader)
        love.graphics.setColor(254,254,254,254)
        an.flippedH = e.flippedH or false
        an:update(dt)
        an:draw(sprite, pos.x, pos.y, r, sx, sy, ox, oy)
        -- love.graphics.setShader()

    elseif sprite then
        love.graphics.draw(sprite, pos.x, pos.y, r, sx, sy, ox, oy)
    end

    if e.draw then
        e:draw(dt)
    end
end

return SpriteSystem
