if VHUDPlus or SydneyHUD then return end

local show_interact_original = HUDManager.show_interact
local remove_interact_original = HUDManager.remove_interact

function HUDManager.show_interact(self, data)
	if self._interact_visible and not data.force then
		return
	end
	self._interact_visible = true
	return show_interact_original(self, data)
end
	
function HUDManager.remove_interact(self)
	self._interact_visible = nil
	return remove_interact_original(self)
end