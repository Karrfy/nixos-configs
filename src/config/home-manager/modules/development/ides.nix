{
  config,
  pkgs,
  inputs,
  nixpkgs,
  lib,
  ...
}:

{
  options = {
    home-configurations.developemt.ides = {
      vscode = {
        enable = lib.mkEnableOption {
          description = "Enables vscode home manager configurations.";
          default = false;
        };
      };
      jetbrains = {
        enable = lib.mkEnableOption {
          description = "Enables jetbrains ides home manager configurations.";
          default = false;
        };
      };
    };
  };

  config = lib.mkMerge [
    (lib.mkIf config.home-configurations.developemt.ides.vscode.enable {

      nixpkgs.overlays = [ inputs.nix-vscode-extensions.overlays.default ];

      programs.vscode = {
        enable = true;
        profiles.default = {
          enableUpdateCheck = false;
          userSettings = {
            "telemetry.telemetryLevel" = "off";
            "editor.formatOnSave" = true;
            "git.autofetch" = "true";
            "git.fetchOnPull" = true;
            "git.enableSmartCommit" = true;
            "git.pruneOnFetch" = true;
            "git.confirmSync" = false;
          };
          extensions = with pkgs.vscode-marketplace; [
            ms-vscode.vs-keybindings
            jnoortheen.nix-ide
            mkhl.direnv
            angular.ng-template
          ];
        };
      };
    })

    (lib.mkIf config.home-configurations.developemt.ides.jetbrains.enable {
      home.packages = with pkgs; [
        jetbrains.rider
        jetbrains.rust-rover
      ];
    })
  ];
}
