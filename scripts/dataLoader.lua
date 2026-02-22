local sh = require("lib.shellUtils")
local paths = require("lib.paths")
local eggon = require("lib.eggon")

local module = {}


function module.load()
	local passives = {}
	local abilities = {}
	for _, path in ipairs(paths.data.gon.passives) do
		local file = assert(io.open(path, "r"))
		local parsed = eggon.parse(file:read("a"))
		file:close()
		for key, value in pairs(parsed) do
			passives[key] = value
		end
	end

	for _, path in ipairs(paths.data.gon.abilities) do
		local file = assert(io.open(path, "r"))
		local parsed = eggon.parse(file:read("a"))
		file:close()
		for key, value in pairs(parsed) do
			abilities[key] = value
		end
	end
	return passives, abilities
end

return module
