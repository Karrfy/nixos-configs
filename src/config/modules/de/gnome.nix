{
  config,
  pkgs,
  lib,
  ...
}:

{

  options = {
    system-configurations.de.gnome = {
      enable = lib.mkEnableOption {
        description = "Enables GNOME desktop enviroment.";
        default = false;
      };
    };
  };

  config = lib.mkIf config.system-configurations.de.gnome.enable {
    # Enable the X11 windowing system.
    services.xserver.enable = false;

    # Enable the GNOME Desktop Environment.
    services.desktopManager.gnome.enable = true;

    # Remove not needed GNOME packages.
    environment.gnome.excludePackages = with pkgs; [
      gnomeExtensions.applications-menu
      gnomeExtensions.smart-auto-move
      gnomeExtensions.launch-new-instance
      gnomeExtensions.light-style
      gnomeExtensions.native-window-placement
      gnomeExtensions.places-status-indicator
      gnomeExtensions.removable-drive-menu
      gnomeExtensions.screenshot-window-sizer
      gnomeExtensions.status-icons
      gnomeExtensions.system-monitor
      gnomeExtensions.window-list
      gnomeExtensions.windownavigator
      gnomeExtensions.workspace-indicator

      baobab # disk usage analyzer
      cheese # photo booth
      eog # image viewer
      epiphany # web browser
      #gedit       # text editor
      simple-scan # document scanner
      #totem       # video player
      yelp # help viewer
      evince # document viewer
      file-roller # archive manager
      geary # email client
      #seahorse    # password manager
      hitori # sudoku game
      iagno # go game
      tali # poker game
      snapshot # camera

      #gnome-calculator
      gnome-calendar
      gnome-characters
      #gnome-clocks
      gnome-contacts
      gnome-font-viewer
      #gnome-logs
      gnome-maps
      gnome-music
      #gnome-photos
      #gnome-screenshot
      #gnome-system-monitor
      gnome-weather
      #gnome-disk-utility
      gnome-connections
      gnome-tour
      gnome-software
    ];

    # Add GNOME packages and shell extensions
    environment.systemPackages = with pkgs; [
      gnomeExtensions.app-hider
      gnomeExtensions.grand-theft-focus
      gnomeExtensions.appindicator
      gnomeExtensions.fullscreen-avoider

      gnome-tweaks
      gnome-firmware
    ];
  };
}
