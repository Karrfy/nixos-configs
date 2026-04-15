{
  config,
  pkgs,
  ...
}:

{
  imports = [
    # Import Desktop enviroments/window managers
    ./de/gnome.nix
    ./de/niri.nix

    # Import Display manager
    ./dm/gdm.nix

    # Import Greeter
    ./greeter/greetd.nix

    # Import Flatpak
    ./flatpak/flatpak.nix

    # Import locale settings
    ./local/de_us.nix
    ./local/de_de.nix

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
