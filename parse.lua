local serpent = require("lib.serpent")
local eggon = require("lib.eggon")
local iconExtractor = require("scripts.iconExtractor")
local svgAdjuster = require("scripts.svgAdjuster")
local sh = require("lib.shellUtils")
local dataLoader = require("scripts.dataLoader")
local langLoader = require("scripts.langLoader")
local json = require("lib.json")
local paths = require("lib.paths")
local shellMaker = require("scripts.shellMaker")
local fontExtractor = require("scripts.fontExtractor")


local function assignText(ability, text)
	if ability.desc then
		ability.desc = text[ability.desc]
	end
	if ability.name then
		ability.name = text[ability.name]
	end
	local i = 1
	while ability[tostring(i)] do
		local key = tostring(i)
		if ability[key].desc then
			ability[key].desc = text[ability[key].desc]
		end
		if ability[key].name then
			ability[key].name = text[ability[key].name]
		end
		i = i + 1
	end
end

if sh.stat(paths.mewbox) then
	if ... == "--force" then
		sh.rm(paths.mewbox, true)
	else
		error(
			"Please get rid of the existing " ..
			paths.mewbox .. " folder first, or run this with --force to delete it automatically")
	end
end

iconExtractor.extractAbilities()
svgAdjuster.adjustPassives()
svgAdjuster.adjustSkills()

local passives, abilities = dataLoader.load()

local text = langLoader.load()


for _, passive in pairs(passives) do
	assignText(passive, text)
end

for _, ability in pairs(abilities) do
	assignText(ability, text)
end


local abilitiesFile = assert(io.open(paths.data.json.abilities, "w"))
abilitiesFile:write(json.encode(abilities))
abilitiesFile:close()

local passivesFile = assert(io.open(paths.data.json.passives, "w"))
passivesFile:write(json.encode(passives))
passivesFile:close()


iconExtractor.extractFontIcons()


shellMaker.makeShells()

fontExtractor.extractFonts()

local mewbox = {}

--@enum mewbox.
mewbox.collar = {
	Colorless = "Collarless",
	Fighter = "Fighter",
	Hunter = "Hunter",
	Mage = "Mage",
	Tank = "Tank",
	Healer = "Cleric",
	Thief = "Thief",
	Necromancer = "Necromancer",
	Tinkerer = "Tinkerer",
	Butcher = "Butcher",
	Druid = "Druid",
	Psychic = "Psychic",
	Monk = "Monk",
	Jester = "Jester",
	Disorder = "Disorder",
}

sh.write(paths.mewbox .. "/mewbox.json", json.encode(mewbox))

--[[
---@enum mewbox.element
mewbox.types.element = {
	Water = "Water",
	Fire = "Fire",
	Explosion = "Explosion",
	Ice = "Ice",
}

---@enum mewbox.effect
mewbox.types.effect = {
	Stun = "Stun",
	Burn = "Burn",
	Freeze = "Freeze",
	Trample = "Trample",
	IgnoreSelf = "Ignore Self",
}

---@enum mewbox.target_mode
mewbox.types.target_mode = {
	direction = "Cardinal direction",
}

---@enum mewbox.aoe_mode
mewbox.types.aoe_mode = {
	line = "Line"
}

---@enum mewbox.aoe_restriction
mewbox.types.aoe_restriction = {
	must_have_line_of_sight_unpurgable = "Must have line of sight (unpurgable)",
	none = "None",
}

---@enum mewbox.knockback_mode
mewbox.types.knockback_mode = {
	character_to_tile = "Character to tile"
}

---@enum mewbox.restriction
mewbox.types.knobckback_mode = {
	must_be_moveable = "Must be movable",
	must_have_tag = "Must have assigned tag",
	must_move = "Must move",
}

---@enum mewbox.tags
mewbox.types.knobckback_mode = {
	food = "Food"
}


---@enum mewbox.templates
mewbox.types.templates = {
	melee_attack = "Melee attack",
	lobbed_attack = "Lobbed attack",
	ranged_attack = "Ranged attack",
	straightshot_attack = "Straightshot attack",
	dash_attack = "Dash attack",
	self_buff = "Self buff",
	spell = "Spell",
}

---@class mewbox.description
---@field en string
---@field sp string
---@field fr string
---@field de string
---@field it string
---@field pt-br string


---@class mewbox.passive
---@field class mewbox.class
---@field desc mewbox.description
---@field name mewbox.description


---@class mewbox.abilities
---@field template mewbox.templates
---@field meta {name: mewbox.description, desc: mewbox.description, class: mewbox.class}
---@field cost {mana: integer, infcantrip?: boolean}
---@field target {target_mode?: mewbox.target_mode, restrictions: mewbox.restrictions, max_aoe?: integer, max_range?: integer, aoe_considers_character_size?: boolean, aoe_excludes_self?: boolean, knockback_mode?: mewbox.knockback_mode}
---@field damage_instance? {damage?: integer, knockback?: integer, elements?: mewbox.element[],  effects?: table<mewbox.effect,any>}
---@field temporary_effects table<mewbox.effect,any>



--]]
