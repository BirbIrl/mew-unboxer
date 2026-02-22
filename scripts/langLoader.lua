local csv = require("lib.csv")
local sh = require("lib.shellUtils")
local paths = require("lib.paths")


local module = {}


function module.load()
	local text = {}
	for _, path in ipairs(paths.data.csv) do
		local file = assert(csv.open(path))
		for fields in file:lines() do
			if fields[1] ~= "KEY" then
				text[fields[1]] = {
					en = fields[2],
					sp = fields[4],
					fr = fields[5],
					de = fields[6],
					it = fields[7],
					ptbr = fields[8],
				}
			end
		end
		file:close()
	end
	return text
end

return module
