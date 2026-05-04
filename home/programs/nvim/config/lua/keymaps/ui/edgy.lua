return {
  {
    "<C-n>",
    function()
      require("edgy").toggle("left")
    end,
    desc = "filetree: toggle",
  },
  {
    "<leader>cc",
    function()
      require("edgy").toggle("right")
    end,
    mode = { "n", "v" },
    desc = "tool: toggle codecompanion",
  },
}
