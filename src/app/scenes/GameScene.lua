local GameScene = class("GameScene",function()
	return display.newScene("GameScene")
end)
local LevelData = require("app.data.LevelData")
local colors = {
	[1]   = cc.c3b(0xf6, 0x7c, 0x5f),
    [2]   = cc.c3b(0xf6, 0x5e, 0x3b),
    [3]   = cc.c3b(0xed, 0xcf, 0x72),
    [4]   = cc.c3b(0xed, 0xcc, 0x61),
}
local LevelConfig ={
	bg = 1,
	game = 2,
	shade = 3,
	btn = 4,
	touch = 5,
	dialog =6,
}
local CUBE_SPACE_LEFT = 20
local CUBE_SPACE_BOTTOM = 150
local CUBE_SPACE = 10
local CUBE_SIZE = (display.width - CUBE_SPACE*3 - 2*CUBE_SPACE_LEFT)/4
local Move_Time = 0.5

function GameScene:ctor()
	self:createBg()
	self:createTouchLayer()
	self:createBottom()
	self:init(LevelData:getCurLevel() or LevelData:getLevel())
end

function GameScene:onEnter()

end

function GameScene:onExit()

end

function GameScene:init(level)
	dump(level)
	self:setMapByLevel(level)
	self:createGame()
end

function GameScene:setMapByLevel(level)
	self.m_map = LevelData:getMap(level)
end 

--创建游戏背景
function GameScene:createBg()
	display.newColorLayer(cc.c4b(0xfa,0xf8,0xef, 255)):addTo(self,LevelConfig["bg"])

	self.m_testTxt = cc.ui.UILabel.new({
		UILabelType = 2,
		text = "test",
		size = 32,
		color = cc.c3b(0,0,0),
		})
	--self.m_testTxt:pos(100,100)
	self.m_testTxt:align(display.CENTER_TOP, display.cx, display.top)
	self.m_testTxt:addTo(self,LevelConfig["btn"])
	--游戏区域所占的部分
	local gameSize= 4*CUBE_SIZE+CUBE_SPACE*3
	--左边
	 cc.LayerColor:create(cc.c4b(0xfa,0xf8,0xef,255),CUBE_SPACE_LEFT,display.height):align(display.LEFT_BOTTOM,0,0):addTo(self,LevelConfig["shade"])
	 --底部
	 cc.LayerColor:create(cc.c4b(0xfa,0xf8,0xef,255),display.width,CUBE_SPACE_BOTTOM):align(display.LEFT_BOTTOM,0,0):addTo(self,LevelConfig["shade"])
	 --上面
	 cc.LayerColor:create(cc.c4b(0xfa,0xf8,0xef,255),display.width,display.height - gameSize - CUBE_SPACE_BOTTOM ):align(display.LEFT_BOTTOM,0,CUBE_SPACE_BOTTOM+4*CUBE_SIZE+CUBE_SPACE*3):addTo(self,LevelConfig["shade"])
	 --右边
	 cc.LayerColor:create(cc.c4b(0xfa,0xf8,0xef,255),CUBE_SPACE_LEFT,CUBE_SPACE_BOTTOM+(CUBE_SIZE+CUBE_SPACE)*5):align(display.LEFT_BOTTOM,CUBE_SPACE_LEFT+CUBE_SIZE*4+CUBE_SPACE*7/2,0):addTo(self,LevelConfig["shade"])
end

function GameScene:createBottom()
	self.m_bottomNode = app:createView("BottomView")
	self.m_bottomNode:pos(0,0)
    self.m_bottomNode:addTo(self,LevelConfig["btn"])
    
    self.m_bottomNode:setLeftButton({
    		images = {
    			normal = "back_normal.png",
    			pressed = "back_press.png"
    		},
    		click = function()
    			g_Director:popScene()
    		end
    	})

    self.m_bottomNode:setRightButton({
    	images = {
    			normal = "help_normal.png",
    			pressed = "help_press.png"
    		},
    		click = function()
    			app:createView("HelpView"):addTo(self,LevelConfig["dialog"])
    		end
    	})
