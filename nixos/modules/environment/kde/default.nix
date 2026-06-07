{ pkgs, lib, ... }:
{
  services.desktopManager.plasma6.enable = true;

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];
    config.plasma = {
      default = lib.mkForce [ "kde" ];
      "org.freedesktop.impl.portal.ScreenCast" = [ "kde" ];
      "org.freedesktop.impl.portal.Screenshot" = [ "kde" ];
    };
  };

  environment.systemPackages = with pkgs; [
    kdePackages.ark
    kdePackages.dolphin
    kdePackages.kate
    kdePackages.spectacle
    kdePackages.gwenview
    kdePackages.okular
  ];
}