local S
if minetest.get_modpath("intllib") then
	S = intllib.Getter()
else
	S = function ( s ) return s end
end

if minetest.global_exists("sethome") then
	unified_inventory.register_button("home_gui_set", {
		type = "image",
		image = "ui_sethome_icon.png",
		tooltip = S("Set home position"),
		hide_lite=true,
		action = function(player)
			minetest.sound_play("dingdong",
					{to_player=player:get_player_name(), gain = 1.0})
			sethome.set(player:get_player_name(), player:getpos())
		end,
	})

	unified_inventory.register_button("home_gui_go", {
		type = "image",
		image = "ui_gohome_icon.png",
		tooltip = S("Go home"),
		hide_lite=true,
		action = function(player)
			minetest.sound_play("teleport",
				{to_player=player:get_player_name(), gain = 1.0})
			sethome.go(player:get_player_name())
		end,
	})
end

unified_inventory.register_button("misc_set_day", {
	type = "image",
	image = "ui_sun_icon.png",
	tooltip = S("Set time to day"),
	hide_lite=true,
	action = function(player)
		local player_name = player:get_player_name()
		if minetest.check_player_privs(player_name, {settime=true}) then
			minetest.sound_play("birds",
					{to_player=player_name, gain = 1.0})
			minetest.set_timeofday((6000 % 24000) / 24000)
			minetest.chat_send_player(player_name,
				S("Time of day set to 6am"))
		else
			minetest.chat_send_player(player_name,
				S("You don't have the settime privilege!"))
		end
	end,
})

unified_inventory.register_button("misc_set_night", {
	type = "image",
	image = "ui_moon_icon.png",
	tooltip = S("Set time to night"),
	hide_lite=true,
	action = function(player)
		local player_name = player:get_player_name()
		if minetest.check_player_privs(player_name, {settime=true}) then
			minetest.sound_play("owl",
					{to_player=player_name, gain = 1.0})
			minetest.set_timeofday((21000 % 24000) / 24000)
			minetest.chat_send_player(player_name,
					S("Time of day set to 9pm"))
		else
			minetest.chat_send_player(player_name,
					S("You don't have the settime privilege!"))
		end
	end,
})

unified_inventory.register_button("clear_inv", {
	type = "image",
	image = "ui_trash_icon.png",
	tooltip = S("Clear inventory"),
	action = function(player)
		local player_name = player:get_player_name()
		if not unified_inventory.is_creative(player_name) then
			minetest.chat_send_player(player_name,
					S("This button has been disabled outside"
					.." of creative mode to prevent"
					.." accidental inventory trashing."
					.."\nUse the trash slot instead."))
			return
		end
		player:get_inventory():set_list("main", {})
		minetest.chat_send_player(player_name, S('Inventory cleared!'))
		minetest.sound_play("trash_all",
				{to_player=player_name, gain = 1.0})
	end,
})
