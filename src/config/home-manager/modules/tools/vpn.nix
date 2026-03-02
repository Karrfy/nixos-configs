{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

{
  options = {
    home-configurations.tools.vpn = {
      enable = lib.mkEnableOption {
        description = "Enables vpn app home manager configurations.";
        default = false;
      };
    };
  };

  config = lib.mkMerge [
    (lib.mkIf config.home-configurations.tools.security.general.enable {
      home.packages = with pkgs; [
        protonvpn-gui
      ];
    })
  ];
}
