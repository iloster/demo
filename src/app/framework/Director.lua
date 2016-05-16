local Director = class("Director")

function Director:ctor()
	self.m_scenes = {}
end

function Director:runWithScene(scene)
	local nowScene = display.getRunningScene().name
	if scene and nowScene then
		table.insert(self.m_scenes,nowScene)
	end
	dump(self.m_scenes)
	app:enterScene(scene)
end

function Director:popScene()
	local scene = self.m_scenes[#self.m_scenes]
	if scene then
		table.remove(self.m_scenes,#self.m_scenes)
		app:enterScene(scene)
	end

end

function Director:dtor()

end

return Director