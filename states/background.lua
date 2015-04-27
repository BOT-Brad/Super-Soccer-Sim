local bg = {}
bg.name = "Background"

function bg:init()
	self.__z = 0
	self.image = g.image.new("bg/2.jpg")
	--
	g.console:log("background:init")
end

function bg:added()

end

function bg:update(dt)

end

function bg:draw()
	love.graphics.setColor(123, 123, 123, 255)
	g.image.draw(self.image)
end

return bg