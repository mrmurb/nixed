{ config, pkgs, ... }:

{
  nixpkgs.config = {
    allowUnfree = true;
#    packageOverrides = pkgs: {
#      vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
#    };
  };

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  hardware = {
    cpu.intel.updateMicrocode = true;
    pulseaudio.enable = true;
    opengl = {
      enable = true;
      extraPackages = with pkgs; [
        vaapiIntel
        vaapiVdpau
        libvdpau-va-gl
      ];
      driSupport = true;
    };
  };
  
  console = {
    keyMap = "sv-latin1";
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    
    initrd = {
      luks.devices = {
        root = {
          device = "/dev/disk/by-uuid/80a0e121-b482-4da7-9ee1-ff861ecaf927";
          preLVM = true;
          allowDiscards = true;
        };
      };
    };

    kernelModules = [ "kvm-intel" "wl" ];
    extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];
  };

  powerManagement = {
    enable = true;
    powertop.enable = true;
    cpuFreqGovernor = "ondemand";
  };

  networking = {
    hostName = "nixbook";
    networkmanager.enable = true;
    firewall.enable = false;
  };
  
  sound.enable = true;

  time.timeZone = "Europe/Stockholm";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "sv_SE.UTF-8/UTF-8"
    ];
  };

  services.xserver = {
    enable = true;
    dpi = 144;
    layout = "se";
    xkbVariant = "mac";
    libinput = {
      enable = true;
    };
    # videoDrivers = [ "intel" ];
    videoDrivers = [ "modesetting" ];
    desktopManager.xterm.enable = true;
  };

  programs.light.enable = true;
  services.actkbd = {
    enable = true;
    bindings = [
      { keys = [ 224 ]; events = [ "key" ]; command = "${pkgs.light}/bin/light -U 5"; }
      { keys = [ 225 ]; events = [ "key" ]; command = "${pkgs.light}/bin/light -A 5"; }
    ];
  };

  users.users.max = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };

  environment = {
    systemPackages = with pkgs; [
      vim firefox kitty powertop
    ];
    pathsToLink = [ "/share/zsh" ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?
  
  system.autoUpgrade.enable = true;
  system.autoUpgrade.channel = "https://nixos.org/channels/nixos-unstable";

  nix.gc.automatic = true;
}

