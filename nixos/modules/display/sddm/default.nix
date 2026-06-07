{ pkgs, inputs, ... }:
{
  services.displayManager.sddm = {
    enable  = true;
    wayland.enable = true;
    wayland.compositor = "kwin";
    theme   = "sddm-astronaut-theme";
    extraPackages = with pkgs.kdePackages; [
      qtsvg
      qtvirtualkeyboard
      qtmultimedia
    ];
  };

  environment.systemPackages = with pkgs; [
    kdePackages.qtsvg
    kdePackages.qtvirtualkeyboard
    kdePackages.qtmultimedia

    (pkgs.stdenvNoCC.mkDerivation {
      pname = "sddm-astronaut-theme-custom";
      version = "1.0";

      src = ../themes/sddm-astronaut-theme;

      installPhase = ''
        mkdir -p $out/share/sddm/themes
        cp -r . $out/share/sddm/themes/sddm-astronaut-theme
      '';
    })
  ];

  environment.etc."sddm/themes/sddm-astronaut-theme".source = ../themes/sddm-astronaut-theme;
}