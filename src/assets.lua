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
assets.titlesmall = love.graphics.newImage("assets/titlesmall.png")
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
-- assets.bullet_sfx_decoder = love.sound.newDecoder("assets/sfx/shoot1.wav")
assets.bullet_sfx_decoder = love.sound.newDecoder("assets/sfx/bullet_sfx.wav")
assets.bullet_sfx = love.audio.newSource(assets.bullet_sfx_decoder)

assets.boost_sfx_decoder = love.sound.newDecoder("assets/sfx/boost_sfx.wav")
assets.boost_sfx = love.audio.newSource(assets.boost_sfx_decoder)

-- new
assets.explode1_sfx = love.audio.newSource(love.sound.newDecoder("assets/sfx/explode1.wav"))
assets.explode2_sfx = love.audio.newSource(love.sound.newDecoder("assets/sfx/explode2.wav"))
assets.explode3_sfx = love.audio.newSource(love.sound.newDecoder("assets/sfx/explode3.wav"))
assets.death = love.audio.newSource(love.sound.newDecoder("assets/sfx/death.wav"))

assets.hit1_sfx = love.audio.newSource(love.sound.newDecoder("assets/sfx/enemyhit.wav"))

assets.shoot1_sfx = love.audio.newSource(love.sound.newDecoder("assets/sfx/shoot1.wav"))
assets.shoot2_sfx = love.audio.newSource(love.sound.newDecoder("assets/sfx/shoot2.wav"))
assets.shoot3_sfx = love.audio.newSource(love.sound.newDecoder("assets/sfx/shoot3.wav"))

assets.music1 = love.audio.newSource(love.sound.newDecoder("assets/sfx/music1.mp3"))

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
