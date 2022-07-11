local status_ok, transparent = pcall(require, "transparent")
if not status_ok then
	return
end

local function get_file_path()
	local str = debug.getinfo(2, "S").source:sub(2)
	return str:match("(.*/)")
end

local function split(s, delimiter)
	local result = {}
	for match in (s .. delimiter):gmatch("(.-)" .. delimiter) do
		table.insert(result, match)
	end
	return result
end

local function filter_string_table(table, s)
	local filtered = {}
	for _, v in ipairs(table) do
		if v:find(s) then
			filtered[#filtered + 1] = v
		end
	end
	return filtered
end

local function array_concat(...)
	local t = {}
	for n = 1, select("#", ...) do
		local arg = select(n, ...)
		if type(arg) == "table" then
			for _, v in ipairs(arg) do
				t[#t + 1] = v
			end
		else
			t[#t + 1] = arg
		end
	end
	return t
end

local function get_extra_groups(filter_keywords)
	local file_path = get_file_path()
	local group_file_path = file_path .. "/groups.txt"

	local group_file = io.open(group_file_path, "r")
	local contents = group_file:read("*all")
	group_file:close()

	local split_string = split(contents, "\n")
	local filtered = {}
	for _, value in ipairs(filter_keywords) do
		local curr_filtered = filter_string_table(split_string, value)
		filtered = array_concat(filtered, curr_filtered)
	end
	-- for _, f in ipairs(filtered) do
	--     print(f)
	-- end
	return filtered
end

transparent.setup({
	enable = false, -- boolean: enable transparent
	-- In particular, when you set it to 'all', that means all avaliable groups
	extra_groups = get_extra_groups({
		"Buffer",
		"NvimTree",
		"Normal",
	}),
	exclude = {
		-- "Visual",
		-- "Highlight",
	}, -- table: groups you don't want to clear
})
