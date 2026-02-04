{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

{
  options = {
    system-configurations.shared.nixFeatures = {
      experimental-features.enable = lib.mkEnableOption {
        description = "Enables nix experimental features.";
        default = true;
      };
      gc = {
        enable = lib.mkEnableOption {
          description = "Enables nix garbage collection features.";
          default = true;
        };
        olderThan = lib.mkOption {
          description = "Defines how old the configurations have to be to get garbage collected.";
          type = lib.types.str;
          default = "7";
        };
      };
    };
  };

  config = lib.mkMerge [
    (lib.mkIf config.system-configurations.shared.nixFeatures.experimental-features.enable {
      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];
    })

    (lib.mkIf config.system-configurations.shared.nixFeatures.gc.enable {
      nix.gc = {
        automatic = true;
        dates = "daily";
        options = "--delete-older-than ${config.system-configurations.shared.nixFeatures.gc.olderThan}d";
      };
    })
  ];
}
