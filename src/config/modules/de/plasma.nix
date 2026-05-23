{
  config,
  pkgs,
  lib,
  ...
}:

{

  options = {
    system-configurations.de.plasma = {
      enable = lib.mkEnableOption {
        description = "Enables Plasma desktop enviroment.";
        default = false;
      };
    };
  };

  config = lib.mkIf config.system-configurations.de.plasma.enable {
    # Enable plasma 6 desktop enviroment.
    services.desktopManager.plasma6.enable = true;

    # Remove not needed KDE packages.
    environment.plasma6.excludePackages = with pkgs; [
      kdePackages.kate # IDE
      kdePackages.khelpcenter # Help center
    ];

    # Add additional KDE packages
    environment.systemPackages = with pkgs; [
      kdePackages.discover
      kdePackages.kcalc
    ];
  };
}
