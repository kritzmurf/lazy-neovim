return {
    dir = "~/Documents/Projects/Lua/NeoCode",
    -- local plugin under development; skip on machines without the project checkout
    cond = function()
        return vim.fn.isdirectory(vim.fn.expand("~/Documents/Projects/Lua/NeoCode")) == 1
    end,
    config = function()
        require("neocode").setup({
        })
    end,
    cmd = "Neocode",
    keys = {
        { "<leader>lcp", "<cmd>Neocode plan<CR>", desc = "Toggle study plans" },
        { "<leader>lcn", "<cmd>Neocode next<CR>", desc = "Next unsolved problem" },
    },
}
