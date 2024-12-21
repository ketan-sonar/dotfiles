return {
  "neovim/nvim-lspconfig",
  dependencies = {
    {
      "williamboman/mason.nvim",
      opts = {},
    },
    {
      "williamboman/mason-lspconfig.nvim",
      dependencies = { "saghen/blink.cmp" },
      opts = {},
      config = function()
        local capabilities = require("blink.cmp").get_lsp_capabilities()

        local on_attach = function()
          local telescope_builtin = require("telescope.builtin")

          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})

          vim.keymap.set("n", "gd", telescope_builtin.lsp_definitions, {})
          vim.keymap.set("n", "gI", telescope_builtin.lsp_implementations, {})
          vim.keymap.set("n", "gr", telescope_builtin.lsp_references, {})
          vim.keymap.set("n", "gf", vim.lsp.buf.format, {})

          vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
        end

        require("lspconfig").dartls.setup({
          cmd = { "fvm", "dart", "language-server", "--protocol=lsp" },
          filetypes = { "dart" },
          init_options = {
            closingLabels = true,
            flutterOutline = true,
            onlyAnalyzeProjectsWithOpenFiles = true,
            outline = true,
            suggestFromUnimportedLibraries = true,
          },
          -- root_dir = root_pattern("pubspec.yaml"),
          settings = {
            dart = {
              completeFunctionCalls = true,
              showTodos = true,
            },
          },
          on_attach = on_attach,
        })

        require("mason-lspconfig").setup_handlers({
          -- The first entry (without a key) will be the default handler
          -- and will be called for each installed server that doesn't have
          -- a dedicated handler.
          function (server_name) -- default handler (optional)
            require("lspconfig")[server_name].setup {
              capabilities = capabilities,
              on_attach = on_attach,
            }
          end,
          -- Next, you can provide a dedicated handler for specific servers.
          -- For example, a handler override for the `rust_analyzer`:
          -- ["rust_analyzer"] = function ()
            --   require("rust-tools").setup {}
            -- end
          })
        end,
      },
    },
    config = function()
      -- local lspconfig = require("lspconfig")

      -- vim.api.nvim_create_autocmd('LspAttach', {
        --   callback = function(args)
          --     local client = vim.lsp.get_client_by_id(args.data.client_id)
          --     if client.supports_method('textDocument/rename') then
          --       -- Create a keymap for vim.lsp.buf.rename()
          --       vim.keymap.set("n", "<leader>rn", function()
            --         vim.ui.input({ prompt = "New Name: " }, function(newName)
              --           vim.lsp.buf.rename(newName)
              --         end)
              --       end)
              --     end
              --     if client.supports_method('textDocument/implementation') then
              --       -- Create a keymap for vim.lsp.buf.implementation
              --       vim.keymap.set("n", "gI", function() vim.lsp.buf.implementation() end)
              --     end
              --   end,
              -- })
            end,
          }
