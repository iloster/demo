local Audio = class("Audio")

function Audio:ctor()
end

function Audio:playEffect(filename)
	audio.playSound(filename)
end 

return Audio