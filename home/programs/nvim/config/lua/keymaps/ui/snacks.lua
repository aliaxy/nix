local system = require("utils.system")

return {
  { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart find" },
  { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
  { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
  { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command history" },
  { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete buffer" },
  { "<leader>bD", function() Snacks.bufdelete({ force = true }) end, desc = "Force delete buffer" },
  { "<leader>bo", function() Snacks.bufdelete.other() end, desc = "Delete other buffers" },
  { "<leader>ff", function() Snacks.picker.files() end, desc = "Find files" },
  { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find git files" },
  { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent files" },
  { "<leader>fc", function() Snacks.picker.files({ cwd = system.config_dir }) end, desc = "Find config files" },
  { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Find buffers" },
  { "<leader>fh", function() Snacks.picker.help() end, desc = "Help tags" },
  { "<leader>fk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
  { "<leader>sw", function() Snacks.picker.grep_word() end, mode = { "n", "x" }, desc = "Search word or selection" },
  { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
  { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer diagnostics" },
  { "<leader>uD", function() Snacks.toggle.dim():toggle() end, desc = "Toggle dim" },
}
