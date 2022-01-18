local status_ok, nightfox = pcall(require, 'nightfox')
if not status_ok then
    return
end

nightfox.setup({
    fox = "nordfox", -- nightfox, nordfox, dayfox, dawnfox, duskfox
    transparent = false,
    styles = {
        comments = "italic", -- change style of comments to be italic
        keywords = "italic", -- change style of keywords to be bold
        functions = "NONE" -- styles can be a comma separated list_workspace_folders
    },
})

-- Load the configuration set above and apply the colorscheme
nightfox.load()
