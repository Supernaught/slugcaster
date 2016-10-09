local assets = {}

love.graphics.setDefaultFilter("nearest", "nearest")

-- Images
assets.player = love.graphics.newImage("assets/player.png")
assets.bullet = love.graphics.newImage("assets/bullet.png")
assets.enemy = love.graphics.newImage("assets/enemy.png")
assets.enemy_bullet = love.graphics.newImage("assets/enemy_bullet.png")
assets.shells = love.graphics.newImage("assets/bullet_shell.png")
assets.explosion = love.graphics.newImage("assets/explosion.png")
assets.smoke = love.graphics.newImage("assets/smoke.png")
assets.title = love.graphics.newImage("assets/title.png")
assets.level = love.graphics.newImage("assets/level.png")
assets.level160 = love.graphics.newImage("assets/level_160.png")

assets.bg = love.graphics.newImage("assets/bg.png")
assets.bg2 = love.graphics.newImage("assets/bg2.png")

assets.skull = love.graphics.newImage("assets/skull.png")
assets.brood_jellyfish = love.graphics.newImage("assets/brood_jellyfish.png")
assets.jellyfish = love.graphics.newImage("assets/jellyfish.png")
assets.water = love.graphics.newImage("assets/water_spritesheet.png")
assets.splash = love.graphics.newImage("assets/splash.png")

-- SFX
assets.bullet_sfx_decoder = love.sound.newDecoder("assets/sfx/bullet_sfx.wav")
assets.bullet_sfx = love.audio.newSource(assets.bullet_sfx_decoder)

assets.explode_sfx_decoder = love.sound.newDecoder("assets/sfx/explode_sfx.wav")
assets.explode_sfx = love.audio.newSource(assets.explode_sfx_decoder)

assets.boost_sfx_decoder = love.sound.newDecoder("assets/sfx/boost_sfx.wav")
assets.boost_sfx = love.audio.newSource(assets.boost_sfx_decoder)

--
assets.font_lg = love.graphics.newFont("assets/press_start.ttf", 24)
assets.font_md = love.graphics.newFont("assets/press_start.ttf", 16)
assets.font_sm = love.graphics.newFont("assets/press_start.ttf", 8)

assets.alt_font_lg = love.graphics.newFont("assets/04b03.ttf", 24)
assets.alt_font_md = love.graphics.newFont("assets/04b03.ttf", 16)
assets.alt_font_sm = love.graphics.newFont("assets/04b03.ttf", 8)

-- Shaders
assets.lamp = love.graphics.newShader("assets/lamp.fs")
assets.spark_shader = love.graphics.newShader("assets/spark.fs")

return assets
