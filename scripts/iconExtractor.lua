local sh = require("lib.shellUtils")
local paths = require("lib.paths")


local abilityID = 1346
local passivesID = 515

local frameDataDumpCommand = "ffdec  -dumpSWF " .. paths.data.ability

local module = {}

local function cleanUp(IDs, from, to)
	if sh.stat(from) == "directory" then
		for name, id in pairs(IDs) do
			sh.mkdir(to)
			sh.mv(from .. "/" .. id .. ".svg", to .. "/" .. name .. ".svg")
		end
		sh.rm(from, true)
	end
end

local function extractData(dataPath, typeId)
	assert(sh.stat(dataPath) == "file", dataPath .. " not found")
	os.execute("ffdec -selectid " .. typeId .. " -format sprite:svg -importAssets yes -export sprite unpacked " ..
		dataPath)
end

function module.extract()
	extractData(paths.data.ability, abilityID)
	extractData(paths.data.ability, passivesID)
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
	cleanUp(passiveIDs, paths.unsorted.passive, paths.final.passive)
	cleanUp(abilityIDs, paths.unsorted.ability, paths.final.ability)
	return passiveIDs, abilityIDs
end

return module
