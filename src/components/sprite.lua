local Concord = require("modules.concord.concord")

return Concord.component("sprite", function(c, image)
	assert(image:type() == "Image", "'image' must be of type Image")
	c.image = image
end)
