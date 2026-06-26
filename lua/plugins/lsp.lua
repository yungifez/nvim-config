-- lua/plugins/lsp.lua

return {
  "neovim/nvim-lspconfig",

  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",

    { "j-hui/fidget.nvim", opts = {} },

    "folke/lazydev.nvim",

    -- Formatting
    "stevearc/conform.nvim",
  },

  config = function()
    -- Lua development
    require("lazydev").setup()

    -- Mason
    require("mason").setup()

    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "ts_ls",
        "vue_ls",
        "tailwindcss",
        "eslint",
        "intelephense",
      },
    })


    local capabilities = vim.lsp.protocol.make_client_capabilities()


    -- Lua
    vim.lsp.config("lua_ls", {
      capabilities = capabilities,

      settings = {
        Lua = {
          diagnostics = {
            globals = {
              "vim",
            },
          },

          workspace = {
            checkThirdParty = false,
          },
        },
      },
    })


    -- Typescript / Vue TS
    vim.lsp.config("ts_ls", {
      capabilities = capabilities,

      filetypes = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "vue",
      },

      init_options = {
        plugins = {
          {
            name = "@vue/typescript-plugin",

            location = vim.fn.stdpath("data")
                .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",

            languages = {
              "vue",
            },
          },
        },
      },
    })


    -- Vue
    vim.lsp.config("vue_ls", {
      capabilities = capabilities,
    })


    -- Tailwind
    vim.lsp.config("tailwindcss", {
      capabilities = capabilities,

      filetypes = {
        "html",
        "css",
        "scss",
        "javascript",
        "typescript",
        "vue",
      },
    })


    -- ESLint
    vim.lsp.config("eslint", {
      capabilities = capabilities,
    })


    -- PHP
    vim.lsp.config("intelephense", {
      capabilities = capabilities,
    })


    -- Enable servers
    vim.lsp.enable({
      "lua_ls",
      "ts_ls",
      "vue_ls",
      "tailwindcss",
      "eslint",
      "intelephense",
    })


    -- Formatting
    require("conform").setup({
      formatters_by_ft = {
        vue = {
          "prettier",
        },

        javascript = {
          "prettier",
        },

        typescript = {
          "prettier",
        },

        javascriptreact = {
          "prettier",
        },

        typescriptreact = {
          "prettier",
        },

        json = {
          "prettier",
        },

        css = {
          "prettier",
        },

        html = {
          "prettier",
        },

        lua = {
          "stylua",
        },

        php = {
          "php_cs_fixer",
        },
      },

      format_on_save = {
        timeout_ms = 500,

        lsp_format = "fallback",
      },
    })


    -- Keymaps
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(event)
        local opts = {
          buffer = event.buf,
        }


        vim.keymap.set(
          "n",
          "gd",
          vim.lsp.buf.definition,
          opts
        )


        vim.keymap.set(
          "n",
          "K",
          vim.lsp.buf.hover,
          opts
        )


        vim.keymap.set(
          "n",
          "gr",
          vim.lsp.buf.references,
          opts
        )


        vim.keymap.set(
          "n",
          "<leader>rn",
          vim.lsp.buf.rename,
          opts
        )


        vim.keymap.set(
          "n",
          "<leader>ca",
          vim.lsp.buf.code_action,
          opts
        )


        vim.keymap.set(
          "n",
          "<leader>f",
          function()
            require("conform").format({
              async = true,
              lsp_fallback = true,
            })
          end,
          opts
        )
      end,
    })
  end,
}
