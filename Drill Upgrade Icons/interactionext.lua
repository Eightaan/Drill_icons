if MUIInteract or PDTHHud and PDTHHud.Options:GetValue("HUD/Interaction") then return end

local selected_orig = BaseInteractionExt.selected

function BaseInteractionExt:selected(...)
	if selected_orig(self, ...) and self._unit:base() and self._unit:base().is_drill then
		managers.hud:show_drill_interact()
	elseif selected_orig(self, ...) and self._unit:base() and self._unit:base().is_saw then
	    managers.hud:show_drill_interact()
	end
	return selected_orig(self, ...)
end