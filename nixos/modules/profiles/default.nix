{
  imports = [
    ../system/nix.nix
    ../system/networking.nix
    ../system/locale.nix
    ../system/boot.nix
  ];

  system.stateVersion = "25.11";
}
