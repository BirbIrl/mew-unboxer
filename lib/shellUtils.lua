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

return module
