local options = {
  -- Behavior ---------------------------------------------------------------

  mode = "buffers",
  themable = true,
  -- style_preset = require("bufferline").style_preset.minimal,
  -- style_preset = {
  --   require("bufferline").style_preset.no_bold,
  --   require("bufferline").style_preset.no_italic,
  -- },

  -- Mouse and close actions ------------------------------------------------

  close_command = function(bufnr)
    Snacks.bufdelete({ buf = bufnr })
  end,
  right_mouse_command = function(bufnr)
    Snacks.bufdelete({ buf = bufnr })
  end,
  left_mouse_command = "buffer %d",
  -- middle_mouse_command = nil,

  -- Labels and numbers -----------------------------------------------------

  numbers = "none",
  -- numbers = "ordinal",
  -- numbers = "buffer_id",
  -- numbers = "both",
  -- numbers = function(opts)
  --   return string.format("%s:%s", opts.ordinal, opts.id)
  -- end,
  name_formatter = nil,
  truncate_names = true,
  max_name_length = 18,
  max_prefix_length = 15,
  tab_size = 18,
  enforce_regular_tabs = false,

  -- Icons and indicators ---------------------------------------------------

  indicator = {
    icon = "▎",
    style = "icon",
    -- style = "underline",
    -- style = "none",
  },
  buffer_close_icon = "󰅖",
  modified_icon = "●",
  close_icon = "",
  left_trunc_marker = "",
  right_trunc_marker = "",
  separator_style = "thin",
  -- separator_style = "thick",
  -- separator_style = "slant",
  -- separator_style = "padded_slant",
  -- separator_style = "slope",
  -- separator_style = { "", "" },

  color_icons = true,
  show_buffer_icons = true,
  show_buffer_close_icons = true,
  show_close_icon = true,
  show_tab_indicators = true,
  show_duplicate_prefix = true,
  duplicates_across_groups = true,
  -- get_element_icon = function(element)
  --   local icon, hl = require("nvim-web-devicons").get_icon_by_filetype(element.filetype, { default = false })
  --   return icon, hl
  -- end,

  -- Visibility -------------------------------------------------------------

  always_show_bufferline = true,
  auto_toggle_bufferline = true,

  -- Diagnostics ------------------------------------------------------------

  diagnostics = "nvim_lsp",
  diagnostics_indicator = function(count)
    return " (" .. count .. ")"
  end,
  diagnostics_update_on_event = true,
  -- diagnostics_update_in_insert = true,
  -- diagnostics_indicator = function(count, level, diagnostics_dict, context)
  --   if context.buffer:current() then
  --     return ""
  --   end
  --   local icon = level:match("error") and " " or " "
  --   return " " .. icon .. count
  -- end,

  -- Sorting and persistence ------------------------------------------------

  sort_by = "id",
  persist_buffer_sort = true,
  move_wraps_at_ends = false,
  -- sort_by = "extension",
  -- sort_by = "directory",
  -- sort_by = "tabs",
  -- sort_by = function(buffer_a, buffer_b)
  --   return buffer_a.id < buffer_b.id
  -- end,

  -- Filtering --------------------------------------------------------------

  -- custom_filter = function(bufnr, bufnrs)
  --   local filetype = vim.bo[bufnr].filetype
  --   return filetype ~= "qf" and filetype ~= "help"
  -- end,

  -- Sidebar offsets --------------------------------------------------------

  offsets = {
    -- {
    --   filetype = "snacks_picker",
    --   text = "Explorer",
    --   text_align = "center",
    --   separator = true,
    --   padding = 0,
    -- },
    -- {
    --   filetype = "NvimTree",
    --   text = "File Explorer",
    --   text_align = "center",
    --   separator = true,
    --   padding = 0,
    -- },
    -- {
    --   filetype = "trouble",
    --   text = "Diagnostics",
    --   text_align = "center",
    --   separator = true,
    --   padding = 0,
    -- },
  },

  -- Groups -----------------------------------------------------------------

  groups = {
    items = {
      -- require("bufferline.groups").builtin.pinned:with({ icon = "󰐃" }),
      -- {
      --   name = "Tests",
      --   matcher = function(buf)
      --     return buf.name:match("_test") or buf.name:match("%.spec")
      --   end,
      -- },
    },
    options = {
      toggle_hidden_on_enter = true,
    },
  },

  -- Hover and picking ------------------------------------------------------

  hover = {
    enabled = false,
    delay = 200,
    reveal = { "close" },
  },

  pick = {
    alphabet = "abcdefghijklmopqrstuvwxyzABCDEFGHIJKLMOPQRSTUVWXYZ1234567890",
  },

  -- Advanced areas ---------------------------------------------------------

  -- custom_areas = {
  --   right = function()
  --     return {}
  --   end,
  -- },

  -- Debug ------------------------------------------------------------------

  debug = {
    logging = false,
  },
}

local highlights = {}

if vim.g.colors_name and vim.g.colors_name:find("catppuccin") then
  highlights = require("catppuccin.special.bufferline").get_theme({
    styles = { "italic", "bold" },
    custom = {
      all = {
        hint = { fg = "#f5e0dc" },
        hint_visible = { fg = "#f5e0dc" },
        hint_selected = { fg = "#f5e0dc" },
        hint_diagnostic = { fg = "#f5e0dc" },
        hint_diagnostic_visible = { fg = "#f5e0dc" },
        hint_diagnostic_selected = { fg = "#f5e0dc" },
      },
    },
  })
end

return {
  options = options,
  highlights = highlights,
}
