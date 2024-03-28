local variant = Tracker.ActiveVariantUID
local has_map = not variant:find("itemsonly")


function split_key()
  Tracker:AddLayouts("layouts/split_cardkey.json")
end

Tracker:AddItems("items/items.json")

ScriptHost:LoadScript("scripts/logic.lua")

if has_map then
  Tracker:AddMaps("maps/maps.json")
  Tracker:AddLocations("locations/locations.json")
end

Tracker:AddLayouts("layouts/item_grids.json")
Tracker:AddLayouts("layouts/layouts.json")
Tracker:AddLayouts("layouts/tracker.json")
Tracker:AddLayouts("layouts/dex.json")
Tracker:AddLayouts("layouts/broadcast.json")

if PopVersion and PopVersion >= "0.18.0" then
  ScriptHost:LoadScript("scripts/autotracking.lua")
end

if PopVersion and PopVersion >= "0.1.0" then
  ScriptHost:AddWatchForCode("loadCardKey", "op_cardkey_split", split_key)
end