{
  config,
  pkgs,
  lib,
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

    services.gnome.gnome-keyring.enable = true;
    hardware.bluetooth.enable = true;
    services.power-profiles-daemon.enable = true;
    services.upower.enable = true;

    # Add niri packages and shell extensions
    environment.systemPackages = with pkgs; [
      alacritty
      fuzzel
      swaylock
      mako
      swayidle
      xwayland-satellite
    ];

    programs.noctalia-shell = {
      enable = true;
      settings = {
        # configure noctalia here
        bar = {
          density = "compact";
          position = "right";
          showCapsule = false;
          widgets = {
            left = [
              {
                id = "ControlCenter";
                useDistroLogo = true;
              }
              {
                id = "Network";
              }
              {
                id = "Bluetooth";
              }
            ];
            center = [
              {
                hideUnoccupied = false;
                id = "Workspace";
                labelMode = "none";
              }
            ];
            right = [
              {
                alwaysShowPercentage = false;
                id = "Battery";
                warningThreshold = 30;
              }
              {
                formatHorizontal = "HH:mm";
                formatVertical = "HH mm";
                id = "Clock";
                useMonospacedFont = true;
                usePrimaryColor = true;
              }
            ];
          };
        };
        colorSchemes.predefinedScheme = "Monochrome";
        location = {
          monthBeforeDay = false;
          name = "Berlin, Germany";
        };
      };
    };

    environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
