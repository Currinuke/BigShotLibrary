local actor, super = Class(Actor, "dummy")

function actor:init()
	super.init(self)

	self.name = "Dummy"

	self.width = 27
	self.height = 45

	self.hitbox = {0, 25, 19, 14}

	self.color = {1, 0, 0}

	self.path = "enemies/dummy"
	self.default = "idle"

	self.animations = {
		["idle"] = {"idle", 0.25, true}
	}

	self.offsets = {
		["idle"] = {0, 0}
	}
end

return actor