{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

{
  options = {
    system-configurations.fonts.cjk = {
      enable = lib.mkEnableOption {
        description = "Enables CJK fonts.";
        default = false;
      };
    };
  };

  config = lib.mkIf config.system-configurations.fonts.cjk.enable {
    environment.systemPackages = with pkgs; [
      noto-fonts-cjk-sans
    ];
  };
}
