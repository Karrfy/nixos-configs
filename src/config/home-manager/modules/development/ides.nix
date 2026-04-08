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
    home-configurations.development.ides = {
      vscode = {
        enable = lib.mkEnableOption {
          description = "Enables vscode home manager configurations.";
          default = false;
        };
        latex = {
          enable = lib.mkEnableOption {
            description = "Enables latex ides home manager configurations.";
            default = false;
          };
        };
        haskell = {
          enable = lib.mkEnableOption {
            description = "Enables haskell ides home manager configurations.";
            default = false;
          };
        };
      };
      jetbrains = {
        enable = lib.mkEnableOption {
          description = "Enables jetbrains ides home manager configurations.";
          default = false;
        };
      };
      prolog = {
        enable = lib.mkEnableOption {
          description = "Enables prolog ides home manager configurations.";
          default = false;
        };
      };
    };
  };

  config = lib.mkMerge [
    (lib.mkIf config.home-configurations.development.ides.vscode.enable {

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
            "latex-workshop.formatting.latex" = "latexindent";
            "haskell.manageHLS" = "PATH";
          };
          extensions = with pkgs.vscode-marketplace; [
            ms-vscode.vs-keybindings
            jnoortheen.nix-ide
            mkhl.direnv
            angular.ng-template
            james-yu.latex-workshop
            haskell.haskell
          ];
        };
      };
    })

    (lib.mkIf
      (
        config.home-configurations.development.ides.vscode.enable
        && config.home-configurations.development.ides.vscode.haskell.enable
      )
      {
        home.packages = with pkgs; [
          ghc
          cabal-install
          haskell-language-server
        ];
      }
    )

    (lib.mkIf
      (
        config.home-configurations.development.ides.vscode.enable
        && config.home-configurations.development.ides.vscode.latex.enable
      )
      {
        home.packages = with pkgs; [
          texliveFull
        ];
      }
    )

    (lib.mkIf (config.home-configurations.development.ides.prolog.enable) {
      home.packages = with pkgs; [
        swi-prolog-gui
      ];
    })

    (lib.mkIf config.home-configurations.development.ides.jetbrains.enable {
      home.packages = with pkgs; [
        jetbrains.rider
        jetbrains.rust-rover
      ];
    })
  ];
}
