ScriptHost:LoadScript("scripts/autotracking/item_mapping.lua")
ScriptHost:LoadScript("scripts/autotracking/location_mapping.lua")

CUR_INDEX = -1
SLOT_DATA = nil
LOCAL_ITEMS = {}
GLOBAL_ITEMS = {}

function onClear(slot_data)
	-- Print out the contents of slot_data for debugging purposes
	print("Contents of slot_data:")
	for key, value in pairs(slot_data) do
		print(key, value)
	end

	if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
		print(string.format("called onClear, slot_data:\n%s", dump_table(slot_data)))
	end

	SLOT_DATA = slot_data
	CUR_INDEX = -1

	-- reset locations
	for _, v in pairs(LOCATION_MAPPING) do
		if v[1] then
			if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
				print(string.format("onClear: clearing location %s", v[1]))
			end

			local obj = Tracker:FindObjectForCode(v[1])

			if obj then
				if v[1]:sub(1, 1) == "@" then
					obj.AvailableChestCount = obj.ChestCount
				elseif obj.Type == "progressive" then
					obj.CurrentStage = 0
				else
					obj.Active = false
				end
			elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
				print(string.format("onClear: could not find object for code %s", v[1]))
			end
		end
	end
	-- reset items
	for _, v in pairs(ITEM_MAPPING) do
		if v[1] and v[2] then
			if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
				print(string.format("onClear: clearing item %s of type %s", v[1], v[2]))
			end
			local obj = Tracker:FindObjectForCode(v[1])
			if obj then
				if v[2] == "toggle" then
					obj.Active = false
				elseif v[2] == "progressive" then
					obj.CurrentStage = 0
					obj.Active = false
				elseif v[2] == "consumable" then
					obj.AcquiredCount = 0
				elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
					print(string.format("onClear: unknown item type %s for code %s", v[2], v[1]))
				end
			elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
				print(string.format("onClear: could not find object for code %s", v[1]))
			end
		end
	end

	LOCAL_ITEMS = {}
	GLOBAL_ITEMS = {}

	if SLOT_DATA == nil then
		return
	end

	--get missing and checked locations
	--loop over all pokedex location IDs and if not in missing/checked,
	-- store then loop over and set each stage to disbled
	missing = Archipelago.MissingLocations
	locations = Archipelago.CheckedLocations
	dex_checks = {}
	for _, v in pairs(missing) do
		dex_checks[v] = true
		-- table.insert(locations, v)
	end
	for _, v in pairs(locations) do
		dex_checks[v] = true
		-- table.insert(locations, v)
	end

	for i = 0, 151 do
		n = i + 172000549
		d = dex_checks[n]
		-- print('i: '..i.. 'd: '.. d)
		if not d then
			l = LOCATION_MAPPING[n]
			obj = Tracker:FindObjectForCode(l[1])
			if obj then
				obj.CurrentStage = 2
			end
		end
	end
	for i, v in pairs(locations) do
		print("i: " .. i .. "v:" .. v)
	end

	if slot_data["split_card_key"] then
		local obj = Tracker:FindObjectForCode("op_cardkey")
		if obj then
			tmp = slot_data["split_card_key"]
			if tmp == 2 then
				tmp = 1
			elseif tmp == 1 then
				tmp = 2
				obj.CurrentStage = tmp
			end
		end
	end
	if slot_data["second_fossil_check_condition"] then
		local obj = Tracker:FindObjectForCode("op_fos")
		if obj then
			obj.AcquiredCount = slot_data["second_fossil_check_condition"]
		end
	end

	if slot_data["route_22_gate_condition"] then
		local obj = Tracker:FindObjectForCode("rt22_digit")
		if obj then
			obj.CurrentStage = slot_data["route_22_gate_condition"]
		end
	end
	if slot_data["victory_road_condition"] then
		local obj = Tracker:FindObjectForCode("vr_digit")
		if obj then
			obj.CurrentStage = slot_data["victory_road_condition"]
		end
	end

	if slot_data["require_item_finder"] then
		local obj = Tracker:FindObjectForCode("op_if")
		if obj then
			obj.CurrentStage = slot_data["require_item_finder"]
		end
	end
	if slot_data["randomize_hidden_items"] then
		local obj = Tracker:FindObjectForCode("op_hid")
		local stage = slot_data["randomize_hidden_items"]
		if stage >= 2 then
			stage = 2
		end
		if obj then
			obj.CurrentStage = stage
		end
	end
	if slot_data["badges_needed_for_hm_moves"] then
		local obj = Tracker:FindObjectForCode("op_hm")
		local stage = slot_data["badges_needed_for_hm_moves"]
		if stage >= 2 then
			stage = 2
		end
		if obj then
			obj.CurrentStage = stage
		end
	end
	if slot_data["route_3_condition"] then
		local obj = Tracker:FindObjectForCode("rt3")
		local stage = slot_data["route_3_condition"]
		if stage >= 5 then
			stage = 5
		end
		if obj then
			obj.CurrentStage = stage
		end
	end
	if slot_data["extra_key_items"] then
		local obj = Tracker:FindObjectForCode("op_exk")
		if obj then
			obj.CurrentStage = slot_data["extra_key_items"]
		end
	end
	if slot_data["tea"] then
		local obj = Tracker:FindObjectForCode("op_tea")
		if obj then
			obj.CurrentStage = slot_data["tea"]
		end
	end
	if slot_data["extra_strength_boulders"] then
		local obj = Tracker:FindObjectForCode("op_bldr")
		if obj then
			obj.CurrentStage = slot_data["extra_strength_boulders"]
		end
	end
	if slot_data["old_man"] then
		local obj = Tracker:FindObjectForCode("op_man")
		local stage = slot_data["old_man"]
		if stage == 2 then
			stage = 0
		else
			stage = 1
		end
		if obj then
			obj.CurrentStage = stage
		end
	end
	if slot_data["free_fly_map"] then
		local obj = Tracker:FindObjectForCode("freefly")
		if obj then
			obj.CurrentStage = slot_data["free_fly_map"]
		end
	end
	if slot_data["town_map_fly_map"] then
		local obj = Tracker:FindObjectForCode("freeflymap")
		if obj then
			obj.CurrentStage = slot_data["town_map_fly_map"]
		end
	end
	if slot_data["elite_four_badges_condition"] then
		local obj = Tracker:FindObjectForCode("e4b_digit")
		obj.CurrentStage = slot_data["elite_four_badges_condition"]
		-- local obj = Tracker:FindObjectForCode("elite4_badges")
		-- if obj then
		-- 	obj.AcquiredCount = slot_data['elite_four_badges_condition']
		-- end
	end
	if slot_data["elite_four_key_items_condition"] then
		local tens = Tracker:FindObjectForCode("e4k_digit1")
		local ones = Tracker:FindObjectForCode("e4k_digit2")
		local val = slot_data["elite_four_key_items_condition"]
		if tens and ones then
			tens.CurrentStage = val // 10
			ones.CurrentStage = val % 10
		end
		-- if obj then
		-- 	obj.AcquiredCount = slot_data['elite_four_key_items_condition']
		-- end
	end
	if slot_data["elite_four_pokedex_condition"] then
		local hunds = Tracker:FindObjectForCode("e4p_digit1")
		local tens = Tracker:FindObjectForCode("e4p_digit2")
		local ones = Tracker:FindObjectForCode("e4p_digit3")
		local val = slot_data["elite_four_pokedex_condition"]
		if hunds and tens and ones then
			hunds.CurrentStage = val // 100
			tens.CurrentStage = val % 100 // 10
			ones.CurrentStage = val % 10
		end

		-- local obj = Tracker:FindObjectForCode("elite4_pokedex")
		-- if obj then
		-- 	obj.AcquiredCount = slot_data['elite_four_pokedex_condition']
		-- end
	end
	if slot_data["victory_road_condition"] then
		local obj = Tracker:FindObjectForCode("victoryroad")
		if obj then
			obj.AcquiredCount = slot_data["victory_road_condition"]
		end
	end
	if slot_data["viridian_gym_condition"] then
		local obj = Tracker:FindObjectForCode("viridian")
		if obj then
			obj.AcquiredCount = slot_data["viridian_gym_condition"]
		end
	end
	if slot_data["cerulean_cave_badges_condition"] then
		local obj = Tracker:FindObjectForCode("ccaveB_digit")
		obj.CurrentStage = slot_data["cerulean_cave_badges_condition"]
		-- if obj then
		-- 	obj.AcquiredCount = slot_data['cerulean_cave_badges_condition']
		-- end
	end
	if slot_data["cerulean_cave_key_items_condition"] then
		local tens = Tracker:FindObjectForCode("ccaveK_digit1")
		local ones = Tracker:FindObjectForCode("ccaveK_digit2")
		local val = slot_data["cerulean_cave_key_items_condition"]
		if tens and ones then
			tens.CurrentStage = val // 10
			ones.CurrentStage = val % 10
		end
		-- local obj = Tracker:FindObjectForCode("cerulean_badges")
		-- if obj then
		--     obj.AcquiredCount = slot_data['cerulean_cave_key_items_condition']
		-- end
	end
	if slot_data["prizesanity"] then
		local obj = Tracker:FindObjectForCode("op_prize")
		if obj then
			obj.CurrentStage = slot_data["prizesanity"]
		end
	end
	if slot_data["stonesanity"] then
		local obj = Tracker:FindObjectForCode("stonesanity")
		if obj then
			obj.CurrentStage = slot_data["stonesanity"]
		end
	end
	if slot_data["key_items_only"] then
		local obj = Tracker:FindObjectForCode("op_keyonly")
		if obj then
			obj.CurrentStage = slot_data["key_items_only"]
		end
	end
	if slot_data["extra_badges"] then
		local hm
		local badge
		local obj
		local blist = { m = 2, v = 3, e = 4, b = 5, c = 6, t = 7, r = 8, s = 9 }
		if slot_data["extra_badges"]["Cut"] then
			badge = string.sub(slot_data["extra_badges"]["Cut"], 1, 1)
			badge = string.lower(badge)
			obj = Tracker:FindObjectForCode("cutex")
			if obj then
				obj.CurrentStage = blist[badge]
			end
		else
			obj = Tracker:FindObjectForCode("cutex")
			if obj then
				obj.CurrentStage = 1
			end
		end
		if slot_data["extra_badges"]["Fly"] then
			badge = string.sub(slot_data["extra_badges"]["Fly"], 1, 1)
			badge = string.lower(badge)
			obj = Tracker:FindObjectForCode("flyex")
			if obj then
				obj.CurrentStage = blist[badge]
			end
		else
			obj = Tracker:FindObjectForCode("flyex")
			if obj then
				obj.CurrentStage = 1
			end
		end
		if slot_data["extra_badges"]["Surf"] then
			badge = string.sub(slot_data["extra_badges"]["Surf"], 1, 1)
			badge = string.lower(badge)
			obj = Tracker:FindObjectForCode("surfex")
			if obj then
				obj.CurrentStage = blist[badge]
			end
		else
			obj = Tracker:FindObjectForCode("surfex")
			if obj then
				obj.CurrentStage = 1
			end
		end
		if slot_data["extra_badges"]["Strength"] then
			badge = string.sub(slot_data["extra_badges"]["Strength"], 1, 1)
			badge = string.lower(badge)
			obj = Tracker:FindObjectForCode("strengthex")
			if obj then
				obj.CurrentStage = blist[badge]
			end
		else
			obj = Tracker:FindObjectForCode("strengthex")
			if obj then
				obj.CurrentStage = 1
			end
		end
		if slot_data["extra_badges"]["Flash"] then
			badge = string.sub(slot_data["extra_badges"]["Flash"], 1, 1)
			badge = string.lower(badge)
			obj = Tracker:FindObjectForCode("flashex")
			if obj then
				obj.CurrentStage = blist[badge]
			end
		else
			obj = Tracker:FindObjectForCode("flashex")
			if obj then
				obj.CurrentStage = 1
			end
		end
	end
	if slot_data["oaks_aide_rt_2"] then
		obj = Tracker:FindObjectForCode("aide2")
		if obj then
			obj.AcquiredCount = slot_data["oaks_aide_rt_2"]
		end
	end
	if slot_data["oaks_aide_rt_11"] then
		obj = Tracker:FindObjectForCode("aide11")
		if obj then
			obj.AcquiredCount = slot_data["oaks_aide_rt_11"]
		end
	end
	if slot_data["oaks_aide_rt_15"] then
		obj = Tracker:FindObjectForCode("aide15")
		if obj then
			obj.AcquiredCount = slot_data["oaks_aide_rt_15"]
		end
	end
	if slot_data["randomize_pokedex"] then
		obj = Tracker:FindObjectForCode("op_dex")
		if obj then
			obj.CurrentStage = slot_data["randomize_pokedex"]
		end
	end
	if slot_data["trainersanity"] then
		obj = Tracker:FindObjectForCode("op_trn")
		if obj then
			obj.CurrentStage = slot_data["trainersanity"]
		end
	end
	if slot_data["poke_doll_skip"] then
		-- print(slot_data['poke_doll_skip'])
		local obj = Tracker:FindObjectForCode("op_pokedoll_skip")
		if obj then
			obj.CurrentStage = slot_data["poke_doll_skip"]
		end
	end
	if slot_data["bicycle_gate_skips"] then
		-- print(slot_data['bicycle_gate_skips'])
		local obj = Tracker:FindObjectForCode("op_bike_skips")
		if obj then
			obj.CurrentStage = slot_data["bicycle_gate_skips"]
		end
	end
	if slot_data["dark_rock_tunnel_logic"] then
		local obj = Tracker:FindObjectForCode("op_dark_rock_tunnel")
		if obj then
			obj.CurrentStage = slot_data["dark_rock_tunnel_logic"]
		end
	end
	-- 	end
	-- end
