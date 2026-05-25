{
  config,
  pkgs,
  lib,
  ...
}:

{

  options = {
    system-configurations.greeter.cosmic = {
      enable = lib.mkEnableOption {
        description = "Enables cosmic greeter.";
        default = false;
      };
    };
  };

  config = lib.mkIf config.system-configurations.greeter.cosmic.enable {
    services.displayManager.cosmic-greeter.enable = true;
  };
}
