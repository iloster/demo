local System = class("System")

function System:ctor()

end

--获取平台
function System:getPlatform()
	-- body
	return device.platform
end

function System:getLanguage()
	return device.language
end

function System:getModel()
	return device.model
end
return System