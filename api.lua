unified_inventory = {
	buttons = {}
}

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