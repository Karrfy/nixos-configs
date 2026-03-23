{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

{
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
    xdg.configFile."niri/config.kdl".source = ./config.kdl;
  };
}
