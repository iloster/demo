local DialogView = class("DialogView", function() 
    return display.newColorLayer(cc.c4b(0,0,0,125))
    end)

function DialogView:ctor()
	--
    self:enableTouch(true)
    self:setTouchSwallowEnabled(true)
    self:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        return true;
    end)

    self.m_dialogBg = display.newScale9Sprite("dialog_bg.png",display.cx,display.cy,cc.size(600,480))
    self.m_dialogBg:addTo(self)
    local size = self.m_dialogBg:getContentSize()

    self.m_content= cc.ui.UILabel.new({
        UILabelType = 2,
        text = "太棒了!成功通过一关",
        size = 25,
        color = cc.c3b(0,0,0),
        })
    self.m_content:align(display.CENTER,size.width/2,size.height-100)
    self.m_content:addTo(self.m_dialogBg)

    local nextBtnImages = {
    	normal = "next_normal.png",
    	pressed = "next_press.png"
	}
    self.m_nextBtn = cc.ui.UIPushButton.new(nextBtnImages)
    self.m_nextBtn:align(display.CENTER, size.width*3/4, size.height/2)
    self.m_nextBtn:addTo(self.m_dialogBg)
    self.m_nextBtn:setScale(1)
    self.m_nextBtn:onButtonClicked(function()
            self.onNextClick()
        end)

    self.m_nextTxt = cc.ui.UILabel.new({
        UILabelType = 2,
        text = "下一关",
        size = 25,
        color = cc.c3b(0,0,0),
        })
    self.m_nextTxt:align(display.CENTER,size.width*3/4,size.height/2-100)
    self.m_nextTxt:addTo(self.m_dialogBg)


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
        text = "再来一次",
        size = 25,
        color = cc.c3b(0,0,0),
        })
    self.m_resetTxt:align(display.CENTER,size.width/4, size.height/2-100)
    self.m_resetTxt:addTo(self.m_dialogBg)
end

function DialogView:setOnNextClick(func)
   self.onNextClick = func
end

function DialogView:setOnRestClick(func)
    self.onRestClick = func
end

return DialogView 