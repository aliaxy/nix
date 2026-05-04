return function()
  local _, utils = pcall(require, "dropbar.utils")
  local _, sources = pcall(require, "dropbar.sources")

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
        menu = { indicator = "" },
      },
    },
  }
end
