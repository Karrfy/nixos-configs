{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

{
  options = {
    home-configurations.gaming.launchers = {
      enable = lib.mkEnableOption {
        description = "Enables game launchers home manager configurations.";
        default = false;
      };
    };
  };

  config = lib.mkIf config.home-configurations.gaming.launchers.enable {
    home.packages = with pkgs; [
      prismlauncher
      modrinth-app
      lunar-client
      heroic
    ];
  };
}
