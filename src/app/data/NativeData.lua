
local NativeData = class()

local ParamType =
{
    Integer = "int",
    String = "string",
    Float = "float",
    Bool = "bool",
    Double = "double",
}

-- 保存
function NativeData:saveValeForKey(key,val, type)
    if type == ParamType.String then
        cc.UserDefault:getInstance():setStringForKey(key, val)
    elseif type == ParamType.Integer then
        cc.UserDefault:getInstance():setIntegerForKey(key, val)
    elseif type == ParamType.Float then
        cc.UserDefault:getInstance():setFloatForKey(key, val)
    elseif type == ParamType.Double then
        cc.UserDefault:getInstance():setDoubleForKey(key, val)
    elseif type == ParamType.Bool then
        cc.UserDefault:getInstance():setBoolForKey(key, val)
    end
    cc.UserDefault:getInstance():flush()
end

-- 读取
function NativeData:getValeForKey( key, type, default)
    local vale = nil
    if type == ParamType.String then
        vale = cc.UserDefault:getInstance():getStringForKey(key, default)
    elseif type == ParamType.Integer then
        vale = cc.UserDefault:getInstance():getIntegerForKey(key, default)
    elseif type == ParamType.Float then
        vale = cc.UserDefault:getInstance():getFloatForKey(key, default)
    elseif type == ParamType.Double then
        vale = cc.UserDefault:getInstance():getDoubleForKey(key, default)
    elseif type == ParamType.Bool then
        vale = cc.UserDefault:getInstance():getBoolForKey(key, default)
    end
     dump(cc.UserDefault:getXMLFilePath())
    return vale
end

return NativeData