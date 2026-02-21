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
    home-configurations.developemt.cli = {
      enable = lib.mkEnableOption {
        description = "Enables development cli tools home manager configurations.";
        default = false;
      };
    };
  };

  config = lib.mkIf config.home-configurations.developemt.cli.enable {
    home.packages = with pkgs; [
      nixfmt
    ];
    programs.direnv = {
      enable = true;
      enableBashIntegration = true;
    };
  };
}
