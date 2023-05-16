local wezterm = require("wezterm")

local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Catppuccin Mocha"
	else
		return "Catppuccin Latte"
	end
end

return {
	color_scheme = scheme_for_appearance(wezterm.gui.get_appearance()),
	font = wezterm.font("CaskaydiaCove Nerd Font"),
	font_size = 18.0,
}