end
--创建步区域
function GameScene:creatStep()
	self.m_stepTxt = cc.ui.UILabel.new({
		  UILabelType = 2,
		  text = "滑动方块开始游戏",
		  color = display.COLOR_BLUE,
		}) 
end


--创建游戏区域
function GameScene:createGame()
	self.m_cubeArr = {}
	for i = 1,4 do
		self.m_cubeArr[i] = {}
		for j = 1,4 do			
			local data = {}
			data.cubeType = self.m_map[j][i]
			data.size = CUBE_SIZE
			self.m_cubeArr[i][j]= app:createView("CubeView",data)
			self.m_cubeArr[i][j]:align(display.LEFT_BOTTOM,(CUBE_SPACE+CUBE_SIZE) * (i-1) + CUBE_SPACE_LEFT,CUBE_SPACE_BOTTOM+(CUBE_SPACE + CUBE_SIZE) * (j-1))
			self.m_cubeArr[i][j]:size(CUBE_SIZE, CUBE_SIZE)
			self.m_cubeArr[i][j]:addTo(self,LevelConfig["game"])		
		end
	end

end

function GameScene:removeGame()
	for i = 1,4 do
		for j = 1, 4 do
			if self.m_cubeArr[i][j] then
				self.m_cubeArr[i][j]:removeSelf()
			end
		end
	end
end
--坐标(i,j)
--cubeType 方块类型
--size 方块大小
function GameScene:createCube(data)	
	local cube = app:createView("CubeView",data)
	cube:align(display.LEFT_BOTTOM,(CUBE_SPACE+CUBE_SIZE) * (data.i-1) + CUBE_SPACE_LEFT,CUBE_SPACE_BOTTOM+(CUBE_SPACE + CUBE_SIZE) * (data.j-1))
	cube:size(CUBE_SIZE, CUBE_SIZE)
	cube:addTo(self,LevelConfig["game"])	
	return cube
end

function GameScene:createTouchLayer()
	self.m_touchLayer = display.newLayer()
	self.m_touchLayer:addTo(self,LevelConfig["game"])
	self.m_touchLayer:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        return self:onTouch(event.name, event.x, event.y)
    end)
end

--触摸区域 (0,0)  (CUBESIZE*4 + CUBESIZE_BOTTOM + CUBESIZE_SPACE*3,CUBESIZE*4 + CUBESIZE_BOTTOM + CUBESIZE_SPACE*3)
function GameScene:onTouch(name,x,y)
	-- body
	--dump({name,x,y})
	if name=='began' then
		if y> CUBE_SIZE*4 + CUBE_SPACE_BOTTOM + CUBE_SPACE*3 then
			return false
		else
			self.m_startX = x
			self.m_startY = y
			return true
		end
	elseif name=='ended' then
		--todo
		self.m_endX = x
		self.m_endY = y
		if self.m_moved then
			--self.m_testTxt:setString(x..','..y)
			self:handleMoved()
		end
		self.m_moved = false
	elseif name=='moved' then
		self.m_moved = true
	end
end

