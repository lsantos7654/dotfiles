local colors = require("colors")
local settings = require("settings")

-- Padding item required because of bracket
sbar.add("item", { position = "right", width = settings.group_paddings })

local front_app = sbar.add("item", "front_app", {
	position = "right", -- Added position right
	display = "active",
	icon = { drawing = false },
	label = {
		color = colors.white,
		padding_right = 8,
		padding_left = 8,
		font = {
			style = settings.font.style_map["Black"],
			size = 12.0,
		},
	},
	background = {
		color = colors.bg2,
		border_color = colors.black,
		border_width = 1,
	},
	updates = true,
})

-- Double border using bracket
sbar.add("bracket", { front_app.name }, {
	background = {
		color = colors.transparent,
		height = 30,
		border_color = colors.grey,
	},
})

-- Padding item required because of bracket
sbar.add("item", { position = "right", width = settings.group_paddings })

front_app:subscribe("front_app_switched", function(env)
	front_app:set({ label = { string = env.INFO } })
end)

front_app:subscribe("mouse.clicked", function(env)
	sbar.trigger("swap_menus_and_spaces")
end)
