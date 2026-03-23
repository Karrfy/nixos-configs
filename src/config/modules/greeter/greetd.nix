{
  config,
  pkgs,
  lib,
  ...
}:

{

  options = {
    system-configurations.greeter.greetd = {
      enable = lib.mkEnableOption {
        description = "Enables Greetd greeter.";
        default = false;
      };
    };
  };

  config = lib.mkIf config.system-configurations.greeter.greetd.enable {
    services.greetd = {
      enable = true;
      settings = rec {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --cmd niri-session";
          user = "jannis";
        };
      };
    };

  };
}