function GameScene:handleMoved()
	if self.m_startY > 0 and self.m_startY < CUBE_SIZE + CUBE_SPACE_BOTTOM + 1/2*CUBE_SPACE then
		if math.abs(self.m_startX - self.m_endX) >= math.abs(self.m_startY - self.m_endY) then
			--dump(self.m_endX - self.m_startX)
			local data = {}
			data.direction = 0
			if self.m_endX - self.m_startX >= 0 then
				--self:moveRow(1)
				data.offset = 1
			else
				-- self:moveRow(-1)
				data.offset = -1
		    end
		    self:addMove(data)
		end
	end
	if self.m_startY > CUBE_SIZE + CUBE_SPACE_BOTTOM + 1/2*CUBE_SPACE  and self.m_startY < 2*CUBE_SIZE + CUBE_SPACE_BOTTOM + 1/2*CUBE_SPACE then
		if math.abs(self.m_startX - self.m_endX) >= math.abs(self.m_startY - self.m_endY) then
			--dump(self.m_endX - self.m_startX)
			local data = {}
			data.direction = 0
			if self.m_endX - self.m_startX >= 0 then
				-- self:moveRow(2)
				data.offset = 2
			else
				-- self:moveRow(-2)
				data.offset = -2
		    end
		    self:addMove(data)
		end
	end
	if self.m_startY > 2*CUBE_SIZE + CUBE_SPACE_BOTTOM + 1/2*CUBE_SPACE and self.m_startY < 3*CUBE_SIZE + CUBE_SPACE_BOTTOM + 1/2*CUBE_SPACE then
		if math.abs(self.m_startX - self.m_endX) >= math.abs(self.m_startY - self.m_endY) then
			--dump(self.m_endX - self.m_startX)
			local data = {}
			data.direction = 0
			if self.m_endX - self.m_startX >= 0 then
				-- self:moveRow(3)
				data.offset = 3
			else
				-- self:moveRow(-3)
				data.offset = -3
			end
			self:addMove(data)
		end
	end
	if self.m_startY > 3*CUBE_SIZE + CUBE_SPACE_BOTTOM + 1/2*CUBE_SPACE and self.m_startY < 4*CUBE_SIZE + CUBE_SPACE_BOTTOM + 1/2*CUBE_SPACE then
		if math.abs(self.m_startX - self.m_endX) >= math.abs(self.m_startY - self.m_endY) then
			local data = {}
			data.direction = 0
			if self.m_endX - self.m_startX >= 0 then
				-- self:moveRow(4)
				data.offset = 4
			else
				-- self:moveRow(-4)
				data.offset = -4
		    end
		    self:addMove(data)
		end
	end

	if self.m_startX > 0 and self.m_startX < CUBE_SIZE + CUBE_SPACE_LEFT + 1/2*CUBE_SPACE then
		if math.abs(self.m_startX - self.m_endX) <= math.abs(self.m_startY - self.m_endY) then
			--dump(self.m_endX - self.m_startX)
			local data = {}
			data.direction = 1
			if self.m_endY - self.m_startY >= 0 then
				-- self:moveCol(1)
				data.offset = 1
			else
				-- self:moveCol(-1)
				data.offset = -1
		    end
		    self:addMove(data)
		end
	end
	if self.m_startX > CUBE_SIZE + CUBE_SPACE_LEFT + 1/2*CUBE_SPACE  and self.m_startX < 2*CUBE_SIZE + CUBE_SPACE_LEFT + 1/2*CUBE_SPACE then
		if math.abs(self.m_startX - self.m_endX) <= math.abs(self.m_startY - self.m_endY) then
			--dump(self.m_endX - self.m_startX)
			local data = {}
			data.direction = 1
			if self.m_endY - self.m_startY >= 0 then
				--self:moveCol(2)
				data.offset = 2
			else
				--self:moveCol(-2)
				data.offset = -2
		    end
		    self:addMove(data)
		end
	end
	if self.m_startX > 2*CUBE_SIZE + CUBE_SPACE_LEFT + 1/2*CUBE_SPACE and self.m_startX < 3*CUBE_SIZE + CUBE_SPACE_LEFT + 1/2*CUBE_SPACE then
		if math.abs(self.m_startX - self.m_endX) <= math.abs(self.m_startY - self.m_endY) then
			--dump(self.m_endX - self.m_startX)
			local data = {}
			data.direction = 1
			if self.m_endY - self.m_startY >= 0 then
				--self:moveCol(3)
				data.offset = 3
			else
				--self:moveCol(-3)
				data.offset = -3
			end
			self:addMove(data)
		end
	end
	if self.m_startX > 3*CUBE_SIZE + CUBE_SPACE_LEFT + 1/2*CUBE_SPACE and self.m_startX < 4*CUBE_SIZE + CUBE_SPACE_LEFT + 1/2*CUBE_SPACE then
		if math.abs(self.m_startX - self.m_endX) <= math.abs(self.m_startY - self.m_endY) then
			local data = {}
			data.direction = 1
			if self.m_endY - self.m_startY >= 0 then
				--self:moveCol(4)
				data.offset = 4
			else
				--self:moveCol(-4)
				data.offset = -4
		    end
		    self:addMove(data)
		end
	end

