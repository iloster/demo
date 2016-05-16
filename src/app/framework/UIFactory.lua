local UIFactory = class("UIFactory")


function UIFactory:getTopLayer()
	local topLayer = cc.Director:sharedDirector():getNotificationNode();
	if not topLayer then
		topLayer = display.newNode();
		cc.Director:sharedDirector():setNotificationNode(topLayer);
	end
	return topLayer;
end

---创建一个按钮
function UIFactory:createButton()
	return 
end

function UIFactory:createLabel()
	if data then
		return cc.ui.UILabel.new(data)
	end
end

function UIFactory:showToast(data)
	--获取当前正在运行的scene
end

return UIFactory