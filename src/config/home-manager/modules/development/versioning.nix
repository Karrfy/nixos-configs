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
    home-configurations.development.versioning = {
      svn = {
        enable = lib.mkEnableOption {
          description = "Enables SVN versioning home manager configurations.";
          default = false;
        };
      };
    };
  };

  config = lib.mkIf config.home-configurations.development.versioning.svn.enable {
    home.packages = with pkgs; [
      kdesvn
    ];
  };
}
