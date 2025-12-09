{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    # Import desktop enviroment configurations
    ./de/gnome.nix

    # Import tool apps
    ./tools/browsers.nix
    ./tools/cli.nix
    ./tools/office.nix
    ./tools/security.nix

    # Import social apps
    ./social/voicechat.nix

    # Import development apps
    ./development/ides.nix
    ./development/cli.nix

    # Import gaming apps
    ./gaming/launchers.nix
    ./gaming/modding.nix

    # Import media apps
    ./media/music.nix
    ./media/pictures.nix

    # Import filemanagement apps
    ./tools/filemanagement.nix
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
