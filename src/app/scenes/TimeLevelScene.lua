local TimeLevelScene = class("TimeLevelScene", Scene)
local LevelData = require("app.data.LevelData")
local AudioConfig = require("app.config.AudioConfig")

function TimeLevelScene:ctor()
	self:createBg();
	self:createLevel();
	self:createBottom();
end

function TimeLevelScene:dtor()

end

function TimeLevelScene:createBg()
	display.newColorLayer(cc.c4b(0xfa,0xf8,0xef, 255)):addTo(self)
	local titleStr = "限时模式"

	cc.ui.UILabel.new({
		UILabelType = 2,
		text = titleStr..'.'..g_Lan:get("LevelScene_ChooseLevel"),
		size = 32,
		color = cc.c3b(0,0, 0) })
	:align(display.CENTER_TOP, display.left+display.width/2, display.top - 170)
	:addTo(self)
end

function TimeLevelScene:createBottom()
	self.m_bottomNode = app:createView("BottomView")
	self.m_bottomNode:pos(0,0)
    self.m_bottomNode:addTo(self)
    
    self.m_bottomNode:setLeftButton({
    		images = {
    			normal = "back_normal.png",
    			pressed = "back_press.png"
    		},
    		click = function()
    			g_Audio:playEffect(AudioConfig.btnClick)
    			g_Director:popScene()
    		end
    	})

    self.m_bottomNode:setRightButton({
    	images = {
    			normal = "help_normal.png",
    			pressed = "help_press.png"
    		},
    		click = function()
    			g_Audio:playEffect(AudioConfig.btnClick)
    			app:createView("HelpView"):addTo(self)
    		end
    	})
end

function TimeLevelScene:createLevel() 
	local levelImages = {
		normal = "circle_normal.png",
		pressed = "circle_press.png",
		disabled ="circle_disable.png",
	}
   local Space = (display.width - 400)/5

   self.m_levelBtn = {}
   self.m_levelLabel={}
   -- 获取限时模式下完成level
   local level = LevelData.getTimeLevel()

   for i = 0,11 do
   		local row = i%4 + 1
   		local col = math.floor(i/4) + 1
   		local x = row * Space + (2*row - 1) * 50
   		local y = display.cy - (4*col -7) *Space + 50
   		--local buttonStatus = ""
		self.m_levelBtn[i+1] = cc.ui.UIPushButton.new(levelImages)
		self.m_levelLabel[i+1] = cc.ui.UILabel.new({
				UILabelType = 2,
				text = "",
				size = 28,
				color = cc.c3b(0,0, 0) })
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
					g_Audio:playEffect(AudioConfig.btnClick)
				 	self:toGameScene(data)
				end)
			-- local step = LevelData:getStep(i+1)
			-- if step == 0 then
		 --    	self.m_levelLabel[i+1]:setString(g_Lan:get("LevelScene_Unfinish"))
		 --    else
		 --    	self.m_levelLabel[i+1]:setString(step..g_Lan:get("LevelScene_Step"))
		 --    end		
		 	local time = LevelData:getTime(i+1)
		 	if time == 0 then
		 		self.m_levelLabel[i+1]:setString(g_Lan:get("LevelScene_Unfinish"))
		 	else
		 		self.m_levelLabel[i+1]:setString(time..'s')
		 	end 	
		else
			self.m_levelBtn[i+1]:setButtonEnabled(false)
			self.m_levelLabel[i+1]:setString(g_Lan:get("LevelScene_Lock"))
		end
		self.m_levelBtn[i+1]:align(display.CENTER, x, y)		
		self.m_levelBtn[i+1]:addTo(self)

		self.m_levelLabel[i+1]:align(display.CENTER_TOP, x, y-Space*1.5)
		self.m_levelLabel[i+1]:addTo(self)

	end
end

function TimeLevelScene:toGameScene()
	print("TimeGameScene")
	g_Director:runWithScene("TimeGameScene")
	
end


return TimeLevelScene;