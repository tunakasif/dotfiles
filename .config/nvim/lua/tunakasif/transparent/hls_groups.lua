local function get_file_path()
	local str = debug.getinfo(2, "S").source:sub(2)
	return str:match("(.*/)")
end

local file_path = get_file_path()
print(file_path)
local group_file = io.open(file_path .. "/groups.txt", "w")
local hls = vim.split(vim.api.nvim_exec("highlight", true), "\n")
for _, hl in ipairs(hls) do
	local group = vim.split(hl, " ")[1]
	if group then
		group_file:write(group .. "\n")
	end
end
group_file:close()
