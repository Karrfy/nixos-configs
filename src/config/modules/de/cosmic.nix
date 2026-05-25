{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

{

  options = {
    system-configurations.de.cosmic = {
      enable = lib.mkEnableOption {
        description = "Enables cosmic desktop enviroment.";
        default = false;
      };
    };
  };

  config = lib.mkIf config.system-configurations.de.cosmic.enable {
    services.desktopManager.cosmic.enable = true;

    services.system76-scheduler.enable = true;
  };
}
