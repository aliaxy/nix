local opt = vim.opt
local global = require("core.global")
local settings = require("core.settings")

-- Reload files automatically when they are changed outside Neovim.
opt.autoread = true

-- Avoid implicit writes when switching buffers or running commands.
opt.autowrite = false

-- Make Backspace work across indentation, line breaks, and insertion start.
opt.backspace = { "indent", "eol", "start" }

-- Keep backup files disabled; writebackup below still protects writes.
-- opt.backup = false

-- Candidate backup directory if persistent backups are enabled later.
-- opt.backupdir = { vim.fs.joinpath(global.cache_dir, "backup//"), "." }

-- Paths where backup files should never be written.
-- opt.backupskip = { "/tmp/*", "$TMPDIR/*", "$TMP/*", "$TEMP/*", "*/shm/*", "/private/var/*", ".vault.vim" }

-- Characters where wrapped lines may break.
opt.breakat = [[\ \	;:,!?@*-+/]]

-- Use the system clipboard for unnamed yank, delete, change, and put operations.
opt.clipboard = "unnamedplus"

-- Command-line height; left at the default for now.
-- opt.cmdheight = 1

-- Height of the command-line window opened by q: or q/.
-- opt.cmdwinheight = 5

-- Built-in insert completion sources; blink.cmp handles primary completion.
-- opt.complete = { ".", "w", "b", "k", "kspell" }

-- Use Neovim 0.12 fuzzy popup completion without preselecting an item.
opt.completeopt = { "fuzzy", "menuone", "noselect", "popup" }

-- Highlight the current column; too visually noisy for now.
-- opt.cursorcolumn = true

-- Highlight the current line.
opt.cursorline = true

-- Improve diff quality with whitespace ignore, patience algorithm, and line matching.
opt.diffopt = { "filler", "iwhite", "internal", "linematch:60", "algorithm:patience" }

-- Candidate swap directory if swap files are re-enabled later.
-- opt.directory = { vim.fs.joinpath(global.cache_dir, "swap//") }

-- Show as much of the last screen line as possible.
-- opt.display = "lastline"

-- Internal encoding; Neovim already defaults to UTF-8.
-- opt.encoding = "utf-8"

-- Do not force all windows to equal sizes after splits close/open.
-- opt.equalalways = false

-- Audible error bell; disabled for a quieter editor.
-- opt.errorbells = true

-- File encodings to try when reading files.
-- opt.fileencodings = { "ucs-bom", "utf-8", "default", "big5", "latin1" }

-- Line-ending formats to detect when reading files.
-- opt.fileformats = { "unix", "mac", "dos" }

-- Enable folds.
opt.foldenable = true

-- Open files with folds expanded by default.
opt.foldlevel = 99
opt.foldlevelstart = 99

-- Use Treesitter as the fold expression provider.
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- Parse ripgrep output as file:line:column:message.
opt.grepformat = "%f:%l:%c:%m"

-- Use ripgrep for :grep, including hidden files and smart case matching.
opt.grepprg = "rg --hidden --vimgrep --smart-case --"

-- Height of help windows.
-- opt.helpheight = 12

-- Historical option for hidden buffers; modern Neovim effectively behaves this way.
-- opt.hidden = true

-- Keep a deep command/search history.
opt.history = 2000

-- Ignore case in search patterns by default.
opt.ignorecase = true

-- Preview substitutions inline without opening a split.
opt.inccommand = "nosplit"

-- Show search matches while typing.
opt.incsearch = true

-- Infer completion item case from typed text.
opt.infercase = true

-- Keep jump list behavior stack-like and preserve view where possible.
opt.jumpoptions = { "stack", "view" }

-- Global statusline; defer until a statusline plugin is configured.
-- opt.laststatus = 3

-- Show invisible characters.
opt.list = true

-- Symbols used for tabs, non-breaking spaces, trailing spaces, and overflow.
opt.listchars = { tab = "»·", nbsp = "+", trail = "·", extends = "→", precedes = "←" }

-- Use magic mode for regular expressions.
opt.magic = true

-- Tune mouse wheel scroll speed.
opt.mousescroll = "ver:3,hor:6"

-- Height of preview windows.
-- opt.previewheight = 12

-- Popup menu transparency; keep opaque for readable completion menus.
opt.pumblend = 0

-- Maximum number of completion items shown in the popup menu.
opt.pumheight = 15

-- Time limit for syntax highlighting and other redraw-heavy operations.
opt.redrawtime = 1500

-- Show cursor position; usually replaced by a statusline.
-- opt.ruler = true

-- Keep context lines above and below the cursor.
opt.scrolloff = 8

-- Session contents to save if session management is added later.
-- opt.sessionoptions = { "buffers", "curdir", "folds", "help", "tabpages", "winpos", "winsize" }

-- ShaDa persistence policy for history, registers, marks, and buffers.
-- opt.shada = "!,'500,<50,@100,s10,h"

-- Round indentation shifts to a multiple of shiftwidth.
opt.shiftround = true

