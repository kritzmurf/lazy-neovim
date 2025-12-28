return {
  "zbirenbaum/copilot.lua",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  event = "VeryLazy", -- adjust if you want earlier load (e.g., "InsertEnter")
  config = function()
    -- Safe mapping helper: only create mapping if it does not already exist.
    -- This prevents accidental keymap overlaps with your other plugin files.
    local function safe_map(mode, lhs, rhs, opts)
      opts = opts or {}
      local existing = vim.fn.maparg(lhs, mode)
      if existing == "" then
        vim.keymap.set(mode, lhs, rhs, opts)
      else
        vim.notify(("copilot.lua: skipped mapping %s (mode=%s) because it already exists"):format(lhs, mode),
                   vim.log.levels.WARN)
      end
    end

    require("copilot").setup({
      -- Panel-first, no inline autopop
      suggestion = {
        enabled = false,
        auto_trigger = false,
      },

      panel = {
        enabled = true,
        auto_refresh = true,
        keymap = {
          jump_prev = "[[",
          jump_next = "]]",
          accept = "<CR>",    -- accept selection while panel has focus
          refresh = "r",
          open = "<leader>p", -- panel-internal default; safe_map below ensures no overlap
        },
      },

      filetypes = {
        ["*"] = true,
        gitcommit = false,
      },

      telemetry = { enabled = false },
    })

    -- after require("copilot").setup({...})
    -- make copilot panel buffers editable so you can type prompts
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "BufReadPost", "BufNewFile" }, {
      callback = function(args)
        local ok, ft = pcall(function() return vim.api.nvim_buf_get_option(args.buf, "filetype") end)
        if not ok or not ft then return end
        if ft:match("^copilot") then
          -- allow editing inside the panel
          pcall(vim.api.nvim_buf_set_option, args.buf, "modifiable", true)
          -- remove readonly if set
          pcall(vim.api.nvim_buf_set_option, args.buf, "readonly", false)
          -- optional: allow undo/changes
          pcall(vim.api.nvim_buf_set_option, args.buf, "bufhidden", "hide")
        end
      end,
    })

    -- Map <leader>p to open the panel only if that mapping is not already present.
    safe_map("n", "<leader>p", "<cmd>Copilot panel<CR>", { desc = "Copilot: open panel" })

    -- Intentionally do NOT set global accept/inline mappings to avoid collisions with your config.
    -- If you'd like, we can add guarded accept mappings (insert or normal) using safe_map.
  end,
}
