local LevelScene = class("LevelScene",function()
		return display.newScene("LevelScene")
end)

function LevelScene:ctor()
	-- body
	
	self:createBg()
	self:createLevel()
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

function LevelScene:createLevel() 
	local levelImages = {
		normal = "circle_normal.png",
		pressed = "circle_press.png",
	}
   local Space = (display.width - 400)/5
   for i = 0,7 do
   		local row = i%4 + 1
   		local col = math.floor(i/4) + 1
   		local x = row * Space + (2*row - 1) * 50
   		local y = display.cy - (col-1) * Space*2
   		if col == 1 then
   			y = display.cy - (-1) * Space
   		end
		cc.ui.UIPushButton.new(levelImages)
			:setButtonLabel("normal", cc.ui.UILabel.new({
				 UILabelType = 2,
				 text = i+1,
				 size = 32,
				 color = cc.c3b(0,0,0)
			}))
			:align(display.CENTER, x, y)
			:onButtonClicked(function(event)
				local data = {}
				data.level = i + 1
				 self:toGameScene(data)
				end)	
			:addTo(self)
	end
end

function LevelScene:toGameScene(data)
	dump(data)
end
return LevelScene