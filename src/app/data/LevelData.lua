local LevelData = class()
local NativeData = require("app.data.NativeData")

function LevelData:getLevel()
	return NativeData:getValeForKey("level","int",1)
end

function LevelData:setLevel(level)
	NativeData:saveValeForKey("level",level,"int")
end

return LevelData