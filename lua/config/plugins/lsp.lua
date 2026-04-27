return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      vim.lsp.config("lua_ls", { capabilities = capabilities })
      vim.lsp.enable("lua_ls")
      vim.lsp.config("clangd", { capabilities = capabilities })
      vim.lsp.enable("clangd")
      vim.lsp.config("ruff", { capabilities = capabilities })
      vim.lsp.enable("ruff")
      vim.lsp.config("marksman", { capabilities = capabilities })
      vim.lsp.enable("marksman")
      vim.lsp.config("typescript-language-server", { capabilities = capabilities })
      vim.lsp.enable("typescript-language-server")

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = (vim.lsp.get_client_by_id(args.data.client_id))
          if not client then return end

          if client:supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
              group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
              end,
            })
          end
        end,
      })
    end,
  }
}
