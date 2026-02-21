-- ffdec -selectid 515 -export sprite unpacked  mewgenics-data/swfs/ability_icons.swf
-- ffdec  -dumpSWF mewgenics-data/swfs/ability_icons.swf

local serpent = require("lib.serpent")
local eggon = require("lib.eggon")
local iconExtractor = require("scripts.iconExtractor")
local svgAdjuster = require("scripts.svgAdjuster")
local sh = require("lib.shellUtils")

--[[
if sh.stat("unpacked") then
	if ... == "--force" then
		sh.rm("unpacked", true)
	else
		error(
			"Please get rid of the existing 'unpacked' folder first, or run this with --force to delete it automatically")
	end
end
--]]

-- local passiveIDs, spellIDs = iconExtractor.extract()
-- svgAdjuster.adjustPassives()
-- svgAdjuster.adjustSkills()
local file = assert(io.open("./mewgenics-data/data/abilities/tinkerer_abilities.gon"))
print(serpent.block(eggon.parse(file:read("a"))))
file:close()
