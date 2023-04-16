return {
	"L3MON4D3/LuaSnip",
	config = function()
		local load_vs_code_snippets = true

		local function file_exists(name)
			local f = io.open(name, "r")
			if f ~= nil then
				io.close(f)
				return true
			else
				return false
			end
		end

		local home_path = os.getenv("HOME")
		local vs_code_user_dir = home_path .. "/.config/Code/User"
		local vs_code_user_file = "package.json"
		local vs_code_user_file_path = vs_code_user_dir .. "/" .. vs_code_user_file

		if load_vs_code_snippets then
			if file_exists(vs_code_user_file_path) then
				require("luasnip.loaders.from_vscode").load({
					paths = { vs_code_user_dir },
				})
			else
				print("[LuaSnip]: " .. vs_code_user_file_path .. " does not exist.")
			end
		end
	end,
}
