require("config.lazy")
require('mini.pairs').setup()

vim.g.mapleader = ' '
vim.o.number = true
vim.o.relativenumber = true
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true

vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")
vim.keymap.set("n", "<space>q", ":q<CR>")
vim.keymap.set("n", "<space>w", ":w<CR>")
vim.keymap.set("n", "-", "<cmd>Oil<CR>")
vim.keymap.set("n", "<space>b", ":!cmake --build build<CR>")
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)

vim.keymap.set("n", "<space>cd", function()
  local dir = vim.fn.expand("%:p:h")
  if dir ~= "" then
    vim.cmd.cd(dir)
  end
end, { desc = "cd to current buffer directory" })

vim.api.nvim_create_autocmd('VimLeave', {
  desc = 'Writes the current working directory to a file on close.',
  callback = function()
    local file = os.getenv("NVIM_CD_FILE")
    if file then
      local modifier = io.open(file, "w")
      if modifier then
        modifier:write(vim.fn.getcwd())
        modifier:close()
      end
    end
  end
}
)

vim.api.nvim_create_autocmd('UIEnter', {
  callback = function()
    vim.o.clipboard = 'unnamedplus'
  end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_user_command('GitBlameLine', function()
  local line_number = vim.fn.line('.') -- Get the current line number. See `:h line()`
  local filename = vim.api.nvim_buf_get_name(0)
  print(vim.system({ 'git', 'blame', '-L', line_number .. ',+1', filename }):wait().stdout)
end, { desc = 'Print the git blame for the current line' })

vim.cmd('packadd! nohlsearch')
