local sh = require("lib.shellUtils")
local paths = require("lib.paths")



local fontPath = paths.assets.final.fonts .. "/"

local fontNames = {
	SwankyTika = "8_Swanky_TikaSwank\\ Regular.ttf",
	Peralta = "7_Peralta_Peralta.ttf",
	Edmundm = "6_Edmundm_EdmundMcMillen_INTLv4\\ Regular.ttf",
	MewgenicsBabyJack = "5_NPCFont_BabyJack_Mewgenics\\ Jack.ttf",
	MewgenicsFrank = "4_NPCFont_Frank_Mewgenics\\ Frank.ttf",
	MewgenicsSteven = "3_NPCFont_Steven_TheEnd\\ Medium.ttf",
	MewgenicsOrganGrinder = "2_NPCFont_OrganGrinder_Mewgenics\\ Organ\\ Grinder.ttf",
	TikaAdjusted = "1_TikaFont_TikaFont\\ Adjusted\\ Regular.ttf"
}

local module = {}
function module.extractFonts()
	os.execute("ffdec  -export font " .. fontPath .. " " .. paths.assets.swf.fonts)
	for newName, path in pairs(fontNames) do
		sh.mv(fontPath .. path, fontPath .. newName .. ".ttf")
	end
end

return module
