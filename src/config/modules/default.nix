{
  config,
  pkgs,
  ...
}:

{
  imports = [
    # Import Desktop enviroments
    ./de/gnome.nix
    ./de/hyprland.nix

    # Import Display manager
    ./dm/gdm.nix

    # Import locale settings
    ./local/de_us.nix

    # Import gaming apps
    ./gaming/steam.nix

    # Import shared modules
    ./shared/audio.nix
    ./shared/bootloader.nix
    ./shared/networking.nix
    ./shared/nixFeatures.nix
    ./shared/secureboot.nix
    ./shared/services.nix
    ./shared/tools.nix
    ./shared/usb.nix
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
