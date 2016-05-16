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


--参数：
-- UILabelType = 2,
--	text = "选择游戏关卡",
--	size = 32,
--	color = cc.c3b(0,0, 0)
function UIFactory:createLabel(data)
	if data then
		return cc.ui.UILabel.new(data)
	end
end

function UIFactory:showToast(data)
	--获取当前正在运行的scene
end

return UIFactory