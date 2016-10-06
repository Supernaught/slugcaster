local assets = {}

love.graphics.setDefaultFilter("nearest", "nearest")

-- Images
assets.player = love.graphics.newImage("assets/player.png")
assets.bullet = love.graphics.newImage("assets/bullet.png")
assets.enemy = love.graphics.newImage("assets/enemy.png")
assets.shells = love.graphics.newImage("assets/bullet_shell.png")
assets.explosion = love.graphics.newImage("assets/explosion.png")
assets.smoke = love.graphics.newImage("assets/smoke.png")

-- Fonts
assets.font_lg = love.graphics.newFont("assets/press_start.ttf", 24)
assets.font_md = love.graphics.newFont("assets/press_start.ttf", 16)
assets.font_sm = love.graphics.newFont("assets/press_start.ttf", 8)

assets.alt_font_lg = love.graphics.newFont("assets/04b03.ttf", 24)
assets.alt_font_md = love.graphics.newFont("assets/04b03.ttf", 16)
assets.alt_font_sm = love.graphics.newFont("assets/04b03.ttf", 8)

-- Shaders
assets.lamp = love.graphics.newShader("assets/lamp.fs")

return assets
