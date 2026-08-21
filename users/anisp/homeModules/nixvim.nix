{
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [inputs.nixvim.homeModules.nixvim];

  stylix.targets.nixvim.enable = false;

  programs.nixvim = {
    enable = true;
    nixpkgs.source = inputs.nixpkgs;
    luaLoader.enable = true;
    extraPackages = [pkgs.alejandra];

    globals = {
      maplocalleader = ",";
      mapleader = " ";
    };

    opts = {
      scrolloff = 10;
      tabclose = "uselast";
      backspace = "indent,eol,start,nostop";
      breakindent = true;
      cmdheight = 0;
      completeopt = "menu,menuone,noselect";
      confirm = true;
      copyindent = true;
      cursorline = true;
      diffopt = "internal,filler,closeoff,algorithm:histogram,linematch:60";
      expandtab = true;
      fillchars = "eob: ";
      ignorecase = true;
      infercase = true;
      laststatus = 3;
      linebreak = true;
      mouse = "a";
      number = true;
      preserveindent = true;
      pumheight = 10;
      relativenumber = true;
      shiftround = true;
      shiftwidth = 2;
      showmode = false;
      showtabline = 1;
      signcolumn = "yes";
      smartcase = true;
      splitbelow = true;
      splitright = true;
      tabstop = 2;
      termguicolors = true;
      timeoutlen = 500;
      title = true;
      updatetime = 300;
      clipboard = "unnamedplus";
      virtualedit = "block";
      wrap = false;
      writebackup = false;
      shortmess = "FsIcC";
      undofile = true;
      backup = false;
      swapfile = false;
    };

    withNodeJs = false;
    withPython3 = false;

    plugins.diffview.enable = true;

    colorschemes.rose-pine = {
      enable = true;
      settings = {
        variant = "main";
        dark_variant = "main";
        dim_inactive_windows = false;
        styles = {
          transparency = false;
        };
      };
    };

    plugins.dap.enable = true;
    plugins.dap-ui.enable = true;

    plugins.nvim-surround.enable = true;
    plugins.flash.enable = true;

    plugins.snacks = {
      enable = true;
      settings = {
        animate.enabled = true;
        bigfile.enabled = true;
        gitbrowse.enabled = true;
        indent.enabled = true;
        notifier.enabled = false;
        quickfile.enabled = true;
        rename.enabled = true;
        scope.enabled = true;
        scroll.enabled = true;
        statuscolumn.enabled = true;
        terminal.enabled = true;
        toggle.enabled = true;
        words.enabled = true;
        zen.enabled = true;
      };
    };

    plugins.neo-tree = {
      enable = true;
      settings = {
        filesystem = {
          use_libuv_file_watcher = true;
          filtered_items = {
            hide_git_ignored = false;
          };
          window = {
            position = "float";
            popup = {
              position = {
                col = "100%";
                row = "2";
              };
              size = {
                __raw = ''
                  function(state)
                    local root_name = vim.fn.fnamemodify(state.path, ":~")
                    local root_len = string.len(root_name) + 4
                    return {
                      width = math.max(root_len, 50),
                      height = vim.o.lines - 6
                    }
                  end
                '';
              };
            };
          };
        };
        git_status = {
          window = {
            position = "float";
            popup = {
              position = {
                col = "100%";
                row = "2";
              };
              size = {
                __raw = ''
                  function(state)
                    local root_name = vim.fn.fnamemodify(state.path, ":~")
                    local root_len = string.len(root_name) + 4
                    return {
                      width = math.max(root_len, 50),
                      height = vim.o.lines - 6
                    }
                  end
                '';
              };
            };
          };
        };
        buffers = {
          window = {
            position = "float";
            popup = {
              position = {
                col = "100%";
                row = "2";
              };
              size = {
                __raw = ''
                  function(state)
                    local root_name = vim.fn.fnamemodify(state.path or "", ":~")
                    local root_len = string.len(root_name) + 4
                    return {
                      width = math.max(root_len, 50),
                      height = vim.o.lines - 6
                    }
                  end
                '';
              };
            };
          };
        };
      };
    };

    plugins.rainbow-delimiters.enable = true;
    plugins.web-devicons.enable = true;

    plugins.todo-comments.enable = true;
    plugins.fidget.enable = true;
    plugins.treesitter-context.enable = true;
    plugins.trouble.enable = true;

    diagnostic = {
      settings = {
        virtual_text = true;
        virtual_lines = false;
      };
    };

    plugins.lsp = {
      enable = true;
      inlayHints = true;
      servers = {
        tailwindcss.enable = true;
        roslyn_ls.enable = true;
        zls = {
          enable = true;
          cmd = ["zls"];
        };
        luau_lsp = {
          enable = true;
          cmd = [(lib.getExe pkgs.luau-lsp) "lsp"];
          filetypes = ["luau"];
          rootMarkers = [".git"];
        };
        vue_ls.enable = true;
        vtsls.enable = true;
        # ts_ls.enable = true;
        denols.enable = true;
        clangd.enable = true;
        cssls.enable = true;
        gopls = {
          enable = true;
          settings = {
            gopls = {
              hints = {
                assignVariableTypes = true;
                compositeLiteralFields = true;
                compositeLiteralTypes = true;
                constantValues = true;
                functionTypeParameters = true;
                parameterNames = true;
                rangeVariableTypes = true;
              };
            };
          };
        };
        qmlls.enable = true;
        html.enable = true;
        jdtls.enable = true;
        jsonls.enable = true;
        taplo.enable = true;
        yamlls.enable = true;
        lua_ls.enable = true;
        nixd.enable = true;
        rust_analyzer = {
          enable = true;
          installRustc = false;
          installCargo = false;
        };
        sqls.enable = true;
        svelte.enable = true;
        slint_lsp.enable = true;
      };
    };

    plugins.conform-nvim = {
      enable = true;
      settings = {
        format_on_save = {
          timeout_ms = 3000;
          lsp_fallback = true;
        };
        formatters_by_ft = {
          typescript = ["oxfmt"];
          javascript = ["oxfmt"];
          typescriptreact = ["oxfmt"];
          javascriptreact = ["oxfmt"];
          vue = {
            __raw = ''{ "oxfmt", "lsp", stop_after_first = true }'';
          };
          lua = ["stylua"];
          luau = ["stylua"];
          go = ["gofumpt"];
          nix = ["alejandra"];
        };
        formatters = {
          stylua = {
            command = lib.getExe pkgs.stylua;
            args = ["--search-parent-directories" "--respect-ignores" "--stdin-filepath" "$FILENAME" "-"];
            range_args = {
              __raw = ''
                function(self, ctx)
                    local util = require("conform.util")
                    local start_offset, end_offset = util.get_offsets_from_range(ctx.buf, ctx.range)
                    return {
                      "--search-parent-directories",
                      "--stdin-filepath",
                      "$FILENAME",
                      "--range-start",
                      tostring(start_offset),
                      "--range-end",
                      tostring(end_offset),
                      "-",
                    }
                  end
              '';
            };
            cwd = {
              __raw = ''require("conform.util").root_file({ ".stylua.toml", "stylua.toml" })'';
            };
            require_cwd = true;
          };
          oxfmt = {
            command = {
              __raw = ''
                function(self, ctx)
                    local root = require("conform.util").root_file({ "package.json", ".git" })(self, ctx)
                    local local_cmd = root and root .. "/node_modules/.bin/oxfmt"
                    if local_cmd and vim.fn.executable(local_cmd) == 1 then
                      return local_cmd
                    end
                    return "oxfmt"
                  end
              '';
            };
            args = ["--stdin-filepath" "$FILENAME"];
            cwd = {
              __raw = ''require("conform.util").root_file({ ".oxfmtrc.json", ".oxfmtrc.jsonc", "package.json" })'';
            };
            require_cwd = false;
            stdin = true;
          };
        };
      };
    };

    plugins.fzf-lua = {
      enable = true;
      profile = "fzf-native";
    };

    plugins.gitsigns = {
      enable = true;
      settings = {
        on_attach = {
          __raw = ''
            function(bufnr)
              local gs = package.loaded.gitsigns
              local function map(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
              end

              -- Navigation
              map('n', ']c', function()
                if vim.wo.diff then return ']c' end
                vim.schedule(function() gs.next_hunk() end)
                return '<Ignore>'
              end, {expr = true, desc = "Next Hunk"})

              map('n', '[c', function()
                if vim.wo.diff then return '[c' end
                vim.schedule(function() gs.prev_hunk() end)
                return '<Ignore>'
              end, {expr = true, desc = "Prev Hunk"})

              -- Actions
              map('n', '<leader>hs', gs.stage_hunk, {desc = "Stage Hunk"})
              map('n', '<leader>hr', gs.reset_hunk, {desc = "Reset Hunk"})
              map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, {desc = "Stage Hunk"})
              map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, {desc = "Reset Hunk"})
              map('n', '<leader>hS', gs.stage_buffer, {desc = "Stage Buffer"})
              map('n', '<leader>hu', gs.undo_stage_hunk, {desc = "Undo Stage Hunk"})
              map('n', '<leader>hR', gs.reset_buffer, {desc = "Reset Buffer"})
              map('n', '<leader>hP', gs.preview_hunk, {desc = "Preview Hunk"})
              map('n', '<leader>hb', function() gs.blame_line{full=true} end, {desc = "Blame Line"})
              map('n', '<leader>tb', gs.toggle_current_line_blame, {desc = "Toggle Blame"})
              map('n', '<leader>hd', '<cmd>DiffviewOpen -- %<CR>', {desc = "Diff This"})
              map('n', '<leader>hD', '<cmd>DiffviewOpen<CR>', {desc = "Diff Project"})
              map('n', '<leader>td', gs.toggle_deleted, {desc = "Toggle Deleted"})

              -- Text object
              map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', {desc = "Select Hunk"})
            end
          '';
        };
      };
    };
    plugins.neogit.enable = true;

    plugins.blink-cmp = {
      enable = true;
      settings = {
        signature = {
          enabled = true;
          window = {
            border = "single";
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder";
          };
        };
        completion = {
          documentation = {
            auto_show = true;
            auto_show_delay_ms = 0;
            window = {
              border = "single";
              winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpDocCursorLine,Search:None";
            };
          };
          menu = {
            border = "single";
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpMenuSelection,Search:None";
          };
        };
        cmdline = {
          enabled = false;
          keymap = {preset = "inherit";};
        };
        keymap.preset = "enter";
      };
    };
    plugins.friendly-snippets.enable = true;

    plugins.nvim-autopairs.enable = true;
    plugins.lualine = {
      enable = true;
      settings = {
        options = {
          always_divide_middle = true;
          component_separators = {
            left = "";
            right = "";
          };
          disabled_filetypes = {
            statusline = ["alpha"];
            winbar = [];
          };
          globalstatus = true;
          icons_enabled = true;
          ignore_focus = ["NvimTree"];
          refresh = {
            statusline = 1000;
            tabline = 1000;
            winbar = 1000;
          };
          section_separators = {
            left = "";
            right = "";
          };
          theme = "auto";
        };
        extensions = [
          "neo-tree"
          {
            filetypes = [
              "snacks_picker_list"
              "snacks_picker_input"
            ];
            sections = {
              lualine_a = [
                {
                  __raw = ''
                    function()
                      return vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
                    end
                  '';
                }
              ];
            };
          }
        ];
        sections = {
          lualine_a = [
            {
              __unkeyed = "mode";
              icons_enabled = true;
              separator = {
                left = "▎";
                right = "";
              };
            }
            {
              __unkeyed = "";
              draw_empty = true;
              separator = {
                left = "";
                right = "";
              };
            }
          ];
          lualine_b = [
            {
              __unkeyed = "filetype";
              colored = true;
              icon_only = true;
              icon = {
                align = "left";
              };
            }
            {
              __unkeyed = "filename";
              symbols = {
                modified = " ";
                readonly = " ";
              };
              separator = {
                right = "";
              };
            }
            {
              __unkeyed = "";
              draw_empty = true;
              separator = {
                left = "";
                right = "";
              };
            }
          ];
          lualine_c = [
            {
              __unkeyed = "diff";
              colored = false;
              diff_color = {
                added = "DiffAdd";
                modified = "DiffChange";
                removed = "DiffDelete";
              };
              symbols = {
                added = "+";
                modified = "~";
                removed = "-";
              };
              separator = {
                right = "";
              };
            }
          ];
          lualine_x = [
            {
              __unkeyed = {
                __raw = ''
                  function()
                    local buf_ft = vim.bo.filetype
                    local excluded_buf_ft = { toggleterm = true, NvimTree = true, ["neo-tree"] = true, TelescopePrompt = true }

                    if excluded_buf_ft[buf_ft] then
                      return ""
                    end

                    local bufnr = vim.api.nvim_get_current_buf()
                    local clients = vim.lsp.get_clients({ bufnr = bufnr })

                    if vim.tbl_isempty(clients) then
                      return "No Active LSP"
                    end

                    local active_clients = {}
                    for _, client in ipairs(clients) do
                      table.insert(active_clients, client.name)
                    end

                    return table.concat(active_clients, ", ")
                  end
                '';
              };
              icon = " ";
              separator = {
                left = "";
              };
            }
            {
              __unkeyed = "diagnostics";
              sources = ["nvim_lsp" "nvim_diagnostic" "vim_lsp"];
              symbols = {
                error = "󰅙  ";
                warn = "  ";
                info = "  ";
                hint = "󰌵 ";
              };
              colored = true;
              update_in_insert = false;
              always_visible = false;
              diagnostics_color = {
                color_error = {fg = "red";};
                color_warn = {fg = "yellow";};
                color_info = {fg = "cyan";};
              };
            }
          ];
          lualine_y = [
            {
              __unkeyed = "";
              draw_empty = true;
              separator = {
                left = "";
                right = "";
              };
            }
            {
              __unkeyed = "searchcount";
              maxcount = 999;
              timeout = 120;
              separator = {
                left = "";
              };
            }
            {
              __unkeyed = "branch";
              icon = " •";
              separator = {
                left = "";
              };
            }
          ];
          lualine_z = [
            {
              __unkeyed = "";
              draw_empty = true;
              separator = {
                left = "";
                right = "";
              };
            }
            {
              __unkeyed = "progress";
              separator = {
                left = "";
              };
            }
            {
              __unkeyed = "location";
            }
            {
              __unkeyed = "fileformat";
              color = {
                fg = "black";
              };
              symbols = {
                unix = "";
                dos = "";
                mac = "";
              };
            }
          ];
        };
      };
    };

    plugins.bufferline = {
      enable = true;
      settings.options = {
        always_show_bufferline = false;
        numbers = "none";
      };
    };

    plugins.which-key = {
      enable = true;
      settings = {
        preset = "helix";
        spec = [
          {
            __unkeyed-1 = "<leader>b";
            group = "Buffers";
          }
          {
            __unkeyed-1 = "<leader>bs";
            group = "Sort buffers";
          }
          {
            __unkeyed-1 = "<leader>d";
            group = "Debugger";
          }
          {
            __unkeyed-1 = "<leader>f";
            group = "Find";
          }
          {
            __unkeyed-1 = "<leader>g";
            group = "Git";
          }
          {
            __unkeyed-1 = "<leader>l";
            group = "LSP";
          }
          {
            __unkeyed-1 = "<leader>t";
            group = "Terminal";
          }
          {
            __unkeyed-1 = "<leader>u";
            group = "UI/UX";
          }
          {
            __unkeyed-1 = "<leader>x";
            group = "Lists";
          }
        ];
      };
    };

    plugins.comment.enable = true;
    plugins.colorful-menu.enable = true;
    plugins.colorizer.enable = true;

    plugins.ts-autotag.enable = true;
    plugins.treesitter = {
      enable = true;
      settings = {
        highlight.enable = true;
        indent.enable = true;
      };
    };
    plugins.treesitter-textobjects.enable = true;

    plugins.markview.enable = true;
    plugins.crates = {
      enable = true;
      settings = {
        completion.crates.enabled = true;
        lsp = {
          enabled = true;
          actions = true;
          completion = true;
          hover = true;
        };
      };
    };

    plugins.neocord.enable = true;

    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "gopher-nvim";
        src = pkgs.fetchFromGitHub {
          owner = "olexsmir";
          repo = "gopher.nvim";
          rev = "v0.1.0";
          hash = "sha256-PNoN9DVH0qGdF5cJax5QVRNGF+5Xz4AYAQ80ZHwZH8I=";
        };
        doCheck = false;
      })
    ];

    extraConfigLua = ''
      -- 1. Colorscheme & Neovide Scale Factor Configuration
      vim.cmd("colorscheme rose-pine")

      -- Change scale factor for Neovide (gui client) with Ctrl+Equal / Ctrl+Minus
      local change_scale_factor = function(delta)
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
      end
      vim.keymap.set("n", "<C-=>", function()
        change_scale_factor(1.25)
      end)
      vim.keymap.set("n", "<C-->", function()
        change_scale_factor(1/1.25)
      end)

      -- 2. Neovim 0.12+ Experimental UI2 Layer Configuration
      -- Safely enable native floating command-line and non-interrupting message grid
      pcall(function()
        require('vim._core.ui2').enable({
          msg = { targets = "msg" }
        })
      end)

      -- Gopher.nvim Setup (Go development utility)
      pcall(function()
        require('gopher').setup({})
      end)

      -- 3. Custom LSP: oxfmt (Oxc Formatter)
      vim.lsp.config('oxfmt', {
        -- Detect and execute local node_modules/.bin/oxfmt if present, falling back to global
        cmd = function(dispatchers, config)
          local cmd = 'oxfmt'
          local local_cmd = (config or {}).root_dir and config.root_dir .. '/node_modules/.bin/oxfmt'
          if local_cmd and vim.fn.executable(local_cmd) == 1 then
            cmd = local_cmd
          end
          return vim.lsp.rpc.start({ cmd, '--lsp' }, dispatchers)
        end,
        filetypes = {
          "javascript", "javascriptreact", "typescript", "typescriptreact",
          "toml", "json", "jsonc", "json5", "yaml", "html", "vue",
          "handlebars", "css", "scss", "less", "graphql", "markdown"
        },
        workspace_required = true,
        -- Determine root path by searching up for .oxfmtrc config files or package.json configured with oxfmt
        root_dir = function(bufnr, on_dir)
          local filename = vim.api.nvim_buf_get_name(bufnr)
          local root_markers = { '.oxfmtrc.json', '.oxfmtrc.jsonc' }

          local pkg_path = vim.fs.find('package.json', { path = filename, upward = true })[1]
          if pkg_path then
            local f = io.open(pkg_path, 'r')
            if f then
              local content = f:read('*a')
              f:close()
              local ok, pkg = pcall(vim.json.decode, content)
              if ok and pkg and pkg.oxfmt then
                table.insert(root_markers, 'package.json')
              end
            end
          end

          local found = vim.fs.find(root_markers, { path = filename, upward = true })[1]
          if found then
            on_dir(vim.fs.dirname(found))
          end
        end
      })
      vim.lsp.enable('oxfmt')

      -- 4. Custom LSP: oxlint (Oxc Linter)
      vim.lsp.config('oxlint', {
        -- Detect and execute local node_modules/.bin/oxlint if present
        cmd = function(dispatchers, config)
          local cmd = 'oxlint'
          local local_cmd = (config or {}).root_dir and config.root_dir .. '/node_modules/.bin/oxlint'
          if local_cmd and vim.fn.executable(local_cmd) == 1 then
            cmd = local_cmd
          end
          return vim.lsp.rpc.start({ cmd, '--lsp' }, dispatchers)
        end,
        filetypes = {
          "javascript", "javascriptreact", "typescript", "typescriptreact",
          "vue", "svelte", "astro"
        },
        root_markers = { ".oxlintrc.json", "oxlint.config.ts" },
        workspace_required = true,
        -- Register user command to apply all linter automatic fixes
        on_attach = function(client, bufnr)
          vim.api.nvim_buf_create_user_command(bufnr, 'LspOxlintFixAll', function()
            client:exec_cmd({
              title = 'Apply Oxlint automatic fixes',
              command = 'oxc.fixAll',
              arguments = { { uri = vim.uri_from_bufnr(bufnr) } },
            })
          end, {
            desc = 'Apply Oxlint automatic fixes',
          })
        end,
        -- Enable type-aware linting dynamically if typescript is present in the configuration file
        before_attach = function(init_params, config)
          local settings = config.settings or {}

          if settings.typeAware == nil and vim.fn.executable('tsgolint') == 1 then
            local ok, res = pcall(function()
              local fn = vim.fs.joinpath(config.root_dir, '.oxlintrc.json')
              for line in io.lines(fn) do
                if line:find('typescript') then
                  return true
                end
              end
              return false
            end)

            if ok and res then
              settings = vim.tbl_extend('force', settings, { typeAware = true })
            end
          end

          local init_options = config.init_options or {}
          init_options.settings = vim.tbl_extend('force', init_options.settings or {}, settings)

          init_params.initializationOptions = init_options
        end
      })
      vim.lsp.enable('oxlint')

      -- 5. LSP Setup: eslint (ESLint Language Server)
      vim.lsp.config('eslint', {
        -- Detect and execute local node_modules/.bin/eslint if present
        cmd = function(dispatchers, config)
          local cmd = 'vscode-eslint-language-server'
          if (config or {}).root_dir then
            local local_cmd = vim.fs.joinpath(config.root_dir, 'node_modules/.bin', cmd)
            if vim.fn.executable(local_cmd) == 1 then
              cmd = local_cmd
            end
          end
          return vim.lsp.rpc.start({ cmd, '--stdio' }, dispatchers)
        end,
        filetypes = {
          "javascript", "javascriptreact", "typescript", "typescriptreact",
          "vue", "svelte", "astro", "htmlangular"
        },
        workspace_required = true,
        -- Register buffer-local command to run ESLint automatic fixes
        on_attach = function(client, bufnr)
          vim.api.nvim_buf_create_user_command(bufnr, 'LspEslintFixAll', function()
            client:request_sync('workspace/executeCommand', {
              command = 'eslint.applyAllFixes',
              arguments = {
                {
                  uri = vim.uri_from_bufnr(bufnr),
                  version = vim.api.nvim_buf_get_var(bufnr, 'changedtick'),
                }
              }
            }, 1000, bufnr)
          end, {
            desc = 'Fix all ESLint auto-fixable problems',
          })
        end,
        -- Resolve project root directory, excluding Deno environments, and verifying config existence
        root_dir = function(bufnr, on_dir)
          local filename = vim.api.nvim_buf_get_name(bufnr)
          if filename == "" then return end

          local root_markers = { 'package-lock.json', 'yarn.lock', 'pnpm-lock.yaml', 'bun.lockb', 'bun.lock', '.git' }

          if vim.fs.root(bufnr, { 'deno.json', 'deno.jsonc', 'deno.lock' }) then
            return
          end

          local project_root = vim.fs.root(bufnr, root_markers) or vim.fn.getcwd()

          local eslint_config_files = {
            '.eslintrc', '.eslintrc.js', '.eslintrc.cjs', '.eslintrc.yaml', '.eslintrc.yml', '.eslintrc.json',
            'eslint.config.js', 'eslint.config.mjs', 'eslint.config.cjs', 'eslint.config.ts', 'eslint.config.mts', 'eslint.config.cts'
          }

          local is_buffer_using_eslint = vim.fs.find(eslint_config_files, {
            path = filename,
            type = 'file',
            limit = 1,
            upward = true,
            stop = vim.fs.dirname(project_root),
          })[1]

          if not is_buffer_using_eslint then
            local pkg_path = vim.fs.find('package.json', {
              path = filename,
              type = 'file',
              limit = 1,
              upward = true,
              stop = vim.fs.dirname(project_root),
            })[1]

            if pkg_path then
              local f = io.open(pkg_path, 'r')
              if f then
                local content = f:read('*a')
                f:close()
                local ok, pkg = pcall(vim.json.decode, content)
                if ok and pkg and pkg.eslintConfig then
                  is_buffer_using_eslint = pkg_path
                end
              end
            end
          end

          if not is_buffer_using_eslint then
            return
          end

          on_dir(project_root)
        end,
        settings = {
          validate = "on",
          packageManager = nil,
          useESLintClass = false,
          experimental = {},
          codeActionOnSave = {
            enable = false,
            mode = "all",
          },
          format = false,
          quiet = false,
          onIgnoredFiles = "off",
          rulesCustomizations = {},
          run = "onType",
          problems = {
            shortenToSingleLine = false,
          },
          nodePath = "",
          workingDirectory = { mode = "auto" },
          codeAction = {
            disableRuleComment = {
              enable = true,
              location = "separateLine",
            },
            showDocumentation = {
              enable = true,
            },
          },
        },
        -- Map root directory to VSCode-compatible workspaceFolder schema & support Yarn PnP
        before_init = function(_, config)
          local root_dir = config.root_dir
          if root_dir then
            config.settings = config.settings or {}
            config.settings.workspaceFolder = {
              uri = root_dir,
              name = vim.fn.fnamemodify(root_dir, ':t'),
            }

            local pnp_cjs = root_dir .. '/.pnp.cjs'
            local pnp_js = root_dir .. '/.pnp.js'
            if type(config.cmd) == 'table' and (vim.uv.fs_stat(pnp_cjs) or vim.uv.fs_stat(pnp_js)) then
              config.cmd = vim.list_extend({ 'yarn', 'exec' }, config.cmd)
            end
          end
        end,
        -- Register VSCode-compatible LSP custom event handlers
        handlers = {
          ["eslint/openDoc"] = function(_, result)
            if result then
              vim.ui.open(result.url)
            end
            return {}
          end,
          ["eslint/confirmESLintExecution"] = function(_, result)
            if not result then
              return
            end
            return 4 -- Auto-approved
          end,
          ["eslint/probeFailed"] = function()
            vim.notify('[vim.lsp.config] ESLint probe failed.', vim.log.levels.WARN)
            return {}
          end,
          ["eslint/noLibrary"] = function()
            vim.notify('[vim.lsp.config] Unable to find ESLint library.', vim.log.levels.WARN)
            return {}
          end,
        }
      })
      vim.lsp.enable('eslint')

      -- Neo-tree Title Restore Configuration
      vim.g.neotree_title_restore_enabled = true
      vim.g.neotree_prev_title = nil

      local function update_neotree_title()
        local ft = vim.bo.filetype
        if ft == "neo-tree" then
          if vim.g.neotree_title_restore_enabled and vim.g.neotree_prev_title then
            vim.opt.titlestring = vim.g.neotree_prev_title
          else
            vim.opt.titlestring = ""
          end
        else
          -- Save title for regular file buffers only
          if vim.bo.buftype == "" then
            local filename = vim.fn.expand("%:t")
            if filename == "" then
              filename = "[No Name]"
            end
            local modified = vim.bo.modified and " [+]" or ""
            local dir = vim.fn.expand("%:~:h")
            vim.g.neotree_prev_title = filename .. modified .. " (" .. dir .. ") - Nvim"
          end
          vim.opt.titlestring = ""
        end
      end

      local title_group = vim.api.nvim_create_augroup("NeotreeTitleRestore", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter", "FileType" }, {
        group = title_group,
        callback = update_neotree_title,
      })

      vim.api.nvim_create_user_command("ToggleNeotreeTitleRestore", function()
        if vim.g.neotree_title_restore_enabled then
          vim.g.neotree_title_restore_enabled = false
          vim.notify("Neo-tree title restore disabled", vim.log.levels.INFO)
          if vim.bo.filetype == "neo-tree" then
            vim.opt.titlestring = ""
          end
        else
          vim.g.neotree_title_restore_enabled = true
          vim.notify("Neo-tree title restore enabled", vim.log.levels.INFO)
          if vim.bo.filetype == "neo-tree" and vim.g.neotree_prev_title then
            vim.opt.titlestring = vim.g.neotree_prev_title
          end
        end
      end, {})
    '';

    keymaps = [
      {
        mode = "n";
        key = "<leader>ue";
        action = "<cmd>ToggleNeotreeTitleRestore<CR>";
        options = {
          silent = true;
          desc = "Toggle Neo-tree title restore";
        };
      }
      {
        mode = "n";
        key = "<C-Up>";
        action = "<cmd>resize +2<CR>";
        options = {
          silent = true;
          desc = "Resize up";
        };
      }
      {
        mode = "n";
        key = "<C-Down>";
        action = "<cmd>resize -2<CR>";
        options = {
          silent = true;
          desc = "Resize Down";
        };
      }
      {
        mode = "n";
        key = "<C-Left>";
        action = "<cmd>vertical resize -2<CR>";
        options = {
          silent = true;
          desc = "Resize Left";
        };
      }
      {
        mode = "n";
        key = "<C-Right>";
        action = "<cmd>vertical resize +2<CR>";
        options = {
          silent = true;
          desc = "Resize Right";
        };
      }
      {
        mode = "n";
        key = "<C-k>";
        action = "<C-w>k";
        options = {
          silent = true;
          desc = "Up Window";
        };
      }
      {
        mode = "n";
        key = "<C-j>";
        action = "<C-w>j";
        options = {
          silent = true;
          desc = "Down Window";
        };
      }
      {
        mode = "n";
        key = "<C-h>";
        action = "<C-w>h";
        options = {
          silent = true;
          desc = "Left Window";
        };
      }
      {
        mode = "n";
        key = "<C-l>";
        action = "<C-w>l";
        options = {
          silent = true;
          desc = "Right Window";
        };
      }
      {
        mode = ["n" "i" "v"];
        key = "<C-s>";
        action = "<cmd>w!<CR>";
        options = {
          silent = true;
          desc = "Force Write";
        };
      }
      {
        mode = "n";
        key = "<C-q>";
        action = "<cmd>qa!<CR>";
        options = {
          silent = true;
          desc = "Force Quit";
        };
      }
      {
        mode = "n";
        key = "<leader>n";
        action = "<cmd>enew<CR>";
        options = {
          silent = true;
          desc = "New File";
        };
      }
      {
        mode = "n";
        key = "<leader>R";
        action.__raw = "function() Snacks.rename.rename_file() end";
        options = {
          silent = true;
          desc = "Rename Current File";
        };
      }
      {
        mode = "n";
        key = "<leader>c";
        action = "<cmd>bdelete<CR>";
        options = {
          silent = true;
          desc = "Close Buffer";
        };
      }
      {
        mode = "n";
        key = "\\";
        action = "<cmd>split<CR>";
        options = {
          silent = true;
          desc = "Horizontal Split";
        };
      }
      {
        mode = "n";
        key = "|";
        action = "<cmd>vsplit<CR>";
        options = {
          silent = true;
          desc = "Vertical Split";
        };
      }
      {
        mode = "n";
        key = "]b";
        action = "<cmd>bnext<CR>";
        options = {
          silent = true;
          desc = "Next Buffer";
        };
      }
      {
        mode = "n";
        key = "[b";
        action = "<cmd>bprevious<CR>";
        options = {
          silent = true;
          desc = "Previous Buffer";
        };
      }
      {
        mode = "n";
        key = ">b";
        action.__raw = "function() vim.cmd('BufferLineMoveNext') end";
        options = {
          silent = true;
          desc = "Move Buffer Right";
        };
      }
      {
        mode = "n";
        key = "<b";
        action.__raw = "function() vim.cmd('BufferLineMovePrev') end";
        options = {
          silent = true;
          desc = "Move Buffer Left";
        };
      }
      {
        mode = "n";
        key = "<leader>bb";
        action = "<cmd>FzfLua buffers<CR>";
        options = {
          silent = true;
          desc = "Navigate to buffer tab with interactive picker";
        };
      }
      {
        mode = "n";
        key = "<leader>bc";
        action.__raw = "function() vim.cmd('%bd|e#|bd#') end";
        options = {
          silent = true;
          desc = "Close all buffers except the current";
        };
      }
      {
        mode = "n";
        key = "<leader>bC";
        action = "<cmd>%bd<CR>";
        options = {
          silent = true;
          desc = "Close all buffers";
        };
      }
      {
        mode = "n";
        key = "<leader>bd";
        action = "<cmd>FzfLua buffers<CR>";
        options = {
          silent = true;
          desc = "Delete a buffer tab with interactive picker";
        };
      }
      {
        mode = "n";
        key = "<leader>bl";
        action.__raw = "function() vim.cmd('BufferLineCloseRight') end";
        options = {
          silent = true;
          desc = "Close all buffers to the left of the current";
        };
      }
      {
        mode = "n";
        key = "<leader>bp";
        action = "<cmd>bprevious<CR>";
        options = {
          silent = true;
          desc = "Go to the previous buffer";
        };
      }
      {
        mode = "n";
        key = "<leader>br";
        action.__raw = "function() vim.cmd('BufferLineCloseLeft') end";
        options = {
          silent = true;
          desc = "Close all buffers to the right of the current";
        };
      }
      {
        mode = "n";
        key = "<leader>bse";
        action.__raw = "function() vim.cmd('BufferLineSortByExtension') end";
        options = {
          silent = true;
          desc = "Sort buffers by extension";
        };
      }
      {
        mode = "n";
        key = "<leader>bsi";
        action.__raw = "function() vim.cmd('BufferLineSortByRelativeDirectory') end";
        options = {
          silent = true;
          desc = "Sort buffers by buffer number";
        };
      }
      {
        mode = "n";
        key = "<leader>bsm";
        action.__raw = "function() vim.cmd('BufferLineSortByTabs') end";
        options = {
          silent = true;
          desc = "Sort buffers by last modification";
        };
      }
      {
        mode = "n";
        key = "<leader>bsp";
        action.__raw = "function() vim.cmd('BufferLineSortByDirectory') end";
        options = {
          silent = true;
          desc = "Sort buffers by full path";
        };
      }
      {
        mode = "n";
        key = "<leader>bsr";
        action.__raw = "function() vim.cmd('BufferLineSortByRelativeDirectory') end";
        options = {
          silent = true;
          desc = "Sort buffers by relative path";
        };
      }
      {
        mode = "n";
        key = "<leader>b\\";
        action = "<cmd>FzfLua buffers<CR>";
        options = {
          silent = true;
          desc = "Open a buffer tab in a new horizontal split with interactive picker";
        };
      }
      {
        mode = "n";
        key = "<leader>b|";
        action = "<cmd>FzfLua buffers<CR>";
        options = {
          silent = true;
          desc = "Open a buffer tab in a new vertical split with interactive picker";
        };
      }
      {
        mode = "n";
        key = "]t";
        action = "<cmd>tabnext<CR>";
        options = {
          silent = true;
          desc = "Next Tab (real vim tab)";
        };
      }
      {
        mode = "n";
        key = "[t";
        action = "<cmd>tabprevious<CR>";
        options = {
          silent = true;
          desc = "Previous Tab (real vim tab)";
        };
      }
      {
        mode = "n";
        key = "<leader>/";
        action = "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>";
        options = {
          silent = true;
          desc = "Toggle comment of current line";
        };
      }
      {
        mode = "v";
        key = "<leader>/";
        action = "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>";
        options = {
          silent = true;
          desc = "Toggle comment of current line";
        };
      }
      {
        mode = "n";
        key = "gco";
        action = "o<Esc>gcc";
        options = {
          silent = true;
          desc = "Insert comment below current line";
        };
      }
      {
        mode = "n";
        key = "gcO";
        action = "O<Esc>gcc";
        options = {
          silent = true;
          desc = "Insert comment above current line";
        };
      }

      {
        mode = "n";
        key = "<leader>xx";
        action = "<cmd>Trouble diagnostics toggle<CR>";
        options = {
          silent = true;
          desc = "Trouble diagnostics (Workspace)";
        };
      }
      {
        mode = "n";
        key = "<leader>xX";
        action = "<cmd>Trouble diagnostics toggle filter.buf=0<CR>";
        options = {
          silent = true;
          desc = "Trouble diagnostics (Buffer)";
        };
      }
      {
        mode = "n";
        key = "<leader>xq";
        action = "<cmd>Trouble qflist toggle<CR>";
        options = {
          silent = true;
          desc = "Trouble Quickfix";
        };
      }
      {
        mode = "n";
        key = "]q";
        action = "<cmd>cnext<CR>";
        options = {
          silent = true;
          desc = "Next Quickfix Entry";
        };
      }
      {
        mode = "n";
        key = "[q";
        action = "<cmd>cprevious<CR>";
        options = {
          silent = true;
          desc = "Previous Quickfix Entry";
        };
      }
      {
        mode = "n";
        key = "]Q";
        action = "<cmd>clast<CR>";
        options = {
          silent = true;
          desc = "Last Quickfix Entry";
        };
      }
      {
        mode = "n";
        key = "[Q";
        action = "<cmd>cfirst<CR>";
        options = {
          silent = true;
          desc = "First Quickfix Entry";
        };
      }
      {
        mode = "n";
        key = "<leader>xl";
        action = "<cmd>Trouble loclist toggle<CR>";
        options = {
          silent = true;
          desc = "Trouble Loclist";
        };
      }
      {
        mode = "n";
        key = "]l";
        action = "<cmd>lnext<CR>";
        options = {
          silent = true;
          desc = "Next Local List Entry";
        };
      }
      {
        mode = "n";
        key = "[l";
        action = "<cmd>lprevious<CR>";
        options = {
          silent = true;
          desc = "Previous Local List Entry";
        };
      }
      {
        mode = "n";
        key = "]L";
        action = "<cmd>llast<CR>";
        options = {
          silent = true;
          desc = "Last Local List Entry";
        };
      }
      {
        mode = "n";
        key = "[L";
        action = "<cmd>lfirst<CR>";
        options = {
          silent = true;
          desc = "First Local List Entry";
        };
      }
      {
        mode = "i";
        key = "jj";
        action = "<Esc>";
        options = {
          silent = true;
          desc = "Escape key";
        };
      }
      {
        mode = "i";
        key = "jk";
        action = "<Esc>";
        options = {
          silent = true;
          desc = "Escape key";
        };
      }
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>silent!Neotree toggle<CR>";
        options = {
          silent = true;
          desc = "Neotree toggle";
        };
      }
      {
        mode = "n";
        key = "<leader>o";
        action = "<cmd>silent!Neotree focus<CR>";
        options = {
          silent = true;
          desc = "Neotree focus";
        };
      }
      {
        mode = "n";
        key = "<leader>li";
        action = "<cmd>LspInfo<CR>";
        options = {
          silent = true;
          desc = "LSP Info";
        };
      }
      {
        mode = "n";
        key = "K";
        action = "<cmd>lua vim.lsp.buf.hover({ border = 'single' })<CR>";
        options = {
          silent = true;
          desc = "Hover Document";
        };
      }
      {
        mode = "n";
        key = "<leader>lf";
        action.__raw = ''
          function()
            require("conform").format({ async = true, lsp_fallback = true })
          end
        '';
        options = {
          silent = true;
          desc = "Format Document (Conform/LSP)";
        };
      }
      {
        mode = "n";
        key = "<leader>lF";
        action.__raw = ''
          function()
            require("conform").format({ async = true, lsp_fallback = true })
          end
        '';
        options = {
          silent = true;
          desc = "Format Document (Conform/LSP)";
        };
      }

      {
        mode = "n";
        key = "<leader>lS";
        action = "<cmd>FzfLua lsp_document_symbols<CR>";
        options = {
          silent = true;
          desc = "Document Symbols";
        };
      }
      {
        mode = "n";
        key = "gl";
        action = "<cmd>lua vim.diagnostic.open_float()<CR>";
        options = {
          silent = true;
          desc = "Line Diagnostics";
        };
      }
      {
        mode = "n";
        key = "<leader>ld";
        action = "<cmd>lua vim.diagnostic.open_float()<CR>";
        options = {
          silent = true;
          desc = "Line Diagnostics";
        };
      }
      {
        mode = "n";
        key = "<C-W>d";
        action = "<cmd>lua vim.diagnostic.open_float()<CR>";
        options = {
          silent = true;
          desc = "Line Diagnostics";
        };
      }
      {
        mode = "n";
        key = "<leader>lD";
        action = "<cmd>FzfLua diagnostics_document<CR>";
        options = {
          silent = true;
          desc = "All Diagnostics";
        };
      }
      {
        mode = "n";
        key = "<leader>la";
        action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
        options = {
          silent = true;
          desc = "Code Actions";
        };
      }
      {
        mode = "n";
        key = "gra";
        action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
        options = {
          silent = true;
          desc = "Code Actions";
        };
      }
      {
        mode = "n";
        key = "<leader>lA";
        action = "<cmd>lua vim.lsp.buf.code_action({ context = { only = {'source'} } })<CR>";
        options = {
          silent = true;
          desc = "Source Code Actions";
        };
      }
      {
        mode = "n";
        key = "<leader>lh";
        action = "<cmd>lua vim.lsp.buf.signature_help({ border = 'single' })<CR>";
        options = {
          silent = true;
          desc = "Signature Help";
        };
      }
      {
        mode = "n";
        key = "<leader>lr";
        action = "<cmd>lua vim.lsp.buf.rename()<CR>";
        options = {
          silent = true;
          desc = "Rename";
        };
      }
      {
        mode = "n";
        key = "grn";
        action = "<cmd>lua vim.lsp.buf.rename()<CR>";
        options = {
          silent = true;
          desc = "Rename";
        };
      }
      {
        mode = "n";
        key = "<leader>ls";
        action = "<cmd>FzfLua lsp_document_symbols<CR>";
        options = {
          silent = true;
          desc = "Document Symbols";
        };
      }
      {
        mode = "n";
        key = "<leader>lG";
        action = "<cmd>FzfLua lsp_workspace_symbols<CR>";
        options = {
          silent = true;
          desc = "Workspace Symbols";
        };
      }
      {
        mode = "n";
        key = "]d";
        action = "<cmd>lua vim.diagnostic.goto_next()<CR>";
        options = {
          silent = true;
          desc = "Diagnostic Next";
        };
      }
      {
        mode = "n";
        key = "[d";
        action = "<cmd>lua vim.diagnostic.goto_prev()<CR>";
        options = {
          silent = true;
          desc = "Diagnostics Previous";
        };
      }
      {
        mode = "n";
        key = "]e";
        action = "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>";
        options = {
          silent = true;
          desc = "Diagnostic Error Next";
        };
      }
      {
        mode = "n";
        key = "[e";
        action = "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>";
        options = {
          silent = true;
          desc = "Diagnostic Error Previous";
        };
      }
      {
        mode = "n";
        key = "]w";
        action = "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.WARN})<CR>";
        options = {
          silent = true;
          desc = "Diagnostic Warning Next";
        };
      }
      {
        mode = "n";
        key = "[w";
        action = "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.WARN})<CR>";
        options = {
          silent = true;
          desc = "Diagnostic Warning Previous";
        };
      }
      {
        mode = "n";
        key = "]y";
        action.__raw = "function() require('nvim-treesitter.textobjects.repeatable_move').goto_next_start('@function.outer') end";
        options = {
          silent = true;
          desc = "Document Symbol Next";
        };
      }
      {
        mode = "n";
        key = "[y";
        action.__raw = "function() require('nvim-treesitter.textobjects.repeatable_move').goto_previous_start('@function.outer') end";
        options = {
          silent = true;
          desc = "Document Symbol Previous";
        };
      }
      {
        mode = "n";
        key = "gO";
        action = "<cmd>FzfLua lsp_document_symbols<CR>";
        options = {
          silent = true;
          desc = "Document Symbol";
        };
      }
      {
        mode = "n";
        key = "gD";
        action = "<cmd>lua vim.lsp.buf.declaration()<CR>";
        options = {
          silent = true;
          desc = "Declaration";
        };
      }
      {
        mode = "n";
        key = "gy";
        action = "<cmd>lua vim.lsp.buf.type_definition()<CR>";
        options = {
          silent = true;
          desc = "Type Definition";
        };
      }
      {
        mode = "n";
        key = "gd";
        action = "<cmd>lua vim.lsp.buf.definition()<CR>";
        options = {
          silent = true;
          desc = "Definition";
        };
      }
      {
        mode = "n";
        key = "gri";
        action = "<cmd>lua vim.lsp.buf.implementation()<CR>";
        options = {
          silent = true;
          desc = "Implementation";
        };
      }
      {
        mode = "n";
        key = "grr";
        action = "<cmd>lua vim.lsp.buf.references()<CR>";
        options = {
          silent = true;
          desc = "References";
        };
      }
      {
        mode = "n";
        key = "<leader>lR";
        action = "<cmd>lua vim.lsp.buf.references()<CR>";
        options = {
          silent = true;
          desc = "References";
        };
      }
      {
        mode = "n";
        key = "<leader>dc";
        action = "<cmd>lua require('dap').continue()<CR>";
        options = {
          silent = true;
          desc = "Start/Continue Debugger";
        };
      }
      {
        mode = "n";
        key = "<F5>";
        action = "<cmd>lua require('dap').continue()<CR>";
        options = {
          silent = true;
          desc = "Start/Continue Debugger";
        };
      }
      {
        mode = "n";
        key = "<leader>dp";
        action = "<cmd>lua require('dap').pause()<CR>";
        options = {
          silent = true;
          desc = "Pause Debugger";
        };
      }
      {
        mode = "n";
        key = "<F6>";
        action = "<cmd>lua require('dap').pause()<CR>";
        options = {
          silent = true;
          desc = "Pause Debugger";
        };
      }
      {
        mode = "n";
        key = "<leader>dr";
        action = "<cmd>lua require('dap').restart()<CR>";
        options = {
          silent = true;
          desc = "Restart Debugger";
        };
      }
      {
        mode = "n";
        key = "<C-F5>";
        action = "<cmd>lua require('dap').restart()<CR>";
        options = {
          silent = true;
          desc = "Restart Debugger";
        };
      }
      {
        mode = "n";
        key = "<leader>ds";
        action = "<cmd>lua require('dap').run_to_cursor()<CR>";
        options = {
          silent = true;
          desc = "Run Debugger to Cursor";
        };
      }
      {
        mode = "n";
        key = "<leader>dq";
        action = "<cmd>lua require('dap').close()<CR>";
        options = {
          silent = true;
          desc = "Close Debugger Session";
        };
      }
      {
        mode = "n";
        key = "<leader>dQ";
        action = "<cmd>lua require('dap').terminate()<CR>";
        options = {
          silent = true;
          desc = "Terminate Debugger";
        };
      }
      {
        mode = "n";
        key = "<S-F5>";
        action = "<cmd>lua require('dap').terminate()<CR>";
        options = {
          silent = true;
          desc = "Terminate Debugger";
        };
      }
      {
        mode = "n";
        key = "<leader>db";
        action = "<cmd>lua require('dap').toggle_breakpoint()<CR>";
        options = {
          silent = true;
          desc = "Toggle Breakpoint";
        };
      }
      {
        mode = "n";
        key = "<F9>";
        action = "<cmd>lua require('dap').toggle_breakpoint()<CR>";
        options = {
          silent = true;
          desc = "Toggle Breakpoint";
        };
      }
      {
        mode = "n";
        key = "<leader>dC";
        action = "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>";
        options = {
          silent = true;
          desc = "Conditional Breakpoint";
        };
      }
      {
        mode = "n";
        key = "<S-F9>";
        action = "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>";
        options = {
          silent = true;
          desc = "Conditional Breakpoint";
        };
      }
      {
        mode = "n";
        key = "<leader>dB";
        action = "<cmd>lua require('dap').clear_breakpoints()<CR>";
        options = {
          silent = true;
          desc = "Clear Breakpoints";
        };
      }
      {
        mode = "n";
        key = "<leader>do";
        action = "<cmd>lua require('dap').step_over()<CR>";
        options = {
          silent = true;
          desc = "Step Over";
        };
      }
      {
        mode = "n";
        key = "<F10>";
        action = "<cmd>lua require('dap').step_over()<CR>";
        options = {
          silent = true;
          desc = "Step Over";
        };
      }
      {
        mode = "n";
        key = "<leader>di";
        action = "<cmd>lua require('dap').step_into()<CR>";
        options = {
          silent = true;
          desc = "Step Into";
        };
      }
      {
        mode = "n";
        key = "<F11>";
        action = "<cmd>lua require('dap').step_into()<CR>";
        options = {
          silent = true;
          desc = "Step Into";
        };
      }
      {
        mode = "n";
        key = "<leader>dO";
        action = "<cmd>lua require('dap').step_out()<CR>";
        options = {
          silent = true;
          desc = "Step Out";
        };
      }
      {
        mode = "n";
        key = "<S-F11>";
        action = "<cmd>lua require('dap').step_out()<CR>";
        options = {
          silent = true;
          desc = "Step Out";
        };
      }
      {
        mode = "n";
        key = "<leader>dE";
        action = "<cmd>lua require('dapui').eval()<CR>";
        options = {
          silent = true;
          desc = "Evaluate Expression";
        };
      }
      {
        mode = "n";
        key = "<leader>dR";
        action = "<cmd>lua require('dap').repl.toggle()<CR>";
        options = {
          silent = true;
          desc = "Toggle REPL";
        };
      }
      {
        mode = "n";
        key = "<leader>du";
        action = "<cmd>lua require('dapui').toggle()<CR>";
        options = {
          silent = true;
          desc = "Toggle Debugger UI";
        };
      }
      {
        mode = "n";
        key = "<leader>dh";
        action = "<cmd>lua require('dapui').eval()<CR>";
        options = {
          silent = true;
          desc = "Debugger Hover";
        };
      }
      {
        mode = "n";
        key = "<leader>f<CR>";
        action = "<cmd>FzfLua resume<CR>";
        options = {
          silent = true;
          desc = "Resume previous search";
        };
      }
      {
        mode = "n";
        key = "<leader>f'";
        action = "<cmd>FzfLua marks<CR>";
        options = {
          silent = true;
          desc = "Marks";
        };
      }
      {
        mode = "n";
        key = "<leader>fb";
        action = "<cmd>FzfLua buffers<CR>";
        options = {
          silent = true;
          desc = "Buffers";
        };
      }
      {
        mode = "n";
        key = "<leader>fc";
        action = "<cmd>FzfLua grep_cword<CR>";
        options = {
          silent = true;
          desc = "Word at cursor";
        };
      }
      {
        mode = "n";
        key = "<leader>fC";
        action = "<cmd>FzfLua commands<CR>";
        options = {
          silent = true;
          desc = "Commands";
        };
      }
      {
        mode = "n";
        key = "<leader>ff";
        action = "<cmd>FzfLua files<CR>";
        options = {
          silent = true;
          desc = "Find files";
        };
      }
      {
        mode = "n";
        key = "<leader>fF";
        action = "<cmd>FzfLua files hidden=true<CR>";
        options = {
          silent = true;
          desc = "Find files (include hidden files)";
        };
      }
      {
        mode = "n";
        key = "<leader>fg";
        action = "<cmd>FzfLua git_files<CR>";
        options = {
          silent = true;
          desc = "Git tracked files";
        };
      }
      {
        mode = "n";
        key = "<leader>fh";
        action = "<cmd>FzfLua help_tags<CR>";
        options = {
          silent = true;
          desc = "Help Tags";
        };
      }
      {
        mode = "n";
        key = "<leader>fk";
        action = "<cmd>FzfLua keymaps<CR>";
        options = {
          silent = true;
          desc = "Keymaps";
        };
      }
      {
        mode = "n";
        key = "<leader>fl";
        action = "<cmd>FzfLua lines<CR>";
        options = {
          silent = true;
          desc = "Lines";
        };
      }
      {
        mode = "n";
        key = "<leader>fm";
        action = "<cmd>FzfLua man_pages<CR>";
        options = {
          silent = true;
          desc = "Man Pages";
        };
      }
      {
        mode = "n";
        key = "<leader>fn";
        action.__raw = "function() Snacks.notifier.show_history() end";
        options = {
          silent = true;
          desc = "Notifications";
        };
      }
      {
        mode = "n";
        key = "<leader>fo";
        action = "<cmd>FzfLua oldfiles<CR>";
        options = {
          silent = true;
          desc = "Old Files";
        };
      }
      {
        mode = "n";
        key = "<leader>fO";
        action = "<cmd>FzfLua oldfiles cwd_only=true<CR>";
        options = {
          silent = true;
          desc = "Old Files (current directory)";
        };
      }
      {
        mode = "n";
        key = "<leader>fr";
        action = "<cmd>FzfLua registers<CR>";
        options = {
          silent = true;
          desc = "Registers";
        };
      }
      {
        mode = "n";
        key = "<leader>ft";
        action = "<cmd>FzfLua colorschemes<CR>";
        options = {
          silent = true;
          desc = "Colorschemes";
        };
      }
      {
        mode = "n";
        key = "<leader>fu";
        action = "<cmd>FzfLua changes<CR>";
        options = {
          silent = true;
          desc = "Undo History";
        };
      }
      {
        mode = "n";
        key = "<leader>fw";
        action = "<cmd>FzfLua live_grep<CR>";
        options = {
          silent = true;
          desc = "Live Grep";
        };
      }
      {
        mode = "n";
        key = "<leader>fW";
        action = "<cmd>FzfLua live_grep hidden=true<CR>";
        options = {
          silent = true;
          desc = "Live Grep (include hidden files)";
        };
      }
      {
        mode = "n";
        key = "<leader>gs";
        action = "<cmd>Neogit<CR>";
        options = {
          silent = true;
          desc = "Git Status [Neogit]";
        };
      }
      {
        mode = "n";
        key = "<leader>gb";
        action = "<cmd>FzfLua git_branches<CR>";
        options = {
          silent = true;
          desc = "Git Branches";
        };
      }
      {
        mode = "n";
        key = "<leader>gc";
        action = "<cmd>FzfLua git_commits<CR>";
        options = {
          silent = true;
          desc = "Git Commits (repository)";
        };
      }
      {
        mode = "n";
        key = "<leader>gC";
        action = "<cmd>FzfLua git_bcommits<CR>";
        options = {
          silent = true;
          desc = "Git Commits (current file)";
        };
      }
      {
        mode = "n";
        key = "<leader>go";
        action.__raw = "function() Snacks.gitbrowse() end";
        options = {
          silent = true;
          desc = "Git browse (open)";
        };
      }
      {
        mode = "n";
        key = "<leader>gt";
        action = "<cmd>FzfLua git_status<CR>";
        options = {
          silent = true;
          desc = "Git Status";
        };
      }
      {
        mode = "n";
        key = "<leader>gT";
        action = "<cmd>FzfLua git_stash<CR>";
        options = {
          silent = true;
          desc = "Git Stash";
        };
      }
      {
        mode = "n";
        key = "<leader>gd";
        action = "<cmd>DiffviewOpen -- %<CR>";
        options = {
          silent = true;
          desc = "Diff Current File [Diffview]";
        };
      }
      {
        mode = "n";
        key = "<leader>gD";
        action = "<cmd>DiffviewOpen<CR>";
        options = {
          silent = true;
          desc = "Diff Project [Diffview]";
        };
      }
      {
        mode = "n";
        key = "<leader>gq";
        action = "<cmd>DiffviewClose<CR>";
        options = {
          silent = true;
          desc = "Close Diffview";
        };
      }
      {
        mode = "n";
        key = "<leader>hd";
        action = "<cmd>DiffviewOpen -- %<CR>";
        options = {
          silent = true;
          desc = "Diff Current File [Diffview]";
        };
      }
      {
        mode = "n";
        key = "<leader>hD";
        action = "<cmd>DiffviewOpen<CR>";
        options = {
          silent = true;
          desc = "Diff Project [Diffview]";
        };
      }
      {
        mode = "n";
        key = "<leader>hq";
        action = "<cmd>DiffviewClose<CR>";
        options = {
          silent = true;
          desc = "Close Diffview";
        };
      }
      {
        mode = "n";
        key = "<leader>tf";
        action.__raw = "function() Snacks.terminal.toggle(nil, {win={position='float'}}) end";
        options = {
          silent = true;
          desc = "Open Floating Terminal";
        };
      }
      {
        mode = "n";
        key = "<leader>th";
        action.__raw = "function() Snacks.terminal.toggle(nil, { win = {position = 'bottom' }}) end";
        options = {
          silent = true;
          desc = "Open Horizontal Terminal";
        };
      }
      {
        mode = "n";
        key = "<leader>tv";
        action.__raw = "function() Snacks.terminal.toggle(nil, { win = { position = 'right'} }) end";
        options = {
          silent = true;
          desc = "Open Vertical Terminal";
        };
      }
      {
        mode = "n";
        key = "<leader>tl";
        action = "<cmd>Neogit<CR>";
        options = {
          silent = true;
          desc = "Open Toggle Neogit";
        };
      }
      {
        mode = "n";
        key = "<leader>tn";
        action.__raw = "function() Snacks.terminal.toggle('node') end";
        options = {
          silent = true;
          desc = "Open Toggle node";
        };
      }
      {
        mode = "n";
        key = "<leader>tp";
        action.__raw = "function() Snacks.terminal.toggle('python') end";
        options = {
          silent = true;
          desc = "Open Toggle Python";
        };
      }
      {
        mode = "n";
        key = "<leader>tt";
        action.__raw = "function() Snacks.terminal.toggle() end";
        options = {
          silent = true;
          desc = "Open Toggle btm";
        };
      }
      {
        mode = ["n" "t"];
        key = "<F7>";
        action.__raw = "function() Snacks.terminal.toggle() end";
        options = {
          silent = true;
          desc = "Toggle Current Terminal";
        };
      }
      {
        mode = ["n" "t"];
        key = "<C-'>";
        action.__raw = "function() Snacks.terminal.toggle() end";
        options = {
          silent = true;
          desc = "Toggle Current Terminal";
        };
      }
      {
        mode = "n";
        key = "<leader>ua";
        action.__raw = "function() if require('nvim-autopairs').state.disabled then require('nvim-autopairs').enable() else require('nvim-autopairs').disable() end end";
        options = {
          silent = true;
          desc = "Toggle autopairs";
        };
      }
      {
        mode = "n";
        key = "<leader>ub";
        action.__raw = "function() Snacks.toggle.option('background', { off = 'light', on = 'dark' }):toggle() end";
        options = {
          silent = true;
          desc = "Toggle light/dark background";
        };
      }
      {
        mode = "n";
        key = "<leader>ud";
        action.__raw = "function() Snacks.toggle.diagnostics():toggle() end";
        options = {
          silent = true;
          desc = "Toggle diagnostics";
        };
      }
      {
        mode = "n";
        key = "<leader>uf";
        action.__raw = "function() Snacks.toggle.new({ name = 'Auto Format (Buffer)', get = function() return not vim.b.disableFormatSave end, set = function(state) vim.b.disableFormatSave = not state end }):toggle() end";
        options = {
          silent = true;
          desc = "Toggle autoformat (buffer)";
        };
      }
      {
        mode = "n";
        key = "<leader>uF";
        action.__raw = "function() Snacks.toggle.new({ name = 'Auto Format (Global)', get = function() return vim.g.formatsave end, set = function(state) vim.g.formatsave = state end }):toggle() end";
        options = {
          silent = true;
          desc = "Toggle autoformat (global)";
        };
      }
      {
        mode = "n";
        key = "<leader>ug";
        action.__raw = "function() Snacks.toggle.option('signcolumn', { off = 'no', on = 'yes' }):toggle() end";
        options = {
          silent = true;
          desc = "Toggle signcolumn";
        };
      }
      {
        mode = "n";
        key = "<leader>u>";
        action.__raw = "function() Snacks.toggle.option('foldcolumn', { off = '0', on = '1' }):toggle() end";
        options = {
          silent = true;
          desc = "Toggle foldcolumn";
        };
      }
      {
        mode = "n";
        key = "<leader>u|";
        action.__raw = "function() Snacks.toggle.indent():toggle() end";
        options = {
          silent = true;
          desc = "Toggle indent guides";
        };
      }
      {
        mode = "n";
        key = "<leader>uH";
        action.__raw = "function() Snacks.toggle.inlay_hints():toggle() end";
        options = {
          silent = true;
          desc = "Toggle LSP inlay hints (global)";
        };
      }
      {
        mode = "n";
        key = "<leader>ul";
        action.__raw = "function() Snacks.toggle.option('laststatus', { off = 0, on = 3 }):toggle() end";
        options = {
          silent = true;
          desc = "Toggle statusline";
        };
      }
      {
        mode = "n";
        key = "<leader>ut";
        action.__raw = "function() Snacks.toggle.option('showtabline', { off = 0, on = 2 }):toggle() end";
        options = {
          silent = true;
          desc = "Toggle tabline";
        };
      }
      {
        mode = "n";
        key = "<leader>un";
        action.__raw = "function() Snacks.toggle.line_number():toggle() end";
        options = {
          silent = true;
          desc = "Toggle line numbers";
        };
      }
      {
        mode = "n";
        key = "<leader>up";
        action.__raw = "function() Snacks.toggle.option('paste'):toggle() end";
        options = {
          silent = true;
          desc = "Toggle paste mode";
        };
      }
      {
        mode = "n";
        key = "<leader>us";
        action.__raw = "function() Snacks.toggle.option('spell'):toggle() end";
        options = {
          silent = true;
          desc = "Toggle spellcheck";
        };
      }
      {
        mode = "n";
        key = "<leader>uS";
        action.__raw = "function() Snacks.toggle.option('conceallevel', { off = 0, on = 2 }):toggle() end";
        options = {
          silent = true;
          desc = "Toggle conceal";
        };
      }
      {
        mode = "n";
        key = "<leader>uw";
        action.__raw = "function() Snacks.toggle.option('wrap'):toggle() end";
        options = {
          silent = true;
          desc = "Toggle line wrapping";
        };
      }
      {
        mode = "n";
        key = "<leader>uy";
        action.__raw = "function() Snacks.toggle.treesitter():toggle() end";
        options = {
          silent = true;
          desc = "Toggle Treesitter highlighting";
        };
      }
      {
        mode = "n";
        key = "<leader>uv";
        action.__raw = "function() vim.diagnostic.config({ virtual_text = not vim.diagnostic.config().virtual_text }) end";
        options = {
          silent = true;
          desc = "Toggle diagnostics virtual text";
        };
      }
      {
        mode = "n";
        key = "<leader>uV";
        action.__raw = "function() vim.diagnostic.config({ virtual_lines = not vim.diagnostic.config().virtual_lines }) end";
        options = {
          silent = true;
          desc = "Toggle diagnostics virtual lines";
        };
      }

      {
        mode = "n";
        key = "<leader>uu";
        action.__raw = "function() vim.g.url_highlight = not vim.g.url_highlight end";
        options = {
          silent = true;
          desc = "Toggle URL highlighting";
        };
      }
      {
        mode = "n";
        key = "<leader>uz";
        action.__raw = "function() require('colorizer').toggle_buffer() end";
        options = {
          silent = true;
          desc = "Toggle color highlighting";
        };
      }
      {
        mode = "n";
        key = "<leader>uZ";
        action.__raw = "function() Snacks.toggle.zen():toggle() end";
        options = {
          silent = true;
          desc = "Toggle Zen mode";
        };
      }
      {
        mode = ["n" "o" "x"];
        key = "s";
        action.__raw = "function() require('flash').jump() end";
        options = {
          silent = true;
          desc = "Flash";
        };
      }
      {
        mode = ["n" "o" "x"];
        key = "S";
        action.__raw = "function() require('flash').treesitter() end";
        options = {
          silent = true;
          desc = "Flash Treesitter";
        };
      }
      {
        mode = "o";
        key = "r";
        action.__raw = "function() require('flash').remote() end";
        options = {
          silent = true;
          desc = "Remote Flash";
        };
      }
      {
        mode = ["o" "x"];
        key = "R";
        action.__raw = "function() require('flash').treesitter_search() end";
        options = {
          silent = true;
          desc = "Treesitter Search";
        };
      }
      {
        mode = "c";
        key = "<c-s>";
        action.__raw = "function() require('flash').toggle() end";
        options = {
          silent = true;
          desc = "Toggle Flash Search";
        };
      }
    ];
  };
}
