local HelpView = class("HelpView",function()
	 return display.newColorLayer(cc.c4b(0,0,0,125))
end)

function HelpView:ctor()
	-- body
	self:enableTouch(true)
    self:setTouchSwallowEnabled(true)
    self:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        self:removeSelf()
        return true;
    end)
end


return HelpView