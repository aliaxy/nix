local settings = require("core.settings")

local transparent_background = settings.transparent_background
local clear_style = {}

return {
  -- Keep the explicit flavour setting used by this personal config.
  flavour = settings.colorscheme_flavour,

  -- Let Catppuccin choose a flavour from Neovim's background option when
  -- no explicit flavour is used. The explicit `flavour` above still wins.
  background = { light = "latte", dark = "macchiato" },

  -- Dim inactive windows if enabled. nvimdots keeps this disabled because
  -- it can make the UI feel busier and is not recommended with older mocha palettes.
  dim_inactive = {
    enabled = false,
    shade = "dark",
    percentage = 0.15,
  },

  -- Reuse the project-level transparency switch so terminals with true
  -- transparency can opt in without touching the theme spec.
  transparent_background = transparent_background,

  -- Hide the `~` markers after the end of a buffer for a cleaner screen.
  show_end_of_buffer = false,

  -- Apply Catppuccin colors to Neovim terminal buffers as well.
  term_colors = true,

  -- Keep Catppuccin's compiled theme cache in Neovim's cache directory.
  compile_path = vim.fn.stdpath("cache") .. "/catppuccin",

  -- Syntax style choices copied from nvimdots. These affect only text
  -- styling, not plugin behavior.
  styles = {
    comments = { "italic" },
    functions = { "bold" },
    keywords = { "italic" },
    operators = { "bold" },
    conditionals = { "bold" },
    loops = { "bold" },
    booleans = { "bold", "italic" },
    numbers = {},
    types = {},
    strings = {},
    variables = {},
    properties = {},
  },

  integrations = {
    -- Active integrations for plugins used by this config.
    blink_cmp = true,
    gitsigns = true,
    mini = { enabled = true },
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { "italic" },
        hints = { "italic" },
        warnings = { "italic" },
        information = { "italic" },
      },
      underlines = {
        errors = { "underline" },
        hints = { "underline" },
        warnings = { "underline" },
        information = { "underline" },
      },
    },
    snacks = true,
    treesitter = true,

    -- Keep semantic token support available for modern LSP servers.
    semantic_tokens = true,

    -- nvimdots integrations kept here as a checklist. Leave disabled
    -- until the corresponding plugin is actually added to this config.
    -- cmp = true,
    -- dap = true,
    -- dap_ui = true,
    -- diffview = true,
    -- dropbar = { enabled = true, color_mode = true },
    -- fidget = true,
    -- flash = true,
    -- fzf = true,
    -- grug_far = true,
    -- hop = true,
    -- indent_blankline = { enabled = true, colored_indent_levels = true },
    -- lsp_saga = true,
    -- lsp_trouble = true,
    -- markdown = true,
    -- mason = true,
    -- notify = true,
    -- nvimtree = true,
    -- rainbow_delimiters = true,
    -- render_markdown = true,
    -- telescope = { enabled = true, style = "nvchad" },
    -- treesitter_context = true,
    -- which_key = true,
  },

  -- Palette overrides are intentionally empty for now. Add entries here
  -- only when the base Catppuccin palette itself needs to change.
  color_overrides = {},

  highlight_overrides = {
    all = function(cp)
      return {
        -- Base floating UI used by built-in LSP, snacks, and many plugins.
        NormalFloat = { fg = cp.text, bg = transparent_background and cp.none or cp.mantle },
        FloatBorder = {
          fg = transparent_background and cp.blue or cp.mantle,
          bg = transparent_background and cp.none or cp.mantle,
        },
        CursorLineNr = { fg = cp.green },

        -- Native LSP diagnostics. Removing virtual-text backgrounds keeps
        -- diagnostics visible without drawing large colored blocks inline.
        DiagnosticVirtualTextError = { bg = cp.none },
        DiagnosticVirtualTextWarn = { bg = cp.none },
        DiagnosticVirtualTextInfo = { bg = cp.none },
        DiagnosticVirtualTextHint = { bg = cp.none },
        LspInfoBorder = { link = "FloatBorder" },

        -- Built-in popup menu used by command-line completion and some UI.
        Pmenu = { fg = cp.overlay2, bg = transparent_background and cp.none or cp.base },
        PmenuBorder = { fg = cp.surface1, bg = transparent_background and cp.none or cp.base },
        PmenuSel = { bg = cp.green, fg = cp.base },

        -- Treesitter tweaks from nvimdots. `clear_style` removes extra
        -- bold/italic styling while keeping the color override.
        ["@keyword.return"] = { fg = cp.pink, style = clear_style },
        ["@error.c"] = { fg = cp.none, style = clear_style },
        ["@error.cpp"] = { fg = cp.none, style = clear_style },

        -- Inactive nvimdots highlight overrides. Uncomment together with
        -- the corresponding plugin integration above when that plugin is added.
        -- MasonNormal = { link = "NormalFloat" },
        -- IblIndent = { fg = cp.surface0 },
        -- IblScope = { fg = cp.surface2, style = { "bold" } },
        -- CmpItemAbbr = { fg = cp.overlay2 },
        -- CmpItemAbbrMatch = { fg = cp.blue, style = { "bold" } },
        -- CmpDoc = { link = "NormalFloat" },
        -- CmpDocBorder = {
        --   fg = transparent_background and cp.surface1 or cp.mantle,
        --   bg = transparent_background and cp.none or cp.mantle,
        -- },
        -- FidgetTask = { bg = cp.none, fg = cp.surface2 },
        -- FidgetTitle = { fg = cp.blue, style = { "bold" } },
        -- NotifyBackground = { bg = cp.base },
        -- NvimTreeRootFolder = { fg = cp.pink },
        -- NvimTreeIndentMarker = { fg = cp.surface2 },
        -- TroubleNormal = { bg = transparent_background and cp.none or cp.base },
        -- TroubleNormalNC = { bg = transparent_background and cp.none or cp.base },
        -- TelescopeMatching = { fg = cp.lavender },
        -- TelescopeResultsDiffAdd = { fg = cp.green },
        -- TelescopeResultsDiffChange = { fg = cp.yellow },
        -- TelescopeResultsDiffDelete = { fg = cp.red },
        -- GlanceWinBarFilename = { fg = cp.subtext1, style = { "bold" } },
        -- GlanceWinBarFilepath = { fg = cp.subtext0, style = { "italic" } },
        -- GlanceWinBarTitle = { fg = cp.teal, style = { "bold" } },
        -- GlanceListCount = { fg = cp.lavender },
        -- GlanceListFilepath = { link = "Comment" },
        -- GlanceListFilename = { fg = cp.blue },
        -- GlanceListMatch = { fg = cp.lavender, style = { "bold" } },
        -- GlanceFoldIcon = { fg = cp.green },
        -- TSNodeKey = {
        --   fg = cp.peach,
        --   bg = transparent_background and cp.none or cp.base,
        --   style = { "bold", "underline" },
        -- },
      }
    end,
  },
}
