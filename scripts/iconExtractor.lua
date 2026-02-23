local sh = require("lib.shellUtils")
local paths = require("lib.paths")


local ids = {
	ability = 1346,
	passives = 515,
	fontIcons = {
		collars = 753,
		divineShield = 2693,
		shield = 2695,
		str = 2704,
		spd = 2707,
		int = 2710,
		dex = 2713,
		con = 2716,
		cha = 2719,
		lck = 3896,
	}

}

local frameDataDumpCommand = "ffdec  -dumpSWF " .. paths.assets.swf.ability

local module = {}

---@param IDs table
---@param from string
---@param to string
local function cleanUp(IDs, from, to)
	if sh.stat(from) == "directory" then
		for name, id in pairs(IDs) do
			if name == "BurningFists" then -- TODO: REMOVE WHEN TYLER FIXES THIS SILLY RENAME BUG
				name = "FlamingFists"
			end
			sh.mkdir(to)
			sh.mv(from .. "/" .. id .. ".svg", to .. "/" .. name .. ".svg")
		end
		sh.rm(from, true)
	end
end

local function extractData(dataPath, typeId)
	assert(sh.stat(dataPath) == "file", dataPath .. " not found")
	os.execute("ffdec -selectid " ..
		typeId .. " -format sprite:svg -importAssets yes -export sprite " .. paths.mewbox .. " " ..
		dataPath)
end

function module.extractAbilities()
	extractData(paths.assets.swf.ability, ids.ability)
	extractData(paths.assets.swf.ability, ids.passives)
	---@type table<string, integer>
	local passiveIDs = {

	}

	---@type table<string, integer>
	local abilityIDs = {

	}

	local dumped = assert(io.popen(frameDataDumpCommand), "Couldn't run " .. frameDataDumpCommand)
	local currTable
	local currID = 1
	while true do
		---@type string
		local line = dumped:read("l")
		if not line then break end
		if line:find("      0. FrameLabel ") then
			currID = 1
			if not currTable then
				currTable = passiveIDs
			else
				currTable = abilityIDs
			end
		elseif line:find("FrameLabel ") then
			local abilityName = line:match('".+"')
			currTable[abilityName:sub(2, -2)] = currID
		elseif line:find("ShowFrame ") then
			currID = currID + 1
		end
	end

	dumped:close()

	-- cleanup
	cleanUp(passiveIDs, paths.assets.unsorted.passive, paths.assets.final.passive)
	cleanUp(abilityIDs, paths.assets.unsorted.ability, paths.assets.final.ability)
	return passiveIDs, abilityIDs
end

local classIDs = {
	Fighter = 4,
	Tank = 5,
	Hunter = 6,
	Thief = 7,
	Mage = 8,
	Healer = 9,
	Colorless = 10,
	Psyhic = 11,
	Jester = 12,
	Tinkerer = 13,
	Butcher = 14,
	Druid = 15,
	Monk = 16,
	Necromancer = 17,
}

function module.extractFontIcons()
	for _, id in pairs(ids.fontIcons) do
		extractData(paths.assets.swf.ui, id)
	end
	cleanUp(classIDs, paths.assets.unsorted.collars, paths.assets.final.collars)
	cleanUp({ str = 1 }, paths.assets.unsorted.str, paths.assets.final.fontIcons)
	cleanUp({ spd = 1 }, paths.assets.unsorted.spd, paths.assets.final.fontIcons)
	cleanUp({ int = 1 }, paths.assets.unsorted.int, paths.assets.final.fontIcons)
	cleanUp({ dex = 1 }, paths.assets.unsorted.dex, paths.assets.final.fontIcons)
	cleanUp({ con = 1 }, paths.assets.unsorted.con, paths.assets.final.fontIcons)
	cleanUp({ cha = 1 }, paths.assets.unsorted.cha, paths.assets.final.fontIcons)
	cleanUp({ lck = 1 }, paths.assets.unsorted.lck, paths.assets.final.fontIcons)
	cleanUp({ DivineShield = 1 }, paths.assets.unsorted.divineShield, paths.assets.final.fontIcons)
	cleanUp({ Shield = 1 }, paths.assets.unsorted.shield, paths.assets.final.fontIcons)
end

return module
