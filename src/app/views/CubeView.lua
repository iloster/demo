local CubeView = class("CubeView",function()
	return display.newNode()
end)

local cubeImgs = {
	[1] = "blue.png",
	[2] = "green.png",
	[3] = "yellow.png",
	[4] = "red.png",
}
function CubeView:ctor(data)
	self.m_data = data
	self.m_cube = display.newSprite(cubeImgs[data.cubeType])
	self.m_cube:align(display.BOTTOM_LEFT, 0, 0)
	self.m_cube:scale(0.75)
	self.m_cube:addTo(self)

end

function CubeView:getSize()
	return self.m_cube:getContentSize()
end
function CubeView:getColor()
	return self.m_data.cubeType
end
return CubeView