end

function GameScene:addMove(data)
	if not self.m_moveList then
		self.m_moveList = {}
	end
	table.insert(self.m_moveList,data)
	if not self.m_isRunning then
		self:nextMove()
	end
end

function GameScene:nextMove()
	local data = table.remove(self.m_moveList,1)
	if data then
		if data.direction == 0 then
			self:moveRow(data.offset)
		else
			self:moveCol(data.offset)
		end
	end
end
--列
function GameScene:moveCol(n)
	self.m_isRunning = true
	print('col:'..n)
	if n > 0 then
		--向上移动
		--在n，0的位置生成一个cube 这个和 n,4相同
		local data = {}
		data.size = CUBE_SIZE
		data.cubeType = self.m_cubeArr[n][4]:getColor()
		data.i = n
		data.j = 0
		local tmpCube = self:createCube(data)
		tmpCube:moveBy(Move_Time, 0,CUBE_SIZE+CUBE_SPACE)
		for j = 1,4 do
			transition.execute(self.m_cubeArr[n][j], cc.MoveBy:create(Move_Time,cc.p(0,CUBE_SIZE+CUBE_SPACE)), {
      			delay = 0,
      			onComplete = function()
          			if j == 4 then
          				self.m_cubeArr[n][4]:removeSelf();    			
          				for k = 3,1,-1 do
          					self.m_cubeArr[n][k%5+1] = self.m_cubeArr[n][k%5]
          				end  
          				self.m_cubeArr[n][1] = tmpCube 
          				self.m_isRunning = false  
          				if self:checkGameOver() then
							self:showGameOver()
						else
							self:nextMove()
						end   		       		
          			end
     			end,
	 		})
	 	
	 	end
	else
		--向下移动
		--在n，0的位置生成一个cube 这个和 n,4相同
		local n = math.abs(n)
		print(n)
		local data = {}
		data.size = CUBE_SIZE
		data.cubeType = self.m_cubeArr[n][1]:getColor()
		data.i = n
		data.j = 5
		local tmpCube = self:createCube(data)
		tmpCube:moveBy(Move_Time, 0,-(CUBE_SIZE+CUBE_SPACE))
		for j = 1,4 do
			transition.execute(self.m_cubeArr[n][j], cc.MoveBy:create(Move_Time,cc.p(0,-(CUBE_SIZE+CUBE_SPACE))), {
      			delay = 0,
      			onComplete = function()
          			if j == 4 then
          				self.m_cubeArr[n][1]:removeSelf();    			
          				for k = 1,3 do
          					self.m_cubeArr[n][k%5] = self.m_cubeArr[n][k%5+1]
          				end  
          				self.m_cubeArr[n][4] = tmpCube 
          				self.m_isRunning = false  
          				if self:checkGameOver() then
							self:showGameOver()
						else
							self:nextMove()
						end   		       		   		
          			end

     			end,
	 		})
	 	
	 	end
	end
	
end

