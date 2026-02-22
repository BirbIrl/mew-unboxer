local module = {}
function module.mkdir(path)
	os.execute("mkdir -p " .. path)
end

function module.rm(path, recursive)
	if recursive then
		os.execute("rm -r " .. path)
	else
		os.execute("rm " .. path)
	end
end

function module.mv(from, to)
	os.execute("mv " .. from .. " " .. to)
end

---@param path string
---@return string[]
function module.ls(path)
	local files = {}
	local cmd = assert(io.popen("ls -- " .. path), "Couldn't run the ls command")
	for file in cmd:lines() do
		files[#files + 1] = file
	end
	cmd:close()
	return files
end

---@param path string
---@return "file"|"directory"|nil
function module.stat(path)
	local stat = assert(io.popen("stat -c %F " .. path), "Couldn't run the stat command")
	---@type string
	local result = stat:read("a")
	stat:close()
	if result:find("file") then
		return "file"
	elseif result:find("directory") then
		return "directory"
	end
end

---@param path string
---@return string
function module.read(path)
	local file = assert(io.open(path, "r"), "Couldn't open file in path: " .. path)
	local contents = file:read("a")
	file:close()
	return contents
end

---@param path string
---@param contents string
function module.write(path, contents)
	local file = assert(io.open(path, "w"), "Couldn't open file in path: " .. path)
	file:write(contents)
	file:close()
end

---@param from string
---@param to string
function module.cp(from, to)
	os.execute("cp " .. from .. " " .. to)
end

return module
