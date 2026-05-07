local settings = {}

-- Plugin and update behavior -------------------------------------------------

-- Use SSH URLs for plugin/parser updates. HTTPS is easier on new cross-platform machines.
---@type boolean
settings.use_ssh = false

-- Disable specific plugin specs by repository name in the future.
---@type string[]
settings.disabled_plugins = {}

-- Enable big-file optimizations where supported by plugins such as snacks.nvim.
---@type boolean
settings.load_big_files_faster = true

-- AI integrations are intentionally disabled until they are explicitly configured.
---@type boolean
-- settings.use_copilot = false

-- UI -------------------------------------------------------------------------

-- Main colorscheme name.
---@type string
settings.colorscheme = "catppuccin"

-- Catppuccin flavour used by the theme plugin.
---@type "latte"|"frappe"|"macchiato"|"mocha"
settings.colorscheme_flavour = "macchiato"

-- Override the theme palette. Kept as a future hook for deeper theme tuning.
---@type table<string, string>
-- settings.palette_overwrite = {}

-- Use a transparent background when the terminal supports it.
---@type boolean
settings.transparent_background = false

-- Background mode for themes that support light and dark variants.
---@type "dark"|"light"
settings.background = "dark"

-- Preferred search backend. This config currently uses snacks.nvim.
---@type "snacks"|"telescope"|"fzf"
settings.search_backend = "snacks"

-- Command used to open external URLs on Linux-like systems if needed later.
---@type string|nil
-- settings.external_browser = nil

-- Enable the startup dashboard.
---@type boolean
settings.dashboard_enabled = true

-- Startup dashboard header.
---@type string[]
settings.dashboard_header = {
  [[                                  __          ]],
  [[                               _.-~  )        ]],
  [[                    _..--~~~~,'   ,-/     _   ]],
  [[                 .-'. . . .'   ,-','    ,' )  ]],
  [[               ,'. . . _   ,--~,-'__..-'  ,'  ]],
  [[             ,'. . .  (@)' ---~~~~      ,'    ]],
  [[            /. . . . '~~             ,-'      ]],
  [[           /. . . . .             ,-'         ]],
  [[          ; . . . .  - .        ,'            ]],
  [[         : . . . .       _     /              ]],
  [[        . . . . .          `-.:               ]],
  [[       . . . ./  - .          )               ]],
  [[      .  . . |  _____..---.._/ ____ Moxi _    ]],
  [[~---~~~~----~~~~             ~~               ]]
}

-- Diagnostics ----------------------------------------------------------------

-- Show inline diagnostic virtual text.
---@type boolean
settings.diagnostics_virtual_text = true

-- nvimdots uses virtual lines as an alternative diagnostic display.
---@type boolean
-- settings.diagnostics_virtual_lines = false

-- Minimum diagnostic severity to show.
---@type integer
settings.diagnostics_level = vim.diagnostic.severity.HINT

-- Formatting -----------------------------------------------------------------

-- Format automatically before saving.
---@type boolean
settings.format_on_save = false

-- Format timeout in milliseconds.
---@type number
settings.format_timeout = 1000

-- Show formatter notifications.
---@type boolean
settings.format_notify = true

-- Format only changed lines when a formatter integration supports it.
---@type boolean
settings.format_modifications_only = false

-- Filetypes that should skip formatting when set to true.
---@type table<string, boolean>
settings.formatter_block_list = {}

-- LSP servers whose formatting capability should be ignored.
---@type table<string, boolean>
settings.server_formatting_block_list = {
  lua_ls = true,
}

-- Directories where format-on-save should be disabled.
---@type string[]
settings.format_disabled_dirs = {}

-- Formatter candidates by filetype. The first executable one is used.
---@type table<string, string[]>
settings.formatters_by_ft = {
  lua = { "stylua" },
  nix = { "nixfmt", "nixfmt-rfc-style", "alejandra" },
  sh = { "shfmt" },
  bash = { "shfmt" },
  zsh = { "shfmt" },
}

-- LSP ------------------------------------------------------------------------

-- Enable LSP inlay hints when a server supports them.
---@type boolean
settings.lsp_inlay_hints = false

-- Preferred LSP servers. Alternatives are tried in order where a list is used.
---@type table<string, string|string[]>
settings.lsp_servers = {
  lua = "lua_ls",
  nix = { "nixd", "nil_ls" },
  shell = "bashls",
}

-- Mason/bootstrap LSP dependency list from nvimdots. Kept commented because Nix will own tools later.
---@type string[]
-- settings.lsp_deps = {
--   "bashls",
--   "clangd",
--   "gopls",
--   "html",
--   "jsonls",
--   "lua_ls",
--   "ruff",
--   "zuban",
-- }

-- none-ls dependency list from nvimdots. This config currently uses conform.nvim instead.
---@type string[]
-- settings.null_ls_deps = {
--   "clang_format",
--   "gofumpt",
--   "goimports",
--   "prettier",
--   "shfmt",
--   "stylua",
--   "vint",
-- }

-- DAP dependency list from nvimdots. Enable when debugging support is added.
---@type string[]
-- settings.dap_deps = {
--   "codelldb",
--   "delve",
--   "python",
-- }

-- Treesitter -----------------------------------------------------------------

-- Treesitter parsers to install and enable.
---@type string[]
settings.treesitter_parsers = {
  "bash",
  "json",
  "lua",
  "markdown",
  "markdown_inline",
  "nix",
  "toml",
  "vim",
  "vimdoc",
  "yaml",
}

-- Broader nvimdots parser set. Keep commented until the language surface expands.
---@type string[]
-- settings.treesitter_deps = {
--   "bash",
--   "c",
--   "cpp",
--   "css",
--   "go",
--   "gomod",
--   "html",
--   "javascript",
--   "json",
--   "latex",
--   "lua",
--   "make",
--   "markdown",
--   "markdown_inline",
--   "python",
--   "rust",
--   "typescript",
--   "vimdoc",
--   "vue",
--   "yaml",
-- }

-- AI -------------------------------------------------------------------------

-- Enable AI chat functionality when CodeCompanion is added.
---@type boolean
-- settings.use_chat = false

-- Language used for AI chat responses.
---@type string
-- settings.chat_lang = "English"

-- Environment variable or command used to read the AI chat API key.
---@type string
-- settings.chat_api_key = "CODE_COMPANION_KEY"

-- AI chat models from nvimdots. Keep commented until AI support is added.
---@type string[]
-- settings.chat_models = {
--   "moonshotai/kimi-k2:free",
--   "qwen/qwen3-coder:free",
--   "deepseek/deepseek-chat-v3-0324:free",
--   "deepseek/deepseek-r1:free",
--   "google/gemma-3-27b-it:free",
--   "openai/codex-mini",
--   "openai/gpt-4.1-mini",
--   "google/gemini-2.5-flash-lite",
--   "google/gemini-2.5-flash",
--   "anthropic/claude-3.7-sonnet",
--   "anthropic/claude-sonnet-4",
-- }

return settings
