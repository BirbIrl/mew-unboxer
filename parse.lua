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
	passive.desc = text[passive.desc]
	passive.name = text[passive.name]
	if passive["2"] and passive["2"].desc then
		passive["2"].desc = text[passive["2"].desc]
	end
end

for _, ability in pairs(abilities) do
	if ability.meta then
		ability.meta.desc = text[ability.meta.desc]
		ability.meta.name = text[ability.meta.name]
	end
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

--[[
local mewbox = {}
mewbox.types = {}


--@enum mewbox.class
mewbox.types.class = {
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
