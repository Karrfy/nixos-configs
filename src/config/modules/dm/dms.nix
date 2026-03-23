{
  config,
  pkgs,
  lib,
  ...
}:

{

  options = {
    system-configurations.dm.dms = {
      enable = lib.mkEnableOption {
        description = "Enables Dank Material Shell greeter.";
        default = false;
      };
    };
  };

  config = lib.mkIf config.system-configurations.dm.dms.enable {

    # Enable the Dank Material Shell greeter.
    services.displayManager.dms-greeter = {
      enable = true;
      compositor.name = "niri";
    };
  };
}
