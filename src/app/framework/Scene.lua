local Scene = class("Scene",function()
	return display.newScene("name")
end)

function Scene:ctor()
	error("subClass must extend this function")
end

function Scene:dtor()
	error("subClass must extend this function")
end

return Scene