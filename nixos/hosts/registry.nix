{ ... }:
{
  "dell-laptop" = {
    system        = "x86_64-linux";
    extraModules  = [ ../modules/profiles/laptop.nix ];
    accessLists   = [ "admins" "developers" ];
    envs          = [ "niri" ];
    specialArgs   = {};
  };

  # Next machine goes here:
  # "office-workstation-01" = {
  #   system   = "x86_64-linux";
  #   hardware = ./hardwares/office-workstation-01.nix;
  # };
}
