{ config, pkgs, lib, ... }:
{
  # import = [];

  config = {
    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    # boot.initrd.availableKernelModules = [ "uas" "usbcore" "usb_storage" ];
    # boot.initrd.luks.devices."luks-hashxxxxxxx".device = "..." # TODO: CHANGE THIS if you ENCRYPTED your DEVICE!!
    boot.initrd.luks.devices."luks-6b862ad1-3067-42fc-b873-04e2cc152d9e".device = "/dev/disk/by-uuid/6b862ad1-3067-42fc-b873-04e2cc152d9e";
  };

  # options = {};
}
