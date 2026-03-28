{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

{

  options = {
    system-configurations.de.niri = {
      enable = lib.mkEnableOption {
        description = "Enables Niri desktop enviroment.";
        default = false;
      };
    };
  };

  config = lib.mkIf config.system-configurations.de.niri.enable {
    # Enable the X11 windowing system.
    services.xserver.enable = false;

    # enable Niri
    programs = {
      niri.enable = true;
    };

    security.polkit.enable = true;
    security.pam.services.swaylock = { };
    security.pam.services.login.enableGnomeKeyring = true;

    services.gnome.gnome-keyring.enable = true;
    hardware.bluetooth.enable = true;
    services.power-profiles-daemon.enable = true;
    services.upower.enable = true;

    # Add niri packages and shell extensions
    environment.systemPackages = with pkgs; [
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      alacritty
      swaylock
      mako
      swayidle
      xwayland-satellite
      nautilus
      adwaita-icon-theme
    ];

    environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
