
-- Set highlight on search
vim.o.hlsearch = true

-- Show where current search pattern matches (while typing)
vim.o.incsearch = true

--[[
let &shell = executable('pwsh') ? 'pwsh' : 'powershell'
let &shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
let &shellredir = '-RedirectStandardOutput %s -NoNewWindow -Wait'
let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
set shellquote= shellxquote=
--]]

-- use <Esc> to exit terminal-mode
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { silent = true })

-- gc to open windows terminal
vim.keymap.set('n', 'gc', ':!wt -d "%:h"<CR>')

-- delete all other buffers except the current one
vim.keymap.set('n', '<F1>', ':%bd <BAR> e# <BAR> bd# <CR>', { silent = true })

-- change vim's directory to the directory of the current file
vim.keymap.set('n', '<F5>', ':cd %:p:h <Enter>:pwd <Enter>')

-- delete extraneous spaces at the end of every line
vim.keymap.set('n', '<F6>', ':%s:[ \\t]\\+$::g <Enter> :noh <Enter>')

-- toggle line numbers
vim.keymap.set('n', '<F7>', 'set number!<Enter>')

-- copy current line to clipboard
vim.keymap.set('n', '<F9>', '"*yy')

-- copy <something> to clipboard (you need to fill in last keystroke)
vim.keymap.set('n', '<F10>', '"*y')

-- copy rest of file to clipboard
vim.keymap.set('n', '<F11>', '"*yG')

-- copy entire file to clipboard (regardless of where you are in file)
vim.keymap.set('n', '<F12>', ':%y *<CR>')

-- show/hide spaces, tabs, etc.
vim.keymap.set('n', '<leader>s', ':set nolist!', { silent = true })

-- use ctrl-v to paste in insert mode and command mode
vim.keymap.set('i', '<C-v>', '<ESC>"*pa')
vim.keymap.set('c', '<C-v>', '<C-R>+')

-- copy filename and line number to clipboard
vim.keymap.set('n', '<leader>n', ':let @*=expand("%:t") . ":" . line(".")<CR>:echo "Copied filename/line no to clipboard"<CR>')

-- copy filename (including path) to clipboard
vim.keymap.set('n', '<leader>f', ':let @*=expand("%:p")<CR>:echo "Copied filename (incl. path) to clipboard"<CR>')

-- copy directory to clipboard
vim.keymap.set('n', '<leader>d', ':let @*=expand("%:p:h")<CR>:echo "Copied directory to clipboard"<CR>')

-- copy filename (including) path and line number to clipboard
-- vim.keymap.set('n', '<leader>l', ':let @*="load -r " . line(".") . " " . expand("%:p")<CR>:echo "Copied filename (incl. path) AND linenumber to clipboard"<CR>')

-- don't wrap lines
vim.o.wrap = false
-- make sure gg goes to beginning of line
vim.o.sol = true
-- no mouse
vim.o.mouse = ''

vim.o.softtabstop = true
vim.o.shiftwidth = 2
vim.o.textwidth = 100
vim.o.expandtab = true

vim.api.nvim_create_autocmd("FileType", {
  pattern = "vim,html,jinja,svelte",
  command = [[let b:delimitMate_matchpairs = "(:),[:],{:}"]],
})

vim.g.closetag_filetypes = 'html,xhtml,phtml,svelte,jinja'
vim.keymap.set('n', '<leader>lf', ':lua vim.lsp.buf.format({timeout_ms = 2500})<CR>')

--[[
local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.completion.spell,
    null_ls.builtins.formatting.sqlfluff.with({
      extra_args = { "--dialect", "postgres" }, -- change to your dialect
    }),
  }
})

-- vim.cmd('map <Leader>lf :lua vim.lsp.buf.formatting_sync(nil, 10000)<CR>')

local lsp_formatting = function(bufnr)
  vim.lsp.buf.format({
    filter = function(client)
      return client.name == "null-ls"
    end,
    bufnr = bufnr,
  })
end

-- if you want to set up formatting on save, you can use this as a callback
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- add to your shared on_attach callback
local on_attach = function(client, bufnr)
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        lsp_formatting(bufnr)
      end,
    })
  end
end
--]]
