local show_interact_orig = HUDInteraction.show_interact
local remove_interact_orig = HUDInteraction.remove_interact

function HUDInteraction:show_interact(...)
    --Settings
    local OLD_ACE_SYMBOL = DrillUpgradeIcon:GetOption("ace_icon")
	local ACTUAL_KICKSTARTER_ICON = DrillUpgradeIcon:GetOption("kickstart_icon")
	local SCALE = DrillUpgradeIcon:GetOption("icon_scale") or 1
	
	--Kickstarter Icon
	if ACTUAL_KICKSTARTER_ICON then
	    kickstarter_texture_rect = { 9 * 80, 8 * 80, 80, 80 }
	else
	    kickstarter_texture_rect = { 5 * 80, 5 * 80, 80, 80 }
	end
	
	--Ace Symbol
	if OLD_ACE_SYMBOL then
	    ace_textrue = "guis/textures/pd2/skilltree/ace"
	else
	    ace_textrue = "guis/textures/pd2/skilltree_2/ace_symbol"
	end

    --Drill Icons Offset
    if ACTUAL_KICKSTARTER_ICON and 0 < managers.player:upgrade_level("player", "drill_speed_multiplier", 0) then
	    offset_speed = 2.25
		offset_auto  = 1.78
	elseif not ACTUAL_KICKSTARTER_ICON and 0 < managers.player:upgrade_level("player", "drill_speed_multiplier", 0) then
        offset_speed = 2.25
        offset_auto  = 1.82
    else
        offset_auto  = 2.25
        offset_speed = 1.82
    end
	
	-- Icon Sizes
	local icon_size_w = 80
	local icon_size_h = 80
	local ace_size_w  = 100
	local ace_size_h  = 100
	
	--Drill Icons Panel
	self._drill_skills_panel = self._hud_panel:panel({
		layer = 1,
		visible = false,
		align = "center",
		y = self._hud_panel:child(self._child_name_text):bottom()
	})
	
	--Drill Sawgeant Basic
	self._drill_skills_panel:bitmap({
		y = 10,
		visible = 0 < managers.player:upgrade_level("player", "drill_speed_multiplier", 0),
		texture = "guis/textures/pd2/skilltree_2/icons_atlas_2",
        texture_rect = { 3 * 80, 6 * 80, 80, 80 },
		color = Color.white,
		align = "center",
		w = icon_size_w * SCALE,
		h = icon_size_h * SCALE,
		layer = 2
	}):set_center_x(self._drill_skills_panel:w() / offset_speed)
	
	--Kickstarter Basic
	self._drill_skills_panel:bitmap({
		y = 10,
		visible = 0 < managers.player:upgrade_level("player", "drill_autorepair_2", 0),
		texture = "guis/textures/pd2/skilltree_2/icons_atlas_2",
        texture_rect = kickstarter_texture_rect,
		color = Color.white,
		align = "center",
		w = icon_size_w * SCALE,
		h = icon_size_h * SCALE,
		layer = 2
	}):set_center_x(self._drill_skills_panel:w() / offset_auto)
	
	--Hardware Expert Basic
	self._drill_skills_panel:bitmap({
		y = 10,
		visible = 0 < managers.player:upgrade_level("player", "silent_drill", 0),
		texture = "guis/textures/pd2/skilltree_2/icons_atlas_2",
		texture_rect = { 9 * 80, 6 * 80, 80, 80 },
		color = Color.white,
		align = "center",
		w = icon_size_w * SCALE,
		h = icon_size_h * SCALE,
		layer = 2
	}):set_center_x(self._drill_skills_panel:w() / 2 )
	
	--Hardware Expert Ace
	if managers.player:upgrade_level("player", "silent_drill", 0) and managers.player:upgrade_level("player", "drill_autorepair_1", 0) == 1 then
		self._drill_skills_panel:bitmap({
			texture = ace_textrue,
			h = ace_size_h * SCALE,
			w = ace_size_w * SCALE,
			alpha = 1,
			blend_mode = "add",
			color = Color.white,
			layer = 1
		}):set_center_x(self._drill_skills_panel:w() / 2)
	end
	
	--Drill Sawgeant Ace
	if managers.player:upgrade_level("player", "drill_speed_multiplier", 0) == 2 then
		self._drill_skills_panel:bitmap({
			texture = ace_textrue,
			h = ace_size_h * SCALE,
			w = ace_size_w * SCALE,
			alpha = 1,
			blend_mode = "add",
			color = Color.white,
			layer = 1
		}):set_center_x(self._drill_skills_panel:w() / offset_speed)	
	end	
	return show_interact_orig(self, ...)
end

function HUDInteraction:show_drill_interact()
	self._drill_skills_panel:set_visible(true)
end

function HUDInteraction:remove_interact(...)
	if alive(self._drill_skills_panel) then
		self._drill_skills_panel:set_visible(false)
    end
	return remove_interact_orig(self, ...)
end