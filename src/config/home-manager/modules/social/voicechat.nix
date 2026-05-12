{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

{
  imports = [
    inputs.nixcord.homeModules.nixcord
  ];

  options = {
    home-configurations.social.voicechat = {
      enable = lib.mkEnableOption {
        description = "Enables social apps home manager configurations.";
        default = false;
      };
    };
  };

  config = lib.mkIf config.home-configurations.social.voicechat.enable {

    programs.nixcord = {
      enable = true;

      discord = {
        branch = "stable";
        equicord.enable = true;
        vencord.enable = false;
        krisp.enable = true;
      };

      config = {
        frameless = true;
        enableReactDevtools = true;
        transparent = false;

        plugins = import ./discordPlugins.nix;
      };
    };
  };
}
