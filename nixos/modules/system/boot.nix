{ pkgs, ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;
  
  boot.loader.systemd-boot.configurationLimit = 10; 

  # boot.initrd.systemd.enable = true;

  imports = [
    ../programs/plymouth
  ];
}
