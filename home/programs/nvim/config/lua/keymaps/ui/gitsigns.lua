local M = {}

-- Keep gitsigns mappings buffer-local so they only exist after gitsigns attaches.
local function map(bufnr, mode, lhs, rhs, desc, opts)
  opts = opts or {}
  opts.buffer = bufnr
  opts.desc = desc
  vim.keymap.set(mode, lhs, rhs, opts)
end

function M.on_attach(bufnr)
  local gitsigns = require("gitsigns")

  -- Preserve built-in diff navigation when the current window is in diff mode.
  map(bufnr, "n", "]g", function()
    if vim.wo.diff then
      return "]g"
    end
    vim.schedule(function()
      gitsigns.nav_hunk("next")
    end)
    return "<Ignore>"
  end, "git: goto next hunk", { expr = true })

  map(bufnr, "n", "[g", function()
    if vim.wo.diff then
      return "[g"
    end
    vim.schedule(function()
      gitsigns.nav_hunk("prev")
    end)
    return "<Ignore>"
  end, "git: goto previous hunk", { expr = true })

  -- Hunk actions use the current hunk in normal mode and the selected range in visual mode.
  map(bufnr, "n", "<leader>gs", gitsigns.stage_hunk, "git: toggle hunk staged")
  map(bufnr, "v", "<leader>gs", function()
    gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
  end, "git: toggle selection staged")

  map(bufnr, "n", "<leader>gr", gitsigns.reset_hunk, "git: reset hunk")
  map(bufnr, "v", "<leader>gr", function()
    gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
  end, "git: reset selection")

  map(bufnr, "n", "<leader>gR", gitsigns.reset_buffer, "git: reset buffer")
  map(bufnr, "n", "<leader>gp", gitsigns.preview_hunk, "git: preview hunk")
  map(bufnr, "n", "<leader>gb", function()
    gitsigns.blame_line({ full = true })
  end, "git: blame line")
  map(bufnr, { "o", "x" }, "ih", gitsigns.select_hunk, "git: hunk text object")
end

return M
