{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  options = {
    home-configurations.de.niri = {
      enable = lib.mkEnableOption {
        description = "Enables niri home manager configurations.";
        default = false;
      };
    };
  };

  config = lib.mkIf config.home-configurations.de.niri.enable {
    # Set configuration file for niri
    xdg.configFile."niri/config.kdl".source = ./config.kdl;

    programs.noctalia-shell = {
      enable = true;
      settings = {
        # configure noctalia here
        bar = {
          density = "compact";
          position = "right";
          showCapsule = false;
          widgets = {
            left = [
              {
                id = "ControlCenter";
                useDistroLogo = true;
              }
              {
                id = "Network";
              }
              {
                id = "Bluetooth";
              }
            ];
            center = [
              {
                hideUnoccupied = false;
                id = "Workspace";
                labelMode = "none";
              }
            ];
            right = [
              {
                alwaysShowPercentage = false;
                id = "Battery";
                warningThreshold = 30;
              }
              {
                formatHorizontal = "HH:mm";
                formatVertical = "HH mm";
                id = "Clock";
                useMonospacedFont = true;
                usePrimaryColor = true;
              }
            ];
          };
        };
        colorSchemes.predefinedScheme = "Monochrome";
        location = {
          monthBeforeDay = false;
          name = "Berlin, Germany";
        };
      };
    };
  };
}
