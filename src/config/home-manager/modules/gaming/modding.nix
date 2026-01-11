{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

{
  options = {
    home-configurations.gaming.modding = {
      enable = lib.mkEnableOption {
        description = "Enables game modding tools home manager configurations.";
        default = false;
      };
    };
  };

  config = lib.mkIf config.home-configurations.gaming.modding.enable {
    home.packages = with pkgs; [
      r2modman
      nexusmods-app-unfree
    ];
  };
}
