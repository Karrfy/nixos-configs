{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

{
  imports = [
    inputs.nix-flatpak.nixosModules.nix-flatpak
  ];

  # For now i will leave the flatpak options here, because nix-flatpak only supports the system-wide flatpak package.
  # Single flatpaks can be installed per user with nix-flatpak home manager module, but the system-wide flatpak package is required for that.
  # Because of this behavior I will keep all flatpak apps in the system configuration, until this behavior changes.

  options = {
    system-configurations.flatpak = {
      enable = lib.mkEnableOption {
        description = "Enables the flatpak system module.";
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
    (lib.mkIf config.system-configurations.flatpak.enable {
      services.flatpak = {
        enable = true;
        update.auto = {
          enable = true;
          onCalendar = "daily";
        };
      };
    })

    (lib.mkIf
      (config.system-configurations.flatpak.enable && config.system-configurations.flatpak.prolog.enable)
      {
        services.flatpak.packages = [
          "org.swi_prolog.swipl"
        ];
      }
    )
  ];
}
