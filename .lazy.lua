local hyprland = vim.fs.joinpath(
  vim.fn.fnamemodify(vim.fn.resolve(vim.fn.exepath "Hyprland"), ":h:h"),
  "share/hypr/stubs"
)

---@type LazySpec[]
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      ---@type table<string, vim.lsp.Config>
      servers = {
        lua_ls = {
          ---@type lspconfig.settings.lua_ls
          settings = {
            Lua = {
              workspace = {
                library = {
                  hyprland,
                },
              },
              codeLens = {
                enable = true,
              },
              completion = {
                callSnippet = "Replace",
              },
              doc = {
                privateName = { "^_" },
              },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "All",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
            },
          },
        },
      },
    },
  },
}
