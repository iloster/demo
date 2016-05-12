local BottomView = class("BottomView",function()
	return display.newNode()
end)

function BottomView:ctor()

end
--参数
--images
--click
function BottomView:setLeftButton(data)
	local leftBtnImages = data.images
	self.m_leftBtn = cc.ui.UIPushButton.new(leftBtnImages)
	self.m_leftBtn:align(display.BOTTOM_LEFT, 50, 50)
	self.m_leftBtn:setScale(0.5)
	self.m_leftBtn:addTo(self)
	self.m_leftBtn:onButtonClicked(function()
			data.click()
		end)
end

function BottomView:setLeftCheckBox(data)
	local leftBtnImages = data.images
	local leftBtn = cc.ui.UICheckBoxButton.new(leftBtnImages)
	leftBtn:align(display.BOTTOM_LEFT, 50, 50)
	leftBtn:setScale(0.5)
	leftBtn:addTo(self)
	leftBtn:onButtonClicked(function()
			data.click(leftBtn:isButtonSelected())
		end)
	-- body
end

function BottomView:setRightButton(data)
	local rightImages = data.images
	self.m_rightBtn = cc.ui.UIPushButton.new(rightImages)
	self.m_rightBtn:align(display.BOTTOM_RIGHT, display.width-50, 50)
	self.m_rightBtn:setScale(0.5)
	self.m_rightBtn:addTo(self)
	self.m_rightBtn:onButtonClicked(function()
		data.click()
	end)
end

return BottomView 
