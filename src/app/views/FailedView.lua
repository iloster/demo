local FailedView = class("FailedView",function()
	return display.newColorLayer(cc.c4b(0,0,0,125))
end)

function FailedView:ctor()
	dump(data)
	self:setTouchEnabled(true)
	self:setTouchSwallowEnabled(true)
	self:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        return true;
    end)

    self.m_dialogBg = display.newScale9Sprite("dialog_bg.png",display.cx,display.cy,cc.size(600,480))
    self.m_dialogBg:addTo(self)
    local size = self.m_dialogBg:getContentSize()

    self.m_content= cc.ui.UILabel.new({
        UILabelType = 2,
        text = g_Lan:get("DialogView_Win"),
        size = 32,
        dimensions = CCSize(size.width*3/4, 0),
        color = cc.c3b(0,0,0),
        })
    self.m_content:align(display.CENTER,size.width/2,size.height-100)
    self.m_content:addTo(self.m_dialogBg)

    local resetBtnImage = {
        normal = "reset_normal.png",
        pressed = "reset_press.png"
    }
    self.m_resetBtn = cc.ui.UIPushButton.new(resetBtnImage)
    self.m_resetBtn:align(display.CENTER, size.width/4, size.height/2)
    self.m_resetBtn:addTo(self.m_dialogBg)
    self.m_resetBtn:setScale(1)
    self.m_resetBtn:onButtonClicked(function()
            self.onRestClick()
        end)

    
    self.m_resetTxt = cc.ui.UILabel.new({
            UILabelType = 2,
            text = g_Lan:get("DialogView_Again"),
            size = 25,
            color = cc.c3b(0,0,0),
        })
    self.m_resetTxt:align(display.CENTER,size.width/4, size.height/2-100)
    self.m_resetTxt:addTo(self.m_dialogBg)

    local addBtnImages = {
        	normal = "yuan_normal.png",
        	pressed = "yuan_press.png"
    	}
    local addTxt = g_Lan:get("DialogView_Next")
    self.m_addBtn = cc.ui.UIPushButton.new(addBtnImages)
    self.m_addBtn:align(display.CENTER, size.width*3/4, size.height/2)
    self.m_addBtn:addTo(self.m_dialogBg)
    self.m_addBtn:setScale(0.5)
    self.m_addBtn:onButtonClicked(function()
            self.onAddClick()
        end)


    self.m_addTxt = cc.ui.UILabel.new({
        UILabelType = 2,
        text = "充值",
        size = 25,
        color = cc.c3b(0,0,0),
        })
    self.m_addTxt:align(display.CENTER,size.width*3/4,size.height/2-100)
    self.m_addTxt:addTo(self.m_dialogBg)
end



function FailedView:setOnRestClick(func)
    self.onRestClick = func
end

function FailedView:setOnAddClick(func)
	self.onAddClick = func
end

function FailedView:setTitle(title)
    self.m_content:setString(title)
end

return FailedView