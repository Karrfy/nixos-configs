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
        initial_session = {
          command = "${pkgs.niri}/bin/niri";
          user = "jannis";
        };
        default_session = initial_session;
      };
    };

  };
}
