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
          eDP1 = [ "0001" "0010" "0011" "0100" ];
        };
      };
    };
  };

  services = {
    polybar = {
      enable = true;
      settings = {
        "colors" = {
          background         = "#11121D";
          foreground         = "#A0A8CD";
          content.background = "#2B2F37";

          blue       = "#7199EE";
          cyan       = "#38A89D";
          green      = "#A0E8A2";
          orange     = "#D19A66";
          red        = "#E06C75";
          yellow     = "#D4B261";
          purple     = "#A485DD";
          light.grey = "#565c64";
        };

        "bar/top" = {
          monitor = "eDP1";
          width = "100%";
          height = 25;
          background = "\${colors.background}";
          foreground = "\${colors.foreground}";
          padding = { left = 1; right = 1; };
          line.size = 3;
          border = {
            top = {
              size = 7;
              color = "\${colors.background}";
            };
            bottom = {
              size = 7;
              color = "\${colors.background}";
            };
          };
          
          font = {
            "0" = "Hack Nerd Font:style=Bold:pixelsize=13;3";
            "1" = "Material Design Icons:style=Bold:size=13;3";
            "2" = "unifont:fontformat=truetype:size=13:antialias=true;";
          };
         
          modules = {
            left = "round-left bspwm round-right";
            right  = "wlan battery round-left time round-right";
          };
        };

        "module/round-right" = {
          type = "custom/text";
          content = "%{T2}%{T-}";
          content-foreground = "\${colors.content-background}";
        };

        "module/round-left" = {
          type = "custom/text";
          content = "%{T2}%{T-}";
          content-foreground = "\${colors.content-background}";
        };

        "module/bspwm" = {
          type = "internal/bspwm";
          pin.workspaces = true;
          inline.mode = true;
          enable = {
            scroll = true;
            click = true;
          };
          label = {
            separator = "";
            separator-background = "\${colors.content-background}";
            
            focused = "%name%";
            focused-foreground = "\${colors.foreground}";
            focused-background = "\${colors.content-background}";
            focused-underline  = "\${colors.light-grey}";
            focused-padding    = 1;

            occupied = "%name%";
            occupied-foreground = "\${colors.light-grey}";
            occupied-background = "\${colors.content-background}";
            occupied-padding    = 1;

            empty = "";
            empty-foreground = "\${colors.foreground}";
            empty-background = "\${colors.content-background}";
            empty-padding    = 1;

            urgent = "%name%";
            urgent-foreground = "\${colors.cyan}";
            urgent-background = "\${colors.content-background}";
            urgent-padding    = 1;
          };
        };

        "module/time" = {
          type     = "internal/date";
          interval = 60;
          format            = "<label>";
          format-background = "\${colors.content-background}";
          label = "󰥔 %time%";
          time  = "%H:%M";
        };

        "module/battery" = {
          type = "internal/battery";

          format = {
            foreground = "\${colors.foreground}";
            background = "\${colors.content-background}";

            charging           = "<ramp-capacity> <label-charging>";
            charging-padding   = 1;
            chargin-foreground = "\${colors.foreground}";

            discharging = "<ramp-capacity> <label-discharging>";
            discharging-foreground = "\${colors.foreground}";
            discharging-padding = 1;

            full-prefix = " ";
            full-prefix-foreground = "\${colors.green}";
          };

          label = {
            charging = "%percentage:2%%";
            charging-foreground = "\${colors.foreground}";
            discharging = "%percentage%%";
            discharging-foreground = "\${colors.foreground}";
            full = " ";
          };

          ramp-capacity-0 = " ";
          ramp-capacity-1 = " ";
          ramp-capacity-2 = " ";
          ramp-capacity-3 = " ";
          ramp-capacity-4 = " ";
          animation-charging-0 = " ";
          animation-charging-1 = " ";
          animation-charging-2 = " ";
          animation-charging-3 = " ";
          animation-charging-4 = " ";
        };

        "module/wlan" = {
          type = "internal/network";
          interface = "wlp3s0";
          interval = 10;
          format = {
            connected = "<label-connected>";
            padding = 1;
          };
          label-connected = "󰤪 ";
          label-connected-foreground = "\${colors.green}";
        };
      };

      script = "polybar top &";
    };

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
    kitty = {
      enable = true;
      font = {
        name = "DejaVu Sans Mono";
        size = 12;
      };
    };

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
