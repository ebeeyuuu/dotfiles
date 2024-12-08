return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets",
    "saadparwaiz1/cmp_luasnip",
    "windwp/nvim-autopairs",
    "js-everts/cmp-tailwind-colors",
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    local kind_icons = {
      Text = "",
      Method = "󰆧",
      Function = "󰊕",
      Constructor = "",
      Field = "󰇽",
      Variable = "󰂡",
      Class = "󰠱",
      Interface = "",
      Module = "",
      Property = "󰜢",
      Unit = "",
      Value = "󰎠",
      Enum = "",
      Keyword = "󰌋",
      Snippet = "",
      Color = "󰏘",
      File = "󰈙",
      Reference = "",
      Folder = "󰉋",
      EnumMember = "",
      Constant = "󰏿",
      Struct = "",
      Event = "",
      Operator = "󰆕",
      TypeParameter = "󰅲",
    }

    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = {
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      },
      sources = {
        { name = 'luasnip' },
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
      },
      window = {
        completion = {
          border = "rounded",
          winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
        },
        documentation = {
          border = "rounded",
          winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
        },
      },
      formatting = {
        fields = { "kind", "abbr", "menu" }, -- order of columns
        format = function(entry, item)
          item.menu = item.kind
          item = require("cmp-tailwind-colors").format(entry, item) -- Tailwind colors formatting
          if kind_icons[item.kind] then
            item.kind = kind_icons[item.kind] .. " "
          end
          return item
        end,
      },
    })

    cmp.event:on(
      'confirm_done',
      cmp_autopairs.on_confirm_done()
    )

    vim.cmd([[
      hi Pmenu guibg=NONE guifg=#616980
      hi CmpItemSelected guibg=#2a2a2a guifg=#e4e4e4
      hi CmpItemSelectedDefault guibg=#2a2a2a guifg=#e4e4e4
      hi FloatBorder guibg=NONE guifg=#616980
    ]])
  end,
}
