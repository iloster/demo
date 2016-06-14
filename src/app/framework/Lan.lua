local Lan = class("Lan")

function Lan:ctor()
	if g_System:getLanguage()==kLanCN then
		self.m_lan = require("app.lan.Cn")
	else
		self.m_lan = require("app.lan.En")
	end
end

function Lan:get(key)
	return self.m_lan[key]
end

return Lan
