{
  programs.nixvim = {
    enable = true;
    colorschemes.catppuccin.enable = true;
    opts = {
      shiftwidth = 2;
      tabstop = 2;
      relativenumber = true;
			undofile = true;
			swapfile = true;
			cursorline = true;
			termguicolors = true;
    };

		globals.mapleader = " ";

		diagnostics = {
			update_in_insert = false;
			virtual_lines = true;
			virtual_text = true;
		};

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
						options = { desc = "Find files"; };
					};
					"<leader>fg" = {
						action = "live_grep";
						options = { desc = "Live grep"; };
					};
				};
			};

			treesitter.enable = true;
			blink-cmp.enable = true;
			which-key.enable = true;
			web-devicons.enable = true;
			lualine.enable = true;
		};
  };  
}
