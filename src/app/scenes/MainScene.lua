
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

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
		text = "Cube",
		size = 32,
		color = cc.c3b(0,0, 0) })
	:align(display.CENTER_TOP, display.left+display.width/2, display.top - 170)
	:addTo(self,LevelConfig["btn"])

	--创建游戏版本号label
	cc.ui.UILabel.new({
		UILabelType = 2,
		text = "Version 1.0.0",
		size = 28,
		color = cc.c3b(0,0,0)
		})
	:align(display.CENTER_BOTTOM, display.cx, display.bottom)
	:addTo(self,LevelConfig["btn"])

	local btnImages = {
		normal = "btn.png",
		pressed = "btn_press.png",
		disabled = "GreenButton.png",
	}

	cc.ui.UIPushButton.new(btnImages)
		--:setButtonSize(250,90)
		:setButtonLabel("normal", cc.ui.UILabel.new({
			 UILabelType = 2,
			 text = "立即游戏",
			 size = 32,
			 color=cc.c3b(0,0,0)
		}))
		:align(display.CENTER, display.cx, display.cy+100)
		:onButtonClicked(function(event)
				self:toGameScene()
			end)	
		:addTo(self,LevelConfig["btn"])

	cc.ui.UIPushButton.new(btnImages)
		--:setButtonSize(250,90)
		:setButtonLabel("normal", cc.ui.UILabel.new({
			 UILabelType = 2,
			 text = "选择关卡",
			 size = 32,
			 color=cc.c3b(0,0,0)
		}))
		:align(display.CENTER, display.cx, display.cy-60)
		:onButtonClicked(function(event)
				self:toLevelScene()
			end)	
		:addTo(self,LevelConfig["btn"])
end

function MainScene:createBottom()
	self.m_bottomNode = app:createView("BottomView")
	self.m_bottomNode:pos(0,0)
    self.m_bottomNode:addTo(self,LevelConfig["btn"])
    
    self.m_bottomNode:setLeftCheckBox({
    		images = {
    			off = "voice_open.png",
    			on = "voice_close.png"
    		},
    		click = function(state)
    		--true 表示 关闭声音 
    		--false 表示 打开声音
    			print(state)
    		end
    	})

    self.m_bottomNode:setRightButton({
    	images = {
    			normal = "help_normal.png",
    			pressed = "help_press.png"
    		},
    		click = function()
    			app:createView("helpView"):addTo(self,LevelConfig["dialog"])
    		end
    	})
end

function MainScene:toGameScene()
	print("进入GameScene------------")
	--app:enterScene("GameScene")
	-- app:enterScene("GameScene", nil, "SLIDEINT", 1.0)
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
