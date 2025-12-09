{
  config,
  pkgs,
  inputs,
  nixpkgs,
  lib,
  ...
}:

{
  options = {
    home-configurations.tools.filemanagement = {
      enable = lib.mkEnableOption {
        description = "Enables filemanagement tools home manager configurations.";
        default = false;
      };
    };
  };

  config = lib.mkIf config.home-configurations.tools.filemanagement.enable {
    home.packages = with pkgs; [
      filezilla
    ];
  };
}
