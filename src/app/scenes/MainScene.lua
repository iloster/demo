
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)
local LevelData = require("app.data.LevelData")
local AudioConfig = require("app.config.AudioConfig")
local LevelConfig = {
	bg  = 1,
	btn = 2,
	dialog = 3,
}
function MainScene:ctor()
    -- cc.ui.UILabel.new({
    --         UILabelType = 2, text = "Hello, World", size = 64})
    --     :align(display.CENTER, display.cx, display.cy)
    --     :addTo(self)

    --创建一个背景
    self:createBg()
    self:createBtn()
    self:createBottom()

end

function MainScene:onEnter()

end

function MainScene:onExit()

end


--创建一个背景
function MainScene:createBg()
	display.newColorLayer(cc.c4b(0xfa,0xf8,0xef,255)):addTo(self,LevelConfig["bg"])
end

--创建按钮
function MainScene:createBtn()
	--创建游戏名label
	cc.ui.UILabel.new({
		UILabelType = 2,
		text = g_Lan:get("MainScene_Title"),
		size = 32,
		color = cc.c3b(0,0, 0) })
	:align(display.CENTER_TOP, display.left+display.width/2, display.top*7/8)
	:addTo(self,LevelConfig["btn"])

	--创建游戏版本号label
	-- cc.ui.UILabel.new({
	-- 	UILabelType = 2,
	-- 	text = "Version 1.0.0",
	-- 	size = 28,
	-- 	color = cc.c3b(0,0,0)
	-- 	})
	-- :align(display.CENTER_BOTTOM, display.cx, display.bottom)
	-- :addTo(self,LevelConfig["btn"])

	local btnImages = {
		normal = "btn.png",
		pressed = "btn_press.png",
		disabled = "GreenButton.png",
	}

	cc.ui.UIPushButton.new(btnImages)
		--:setButtonSize(250,90)
		:setButtonLabel("normal", cc.ui.UILabel.new({
			 UILabelType = 2,
			 text = g_Lan:get("MainScene_QuickGame"),
			 size = 32,
			 color=cc.c3b(0,0,0)
		}))
		:align(display.CENTER, display.cx, display.cy+120)
		:onButtonClicked(function(event)
				g_Audio:playEffect(AudioConfig.btnClick)
				local data = {}
				data.eventId = "Btn_QuickGame"
				g_Native:report(data)
				self:toGameScene()
			end)	
		:addTo(self,LevelConfig["btn"])

	cc.ui.UIPushButton.new(btnImages)
		--:setButtonSize(250,90)
		:setButtonLabel("normal", cc.ui.UILabel.new({
			 UILabelType = 2,
			 text = g_Lan:get("MainScene_ChooseLevel"),
			 size = 32,
			 color=cc.c3b(0,0,0)
		}))
		:align(display.CENTER, display.cx, display.cy-80)
		:onButtonClicked(function(event)
				g_Audio:playEffect(AudioConfig.btnClick)
				local data = {}
				data.eventId = "Btn_ChooseLevel"
				g_Native:report(data)
				self:toLevelScene()
			end)	
		:addTo(self,LevelConfig["btn"])
end

function MainScene:createBottom()
	self.m_bottomNode = app:createView("BottomView")
	self.m_bottomNode:pos(0,0)
    self.m_bottomNode:addTo(self,LevelConfig["btn"])
    
    -- self.m_bottomNode:setLeftCheckBox({
    -- 		images = {
    -- 			off = "voice_open.png",
    -- 			on = "voice_close.png"
    -- 		},
    -- 		click = function(state)
    -- 		--true 表示 关闭声音 
    -- 		--false 表示 打开声音
    -- 			print(state)
    -- 			-- math.newrandomseed(os.time())
    -- 			-- print(math.random(1,4))
    -- 		end
    -- 	})

    self.m_bottomNode:setRightButton({
    	images = {
    			normal = "help_normal.png",
    			pressed = "help_press.png"
    		},
    		click = function()
    			g_Audio:playEffect(AudioConfig.btnClick)
    			app:createView("HelpView"):addTo(self,LevelConfig["dialog"])
    		end
    	})
end

function MainScene:toGameScene()
	print("进入GameScene------------")
	--app:enterScene("GameScene")
	-- app:enterScene("GameScene", nil, "SLIDEINT", 1.0)
	LevelData:setCurLevel(LevelData:getLevel())
	g_Director:runWithScene("GameScene")
end

function MainScene:toLevelScene()
	print("进入LevelScene------------")
	g_Director:runWithScene("LevelScene")
end

function MainScene:toAboutScene()
	print("进入About------------")
	app:enterScene("AboutScene")
end
return MainScene
