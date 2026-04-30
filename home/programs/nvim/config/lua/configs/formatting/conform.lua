local system = require("utils.system")
local settings = require("core.settings")

local function first_available(names)
  local available = {}
  for _, name in ipairs(names) do
    if system.executable(name) then
      table.insert(available, name)
    end
  end
  available.stop_after_first = true
  return available
end

return {
  formatters_by_ft = vim.tbl_map(first_available, settings.formatters_by_ft),
  default_format_opts = {
    lsp_format = "fallback",
    timeout_ms = settings.format_timeout,
  },
  notify_on_error = settings.format_notify,
  notify_no_formatters = settings.format_notify,
  format_on_save = settings.format_on_save and {
    lsp_format = "fallback",
    timeout_ms = settings.format_timeout,
  } or nil,
}
