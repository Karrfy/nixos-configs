# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    # Import home manager
    inputs.home-manager.nixosModules.default

    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # Import all system apps
    ./../../modules/default.nix
  ];

  # Use latest linux kernel instead of LTS
  boot.kernelPackages = pkgs.linuxPackages_latest;

  system-configurations = {
    # Define Deskop Enviroment
    de.gnome.enable = true;
    # Define Gnome Display Manager.
    dm.gdm.enable = true;

    # Define critical system components
    shared = {
      networking = {
        enable = true;
        hostName = "nixos";
      };
      audio.enable = true;
      usbmuxd.enable = true;
      bootloader.enable = true;
      nixFeatures.enable = true;
      services = {
        enablePrinting = true;
        enableTailscale = false;
        autoupdate = {
          enable = true;
          configName = "desktop";
        };
      };
      tools = {
        enableGit = true;
      };
    };

    # Define localization
    local.de_us.enable = true;

    # Define gaming system components
    gaming.steam.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jannis = {
    isNormalUser = true;
    description = "Jannis";
    home = "/home/jannis";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
  # Import home manager for user
  home-manager = {
    users.jannis = import ./../../home-manager/hosts/desktop/home.nix;
    extraSpecialArgs = { inherit inputs; };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
