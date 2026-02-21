-- ffdec -selectid 515 -export sprite unpacked  mewgenics-data/swfs/ability_icons.swf
-- ffdec  -dumpSWF mewgenics-data/swfs/ability_icons.swf

local serpent = require("lib.serpent")
local iconExtractor = require("scripts.iconExtractor")
local svgAdjuster = require("scripts.svgAdjuster")
local sh = require("lib.shellUtils")

if sh.stat("unpacked") then
	if ... == "--force" then
		sh.rm("unpacked", true)
	else
		error(
			"Please get rid of the existing 'unpacked' folder first, or run this with --force to delete it automatically")
	end
end

local passiveIDs, spellIDs = iconExtractor.extract()
svgAdjuster.adjustPassives()
svgAdjuster.adjustSkills()
