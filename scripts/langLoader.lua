local csv = require("lib.csv")
local sh = require("lib.shellUtils")
local paths = require("lib.paths")


local module = {}


---@param txt string
---@return string
local function removeNBSP(txt)
	local result = txt:gsub("&nbsp;", " ")
	return result
end


function module.load()
	local text = {}
	for _, path in ipairs(paths.data.csv) do
		local file = assert(csv.open(path))
		for fields in file:lines() do
			if fields[1] ~= "KEY" then
				text[fields[1]] = {
					en = removeNBSP(fields[2]),
					sp = removeNBSP(fields[4]),
					fr = removeNBSP(fields[5]),
					de = removeNBSP(fields[6]),
					it = removeNBSP(fields[7]),
					ptbr = removeNBSP(fields[8]),
				}
			end
		end
		file:close()
	end
	return text
end

return module
