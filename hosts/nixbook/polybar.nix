{ config, pkgs, ...}:

{
  services = {
    polybar = {
      enable = true;
      package = pkgs.polybar.override { pulseSupport = true; };
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
#            "2" = "unifont:fontformat=truetype:size=13:antialias=true;";
          };
         
          modules = {
            left = "round-left bspwm round-right";
            right  = "wlan audio battery round-left time round-right";
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

            charging           = "<animation-charging> <label-charging>";
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
          animation-charging-framerate = 750;
        };

        "module/audio" = {
          type = "internal/pulseaudio";
          label = {
            muted = " ";
            volume = {
              text = "%percentage%%";
              foreground = "\${colors.foreground}";
            };
          };
          format = {
            muted = {
              text = "<label-muted>";
              foreground = "\${colors.foreground}";
              background = "\${colors.content-background}";
              padding = 1;
            };
            volume = "<ramp-volume> <label-volume>";
          };
          ramp = {
            volume.foreground = "\${colors.cyan}";
            volume.text = [
              ""
              ""
              ""
            ];
          };
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
  };
}
