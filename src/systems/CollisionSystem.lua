-- 
-- CollisionSystem
-- by Alphonsus
--
-- Required:
--   self.collider = HC.rectangle(self.pos.x, self.pos.y, self.sprite:getWidth(), self.sprite:getHeight())
--   self.collider['parent'] = self
--
--   function Object:onCollision(other, delta) end
--

local CollisionSystem = tiny.processingSystem(class "CollisionSystem")

CollisionSystem.filter = tiny.requireAll("collider", "pos", "onCollision")

function CollisionSystem:init()
end

function CollisionSystem:process(e, dt)
	local pos = e.pos
	local vel = e.movable.velocity
	local col = e.collider

	-- update rotation
	col:setRotation(e.angle)

	-- update position
	col:moveTo(pos.x, pos.y)

	-- check collisions
	for col2, delta in pairs(HC:collisions(col)) do
		col.parent:onCollision(col2.parent, delta)
		-- col2.parent:onCollision(col.parent, delta)
	end

	if col.toRemove then
		HC:remove(col)
	end

	-- if col2.toRemove then
		-- HC:remove(col2)
	-- end
end

function CollisionSystem:onAdd(e)
end

function CollisionSystem:onRemove(e)
end

return CollisionSystem