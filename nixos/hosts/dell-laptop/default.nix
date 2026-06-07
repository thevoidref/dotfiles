{ hostname, pkgs, lib, ... }:
{
  networking.hostName = hostname;

  imports = [
    ./hardware.nix
    ./printers.nix
    ./shells.nix
    ./audio.nix
    ./graphics.nix
  ];
}