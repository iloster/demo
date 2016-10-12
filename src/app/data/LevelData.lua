local LevelData = class()
local NativeData = require("app.data.NativeData")
local OrgMap = {
	[1] = {1,1,1,1},
	[2] = {2,2,2,2},
	[3] = {3,3,3,3},
	[4] = {4,4,4,4},
}

-- 获取当前已经完成的level
function LevelData:getLevel()
	return NativeData:getValeForKey("level","int",1)
end

function LevelData:setLevel(level)
	NativeData:saveValeForKey("level",level,"int")
end

-- 完成每个level所用的步数
function LevelData:setStep(level,step)
	if self:getStep(level) == 0 or step<self:getStep(level) then
		NativeData:saveValeForKey("level_step_"..level,step,"int")
	end  
end

function LevelData:getStep(level)
	return NativeData:getValeForKey("level_step_"..level,"int",0)
end

function LevelData:setCurLevel(level)
	self.m_curLevel = level
end

function LevelData:getCurLevel()
	return self.m_curLevel
end

function LevelData:createMap(level)

	local tmpMap = clone(OrgMap)
	for i = 1,level do
		if i%2 == 0 then
			--上下移动
			math.newrandomseed(os.time())
			tmpMap = self:moveMapRow(tmpMap,math.random(1,4))
		else
			--左右移动
			math.newrandomseed(os.time())
			tmpMap = self:moveMapCol(tmpMap,math.random(1,4))
		end
	end
	-- NativeData:saveValeForKey("level_map_"..level,json.encode(tmpMap),"string")
	return tmpMap
end

function LevelData:setMap(level,map)
	NativeData:saveValeForKey("level_map_"..level,json.encode(map),"string")
end

function LevelData:getMap(level)
	local map = json.decode((NativeData:getValeForKey("level_map_"..level,"string","")))
	if not map then
		map = self:createMap(level)
		self:setMap(level,map)
	end
	return map
end

--左右移动
function LevelData:moveMapRow(data,offset)
	-- print("左右移动")
	local tmp = data[offset][4]
	data[offset][4] = data[offset][3]
	data[offset][3] = data[offset][2]
	data[offset][2] = data[offset][1]
	data[offset][1] = tmp
	return data
end

--上下移动
function LevelData:moveMapCol(data,offset)
	-- print("上下移动")
	local tmp = data[4][offset]
	data[4][offset] = data[3][offset]
	data[3][offset] = data[2][offset]
	data[2][offset] = data[1][offset]
	data[1][offset] = tmp
	return data
end

-- 设置限时模式下的level
function LevelData:setTimeLevel(level)
	NativeData:saveValeForKey("time_level",level,"int")
end

function LevelData:getTimeLevel()
	return NativeData:getValeForKey("time_level","int",1)	
end

function LevelData:setTime(level,time)
	if self:getTime(level) == 0 or time<self:getTime(level) then
		NativeData:saveValeForKey("level_time_"..level,time,"int")
	end  
end

function LevelData:getTime(level)
	return NativeData:getValeForKey("level_time_"..level,"int",0)
end

function LevelData:getTimeMap(level)
	return self:createMap(level)
end

function LevelData:getTotalTime(level)
	if level<=6 then
		return 10*(level-1) + 60
	else
		return 180
	end
end

return LevelData