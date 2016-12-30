unified_inventory = {
	pages = {},
	buttons = {},

	lite_mode = false,

	pagecols = 8,
	pagerows = 10,
	page_y = 0,
	formspec_y = 1,
	main_button_x = 0,
	main_button_y = 9,
	craft_result_x = 0.3,
	craft_result_y = 0.5,
	form_header_y = 0
}

function unified_inventory.register_page(name, def)
	unified_inventory.pages[name] = def
	sfinv.register_page(name, {
		title = name,
		get = function(self, player, context)
			local ui = {}
			ui.pagecols = unified_inventory.pagecols
			ui.pagerows = unified_inventory.pagerows
			ui.page_y = unified_inventory.page_y
			ui.formspec_y = unified_inventory.formspec_y
			ui.main_button_x = unified_inventory.main_button_x
			ui.main_button_y = unified_inventory.main_button_y
			ui.craft_result_x = unified_inventory.craft_result_x
			ui.craft_result_y = unified_inventory.craft_result_y
			ui.form_header_y = unified_inventory.form_header_y

			local res = def.get_formspec(player, ui)
			return sfinv.make_formspec(player, context, res, false, "size[14,10]")
		end,
	})
end

function unified_inventory.register_button(name, def)
	if not def.action then
		def.action = function(player)
			sfinv.set_player_inventory_formspec(player)
		end
	end
	def.name = name
	def.title = def.tooltip or name
	table.insert(unified_inventory.buttons, def)

	sfinv_buttons.register_button(name, def)
end

if creative.is_enabled_for then
	unified_inventory.is_creative = creative.is_enabled_for
else
	function unified_inventory.is_creative(name)
		return minetest.setting_getbool("creative_mode")
	end
end

if minetest.global_exists("sethome") then
	function unified_inventory.set_home(player, pos)
		sethome.set(player:get_player_name(), pos)
	end

	function unified_inventory.go_home(player)
		sethome.go(player:get_player_name())
	end
end
