function transition_icons(icon_from, icon_to)
  if type(icon_to) == "string" then
    return {
      { icon = "__space-exploration-graphics__/graphics/blank.png", scale = 1, shift = {0, 0}, icon_size = 32 }, -- to lock scale
      { icon = icon_from, scale = 0.66, shift = {8, -8}, icon_size = 32 },
      { icon = icon_to, scale = 0.66, shift = {-8, 8}, icon_size = 32 },
      { icon = "__space-exploration-graphics__/graphics/icons/transition-arrow.png", scale = 1, shift = {0, 0}, icon_size = 32 }, -- to overlay
    }
  else
    local icons = {
      { icon = "__space-exploration-graphics__/graphics/blank.png", scale = 1, shift = {0, 0}, icon_size = 32 }, -- to lock scale
      { icon = icon_from, scale = 0.66, shift = {8, -8}, icon_size = 32 },
    }
    for _, icon in pairs(icon_to) do
      table.insert(icons, { icon = icon, scale = 0.5, shift = {-12 + (_-1) * 8, 12}, icon_size = 32 })
    end
    table.insert(icons, { icon = "__space-exploration-graphics__/graphics/icons/transition-arrow.png", scale = 1, shift = {0, 0}, icon_size = 32 })
    return icons
  end
end

local emptyCanisterReprocessing ={
    type = "recipe",
    name = "selb-empty-canister-reprocessing",
    localised_name = {"recipe-name.selb-empty-canister-reprocessing"},
    results = {
      { name="iron-plate", amount = 1},
      { name="plastic-bar", amount = 1 },
    },
    enabled = false,
    energy_required = 2,
    ingredients = {
      { "empty-canister", 5 }
    },
  	icons = transition_icons(
	    data.raw.item["empty-canister"].icon,
	    {
	      data.raw.item["iron-plate"].icon,
	      data.raw.item["plastic-bar"].icon
	    }
	  ),
  	category = "space-recycling",
  	subgroup = "space-recycling",
  	allow_as_intermediate = false,
    always_show_made_in = true,
    always_show_products = true
}

local gasCanisterReprocessing ={
    type = "recipe",
    name = "selb-gas-canister-reprocessing",
    localised_name = {"recipe-name.selb-gas-canister-reprocessing"},
    results = {
      { name="steel-plate", amount = 1}
    },
    enabled = false,
    energy_required = 2,
    ingredients = {
      { "gas-canister", 5 }
    },
  	icons = transition_icons(
	    data.raw.item["gas-canister"].icon,
	    data.raw.item["steel-plate"].icon
	  ),
  	category = "space-recycling",
  	subgroup = "space-recycling",
  	allow_as_intermediate = false,
    always_show_made_in = true,
    always_show_products = true
}

data:extend{emptyCanisterReprocessing, gasCanisterReprocessing}

local spaceRecyclingFacilityTech = data.raw.technology["se-space-recycling-facility"]

table.insert(spaceRecyclingFacilityTech.effects, { type = "unlock-recipe", recipe = emptyCanisterReprocessing.name })
table.insert(spaceRecyclingFacilityTech.effects, { type = "unlock-recipe", recipe = gasCanisterReprocessing.name })