{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

{
  options = {
    system-configurations.shared.bootloader = {
      enable = lib.mkEnableOption {
        description = "Enables bootloader system configurations.";
        default = true;
      };
    };
  };

  config = lib.mkIf config.system-configurations.shared.bootloader.enable {
    # Configure Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    #Support TMP unlocking LUKS
    boot.initrd.systemd.enable = true;
  };
}
