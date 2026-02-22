local sh = require("lib.shellUtils")
local paths = require("lib.paths")

---TODO: these might be innacurate
local activeColors = {
	Colorless = "#76716D",
	Fighter = "#8E5C5C",
	Hunter = "#354B31",
	Mage = "#60607B",
	Tank = "#6B5C3A",
	Medic = "#CBCBCB",
	Thief = "#CDCA91",
	Necromancer = "#1C1D1E",
	Tinkerer = "#91BCB1",
	Butcher = "#8A3746",
	Druid = "#49352C",
	Psychic = "#504361",
	Monk = "#606060",
	Jester = "#b55aa8",
}
local passiveColors = {
	Colorless = "#938D88",
	Fighter = "#B17373",
	Hunter = "#425D3D",
	Mage = "#787899",
	Tank = "#857348",
	Medic = "#FDFDFD",
	Thief = "#FFFBB5",
	Necromancer = "#232425",
	Tinkerer = "#B5EADC",
	Butcher = "#AC4457",
	Druid = "#5B4237",
	Psychic = "#B2A9BC",
	Monk = "#787878",
	Jester = "#dd54cb",
}


local module = {}
local shells = paths.assets.unsorted.shells .. "/"
local shellsSorted = paths.assets.final.shells .. "/"

function module.makeShells()
	local passive = sh.read(shells .. "shellPassive.svg")
	local passiveClassed = sh.read(shells .. "shellPassiveClassed.svg")
	sh.mkdir(paths.mewbox .. "/" .. "shells")
	sh.cp(shells .. "shellPassiveDisorder.svg", shellsSorted .. "shellPassiveDisorder.svg")
	sh.cp(shells .. "shellPassiveUpgradePip.svg", shellsSorted .. "shellPassiveUpgradePip.svg")
	sh.cp(shells .. "shellPassiveUpgradeCrown.svg", shellsSorted .. "shellPassiveUpgradeCrown.svg")
	sh.write(shellsSorted .. "shellPassiveColorless.svg", passive:gsub("#111111", passiveColors.Colorless))
	for class, color in pairs(passiveColors) do
		if class ~= "Colorless" then
			sh.write(shellsSorted .. "shellPassive" .. class .. ".svg", passiveClassed:gsub("#111111", color))
		end
	end
end

return module
