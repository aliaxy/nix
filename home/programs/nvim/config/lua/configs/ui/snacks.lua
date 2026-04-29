local settings = require("core.settings")
local global = require("core.global")

return {
  bigfile = { enabled = settings.load_big_files_faster },
  dashboard = {
    enabled = settings.dashboard_enabled,
    preset = {
      header = table.concat(settings.dashboard_header, "\n"),
      keys = {
        { icon = " ", key = "f", desc = "Find file", action = ":lua Snacks.picker.files()" },
        { icon = "󰱼 ", key = "g", desc = "Grep text", action = ":lua Snacks.picker.grep()" },
        { icon = " ", key = "r", desc = "Recent files", action = ":lua Snacks.picker.recent()" },
        { icon = " ", key = "c", desc = "Config", action = function() Snacks.picker.files({ cwd = global.config_dir }) end },
        { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
        { icon = " ", key = "q", desc = "Quit", action = ":qa" },
      },
    },
  },
  indent = {
    enabled = true,
    animate = { enabled = false },
  },
  input = { enabled = true },
  notifier = {
    enabled = true,
    timeout = 3000,
  },
  picker = {
    enabled = true,
    ui_select = true,
  },
  quickfile = { enabled = true },
  words = { enabled = true },
  styles = {
    notification = {
      wo = { wrap = true },
    },
  },
}
