local HelpView = class("HelpView",function()
	 return display.newColorLayer(cc.c4b(0,0,0,200))
end)

function HelpView:ctor()
	-- body
	self:setContentBg()
	self:setContentView()
	self:enableTouch(true)
    self:setTouchSwallowEnabled(true)
    self:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        self:removeSelf()
        return true;
    end)
end

function HelpView:setContentBg()
	self.m_dialogBg = display.newScale9Sprite("dialog_bg.png",display.cx,display.cy,cc.size(600,480))
    self.m_dialogBg:addTo(self)	-- body
end
function HelpView:setContentView()
	local size = self.m_dialogBg:getContentSize()
	dump(self.m_dialogBg:getContentSize())
	--创建一个label
	local data  = {}
	local label = g_UIFactory:createLabel({
		UILabelType = 2,
		text = "将无序的方块移动成:",
		size = 32,
		color = cc.c3b(0,0,0)
	})
	label:align(display.CENTER,size.width/2,size.height-50)
	label:addTo(self.m_dialogBg,1)

	
end

return HelpView