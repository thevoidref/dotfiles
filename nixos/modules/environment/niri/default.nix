{ pkgs, lib, ... }:
{
  programs.niri.enable = true;
  programs.xwayland.enable = true;

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config = {
      common = {
          default = [ "gtk" ];
      };
      niri = lib.mkDefault {
        default = [ "gtk" ];
        "org.freedesktop.impl.portal.ScreenCast" = [ "niri" ];
        "org.freedesktop.impl.portal.Screenshot" = [ "niri" ];
      };
    };
    extraPortals = [ 
      pkgs.xdg-desktop-portal-gtk 
    ];
  };

  environment.systemPackages = with pkgs; [
    noctalia-shell
    adw-gtk3
    nwg-look
    kdePackages.qt6ct
    pywalfox-native
    
    wayland-utils
    xwayland-satellite
    udisks

    wl-clipboard
    evince

    foot
    galculator
    loupe
    clapper
  ];

  imports = [
    ../../programs/thunar
  ];

}
