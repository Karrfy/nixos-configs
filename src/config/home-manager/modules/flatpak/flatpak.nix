{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

{
  imports = [
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
  ];

  options = {
    home-configurations.flatpak = {
      enable = lib.mkEnableOption {
        description = "Enables the flatpak home manager module.";
        default = false;
      };
      prolog = {
        enable = lib.mkEnableOption {
          description = "Enables the prolog flatpak package.";
          default = false;
        };
      };
    };
  };

  config = lib.mkMerge [
    (lib.mkIf config.home-configurations.flatpak.enable {
      services.flatpak.enable = true;
    })

    (lib.mkIf
      (config.home-configurations.flatpak.enable && config.home-configurations.flatpak.prolog.enable)
      {
        services.flatpak.packages = [
          "org.swi_prolog.swipl"
        ];
      }
    )
  ];
}