end
	-- called when an item gets collected
function onItem(index, item_id, item_name, player_number)
	if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
		print(
			string.format("called onItem: %s, %s, %s, %s, %s", index, item_id, item_name, player_number, CUR_INDEX)
		)
	end
	if index <= CUR_INDEX then
		return
	end
	local is_local = player_number == Archipelago.PlayerNumber
	CUR_INDEX = index
	local v = ITEM_MAPPING[item_id]
	if not v then
		if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
			print(string.format("onItem: could not find item mapping for id %s", item_id))
		end
		return
	end
	if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
		print(string.format("onItem: code: %s, type %s", v[1], v[2]))
	end
	if not v[1] then
		return
	end
	local obj = Tracker:FindObjectForCode(v[1])
	if obj then
		if v[2] == "toggle" then
			obj.Active = true
		elseif v[2] == "progressive" then
			if obj.Active then
				obj.CurrentStage = obj.CurrentStage + 1
			else
				obj.Active = true
			end
		elseif v[2] == "consumable" then
			obj.AcquiredCount = obj.AcquiredCount + obj.Increment
		elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
			print(string.format("onItem: unknown item type %s for code %s", v[2], v[1]))
		end
	elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
		print(string.format("onItem: could not find object for code %s", v[1]))
	end
	-- track local items via snes interface
	if is_local then
		if LOCAL_ITEMS[v[1]] then
			LOCAL_ITEMS[v[1]] = LOCAL_ITEMS[v[1]] + 1
		else
			LOCAL_ITEMS[v[1]] = 1
		end
	else
		if GLOBAL_ITEMS[v[1]] then
			GLOBAL_ITEMS[v[1]] = GLOBAL_ITEMS[v[1]] + 1
		else
			GLOBAL_ITEMS[v[1]] = 1
		end
	end
	if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
		print(string.format("local items: %s", dump_table(LOCAL_ITEMS)))
		print(string.format("global items: %s", dump_table(GLOBAL_ITEMS)))
	end
	if PopVersion < "0.20.1" or AutoTracker:GetConnectionState("SNES") == 3 then
		-- add snes interface functions here for local item tracking
	end
end

	--called when a location gets cleared
function onLocation(location_id, location_name)
	if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
		print(string.format("called onLocation: %s, %s", location_id, location_name))
	end
	local v = LOCATION_MAPPING[location_id]
	if not v and AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
		print(string.format("onLocation: could not find location mapping for id %s", location_id))
	end
	if not v[1] then
		return
	end

	for _, w in ipairs(v) do
		print(w)
		local obj = Tracker:FindObjectForCode(w)
		if obj then
			if w:sub(1, 1) == "@" then
				obj.AvailableChestCount = obj.AvailableChestCount - 1
			elseif obj.Type == "progressive" then
				obj.CurrentStage = obj.CurrentStage + 1
			else
				obj.Active = true
			end
		elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
			print(string.format("onLocation: could not find object for code %s", v[1]))
		end
		if location_name == "Silph Co President (Card Key)" then
			Tracker:FindObjectForCode("silph").Active = true
		end
		if location_name == "Mr. Fuji" then
			Tracker:FindObjectForCode("fuji").Active = true
		end
	end
end

Archipelago:AddClearHandler("clear handler", onClear)
Archipelago:AddItemHandler("item handler", onItem)
Archipelago:AddLocationHandler("location handler", onLocation)
