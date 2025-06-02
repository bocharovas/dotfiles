-- init.lua

vim.api.nvim_set_keymap('n', '<A-j>', ':m .+1<CR>==', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-k>', ':m .-2<CR>==', { noremap = true, silent = true })

vim.g.mapleader = " "

-- Bootstrap lazy.nvim, если еще не установлен
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Настройка плагинов через lazy.nvim
require("lazy").setup({
  {
    "vimwiki/vimwiki",
    init = function()
      vim.g.vimwiki_list = {{
        path = os.getenv("HOME") .. "/vimwiki/",
        syntax = "markdown",
        ext = ".md",
        template_path = vim.fn.expand("~/vimwiki/templates/"),
        template_default = "daily",
        template_ext = ".md",
      }}
      vim.g.vimwiki_global_ext = 0
    end,
    config = function()
      vim.api.nvim_set_keymap("n", "<leader>ww", ":VimwikiIndex<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>wt", ":VimwikiMakeDiaryNote<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>ws", ":VimwikiUISelect<CR>", { noremap = true, silent = true })
    end,
  },

  {
    "tbabej/taskwiki",
    config = function()
      vim.g.taskwiki_markdown = 1
      vim.g.taskwiki_update_on_write = 1
      vim.g.taskwiki_split_cmd = "botright vsplit"
      vim.g.taskwiki_date_format = "%Y-%m-%d"
    end,
  },
})

-- Включаем подсветку синтаксиса
vim.cmd("syntax on")

-- Включаем номера строк и относительные номера
vim.opt.number = true
vim.opt.relativenumber = true

-- Задаём лидер (если ещё не установлен)

-- Автозапуск скрипта tasks.sh при сохранении index.md
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "index.md",
  callback = function()
    local script_path = vim.fn.expand("$HOME") .. "/vimwiki/tasks.sh"
    if vim.fn.filereadable(script_path) == 1 then
      print("Запускаем скрипт " .. script_path)
      vim.fn.system("bash " .. script_path)
    else
      print("Скрипт не найден: " .. script_path)
    end
  end,
})

-- Указываем python3 интерпретатор для плагинов, если нужно
vim.g.python3_host_prog = "/usr/bin/python3"

require("config.autocmds")
