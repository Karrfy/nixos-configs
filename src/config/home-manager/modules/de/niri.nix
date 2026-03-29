{
  config,
  pkgs,
  inputs,
  lib,
  configName,
  ...
}:

{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  options = {
    home-configurations.de.niri = {
      enable = lib.mkEnableOption {
        description = "Enables niri home manager configurations.";
        default = false;
      };
    };
  };

  config = lib.mkIf config.home-configurations.de.niri.enable {
    # Set configuration file for niri
    xdg.configFile."niri/config.kdl".source = ../../configs/niri/niriConfig.${configName}.kdl;

    programs.noctalia-shell = {
      enable = true;
      settings = ../../configs/niri/noctaliaSettings.${configName}.json;
    };
  };
}
