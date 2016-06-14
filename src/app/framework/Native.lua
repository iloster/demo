--与原生方法调用的接口
local Native = class("Native")

function Native:ctor()

end

--
--eventId
--info
function Native:report(data)
	if g_System:getPlatform() == kPlatformIOS then
		luaoc.callStaticMethod("Report", "eventId",data)
	end
end
return Native;