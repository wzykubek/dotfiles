{ lib, ... }:
{
  programs.nixvim = {
    enable = true;

    vimAlias = true;
    viAlias = true;

    colorschemes.gruvbox.enable = true;
    globals.mapleader = " "; # Set leader key to Space

    opts = {
      shiftwidth = 2; # Indent size
      tabstop = 2; # Width of \t character
      expandtab = true; # Use spaces instead of tab
      smarttab = true; # Use spaces on indentation and \t in the middle of the line
      ignorecase = true; # Ignore case on search
      autoindent = true; # Copy indent from previous line
      smartindent = true; # Add extra indentation when needed (e.g. opening brackets)
      relativenumber = true; # Show relative line numbers
      undofile = true; # Keep undo beetween sessions
      swapfile = true; # Prevent data loss when editor crashes
      cursorline = true; # Highlight current line
      termguicolors = true; # Enable true colors in terminal
      signcolumn = "auto:4"; # Expand signcolumn when needed (e.g. display both diagnostics and gitsigns)
      clipboard = "unnamedplus"; # Use system clipboard
    };

    diagnostics = {
      update_in_insert = false; # Do not spam errors when typing
      virtual_lines = true; # Add virtual lines when error message is long
      virtual_text = true; # Show messages in buffer
    };

    keymaps = [
      {
        mode = [ "n" ];
        key = "<ESC>";
        action = ":nohlsearch<CR>";
        options = {
          silent = true;
        };
      }
      {
        mode = [ "n" ];
        key = "<leader>fm";
        action = lib.generators.mkLuaInline ''
          function()
            vim.lsp.buf.format()
          end'';
        options = {
          silent = true;
        };
      }
    ];

    plugins = {
      lsp = {
        enable = true;

        servers = {
          nixd.enable = true;
        };
      };

      telescope = {
        enable = true;

        keymaps = {
          "<leader>ff" = {
            action = "find_files";
            options = {
              desc = "Find files";
            };
          };
          "<leader>fg" = {
            action = "live_grep";
            options = {
              desc = "Live grep";
            };
          };
        };
      };

      lualine = {
        enable = true;
        settings.options = {
          section_separators = "";
          component_separators = "";
        };
      };

      gitsigns = {
        enable = true;
        settings = {
          sign_priority = 10; # Display gitsigns before diagnostics
        };
      };

      blink-cmp = {
        enable = true;
        # I didn't changed default behavior and there is selecting with
        # tab and enter does not confirm selection. I'm often angry when
        # I want to just enter new line or \t character and completion
        # adds suggested word to my sentence. Currently I'm trying to
        # change my habit of hitting tab to select option to Ctrl+n
        # and Ctrl+p. Reminder: hit Ctrl+y to confirm selection.
      };
      luasnip.enable = true;

      which-key = {
        enable = true;
        settings.preset = "helix";
      };

      treesitter.enable = true;
      web-devicons.enable = true;
      commentary.enable = true; # Comment with gcc
    };

    extraConfigLua = ''
      vim.cmd([[cabbrev help vert bo help]]) -- Open help on the right in vertical split
      vim.cmd([[cabbrev h vert bo help]]) -- Same as above
    '';

    highlightOverride = {
      Normal.bg = "none";
      NormalNC.bg = "none";
      SignColumn.bg = "none";
    };
  };
}
