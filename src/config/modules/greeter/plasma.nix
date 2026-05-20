{
  config,
  pkgs,
  lib,
  ...
}:

{

  options = {
    system-configurations.greeter.plasma = {
      enable = lib.mkEnableOption {
        description = "Enables Plasma greeter.";
        default = false;
      };
    };
  };

  config = lib.mkIf config.system-configurations.greeter.plasma.enable {
    # Enable the Plasma display manager.
    services.displayManager.plasma-login-manager.enable = true;
  };
}
