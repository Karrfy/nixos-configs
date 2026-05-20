{
  config,
  pkgs,
  lib,
  ...
}:

{

  options = {
    system-configurations.greeter.gdm = {
      enable = lib.mkEnableOption {
        description = "Enables GNOME greeter.";
        default = false;
      };
    };
  };

  config = lib.mkIf config.system-configurations.greeter.gdm.enable {

    # Enable the GNOME display manager.
    services.displayManager.gdm.enable = true;

    # Enable auto suspend on login screen.
    services.displayManager.gdm.autoSuspend = true;

    # Enable touchpad support (enabled default in most desktopManager).
    services.libinput.enable = true;
  };
}
