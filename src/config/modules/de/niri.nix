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

    # enable Niri with DMS
    programs = {
      niri.enable = true;
      dms-shell = {
        enable = true;

        systemd = {
          enable = true;
          restartIfChanged = true;
        };

        enableSystemMonitoring = true;
        enableVPN = true;
        enableCalendarEvents = true;
        enableClipboardPaste = true;
      };
      dsearch.enable = true;
    };

    services.gnome.gnome-keyring.enable = true;

    # Add niri/dms packages and shell extensions
    environment.systemPackages = with pkgs; [
      alacritty
    ];
  };
}
