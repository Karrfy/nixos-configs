{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

{
  options = {
    home-configurations.de.gnome = {
      enable = lib.mkEnableOption {
        description = "Enables GNOME home manager configurations.";
        default = false;
      };
    };
  };

  config = lib.mkIf config.home-configurations.de.gnome.enable {
    # Set cursor Theme and size.
    home.pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      name = "Adwaita";
      size = 24;
      package = pkgs.adwaita-icon-theme;
    };
    home.sessionVariables = {
      XCURSOR_THEME = "Adwaita";
      XCURSOR_SIZE = "24";
    };

    dconf.settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        disabled-extensions = "disabled";
        # Enable installed extensions.
        enabled-extensions = [
          "appindicatorsupport@rgcjonas.gmail.com"
          "fullscreen-avoider@noobsai.github.com"
          "grand-theft-focus@zalckos.github.com"
          "app-hider@lynith.dev"
        ];
        # Add apps to dock.
        favorite-apps = [
          "firefox.desktop"
          "org.gnome.Nautilus.desktop"
          "steam.desktop"
          "spotify.desktop"
          "vesktop.desktop"
        ];
      };
      # Enable dynamic workspaces.
      "org/gnome/mutter" = {
        dynamic-workspaces = true;
      };
      # Place minimize, maximize, and close buttons on the right (default order):
      "org/gnome/desktop/wm/preferences" = {
        button-layout = ":minimize,maximize,close";
      };
      # Set theme to dark.
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
      # Disable mouse acceleration, set mouse speed and disable natural scroll.
      "org/gnome/desktop/peripherals/mouse" = {
        natural-scroll = false;
        accel-profile = "flat";
        speed = 0.0;
      };
      # Disable inactivity sleep.
      "org/gnome/settings-daemon/plugins/power" = {
        sleep-inactive-ac-type = "nothing";
      };
      # Show hidden files.
      "org/gtk/gtk4/settings/file-chooser" = {
        show-hidden = true;
      };
      # Disable idle delay.
      "org/gnome/desktop/session" = {
        idle-delay = lib.hm.gvariant.mkUint32 0;
      };
      # Disable hot corners.
      "org/gnome/desktop/interface" = {
        clock-format = "24h";
        enable-hot-corners = false;
      };
      # Set keybinds for fullscreen toggle
      "org/gnome/desktop/wm/keybindings" = {
        toggle-fullscreen = [ "<Super>Return" ];
      };
      # Remap interactive screenshot UI to Super+Shift+S
      "org/gnome/shell/keybindings" = {
        show-screenshot-ui = [ "<Super><Shift>s" ];
      };
    };
  };
}
