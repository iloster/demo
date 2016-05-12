local AboutScene = class("AboutScene",function()
	return display.newScene("AboutScene")
end)
local wangfa = "向上，向下，向左，向右滑动方块，如果四条横线或者四条竖线上的方块为同一种颜色，表示过关成功。如图所示："
function AboutScene:ctor()
	self:createBg()
end

function AboutScene:onEnter()

end

function AboutScene:onExit()

end

function AboutScene:createBg()
	display.newColorLayer(cc.c4b(0xfa,0xf8,0xef, 255)):addTo(self)
	cc.ui.UILabel.new({
		UILabelType = 2,
		text = "游戏玩法",
		size = 32,
		color = cc.c3b(0,0, 0) })
	:align(display.CENTER, display.cx, display.cy+400)
	:addTo(self)
	cc.ui.UILabel.new({
		UILabelType = 2,
		text = wangfa,
		size = 28,
		align = cc.ui.TEXT_ALIGN_LEFT,
		dimensions = cc.size(display.width-100, 200),
		color = cc.c3b(0,0, 0) })
	:align(display.CENTER, display.cx, display.cy+200)
	:addTo(self)
end

return AboutScene