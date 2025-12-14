local theme_path = vim.fn.expand("~/.config/theme/current/nvim/theme.lua")

if vim.fn.filereadable(theme_path) == 1 then
  return dotfile(theme_path)
end

return {}
