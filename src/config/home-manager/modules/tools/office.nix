{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

{
  options = {
    home-configurations.tools.office = {
      enable = lib.mkEnableOption {
        description = "Enables office apps home manager configurations.";
        default = false;
      };
    };
  };
  config = lib.mkIf config.home-configurations.tools.office.enable {
    home.packages = with pkgs; [
      libreoffice
      trilium-desktop
    ];
  };
}
