{ config, pkgs, lib, ... }:
{
  # import = [];

  config = {
    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    # boot.initrd.availableKernelModules = [ "uas" "usbcore" "usb_storage" ];
  };

  # options = {};
}
