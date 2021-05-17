{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;

  xsession = {
    enable = true;
    windowManager = {
      i3 = {
        enable = true;
        package = pkgs.i3-gaps;
        config = {
          modifier = "Mod4";
          terminal = "kitty";
        };
      };
    };
  };

  programs = {
    git = {
      enable = true;
      userName = "mrmurb";
      userEmail = "max@ig4.se";
      extraConfig = {
        init.defaultBranch = "master";
      };
    };

    neovim = {
      enable = true;
      vimAlias = true;
      plugins = with pkgs.vimPlugins; [
        vim-nix
        vim-go
        vim-airline
        gruvbox
        suda-vim
      ];
      extraConfig = ''
        colorscheme gruvbox
      '';
    };

    vscode = {
      enable = true;
      package = pkgs.vscode;
    };
  };

  home.packages = [
    pkgs.htop
    pkgs.discord
    pkgs.slack
    pkgs.spotify
    pkgs.spicetify-cli
    pkgs.google-chrome
  ];

  home.username = "max";
  home.homeDirectory = "/home/max";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.03";
}
