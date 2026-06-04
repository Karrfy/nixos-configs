{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

{
  options = {
    system-configurations.gaming.steam = {
      enable = lib.mkEnableOption {
        description = "Enables steam system configurations.";
        default = false;
      };
    };
  };

  config = lib.mkIf config.system-configurations.gaming.steam.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
      extraCompatPackages = with pkgs; [
        dwproton-bin
        proton-ge-bin
      ];
    };
  };
}
