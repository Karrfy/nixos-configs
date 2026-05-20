{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

{
  imports = [
    inputs.plasma-manager.homeModules.plasma-manager
  ];

  options = {
    home-configurations.de.kde = {
      enable = lib.mkEnableOption {
        description = "Enables KDE home manager configurations.";
        default = false;
      };
    };
  };

  config = lib.mkIf config.home-configurations.de.kde.enable {
    programs.plasma = {
      enable = true;
      shortcuts = {
        kwin = {

        };
      };
    };
  };
}
