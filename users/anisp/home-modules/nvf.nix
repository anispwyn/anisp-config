{
  inputs,
  lib,
  pkgs,
  ...
}: let
  vuels = with pkgs; (vue-language-server.overrideAttrs (finalAttrs: prevAttrs: {
    version = "3.2.5";
    src = fetchFromGitHub {
      owner = "vuejs";
      repo = "language-tools";
      rev = "v${finalAttrs.version}";
      hash = "sha256-WvxZz3Rtv1AWWVJjPiUaddoyBQXUsnucg/QXCKtNXbk=";
    };

    pnpmDeps = fetchPnpmDeps {
      inherit (finalAttrs) version src;
      inherit (prevAttrs) pname;
      fetcherVersion = 1;
      hash = "sha256-rc0oq+dujIhCa+axSj5RjXsHKzh5BCpNAJ6w1vnCtt8=";
    };
  }));
in {
  imports = [inputs.nvf.homeManagerModules.default];

  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        extraPlugins = with pkgs.vimPlugins; {
          "easy-dotnet-nvim" = {
            package = easy-dotnet-nvim;
            setup = "require('easy-dotnet').setup()";
          };
          "roslyn-nvim" = {
            package = roslyn-nvim;
            setup = "require('roslyn').setup()";
          };
        };
        luaConfigRC.neovideScale = lib.hm.dag.entryAnywhere ''
          local change_scale_factor = function(delta)
            vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
          end
          vim.keymap.set("n", "<C-=>", function()
            change_scale_factor(1.25)
          end)
          vim.keymap.set("n", "<C-->", function()
            change_scale_factor(1/1.25)
          end)
        '';
        options = {
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
        };
        undoFile.enable = true;

        globals = {
          maplocalleader = ",";
          mapleader = " ";
        };
        withNodeJs = true;
        withPython3 = true;
        preventJunkFiles = true;
        enableLuaLoader = true;
        debugger = {
          nvim-dap = {
            enable = true;
            ui = {
              enable = true;
            };
          };
        };

        ui = {
          ui2 = {
            enable = true;
            setupOpts.msg.targets = "msg";
          };
          noice = {
            enable = false;
            setupOpts = {
              routes = [
                {
                  filter = {
                    event = "lsp";
                    kind = "progress";
                    find = "jdtls";
                  };
                  opts = {skip = true;};
                }
              ];
            };
          };
        };

        utility = {
          surround = {
            enable = true;
            useVendoredKeybindings = false;
          };
          motion.flash-nvim.enable = true;
          snacks-nvim = {
            enable = true;
            setupOpts = {
              animate.enabled = true;
              bigfile.enabled = true;
              gitbrowse.enabled = true;
              indent.enabled = true;
              notifier.enabled = true;
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
        };

        filetree.neo-tree = {
          enable = true;
          setupOpts = {
            filesystem = {
              window = {
                position = "float";
                popup = {
                  position = {
                    col = "100%";
                    row = "2";
                  };
                  size = lib.generators.mkLuaInline ''
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
            git_status = {
              window = {
                position = "float";
                popup = {
                  position = {
                    col = "100%";
                    row = "2";
                  };
                  size = lib.generators.mkLuaInline ''
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
            buffers = {
              window = {
                position = "float";
                popup = {
                  position = {
                    col = "100%";
                    row = "2";
                  };
                  size = lib.generators.mkLuaInline ''
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

        visuals = {
          rainbow-delimiters = {
            enable = true;
            # setupOpts.blacklist = ["vue"];
          };
          nvim-web-devicons.enable = true;
        };
        diagnostics = {
          enable = true;
          config = {
            virtual_lines = true;
          };
        };
        lsp = {
          enable = true;
          formatOnSave = true;
          inlayHints.enable = true;
          lspkind = {
            enable = true;
          };
          trouble.enable = true;
          servers = {
            zls = {
              cmd = lib.mkForce ["zls"];
            };
            luau_lsp = {
              cmd = [(lib.getExe pkgs.luau-lsp) "lsp"];
              filetypes = ["luau"];
              root_markers = [".git"];
            };
            # velvet = {
            #   cmd = [(lib.getExe pkgs.velvet)];
            #   filetypes = ["v" "vsh" "vv"];
            #   root_markers = ["v.mod" ".git"];
            # };
            oxfmt = {
              cmd = lib.generators.mkLuaInline ''
                function(dispatchers, config)
                    local cmd = 'oxfmt'
                    local local_cmd = (config or {}).root_dir and config.root_dir .. '/node_modules/.bin/oxfmt'
                    if local_cmd and vim.fn.executable(local_cmd) == 1 then
                      cmd = local_cmd
                    end
                    return vim.lsp.rpc.start({ cmd, '--lsp' }, dispatchers)
                  end
              '';
              filetypes = [
                "javascript"
                "javascriptreact"
                "typescript"
                "typescriptreact"
                "toml"
                "json"
                "jsonc"
                "json5"
                "yaml"
                "html"
                "vue"
                "handlebars"
                "css"
                "scss"
                "less"
                "graphql"
                "markdown"
              ];
              workspace_required = true;
              root_dir = lib.generators.mkLuaInline ''
                function(bufnr, on_dir)
                    local fname = vim.api.nvim_buf_get_name(bufnr)

                    -- Oxfmt resolves configuration by walking upward and using the nearest config file
                    -- to the file being processed. We therefore compute the root directory by locating
                    -- the closest `.oxfmtrc.json` / `.oxfmtrc.jsonc` (or `package.json` fallback) above the buffer.
                    local root_markers = util.insert_package_json({ '.oxfmtrc.json', '.oxfmtrc.jsonc' }, 'oxfmt', fname)
                    on_dir(vim.fs.dirname(vim.fs.find(root_markers, { path = fname, upward = true })[1]))
                  end
              '';
            };
            oxlint = {
              cmd = lib.generators.mkLuaInline ''
                function(dispatchers, config)
                    local cmd = 'oxlint'
                    local local_cmd = (config or {}).root_dir and config.root_dir .. '/node_modules/.bin/oxlint'
                    if local_cmd and vim.fn.executable(local_cmd) == 1 then
                      cmd = local_cmd
                    end
                    return vim.lsp.rpc.start({ cmd, '--lsp' }, dispatchers)
                  end
              '';
              filetypes = [
                "javascript"
                "javascriptreact"
                "typescript"
                "typescriptreact"
                "vue"
                "svelte"
                "astro"
              ];
              root_markers = [".oxlintrc.json" "oxlint.config.ts"];
              workspace_required = true;
              on_attach = lib.generators.mkLuaInline ''
                function(client, bufnr)
                    vim.api.nvim_buf_create_user_command(bufnr, 'LspOxlintFixAll', function()
                      client:exec_cmd({
                        title = 'Apply Oxlint automatic fixes',
                        command = 'oxc.fixAll',
                        arguments = { { uri = vim.uri_from_bufnr(bufnr) } },
                      })
                    end, {
                      desc = 'Apply Oxlint automatic fixes',
                    })
                  end
              '';
              before_attach = lib.generators.mkLuaInline ''
                function(init_params, config)
                    local settings = config.settings or {}

                    if settings.typeAware == nil and vim.fn.executable('tsgolint') == 1 then
                      -- Inlined function here using an anonymous function inside pcall
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
                    init_options.settings = vim.tbl_extend('force', init_options.settings or {} --[[@as table]], settings)

                    init_params.initializationOptions = init_options
                  end
              '';
            };
            gopls = {
              settings.gopls.hints = {
                assignVariableTypes = true;
                compositeLiteralFields = true;
                compositeLiteralTypes = true;
                constantValues = true;
                functionTypeParameters = true;
                parameterNames = true;
                rangeVariableTypes = true;
              };
            };

            vtsls = {
              cmd = ["vtsls" "--stdio"];
              init_options = {
                hostInfo = "neovim";
              };
              filetypes = [
                "javascript"
                "javascriptreact"
                "typescript"
                "vue"
                "typescriptreact"
              ];
              settings = {
                vtsls = {
                  tsserver = {
                    globalPlugins = [
                      {
                        name = "@vue/typescript-plugin";
                        # own or others
                        location = lib.generators.mkLuaInline ''
                          vim.env.VUE_TS_PLUGIN_PATH or "${vuels}/lib/language-tools/packages/language-server"
                        '';
                        languages = ["vue"];
                        configNamespace = "typescript";
                        enableForWorkspaceTypeScriptVersions = true;
                      }
                    ];
                  };
                };
              };
              root_dir = lib.generators.mkLuaInline ''
                function(bufnr, on_dir)
                  local root_markers = { 'package-lock.json', 'yarn.lock', 'pnpm-lock.yaml', 'bun.lockb', 'bun.lock' }
                  root_markers = vim.fn.has('nvim-0.11.3') == 1 and { root_markers, { '.git' } }
                    or vim.list_extend(root_markers, { '.git' })
                  local deno_root = vim.fs.root(bufnr, { 'deno.json', 'deno.jsonc' })
                  local deno_lock_root = vim.fs.root(bufnr, { 'deno.lock' })
                  local project_root = vim.fs.root(bufnr, root_markers)
                  if deno_lock_root and (not project_root or #deno_lock_root > #project_root) then
                    return
                  end
                  if deno_root and (not project_root or #deno_root >= #project_root) then
                    return
                  end
                  on_dir(project_root or vim.fn.getcwd())
                end
              '';
            };
            vue_ls = {
              cmd = ["vue-language-server" "--stdio"];
              filetypes = ["vue"];
              root_markers = ["package.json"];
              on_init = lib.generators.mkLuaInline ''
                function(client)
                  local retries = 0

                  ---@param _ lsp.ResponseError
                  ---@param result any
                  ---@param context lsp.HandlerContext
                  local function typescriptHandler(_, result, context)
                    local ts_client = vim.lsp.get_clients({ bufnr = context.bufnr, name = 'ts_ls' })[1]
                      or vim.lsp.get_clients({ bufnr = context.bufnr, name = 'vtsls' })[1]
                      or vim.lsp.get_clients({ bufnr = context.bufnr, name = 'typescript-tools' })[1]

                    if not ts_client then
                      -- there can sometimes be a short delay until `ts_ls`/`vtsls` are attached so we retry for a few times until it is ready
                      if retries <= 10 then
                        retries = retries + 1
                        vim.defer_fn(function()
                          typescriptHandler(_, result, context)
                        end, 100)
                      else
                        vim.notify(
                          'Could not find `ts_ls`, `vtsls`, or `typescript-tools` lsp client required by `vue_ls`.',
                          vim.log.levels.ERROR
                        )
                      end
                      return
                    end

                    local param = unpack(result)
                    local id, command, payload = unpack(param)
                    ts_client:exec_cmd({
                      title = 'vue_request_forward', -- You can give title anything as it's used to represent a command in the UI, `:h Client:exec_cmd`
                      command = 'typescript.tsserverRequest',
                      arguments = {
                        command,
                        payload,
                      },
                    }, { bufnr = context.bufnr }, function(_, r)
                      local response_data = { { id, r and r.body } }
                      ---@diagnostic disable-next-line: param-type-mismatch
                      client:notify('tsserver/response', response_data)
                    end)
                  end

                  client.handlers['tsserver/request'] = typescriptHandler
                end
              '';
            };
          };
        };

        formatter = {
          conform-nvim = {
            setupOpts = {
              formatters = {
                stylua = {
                  command = lib.getExe pkgs.stylua;
                  args = ["--search-parent-directories" "--respect-ignores" "--stdin-filepath" "$FILENAME" "-"];
                  range_args = lib.generators.mkLuaInline ''
                    function(self, ctx)
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
                  cwd = lib.generators.mkLuaInline ''require("conform.util").root_file({ ".stylua.toml", "stylua.toml" })'';
                  require_cwd = true;
                };
                oxfmt = {
                  command = lib.generators.mkLuaInline ''
                    function(dispatchers, config)
                        local cmd = 'oxfmt'
                        local local_cmd = (config or {}).root_dir and config.root_dir .. '/node_modules/.bin/oxfmt'
                        if local_cmd and vim.fn.executable(local_cmd) == 1 then
                          cmd = local_cmd
                        end
                        return cmd
                      end
                  '';
                  args = ["--stdin-filepath" "$FILENAME"];
                  cwd = lib.generators.mkLuaInline ''require("conform.util").root_file({ ".oxfmtrc.json",".oxfmtrc.jsonc" })'';
                  require_cwd = true;
                  stdin = true;
                };
              };
              formatters_by_ft = {
                typescript = ["oxfmt"];
                javascript = ["oxfmt"];
                typescriptreact = ["oxfmt"];
                javascriptreact = ["oxfmt"];
                vue = ["oxfmt"];
                lua = ["stylua"];
                luau = ["stylua"];
              };
            };
          };
        };

        fzf-lua = {
          enable = true;
          profile = "fzf-native";
        };

        git = {
          enable = true;
          neogit = {
            enable = true;
          };
        };

        autocomplete = {
          blink-cmp = {
            enable = true;
            friendly-snippets.enable = true;
            setupOpts = {
              signature.enabled = true;
              cmdline.keymap.preset = "inherit";
              cmdline.enabled = false;
              keymap.preset = "default";
            };
          };
        };

        autopairs.nvim-autopairs = {
          enable = true;
        };

        statusline = {
          lualine = {
            enable = true;
          };
        };
        tabline = {
          nvimBufferline = {
            enable = true;
            setupOpts.options = {
              always_show_bufferline = false;
              numbers = "none";
            };
          };
        };
        binds = {
          hardtime-nvim.enable = true;
          whichKey = {
            enable = true;
            setupOpts = {
              preset = "helix";
              spec = [
                {
                  lhs = "<leader>b";
                  group = "Buffers";
                }
                {
                  lhs = "<leader>bs";
                  group = "Sort buffers";
                }
                {
                  lhs = "<leader>d";
                  group = "Debugger";
                }
                {
                  lhs = "<leader>f";
                  group = "Find";
                }
                {
                  lhs = "<leader>g";
                  group = "Git";
                }
                {
                  lhs = "<leader>l";
                  group = "LSP";
                }
                {
                  lhs = "<leader>t";
                  group = "Terminal";
                }
                {
                  lhs = "<leader>u";
                  group = "UI/UX";
                }
                {
                  lhs = "<leader>x";
                  group = "Lists";
                }
              ];
            };
          };
        };

        comments.comment-nvim = {
          enable = true;
        };
        ui = {
          colorful-menu-nvim.enable = true;
          colorizer.enable = true;
        };

        treesitter = {
          autotagHtml = true;
          grammars = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
            vue
            v
          ];
          textobjects.enable = true;
          indent.enable = true;
          enable = true;
        };

        languages = {
          enableDAP = true;
          enableFormat = true;
          enableTreesitter = true;
          enableExtraDiagnostics = true;
          clang = {
            enable = true;
            lsp = {
              servers = ["clangd"];
            };
          };
          qml = {
            enable = true;
          };
          css = {
            enable = true;
          };
          go = {
            extensions.gopher-nvim.enable = true;
            enable = true;
            format.type = ["gofumpt"];
            extraDiagnostics.enable = false;
          };
          html = {
            enable = true;
            extraDiagnostics.enable = true;
          };
          java = {
            enable = true;
          };
          json = {
            enable = true;
          };
          toml = {
            enable = true;
          };
          yaml.enable = true;
          lua = {
            enable = true;
            format.enable = false;
            extraDiagnostics = {
              enable = true;
            };
          };
          markdown = {
            enable = true;
            extensions.markview-nvim.enable = true;
          };
          nix = {
            enable = true;
            lsp = {
              servers = ["nixd"];
            };
          };
          rust = {
            enable = true;
            extensions = {
              crates-nvim = {
                enable = true;
                setupOpts = {
                  completion.crates.enabled = true;
                  lsp = {
                    enabled = true;
                    actions = true;
                    completion = true;
                    hover = true;
                  };
                };
              };
            };
          };
          sql = {
            enable = true;
          };
          tailwind = {
            enable = true;
          };
          ts = {
            enable = true;
            extensions = {
              ts-error-translator.enable = true;
            };
            extraDiagnostics.enable = false;
            format = {
              enable = false;
              type = ["biome"];
            };
            lsp.enable = false;
          };

          zig = {
            enable = true;
          };
          csharp = {
            enable = true;
            lsp.servers = ["roslyn_ls"];
          };
        };
        keymaps = [
          # === General Mappings ===
          # Window Resizing
          {
            key = "<C-Up>";
            mode = "n";
            action = "<cmd>resize +2<CR>";
            silent = true;
            desc = "Resize up";
          }
          {
            key = "<C-Down>";
            mode = "n";
            action = "<cmd>resize -2<CR>";
            silent = true;
            desc = "Resize Down";
          }
          {
            key = "<C-Left>";
            mode = "n";
            action = "<cmd>vertical resize -2<CR>";
            silent = true;
            desc = "Resize Left";
          }
          {
            key = "<C-Right>";
            mode = "n";
            action = "<cmd>vertical resize +2<CR>";
            silent = true;
            desc = "Resize Right";
          }

          # Window Navigation
          {
            key = "<C-k>";
            mode = "n";
            action = "<C-w>k";
            silent = true;
            desc = "Up Window";
          }
          {
            key = "<C-j>";
            mode = "n";
            action = "<C-w>j";
            silent = true;
            desc = "Down Window";
          }
          {
            key = "<C-h>";
            mode = "n";
            action = "<C-w>h";
            silent = true;
            desc = "Left Window";
          }
          {
            key = "<C-l>";
            mode = "n";
            action = "<C-w>l";
            silent = true;
            desc = "Right Window";
          }

          # File Operations
          {
            key = "<C-s>";
            mode = ["n" "i" "v"];
            action = "<cmd>w!<CR>";
            silent = true;
            desc = "Force Write";
          }
          {
            key = "<C-q>";
            mode = "n";
            action = "<cmd>qa!<CR>";
            silent = true;
            desc = "Force Quit";
          }
          {
            key = "<leader>n";
            mode = "n";
            action = "<cmd>enew<CR>";
            silent = true;
            desc = "New File";
          }
          {
            key = "<leader>R";
            mode = "n";
            lua = true;
            action = "function() Snacks.rename.rename_file() end";
            silent = true;
            desc = "Rename Current File";
          }
          {
            key = "<leader>c";
            mode = "n";
            action = "<cmd>bdelete<CR>";
            silent = true;
            desc = "Close Buffer";
          }

          # Splits
          {
            key = "\\";
            mode = "n";
            action = "<cmd>split<CR>";
            silent = true;
            desc = "Horizontal Split";
          }
          {
            key = "|";
            mode = "n";
            action = "<cmd>vsplit<CR>";
            silent = true;
            desc = "Vertical Split";
          }

          # === Buffer Mappings ===
          {
            key = "]b";
            mode = "n";
            action = "<cmd>bnext<CR>";
            silent = true;
            desc = "Next Buffer";
          }
          {
            key = "[b";
            mode = "n";
            action = "<cmd>bprevious<CR>";
            silent = true;
            desc = "Previous Buffer";
          }
          {
            key = ">b";
            mode = "n";
            lua = true;
            action = "function() vim.cmd('BufferLineMoveNext') end";
            silent = true;
            desc = "Move Buffer Right";
          }
          {
            key = "<b";
            mode = "n";
            lua = true;
            action = "function() vim.cmd('BufferLineMovePrev') end";
            silent = true;
            desc = "Move Buffer Left";
          }
          {
            key = "<leader>bb";
            mode = "n";
            action = "<cmd>FzfLua buffers<CR>";
            silent = true;
            desc = "Navigate to buffer tab with interactive picker";
          }
          {
            key = "<leader>bc";
            mode = "n";
            lua = true;
            action = "function() vim.cmd('%bd|e#|bd#') end";
            silent = true;
            desc = "Close all buffers except the current";
          }
          {
            key = "<leader>bC";
            mode = "n";
            action = "<cmd>%bd<CR>";
            silent = true;
            desc = "Close all buffers";
          }
          {
            key = "<leader>bd";
            mode = "n";
            action = "<cmd>FzfLua buffers<CR>";
            silent = true;
            desc = "Delete a buffer tab with interactive picker";
          }
          {
            key = "<leader>bl";
            mode = "n";
            lua = true;
            action = "function() vim.cmd('BufferLineCloseRight') end";
            silent = true;
            desc = "Close all buffers to the left of the current";
          }
          {
            key = "<leader>bp";
            mode = "n";
            action = "<cmd>bprevious<CR>";
            silent = true;
            desc = "Go to the previous buffer";
          }
          {
            key = "<leader>br";
            mode = "n";
            lua = true;
            action = "function() vim.cmd('BufferLineCloseLeft') end";
            silent = true;
            desc = "Close all buffers to the right of the current";
          }
          {
            key = "<leader>bse";
            mode = "n";
            lua = true;
            action = "function() vim.cmd('BufferLineSortByExtension') end";
            silent = true;
            desc = "Sort buffers by extension";
          }
          {
            key = "<leader>bsi";
            mode = "n";
            lua = true;
            action = "function() vim.cmd('BufferLineSortByRelativeDirectory') end";
            silent = true;
            desc = "Sort buffers by buffer number";
          }
          {
            key = "<leader>bsm";
            mode = "n";
            lua = true;
            action = "function() vim.cmd('BufferLineSortByTabs') end";
            silent = true;
            desc = "Sort buffers by last modification";
          }
          {
            key = "<leader>bsp";
            mode = "n";
            lua = true;
            action = "function() vim.cmd('BufferLineSortByDirectory') end";
            silent = true;
            desc = "Sort buffers by full path";
          }
          {
            key = "<leader>bsr";
            mode = "n";
            lua = true;
            action = "function() vim.cmd('BufferLineSortByRelativeDirectory') end";
            silent = true;
            desc = "Sort buffers by relative path";
          }
          {
            key = "<leader>b\\";
            mode = "n";
            action = "<cmd>FzfLua buffers<CR>";
            silent = true;
            desc = "Open a buffer tab in a new horizontal split with interactive picker";
          }
          {
            key = "<leader>b|";
            mode = "n";
            action = "<cmd>FzfLua buffers<CR>";
            silent = true;
            desc = "Open a buffer tab in a new vertical split with interactive picker";
          }

          # === Tab Mappings ===
          {
            key = "]t";
            mode = "n";
            action = "<cmd>tabnext<CR>";
            silent = true;
            desc = "Next Tab (real vim tab)";
          }
          {
            key = "[t";
            mode = "n";
            action = "<cmd>tabprevious<CR>";
            silent = true;
            desc = "Previous Tab (real vim tab)";
          }

          # === Commenting (comment.nvim) ===
          {
            key = "<leader>/";
            mode = "n";
            action = "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>";
            silent = true;
            desc = "Toggle comment of current line";
          }
          {
            key = "<leader>/";
            mode = "v";
            action = "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>";
            silent = true;
            desc = "Toggle comment of current line";
          }
          {
            key = "gco";
            mode = "n";
            action = "o<Esc>gcc";
            silent = true;
            desc = "Insert comment below current line";
          }
          {
            key = "gcO";
            mode = "n";
            action = "O<Esc>gcc";
            silent = true;
            desc = "Insert comment above current line";
          }

          # === Quickfix List ===
          {
            key = "<leader>xq";
            mode = "n";
            action = "<cmd>copen<CR>";
            silent = true;
            desc = "Open Quickfix List";
          }
          {
            key = "]q";
            mode = "n";
            action = "<cmd>cnext<CR>";
            silent = true;
            desc = "Next Quickfix Entry";
          }
          {
            key = "[q";
            mode = "n";
            action = "<cmd>cprevious<CR>";
            silent = true;
            desc = "Previous Quickfix Entry";
          }
          {
            key = "]Q";
            mode = "n";
            action = "<cmd>clast<CR>";
            silent = true;
            desc = "Last Quickfix Entry";
          }
          {
            key = "[Q";
            mode = "n";
            action = "<cmd>cfirst<CR>";
            silent = true;
            desc = "First Quickfix Entry";
          }

          # === Local List ===
          {
            key = "<leader>xl";
            mode = "n";
            action = "<cmd>lopen<CR>";
            silent = true;
            desc = "Open Local List";
          }
          {
            key = "]l";
            mode = "n";
            action = "<cmd>lnext<CR>";
            silent = true;
            desc = "Next Local List Entry";
          }
          {
            key = "[l";
            mode = "n";
            action = "<cmd>lprevious<CR>";
            silent = true;
            desc = "Previous Local List Entry";
          }
          {
            key = "]L";
            mode = "n";
            action = "<cmd>llast<CR>";
            silent = true;
            desc = "Last Local List Entry";
          }
          {
            key = "[L";
            mode = "n";
            action = "<cmd>lfirst<CR>";
            silent = true;
            desc = "First Local List Entry";
          }

          # === Better Escape ===
          {
            key = "jj";
            mode = "i";
            action = "<Esc>";
            silent = true;
            desc = "Escape key";
          }
          {
            key = "jk";
            mode = "i";
            action = "<Esc>";
            silent = true;
            desc = "Escape key";
          }

          # === Neo-Tree ===
          {
            key = "<leader>e";
            mode = "n";
            silent = true;
            action = "<cmd>silent!Neotree toggle<CR>";
            desc = "Neotree toggle";
          }
          {
            key = "<leader>o";
            mode = "n";
            silent = true;
            action = "<cmd>silent!Neotree focus<CR>";
            desc = "Neotree focus";
          }

          # === LSP Mappings ===
          {
            key = "<leader>li";
            mode = "n";
            action = "<cmd>LspInfo<CR>";
            silent = true;
            desc = "LSP Info";
          }
          {
            key = "K";
            mode = "n";
            action = "<cmd>lua vim.lsp.buf.hover()<CR>";
            silent = true;
            desc = "Hover Document";
          }
          {
            key = "<leader>lf";
            mode = "n";
            action = "<cmd>lua vim.lsp.buf.format({ async = true })<CR>";
            silent = true;
            desc = "Format Document";
          }
          {
            key = "<leader>lS";
            mode = "n";
            action = "<cmd>Telescope lsp_document_symbols<CR>";
            silent = true;
            desc = "Symbols Outline";
          }
          {
            key = "gl";
            mode = "n";
            action = "<cmd>lua vim.diagnostic.open_float()<CR>";
            silent = true;
            desc = "Line Diagnostics";
          }
          {
            key = "<leader>ld";
            mode = "n";
            action = "<cmd>lua vim.diagnostic.open_float()<CR>";
            silent = true;
            desc = "Line Diagnostics";
          }
          {
            key = "<C-W>d";
            mode = "n";
            action = "<cmd>lua vim.diagnostic.open_float()<CR>";
            silent = true;
            desc = "Line Diagnostics";
          }
          {
            key = "<leader>lD";
            mode = "n";
            action = "<cmd>FzfLua diagnostics_document<CR>";
            silent = true;
            desc = "All Diagnostics";
          }
          {
            key = "<leader>la";
            mode = "n";
            action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
            silent = true;
            desc = "Code Actions";
          }
          {
            key = "gra";
            mode = "n";
            action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
            silent = true;
            desc = "Code Actions";
          }
          {
            key = "<leader>lA";
            mode = "n";
            action = "<cmd>lua vim.lsp.buf.code_action({ context = { only = {'source'} } })<CR>";
            silent = true;
            desc = "Source Code Actions";
          }
          {
            key = "<leader>lh";
            mode = "n";
            action = "<cmd>lua vim.lsp.buf.signature_help()<CR>";
            silent = true;
            desc = "Signature Help";
          }
          {
            key = "<leader>lr";
            mode = "n";
            action = "<cmd>lua vim.lsp.buf.rename()<CR>";
            silent = true;
            desc = "Rename";
          }
          {
            key = "grn";
            mode = "n";
            action = "<cmd>lua vim.lsp.buf.rename()<CR>";
            silent = true;
            desc = "Rename";
          }
          {
            key = "<leader>ls";
            mode = "n";
            action = "<cmd>FzfLua lsp_document_symbols<CR>";
            silent = true;
            desc = "Document Symbols";
          }
          {
            key = "<leader>lG";
            mode = "n";
            action = "<cmd>FzfLua lsp_workspace_symbols<CR>";
            silent = true;
            desc = "Workspace Symbols";
          }
          {
            key = "]d";
            mode = "n";
            action = "<cmd>lua vim.diagnostic.goto_next()<CR>";
            silent = true;
            desc = "Diagnostic Next";
          }
          {
            key = "[d";
            mode = "n";
            action = "<cmd>lua vim.diagnostic.goto_prev()<CR>";
            silent = true;
            desc = "Diagnostics Previous";
          }
          {
            key = "]e";
            mode = "n";
            action = "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>";
            silent = true;
            desc = "Diagnostic Error Next";
          }
          {
            key = "[e";
            mode = "n";
            action = "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>";
            silent = true;
            desc = "Diagnostic Error Previous";
          }
          {
            key = "]w";
            mode = "n";
            action = "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.WARN})<CR>";
            silent = true;
            desc = "Diagnostic Warning Next";
          }
          {
            key = "[w";
            mode = "n";
            action = "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.WARN})<CR>";
            silent = true;
            desc = "Diagnostic Warning Previous";
          }
          {
            key = "]y";
            mode = "n";
            lua = true;
            action = "function() require('nvim-treesitter.textobjects.repeatable_move').goto_next_start('@function.outer') end";
            silent = true;
            desc = "Document Symbol Next";
          }
          {
            key = "[y";
            mode = "n";
            lua = true;
            action = "function() require('nvim-treesitter.textobjects.repeatable_move').goto_previous_start('@function.outer') end";
            silent = true;
            desc = "Document Symbol Previous";
          }
          {
            key = "gO";
            mode = "n";
            action = "<cmd>FzfLua lsp_document_symbols<CR>";
            silent = true;
            desc = "Document Symbol";
          }
          {
            key = "gD";
            mode = "n";
            action = "<cmd>lua vim.lsp.buf.declaration()<CR>";
            silent = true;
            desc = "Declaration";
          }
          {
            key = "gy";
            mode = "n";
            action = "<cmd>lua vim.lsp.buf.type_definition()<CR>";
            silent = true;
            desc = "Type Definition";
          }
          {
            key = "gd";
            mode = "n";
            action = "<cmd>lua vim.lsp.buf.definition()<CR>";
            silent = true;
            desc = "Definition";
          }
          {
            key = "gri";
            mode = "n";
            action = "<cmd>lua vim.lsp.buf.implementation()<CR>";
            silent = true;
            desc = "Implementation";
          }
          {
            key = "grr";
            mode = "n";
            action = "<cmd>lua vim.lsp.buf.references()<CR>";
            silent = true;
            desc = "References";
          }
          {
            key = "<leader>lR";
            mode = "n";
            action = "<cmd>lua vim.lsp.buf.references()<CR>";
            silent = true;
            desc = "References";
          }

          # === Debugger Mappings (DAP) ===
          {
            key = "<leader>dc";
            mode = "n";
            action = "<cmd>lua require('dap').continue()<CR>";
            silent = true;
            desc = "Start/Continue Debugger";
          }
          {
            key = "<F5>";
            mode = "n";
            action = "<cmd>lua require('dap').continue()<CR>";
            silent = true;
            desc = "Start/Continue Debugger";
          }
          {
            key = "<leader>dp";
            mode = "n";
            action = "<cmd>lua require('dap').pause()<CR>";
            silent = true;
            desc = "Pause Debugger";
          }
          {
            key = "<F6>";
            mode = "n";
            action = "<cmd>lua require('dap').pause()<CR>";
            silent = true;
            desc = "Pause Debugger";
          }
          {
            key = "<leader>dr";
            mode = "n";
            action = "<cmd>lua require('dap').restart()<CR>";
            silent = true;
            desc = "Restart Debugger";
          }
          {
            key = "<C-F5>";
            mode = "n";
            action = "<cmd>lua require('dap').restart()<CR>";
            silent = true;
            desc = "Restart Debugger";
          }
          {
            key = "<leader>ds";
            mode = "n";
            action = "<cmd>lua require('dap').run_to_cursor()<CR>";
            silent = true;
            desc = "Run Debugger to Cursor";
          }
          {
            key = "<leader>dq";
            mode = "n";
            action = "<cmd>lua require('dap').close()<CR>";
            silent = true;
            desc = "Close Debugger Session";
          }
          {
            key = "<leader>dQ";
            mode = "n";
            action = "<cmd>lua require('dap').terminate()<CR>";
            silent = true;
            desc = "Terminate Debugger";
          }
          {
            key = "<S-F5>";
            mode = "n";
            action = "<cmd>lua require('dap').terminate()<CR>";
            silent = true;
            desc = "Terminate Debugger";
          }
          {
            key = "<leader>db";
            mode = "n";
            action = "<cmd>lua require('dap').toggle_breakpoint()<CR>";
            silent = true;
            desc = "Toggle Breakpoint";
          }
          {
            key = "<F9>";
            mode = "n";
            action = "<cmd>lua require('dap').toggle_breakpoint()<CR>";
            silent = true;
            desc = "Toggle Breakpoint";
          }
          {
            key = "<leader>dC";
            mode = "n";
            action = "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>";
            silent = true;
            desc = "Conditional Breakpoint";
          }
          {
            key = "<S-F9>";
            mode = "n";
            action = "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>";
            silent = true;
            desc = "Conditional Breakpoint";
          }
          {
            key = "<leader>dB";
            mode = "n";
            action = "<cmd>lua require('dap').clear_breakpoints()<CR>";
            silent = true;
            desc = "Clear Breakpoints";
          }
          {
            key = "<leader>do";
            mode = "n";
            action = "<cmd>lua require('dap').step_over()<CR>";
            silent = true;
            desc = "Step Over";
          }
          {
            key = "<F10>";
            mode = "n";
            action = "<cmd>lua require('dap').step_over()<CR>";
            silent = true;
            desc = "Step Over";
          }
          {
            key = "<leader>di";
            mode = "n";
            action = "<cmd>lua require('dap').step_into()<CR>";
            silent = true;
            desc = "Step Into";
          }
          {
            key = "<F11>";
            mode = "n";
            action = "<cmd>lua require('dap').step_into()<CR>";
            silent = true;
            desc = "Step Into";
          }
          {
            key = "<leader>dO";
            mode = "n";
            action = "<cmd>lua require('dap').step_out()<CR>";
            silent = true;
            desc = "Step Out";
          }
          {
            key = "<S-F11>";
            mode = "n";
            action = "<cmd>lua require('dap').step_out()<CR>";
            silent = true;
            desc = "Step Out";
          }
          {
            key = "<leader>dE";
            mode = "n";
            action = "<cmd>lua require('dapui').eval()<CR>";
            silent = true;
            desc = "Evaluate Expression";
          }
          {
            key = "<leader>dR";
            mode = "n";
            action = "<cmd>lua require('dap').repl.toggle()<CR>";
            silent = true;
            desc = "Toggle REPL";
          }
          {
            key = "<leader>du";
            mode = "n";
            action = "<cmd>lua require('dapui').toggle()<CR>";
            silent = true;
            desc = "Toggle Debugger UI";
          }
          {
            key = "<leader>dh";
            mode = "n";
            action = "<cmd>lua require('dapui').eval()<CR>";
            silent = true;
            desc = "Debugger Hover";
          }

          # === FZF-lua Picker Mappings ===
          {
            key = "<leader>f<CR>";
            mode = "n";
            action = "<cmd>FzfLua resume<CR>";
            silent = true;
            desc = "Resume previous search";
          }
          {
            key = "<leader>f'";
            mode = "n";
            action = "<cmd>FzfLua marks<CR>";
            silent = true;
            desc = "Marks";
          }
          {
            key = "<leader>fb";
            mode = "n";
            action = "<cmd>FzfLua buffers<CR>";
            silent = true;
            desc = "Buffers";
          }
          {
            key = "<leader>fc";
            mode = "n";
            action = "<cmd>FzfLua grep_cword<CR>";
            silent = true;
            desc = "Word at cursor";
          }
          {
            key = "<leader>fC";
            mode = "n";
            action = "<cmd>FzfLua commands<CR>";
            silent = true;
            desc = "Commands";
          }
          {
            key = "<leader>ff";
            mode = "n";
            action = "<cmd>FzfLua files<CR>";
            silent = true;
            desc = "Find files";
          }
          {
            key = "<leader>fF";
            mode = "n";
            action = "<cmd>FzfLua files hidden=true<CR>";
            silent = true;
            desc = "Find files (include hidden files)";
          }
          {
            key = "<leader>fg";
            mode = "n";
            action = "<cmd>FzfLua git_files<CR>";
            silent = true;
            desc = "Git tracked files";
          }
          {
            key = "<leader>fh";
            mode = "n";
            action = "<cmd>FzfLua help_tags<CR>";
            silent = true;
            desc = "Help Tags";
          }
          {
            key = "<leader>fk";
            mode = "n";
            action = "<cmd>FzfLua keymaps<CR>";
            silent = true;
            desc = "Keymaps";
          }
          {
            key = "<leader>fl";
            mode = "n";
            action = "<cmd>FzfLua lines<CR>";
            silent = true;
            desc = "Lines";
          }
          {
            key = "<leader>fm";
            mode = "n";
            action = "<cmd>FzfLua man_pages<CR>";
            silent = true;
            desc = "Man Pages";
          }
          {
            key = "<leader>fn";
            mode = "n";
            lua = true;
            action = "function() Snacks.notifier.show_history() end";
            silent = true;
            desc = "Notifications";
          }
          {
            key = "<leader>fo";
            mode = "n";
            action = "<cmd>FzfLua oldfiles<CR>";
            silent = true;
            desc = "Old Files";
          }
          {
            key = "<leader>fO";
            mode = "n";
            action = "<cmd>FzfLua oldfiles cwd_only=true<CR>";
            silent = true;
            desc = "Old Files (current directory)";
          }
          {
            key = "<leader>fr";
            mode = "n";
            action = "<cmd>FzfLua registers<CR>";
            silent = true;
            desc = "Registers";
          }
          {
            key = "<leader>ft";
            mode = "n";
            action = "<cmd>FzfLua colorschemes<CR>";
            silent = true;
            desc = "Colorschemes";
          }
          {
            key = "<leader>fu";
            mode = "n";
            action = "<cmd>FzfLua changes<CR>";
            silent = true;
            desc = "Undo History";
          }
          {
            key = "<leader>fw";
            mode = "n";
            action = "<cmd>FzfLua live_grep<CR>";
            silent = true;
            desc = "Live Grep";
          }
          {
            key = "<leader>fW";
            mode = "n";
            action = "<cmd>FzfLua live_grep hidden=true<CR>";
            silent = true;
            desc = "Live Grep (include hidden files)";
          }

          # === Git Mappings ===
          {
            key = "<leader>gb";
            mode = "n";
            action = "<cmd>FzfLua git_branches<CR>";
            silent = true;
            desc = "Git Branches";
          }
          {
            key = "<leader>gc";
            mode = "n";
            action = "<cmd>FzfLua git_commits<CR>";
            silent = true;
            desc = "Git Commits (repository)";
          }
          {
            key = "<leader>gC";
            mode = "n";
            action = "<cmd>FzfLua git_bcommits<CR>";
            silent = true;
            desc = "Git Commits (current file)";
          }
          {
            key = "<leader>go";
            mode = "n";
            lua = true;
            action = "function() Snacks.gitbrowse() end";
            silent = true;
            desc = "Git browse (open)";
          }
          {
            key = "<leader>gt";
            mode = "n";
            action = "<cmd>FzfLua git_status<CR>";
            silent = true;
            desc = "Git Status";
          }
          {
            key = "<leader>gT";
            mode = "n";
            action = "<cmd>FzfLua git_stash<CR>";
            silent = true;
            desc = "Git Stash";
          }

          # === Terminal Mappings (Snacks) ===
          {
            key = "<leader>tf";
            mode = "n";
            lua = true;
            action = "function() Snacks.terminal.toggle(nil, {win={position='float'}}) end";
            silent = true;
            desc = "Open Floating Terminal";
          }
          {
            key = "<leader>th";
            mode = "n";
            lua = true;
            action = "function() Snacks.terminal.toggle(nil, { win = {position = 'bottom' }}) end";
            silent = true;
            desc = "Open Horizontal Terminal";
          }
          {
            key = "<leader>tv";
            mode = "n";
            lua = true;
            action = "function() Snacks.terminal.toggle(nil, { win = { position = 'right'} }) end";
            silent = true;
            desc = "Open Vertical Terminal";
          }
          {
            key = "<leader>tl";
            mode = "n";
            action = "<cmd>Neogit<CR>";
            silent = true;
            desc = "Open Toggle Lazygit";
          }
          {
            key = "<leader>tn";
            mode = "n";
            lua = true;
            action = "function() Snacks.terminal.toggle('node') end";
            silent = true;
            desc = "Open Toggle node";
          }
          {
            key = "<leader>tp";
            mode = "n";
            lua = true;
            action = "function() Snacks.terminal.toggle('python') end";
            silent = true;
            desc = "Open Toggle Python";
          }
          {
            key = "<leader>tt";
            mode = "n";
            lua = true;
            action = "function() Snacks.terminal.toggle() end";
            silent = true;
            desc = "Open Toggle btm";
          }
          {
            key = "<F7>";
            mode = ["n" "t"];
            lua = true;
            action = "function() Snacks.terminal.toggle() end";
            silent = true;
            desc = "Toggle Current Terminal";
          }
          {
            key = "<C-'>";
            mode = ["n" "t"];
            lua = true;
            action = "function() Snacks.terminal.toggle() end";
            silent = true;
            desc = "Toggle Current Terminal";
          }

          # === UI / UX Toggle Mappings ===
          {
            key = "<leader>ua";
            mode = "n";
            lua = true;
            action = "function() if require('nvim-autopairs').state.disabled then require('nvim-autopairs').enable() else require('nvim-autopairs').disable() end end";
            silent = true;
            desc = "Toggle autopairs";
          }
          {
            key = "<leader>ub";
            mode = "n";
            lua = true;
            action = "function() Snacks.toggle.option('background', { off = 'light', on = 'dark' }):toggle() end";
            silent = true;
            desc = "Toggle light/dark background";
          }
          # diagnostics
          {
            key = "<leader>ud";
            mode = "n";
            lua = true;
            action = "function() Snacks.toggle.diagnostics():toggle() end";
            silent = true;
            desc = "Toggle diagnostics";
          }

          # formatting
          {
            key = "<leader>uf";
            mode = "n";
            lua = true;
            action = "function() Snacks.toggle.new({ name = 'Auto Format (Buffer)', get = function() return not vim.b.disableFormatSave end, set = function(state) vim.b.disableFormatSave = not state end }):toggle() end";
            silent = true;
            desc = "Toggle autoformat (buffer)";
          }
          {
            key = "<leader>uF";
            mode = "n";
            lua = true;
            action = "function() Snacks.toggle.new({ name = 'Auto Format (Global)', get = function() return vim.g.formatsave end, set = function(state) vim.g.formatsave = state end }):toggle() end";
            silent = true;
            desc = "Toggle autoformat (global)";
          }

          # columns / guides
          {
            key = "<leader>ug";
            mode = "n";
            lua = true;
            action = "function() Snacks.toggle.option('signcolumn', { off = 'no', on = 'yes' }):toggle() end";
            silent = true;
            desc = "Toggle signcolumn";
          }
          {
            key = "<leader>u>";
            mode = "n";
            lua = true;
            action = "function() Snacks.toggle.option('foldcolumn', { off = '0', on = '1' }):toggle() end";
            silent = true;
            desc = "Toggle foldcolumn";
          }
          {
            key = "<leader>u|";
            mode = "n";
            lua = true;
            action = "function() Snacks.toggle.indent():toggle() end";
            silent = true;
            desc = "Toggle indent guides";
          }

          {
            key = "<leader>uH";
            mode = "n";
            lua = true;
            action = "function() Snacks.toggle.inlay_hints():toggle() end";
            silent = true;
            desc = "Toggle LSP inlay hints (global)";
          }

          # status / tabline
          {
            key = "<leader>ul";
            mode = "n";
            lua = true;
            action = "function() Snacks.toggle.option('laststatus', { off = 0, on = 3 }):toggle() end";
            silent = true;
            desc = "Toggle statusline";
          }
          {
            key = "<leader>ut";
            mode = "n";
            lua = true;
            action = "function() Snacks.toggle.option('showtabline', { off = 0, on = 2 }):toggle() end";
            silent = true;
            desc = "Toggle tabline";
          }

          # numbers / wrapping / spell
          {
            key = "<leader>un";
            mode = "n";
            lua = true;
            action = "function() Snacks.toggle.line_number():toggle() end";
            silent = true;
            desc = "Toggle line numbers";
          }
          {
            key = "<leader>up";
            mode = "n";
            lua = true;
            action = "function() Snacks.toggle.option('paste'):toggle() end";
            silent = true;
            desc = "Toggle paste mode";
          }
          {
            key = "<leader>us";
            mode = "n";
            lua = true;
            action = "function() Snacks.toggle.option('spell'):toggle() end";
            silent = true;
            desc = "Toggle spellcheck";
          }
          {
            key = "<leader>uS";
            mode = "n";
            lua = true;
            action = "function() Snacks.toggle.option('conceallevel', { off = 0, on = 2 }):toggle() end";
            silent = true;
            desc = "Toggle conceal";
          }
          {
            key = "<leader>uw";
            mode = "n";
            lua = true;
            action = "function() Snacks.toggle.option('wrap'):toggle() end";
            silent = true;
            desc = "Toggle line wrapping";
          }

          # treesitter
          {
            key = "<leader>uy";
            mode = "n";
            lua = true;
            action = "function() Snacks.toggle.treesitter():toggle() end";
            silent = true;
            desc = "Toggle Treesitter highlighting";
          }

          # diagnostics text styles
          {
            key = "<leader>uv";
            mode = "n";
            lua = true;
            action = "function() vim.diagnostic.config({ virtual_text = not vim.diagnostic.config().virtual_text }) end";
            silent = true;
            desc = "Toggle diagnostics virtual text";
          }
          {
            key = "<leader>uV";
            mode = "n";
            lua = true;
            action = "function() vim.diagnostic.config({ virtual_lines = not vim.diagnostic.config().virtual_lines }) end";
            silent = true;
            desc = "Toggle diagnostics virtual lines";
          }

          # misc
          {
            key = "<leader>uu";
            mode = "n";
            lua = true;
            action = "function() vim.g.url_highlight = not vim.g.url_highlight end";
            silent = true;
            desc = "Toggle URL highlighting";
          }
          {
            key = "<leader>uz";
            mode = "n";
            lua = true;
            action = "function() require('colorizer').toggle_buffer() end";
            silent = true;
            desc = "Toggle color highlighting";
          }
          {
            key = "<leader>uZ";
            mode = "n";
            lua = true;
            action = "function() Snacks.toggle.zen():toggle() end";
            silent = true;
            desc = "Toggle Zen mode";
          }
        ];

        presence.neocord.enable = true;
        extraPackages = [
          vuels
        ];
      };
    };
  };
}
