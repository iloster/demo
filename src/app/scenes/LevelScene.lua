local LevelScene = class("LevelScene",function()
		return display.newScene("LevelScene")
end)
local LevelData = require("app.data.LevelData")

function LevelScene:ctor()
	-- body
	
	self:createBg()
	self:createLevel()
	self:createBottom()
end

function LevelScene:onEnter()

end

function LevelScene:onExit()

end

function LevelScene:createBg()
	display.newColorLayer(cc.c4b(0xfa,0xf8,0xef, 255)):addTo(self)

	cc.ui.UILabel.new({
		UILabelType = 2,
		text = "选择游戏关卡",
		size = 32,
		color = cc.c3b(0,0, 0) })
	:align(display.CENTER_TOP, display.left+display.width/2, display.top - 170)
	:addTo(self)
end

function LevelScene:createBottom()
	self.m_bottomNode = app:createView("BottomView")
	self.m_bottomNode:pos(0,0)
    self.m_bottomNode:addTo(self)
    
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
    			app:createView("HelpView"):addTo(self)
    		end
    	})
end

function LevelScene:createLevel() 
	local levelImages = {
		normal = "circle_normal.png",
		pressed = "circle_press.png",
		disabled ="circle_disable.png",
	}
   local Space = (display.width - 400)/5
   self.m_levelBtn = {}
   local level = LevelData.getLevel()

   for i = 0,7 do
   		local row = i%4 + 1
   		local col = math.floor(i/4) + 1
   		local x = row * Space + (2*row - 1) * 50
   		local y = display.cy - (col-1) * Space*2
   		if col == 1 then
   			y = display.cy - (-1) * Space
   		end
   		--local buttonStatus = ""
		self.m_levelBtn[i+1] = cc.ui.UIPushButton.new(levelImages)
		if i<level then
			self.m_levelBtn[i+1]:setButtonLabel("normal", cc.ui.UILabel.new({
					 UILabelType = 2,
					 text = i+1,
					 size = 32,
					 color = cc.c3b(0,0,0)
				}))
			self.m_levelBtn[i+1]:onButtonClicked(function(event)
					--dump(LevelData:getMap(data.level))
					LevelData:setCurLevel(i+1)
				 	self:toGameScene(data)
				end)	
		else
			self.m_levelBtn[i+1]:setButtonEnabled(false)
		end
		self.m_levelBtn[i+1]:align(display.CENTER, x, y)
		
		self.m_levelBtn[i+1]:addTo(self)
	end
end


function LevelScene:toGameScene(data)
	dump(data)
	--app:enterScene("GameScene", {data},"fade", 0.6,display.COLOR_WHITE)
	--app:createView("HelpView"):addTo(self)
	g_Director:runWithScene("GameScene")
end
return LevelScene