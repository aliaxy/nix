return function()
  local icons = {
    ui = require("utils.icons").get("ui"),
  }
  local ok_utils, utils = pcall(require, "dropbar.utils")
  local ok_sources, sources = pcall(require, "dropbar.sources")
  if not ok_utils or not ok_sources then
    return {}
  end

  -- Show only the leaf filename before appending semantic breadcrumbs.
  sources.symbols = {
    get_symbols = function(buf, win, cursor)
      local symbols = sources.path.get_symbols(buf, win, cursor)
      return { symbols[#symbols] }
    end,
  }

  return {
    bar = {
      hover = false,
      truncate = true,
      pick = { pivots = "etovxqpdygfblzhckisuran" },
      sources = function(buf)
        if vim.bo[buf].ft == "markdown" then
          return {
            sources.symbols,
            sources.markdown,
          }
        end

        if vim.bo[buf].buftype == "terminal" then
          return {
            sources.terminal,
          }
        end

        return {
          sources.symbols,
          utils.source.fallback({
            sources.lsp,
            sources.treesitter,
          }),
        }
      end,
    },
    sources = {
      terminal = {
        name = function(buf)
          return vim.api.nvim_buf_get_name(buf)
        end,
      },
    },
    icons = {
      enable = true,
      ui = {
        bar = { separator = "  " },
        menu = { indicator = icons.ui.ArrowClosed },
      },
    },
  }
end