--行
function GameScene:moveRow(n)
	print('row:'..n)
	self.m_isRunning = true
	if n > 0 then
		--向右移动
		--在0，n的位置生成一个cube 这个和 n,4相同
		local data = {}
		data.size = CUBE_SIZE
		data.cubeType = self.m_cubeArr[4][n]:getColor()
		data.i = 0
		data.j = n
		local tmpCube = self:createCube(data)
		tmpCube:moveBy(Move_Time,CUBE_SIZE+CUBE_SPACE,0)
		for j = 1,4 do
			transition.execute(self.m_cubeArr[j][n], cc.MoveBy:create(Move_Time,cc.p(CUBE_SIZE+CUBE_SPACE,0)), {
      			delay = 0,
      			onComplete = function()
          			if j == 4 then
          				self.m_cubeArr[4][n]:removeSelf();    			
          				for k = 3,1,-1 do
          					self.m_cubeArr[k%5+1][n] = self.m_cubeArr[k%5][n]
          				end  
          				self.m_cubeArr[1][n] = tmpCube 
          				self.m_isRunning = false  
          				if self:checkGameOver() then
							self:showGameOver()
						else
							self:nextMove()
						end   		       		    		       		
          			end
     			end,
	 		})
	 	
	 	end
	else
		--向左移动
		--在n，0的位置生成一个cube 这个和 n,4相同
		local n = math.abs(n)
		print(n)
		local data = {}
		data.size = CUBE_SIZE
		data.cubeType = self.m_cubeArr[1][n]:getColor()
		data.i = 5
		data.j = n
		local tmpCube = self:createCube(data)
		tmpCube:moveBy(Move_Time,-(CUBE_SIZE+CUBE_SPACE),0)
		for j = 1,4 do
			transition.execute(self.m_cubeArr[j][n], cc.MoveBy:create(Move_Time,cc.p(-(CUBE_SIZE+CUBE_SPACE),0)), {
      			delay = 0,
      			onComplete = function()
          			if j == 4 then
          				self.m_cubeArr[1][n]:removeSelf();    			
          				for k = 1,3 do
          					self.m_cubeArr[k%5][n] = self.m_cubeArr[k%5+1][n]
          				end  
          				self.m_cubeArr[4][n] = tmpCube 
          				self.m_isRunning = false  
          				if self:checkGameOver() then
							self:showGameOver()
						else
							self:nextMove()
						end   		       		    			
          			end
          			
     			end,
	 		})
	 	
	 	end
	end
	
end

---判断游戏是否结束
function GameScene:checkGameOver()
	local tag1 = {};
	local tag2 = {};
	for i = 1,4 do
		tag1[i] = self:compare4Num(self.m_cubeArr[1][i]:getColor(),self.m_cubeArr[2][i]:getColor(), self.m_cubeArr[3][i]:getColor(), self.m_cubeArr[4][i]:getColor())
		tag2[i] = self:compare4Num(self.m_cubeArr[i][1]:getColor(),self.m_cubeArr[i][2]:getColor(), self.m_cubeArr[i][3]:getColor(), self.m_cubeArr[i][4]:getColor())
	end
	return (tag1[1] and tag1[2] and tag1[3] and tag1[4]) or (tag2[1] and tag2[2] and tag2[3] and tag2[4])
end

function GameScene:compare4Num(a,b,c,d)
	if a==b and b==c and c==d then
		return true
	else
		return false
	end
end

function GameScene:showGameOver()
	local dialog = app:createView("DialogView")
	dialog:setOnNextClick(function()
		self:removeGame()
		if LevelData:getCurLevel() + 1 > LevelData:getLevel() then
			LevelData:setLevel(LevelData:getCurLevel() + 1)
		end
		LevelData:setCurLevel(LevelData:getCurLevel() + 1)
		self:init(LevelData:getCurLevel())
		dialog:removeSelf()
	end)
	dialog:setOnRestClick(function()
		self:removeGame()
		self:init(LevelData:getCurLevel())
		dialog:removeSelf()
	end)
	dialog:addTo(self,LevelConfig["dialog"])
end

return GameScene

