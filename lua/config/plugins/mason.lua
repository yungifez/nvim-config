-- [[ Configure LSP ]]

local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end

    vim.keymap.set("n", keys, func, {
      buffer = bufnr,
      desc = desc,
    })
  end

  nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
  nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

  nmap(
    "gd",
    require("telescope.builtin").lsp_definitions,
    "[G]oto [D]efinition"
  )

  nmap(
    "gr",
    require("telescope.builtin").lsp_references,
    "[G]oto [R]eferences"
  )

  nmap(
    "gI",
    require("telescope.builtin").lsp_implementations,
    "[G]oto [I]mplementation"
  )

  nmap(
    "<leader>D",
    require("telescope.builtin").lsp_type_definitions,
    "Type [D]efinition"
  )

  nmap(
    "<leader>ds",
    require("telescope.builtin").lsp_document_symbols,
    "[D]ocument [S]ymbols"
  )

  nmap(
    "<leader>ws",
    require("telescope.builtin").lsp_dynamic_workspace_symbols,
    "[W]orkspace [S]ymbols"
  )

  nmap("K", vim.lsp.buf.hover, "Hover Documentation")

  nmap(
    "<C-k>",
    vim.lsp.buf.signature_help,
    "Signature Documentation"
  )

  nmap(
    "gD",
    vim.lsp.buf.declaration,
    "[G]oto [D]eclaration"
  )

  nmap(
    "<leader>wa",
    vim.lsp.buf.add_workspace_folder,
    "[W]orkspace [A]dd Folder"
  )

  nmap(
    "<leader>wr",
    vim.lsp.buf.remove_workspace_folder,
    "[W]orkspace [R]emove Folder"
  )

  nmap(
    "<leader>wl",
    function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end,
    "[W]orkspace [L]ist Folders"
  )


  vim.api.nvim_buf_create_user_command(
    bufnr,
    "Format",
    function()
      vim.lsp.buf.format()
    end,
    {
      desc = "Format current buffer with LSP",
    }
  )
end


-- which-key groups
require("which-key").register({
  ["<leader>c"] = {
    name = "[C]ode",
    _ = "which_key_ignore",
  },

  ["<leader>d"] = {
    name = "[D]ocument",
    _ = "which_key_ignore",
  },

  ["<leader>g"] = {
    name = "[G]it",
    _ = "which_key_ignore",
  },

  ["<leader>r"] = {
    name = "[R]ename",
    _ = "which_key_ignore",
  },

  ["<leader>w"] = {
    name = "[W]orkspace",
    _ = "which_key_ignore",
  },
})


-- Mason
require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
    "html",
    "ts_ls",
    "vue_ls",
    "tailwindcss",
    "eslint",
    "intelephense",
  },
})


-- Completion capabilities
local capabilities =
    require("cmp_nvim_lsp").default_capabilities()


--------------------------------------------------
-- LSP CONFIGURATION (Neovim 0.11)
--------------------------------------------------

vim.lsp.config("lua_ls", {
  capabilities = capabilities,
  on_attach = on_attach,

  settings = {
    Lua = {
      workspace = {
        checkThirdParty = false,
      },

      telemetry = {
        enable = false,
      },
    },
  },
})


vim.lsp.config("html", {
  capabilities = capabilities,
  on_attach = on_attach,

  filetypes = {
    "html",
    "twig",
    "hbs",
    "blade",
  },
})


vim.lsp.config("vue_ls", {
  capabilities = capabilities,
  on_attach = on_attach,
})


vim.lsp.config("ts_ls", {
  capabilities = capabilities,
  on_attach = on_attach,

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

        location =
            vim.fn.stdpath("data")
            .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",

        languages = {
          "vue",
        },
      },
    },
  },
})


vim.lsp.config("tailwindcss", {
  capabilities = capabilities,
  on_attach = on_attach,
})


vim.lsp.config("eslint", {
  capabilities = capabilities,
  on_attach = on_attach,
})


vim.lsp.config("intelephense", {
  capabilities = capabilities,
  on_attach = on_attach,
})


vim.lsp.enable({
  "lua_ls",
  "html",
  "ts_ls",
  "vue_ls",
  "tailwindcss",
  "eslint",
  "intelephense",
})


--------------------------------------------------
-- nvim-cmp
--------------------------------------------------

local cmp = require("cmp")
local luasnip = require("luasnip")

require("luasnip.loaders.from_vscode").lazy_load()

luasnip.config.setup()


cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  completion = {
    completeopt = "menu,menuone,noinsert",
  },

  mapping = cmp.mapping.preset.insert({

    ["<C-n>"] =
        cmp.mapping.select_next_item(),

    ["<C-p>"] =
        cmp.mapping.select_prev_item(),

    ["<C-d>"] =
        cmp.mapping.scroll_docs(-4),

    ["<C-f>"] =
        cmp.mapping.scroll_docs(4),

    ["<C-Space>"] =
        cmp.mapping.complete(),

    ["<CR>"] =
        cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }),

    ["<Tab>"] =
        cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, {
          "i",
          "s",
        }),

    ["<S-Tab>"] =
        cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, {
          "i",
          "s",
        }),
  }),

  sources = {
    {
      name = "nvim_lsp",
    },
    {
      name = "luasnip",
    },
  },
})
