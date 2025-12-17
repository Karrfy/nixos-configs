{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

{
  options = {
    system-configurations.shared.services = {
      enablePrinting = lib.mkEnableOption {
        default = true;
        description = "Enables printing system configurations.";
      };
      enableTailscale = lib.mkEnableOption {
        default = false;
        description = "Enables Tailscale services.";
      };
      autoupdate = {
        enable = lib.mkEnableOption {
          description = "Enables nixos update script.";
          default = false;
        };
        configName = lib.mkOption {
          type = lib.types.str;
          description = "The name of the nixos configuration inside the flake.";
          example = "gamingpc";
        };
      };
    };
  };

  config = lib.mkMerge [
    (lib.mkIf config.system-configurations.shared.services.enablePrinting {
      # Enable CUPS to print documents.
      services.printing.enable = true;
    })
    (lib.mkIf config.system-configurations.shared.services.enableTailscale {
      # Enable Tailscale for VPN network connections.
      services.tailscale.enable = true;
    })
    (
      let
        flakeRepo = "/var/lib/nixos-flake";
        configName = config.system-configurations.shared.services.autoupdate.configName;
      in
      lib.mkIf config.system-configurations.shared.services.autoupdate.enable {

        users.users.flake = {
          isNormalUser = true;
          description = "User for NixOS flake updates";
          home = flakeRepo;
          createHome = true;
        };

        systemd.services.auto-update-flake-git = {
          script = ''
            set -e
            git pull
          '';
          after = [ "network-online.target" ];
          wants = [ "network-online.target" ];
          serviceConfig = {
            Type = "oneshot";
            User = "flake";
            WorkingDirectory = flakeRepo;
            Environment = [
              "PATH=/run/current-system/sw/bin"
            ];
          };
        };

        systemd.services.auto-update-flake-rebuild = {
          script = ''
            set -e
            repoPath="${flakeRepo}"
            gitDirs=$(git config --global --get-all safe.directory || true)
            if ! echo "$gitDirs" | grep -qx "$repoPath"; then
              git config --global --add safe.directory "$repoPath"
            fi
            nixos-rebuild switch --flake .#${configName}
          '';
          after = [
            "auto-update-flake-git.service"
            "network-online.target"
          ];
          wants = [
            "auto-update-flake-git.service"
            "network-online.target"
          ];
          serviceConfig = {
            Type = "oneshot";
            User = "root";
            WorkingDirectory = "${flakeRepo}/src/config";
            Environment = [
              "PATH=/run/current-system/sw/bin"
            ];
          };
        };
        systemd.timers.auto-update-flake-rebuild = {
          wantedBy = [ "timers.target" ];
          timerConfig = {
            OnCalendar = "05:00";
            Persistent = true;
          };
        };
      }
    )
  ];
}
