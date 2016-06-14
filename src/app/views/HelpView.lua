local HelpView = class("HelpView",function()
	 return display.newColorLayer(cc.c4b(0,0,0,200))
end)

function HelpView:ctor()
	-- body
	self:setContentBg()
	self:setContentView()
	self:setTouchEnabled(true)
    self:setTouchSwallowEnabled(true)
    self:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        self:removeSelf()
        return true;
    end)
    local data = {}
	data.eventId = "Btn_Help"
	g_Native:report(data)
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
		text = g_Lan:get("HelpView_Info"),
		size = 32,
		color = cc.c3b(0,0,0)
	})
	label:align(display.CENTER,size.width/2,size.height-50)
	label:addTo(self.m_dialogBg,1)

	display.newSprite("help1.png"):align(display.CENTER, size.width/4, size.height/2):scale(0.3):addTo(self.m_dialogBg)
	display.newSprite("help2.png"):align(display.CENTER, size.width*3/4, size.height/2):scale(0.3):addTo(self.m_dialogBg)
end

return HelpView