-- Reduce noisy command messages.
opt.shortmess = "aoOTIcF"

-- Prefix shown before visually wrapped continuation lines.
-- opt.showbreak = "↳  "

-- Do not show partially typed normal-mode commands.
opt.showcmd = false

-- Do not show the mode; UI/statusline can handle this later.
opt.showmode = false

-- Always show the tabline; defer until buffer/tab UI is decided.
-- opt.showtabline = 2

-- Keep context columns to the left and right of the cursor.
opt.sidescrolloff = 8

-- Search case-sensitively when the pattern contains uppercase letters.
opt.smartcase = true

-- Make Tab at the start of a line respect shiftwidth.
opt.smarttab = true

-- Enable smoother scrolling in supported Neovim views.
opt.smoothscroll = true

-- Custom spellfile if spell checking is configured later.
-- opt.spellfile = vim.fs.joinpath(global.config_dir, "spell", "en.utf-8.add")

-- Open horizontal splits below and vertical splits to the right.
opt.splitbelow = true
opt.splitright = true

-- Preserve screen view when opening splits.
opt.splitkeep = "screen"

-- Do not jump to the first non-blank character after some motions.
opt.startofline = false

-- Disable swap files.
opt.swapfile = false

-- Prefer reusing existing tabs/windows when jumping to buffers.
opt.switchbuf = { "usetab", "uselast" }

-- Enable true color support.
opt.termguicolors = true

-- Enable mapping timeout handling.
opt.timeout = true

-- Keep key sequence timeout responsive.
opt.timeoutlen = 300

-- Enable terminal key-code timeout handling.
opt.ttimeout = true

-- Do not wait on terminal key-code ambiguity.
opt.ttimeoutlen = 0

-- Candidate undo directory if undo files need a dedicated location later.
-- opt.undodir = vim.fs.joinpath(global.cache_dir, "undo//")

-- Persist undo history across sessions.
opt.undofile = true

-- Lower CursorHold/update latency for diagnostics and plugins.
opt.updatetime = 200

-- View state saved by :mkview if view persistence is added later.
-- opt.viewoptions = { "folds", "cursor", "curdir", "slash", "unix" }

-- Allow block selection to move through virtual whitespace.
opt.virtualedit = "block"

-- Visual bell; disabled for a calmer UI.
-- opt.visualbell = true

-- Let selected horizontal motions wrap across line boundaries.
opt.whichwrap = "h,l,<,>,[,],~"

-- Exclude noisy files and directories from command-line completion.
opt.wildignore = {
  ".git",
  ".hg",
  ".svn",
  "*.pyc",
  "*.o",
  "*.out",
  "*.jpg",
  "*.jpeg",
  "*.png",
  "*.gif",
  "*.zip",
  "**/tmp/**",
  "*.DS_Store",
  "**/node_modules/**",
  "**/bower_modules/**",
}

-- Ignore case in command-line file completion.
opt.wildignorecase = true

-- Floating window transparency; keep opaque.
-- opt.winblend = 0

-- Use rounded borders for built-in floating windows.
opt.winborder = "rounded"

-- Candidate window sizing preferences.
-- opt.winminwidth = 10
-- opt.winwidth = 30

-- Wrap searches around the end of the file.
opt.wrapscan = true

-- Use a temporary backup while writing files.
opt.writebackup = true

-- Carry indentation from the previous line.
opt.autoindent = true

-- Wrapped-line indentation style if line wrapping is enabled later.
-- opt.breakindentopt = "shift:2,min:20"

-- Conceal behavior by mode.
-- opt.concealcursor = "niv"

-- Do not conceal text by default.
-- opt.conceallevel = 0

-- Insert spaces instead of literal tab characters.
opt.expandtab = true

-- Formatting behavior for comments and text.
opt.formatoptions = "1jcroql"

-- Break wrapped lines at word boundaries if wrapping is enabled later.
-- opt.linebreak = true

-- Show absolute and relative line numbers.
opt.number = true
opt.relativenumber = true

-- Use two-space indentation.
opt.shiftwidth = 2
opt.softtabstop = 2
opt.tabstop = 2

-- Always reserve the sign column to avoid layout shifts.
opt.signcolumn = "yes"

-- Enable smart indentation heuristics.
opt.smartindent = true

-- Stop syntax highlighting extremely long lines.
opt.synmaxcol = 2500

-- Do not enforce hard wrapping globally.
-- opt.textwidth = 80

-- Keep long lines unwrapped by default.
opt.wrap = false

-- Candidate netrw tree-style listing if netrw is re-enabled later.
-- vim.g.netrw_liststyle = 3

-- Configure built-in diagnostics display.
vim.diagnostic.config({
  severity_sort = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  virtual_text = settings.diagnostics_virtual_text and {
    spacing = 4,
    source = "if_many",
    prefix = "●",
    severity = { min = settings.diagnostics_level },
  } or false,
  float = {
    border = "rounded",
    source = true,
  },
})
