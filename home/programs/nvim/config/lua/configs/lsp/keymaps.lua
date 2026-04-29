local map = require("utils.keymap").buf_set

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("personal_lsp", { clear = true }),
  callback = function(event)
    local bufnr = event.buf

    map(bufnr, "n", "gd", vim.lsp.buf.definition, "Goto definition")
    map(bufnr, "n", "gD", vim.lsp.buf.declaration, "Goto declaration")
    map(bufnr, "n", "gi", vim.lsp.buf.implementation, "Goto implementation")
    map(bufnr, "n", "go", vim.lsp.buf.type_definition, "Goto type definition")
    map(bufnr, "n", "gr", vim.lsp.buf.references, "Goto references")
    map(bufnr, "n", "K", vim.lsp.buf.hover, "Hover")
    map(bufnr, "n", "<C-k>", vim.lsp.buf.signature_help, "Signature help")
    map(bufnr, "n", "<leader>cr", vim.lsp.buf.rename, "Rename symbol")
    map(bufnr, { "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
  end,
})
