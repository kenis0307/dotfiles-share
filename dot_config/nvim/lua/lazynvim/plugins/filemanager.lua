return {
  {
    "stevearc/oil.nvim",
    enabled = false,
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    config = function()
      -- Declare a global function to retrieve the current directory
      function _G.get_oil_winbar()
        local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
        local dir = require("oil").get_current_dir(bufnr)
        if dir then
          return vim.fn.fnamemodify(dir, ":~")
        else
          -- If there is no current directory (e.g. over ssh), just show the buffer name
          return vim.api.nvim_buf_get_name(0)
        end
      end
      require("oil").setup({
        view_options = {
          show_hidden = true,
        },
        win_options = {
          winbar = "%!v:lua.get_oil_winbar()",
        },
      })
      vim.keymap.set("n", "<Leader>e", "<CMD>Oil<CR>", { desc = "[E]xplorer (oil)" })
    end,
  },
  {
    "echasnovski/mini.files",
    enabled = false,
    config = function()
      require("mini.files").setup()
      vim.keymap.set("n", "<Leader>e", MiniFiles.open, { desc = "[E]xplorer (mini.files)" })
    end,
  },
}
