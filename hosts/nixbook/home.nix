{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;

  imports = [
    ./polybar.nix
    ./programs/kitty.nix
    ./programs/vim.nix
    ./programs/zsh.nix
  ];

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
          top_padding = 26;
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
          "eDP-1" = [ "0001" "0010" "0011" "0100" ];
        };
      };
    };
  };

  services = {
    picom = {
      enable = true;
      vSync = true;
    };
    sxhkd = {
      enable = true;
      keybindings = {
        "super + shift + e" = "bspc quit";
        "super + shift + q" = "bspc node -c";
        "super + t"         = "bspc node -l next";
        "super + b"         = "bspc desktop -B";
        "super + Tab"       = "bspc node -f last";
        "super + {a,s,f}"   = "bspc node -t {tiled,floating,fullscreen}";
        "super + {ctrl,shift,alt} + {Left,Down,Up,Right}" = "bspc node -{f,s,p} {west,south,north,east}";
        "super + {_,shift + }{1-9,0}"                     = "bspc {desktop -f,node -d} '^{1-9,10}'";
        "super + {_,shift + } d"  = "rofi -show {run,ssh} -hide-scrollbar";
        "super + Return"          = "kitty";
        "super + Escape"          = "pkill -USR1 -x sxhkd";
        "XF86AudioMute"         = "amixer -q set Master toggle";
        "XF86AudioLowerVolume"  = "amixer -q set Master 2%- unmute";
        "XF86AudioRaiseVolume"  = "amixer -q set Master 2%+ unmute";

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
        core.pager = "diff-so-fancy | less --tabs=4 -RFX";
        interactive.diffFilter = "diff-so-fancy --patch";
        color = {
          ui = true;
          diff = {
            meta = 11;
            frag = "magenta bold";
            func = "146 bold";
            commit = "yellow bold";
            old = "red bold";
            new = "green bold";
            whitespace = "red reverse";
          };
          "diff-highlight" = {
            oldNormal = "red bold";
            oldHighlight = "red bold 52";
            newNormal = "green bold";
            newHighlight = "green bold 22";
          };
        };
      };
    };

    rofi = {
      enable = true;
    };

    vscode = {
      enable = true;
      package = pkgs.vscode;
    };

    go = {
      enable = true;
      goPath = "dev/go";
    };

    bat.enable = true;
  };

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    htop
    discord
    slack
    spotify
    spicetify-cli
    google-chrome
    pavucontrol
    scrot
    neofetch
    material-design-icons
    nerdfonts
    diff-so-fancy
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
