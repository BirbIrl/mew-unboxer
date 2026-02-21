-- eggon - birbirl's terrible half assed gon file interpretor. licensed under GPL3.0
local module = {}

---@enum modes
local modes = {
	define = 0,
	declare = 1,
}

---@param chunk string
---@return any
local function parseChunk(chunk)
	local chunkAsNumber = tonumber(chunk)
	if chunkAsNumber then
		return chunkAsNumber
	elseif chunk == "true" then
		return true
	elseif chunk == "false" then
		return false
	end
	return { type = "reference", id = chunk }
end


---@param contents string
---@return table
function module.parse(contents)
	local base = {}
	---@type table<table, "array"|"object">
	local tableTypes = {}
	tableTypes[base] = "object"
	local tree = { base }
	---@type modes
	local mode = modes.define
	local definition
	---@type string?
	local chunk
	for char in contents:gmatch "." do
		if chunk and chunk:sub(1, 2) == "//" then
			if char == "\n" then
				chunk = nil
			end
			goto skip
		end
		if chunk and chunk:sub(1, 2) == "/*" then
			if chunk:sub(-1, -1) == "*" and char == "/" then
				chunk = nil
				goto skip
			end
			goto cat
		end
		if mode == modes.declare and chunk and chunk:sub(1, 1) == '"' then
			if char == '"' then
				tree[#tree][definition] = chunk:sub(2, -1)
				mode = modes.define
				chunk = nil
				goto skip
			else
				goto cat
			end
		end

		if char:match("%s") or char == "," then
			if chunk then
				if mode == modes.define then
					definition = chunk
					mode = modes.declare
				elseif mode == modes.declare then
					if tableTypes[tree[#tree]] == "object" then
						tree[#tree][definition] = parseChunk(chunk)
						mode = modes.define
					else
						local arr = tree[#tree]
						arr[#arr + 1] = parseChunk(chunk)
					end
				end
				chunk = nil
			end
			goto skip
		end

		if mode == modes.declare then
			if char == "{" or char == "[" then
				local tbl = {}
				tree[#tree][definition] = tbl
				tree[#tree + 1] = tbl
				if char == "{" then
					tableTypes[tbl] = "object"
					mode = modes.define
				else
					tableTypes[tbl] = "array"
					definition = 1
				end
				goto skip
			end
		end

		if mode == modes.declare and tableTypes[tree[#tree]] == "array" then
			if char == "]" then
				if chunk then
					local arr = tree[#tree]
					arr[#arr + 1] = parseChunk(chunk)
				end
				chunk = nil
				tree[#tree] = nil
				if tableTypes[tree[#tree]] == "object" then
					mode = modes.define
				else
					mode = modes.declare
				end
				goto skip
			end
		end

		if mode == modes.define and char == "}" then
			tree[#tree] = nil
			if tableTypes[tree[#tree]] == "object" then
				mode = modes.define
			else
				mode = modes.declare
			end
			goto skip
		end

		if not chunk then
			chunk = ""
		end

		::cat::
		chunk = chunk .. char
		::skip::
	end
	return base
end

return module
