{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;

  xsession = {
    enable = true;
    windowManager = {
      i3 = {
        enable = false;
        package = pkgs.i3-gaps;
        config = {
          modifier = "Mod4";
          terminal = "kitty";
        };
      };
      bspwm = {
        enable = true;
        startupPrograms = [ "kitty" ];
        settings = {
          border_width = 2;
          window_gap = 3;
          split_ratio = 0.5;
          borderless_monocle = true;
          gapless_monocle = true;
          focus_by_distance = true;
          focus_follows_pointer = true;
          pointer_modifier = "mod4";
          pointer_action1 = "move";
          pointer_action2 = "resize_corner";
        };
        monitors = {
          eDP1 = [ "0001" "0010" "0011" "0100" ];
        };
      };
    };
  };

  services = {
    sxhkd = {
      enable = true;
      keybindings = {
        "mod4 + shift + e" = "bspc quit";
        "mod4 + shift + q" = "bspc node -c";
        "mod4 + t"         = "bspc node -l next";
        "mod4 + b"         = "bspc desktop -B";
        "mod4 + Tab"       = "bspc node -f last";
        "mod4 + {a,s,f}"   = "bspc node -t {tiled,floating,fullscreen}";
        "mod4 + {ctrl,shift,alt} + {Left,Down,Up,Right}" = "bspc node -{f,s,p} {west,south,north,east}";
        "mod4 + {_,shift + }{1-9,0}"                     = "bspc {desktop -f,node -d} '^{1-9,10}'";
        "super + {_,shift + } d"  = "rofi -show {run,ssh} -hide-scrollbar";
        "mod4 + Return"           = "kitty";
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

    rofi = {
      enable = true;
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
