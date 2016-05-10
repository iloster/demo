
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    -- cc.ui.UILabel.new({
    --         UILabelType = 2, text = "Hello, World", size = 64})
    --     :align(display.CENTER, display.cx, display.cy)
    --     :addTo(self)

    --创建一个背景
    self:createBg()
    self:createBtn()

end

function MainScene:onEnter()
end

function MainScene:onExit()
end


--创建一个背景
function MainScene:createBg()
	display.newColorLayer(cc.c4b(0xfa,0xf8,0xef, 255)):addTo(self)
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
	:addTo(self)

	--创建游戏版本号label
	cc.ui.UILabel.new({
		UILabelType = 2,
		text = "Version 1.0.0",
		size = 28,
		color = cc.c3b(0,0,0)
		})
	:align(display.CENTER_BOTTOM, display.cx, display.bottom)
	:addTo(self)

	local btnImages = {
		normal = "GreenButton.png",
		pressed = "GreenScale9Block.png",
		disabled = "GreenButton.png",
	}

	cc.ui.UIPushButton.new(btnImages,{scale9 = true})
		:setButtonSize(200,60)
		:setButtonLabel("normal", cc.ui.UILabel.new({
			 UILabelType = 2,
			 text = "start",
			 size = 32
		}))
		:align(display.CENTER, display.cx, display.cy)
		:onButtonClicked(function(event)
				self:toGameScene()
			end)	
		:addTo(self)
end

function MainScene:toGameScene()
	print("进入GameScene------------")
	app:enterScene("LevelScene")
	-- app:enterScene("GameScene", nil, "SLIDEINT", 1.0)
end

return MainScene
