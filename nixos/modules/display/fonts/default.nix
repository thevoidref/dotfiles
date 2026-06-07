{ pkgs, ... }:
{
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      # Mono : Terminal & Code (Nerd)
      nerd-fonts.fira-code
      
      # UI
      mona-sans
      inter

      # Serif
      source-serif
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        serif     = [ "Source Serif 4" "Liberation Serif" ];
        sansSerif = [ "Mona Sans" "Inter" ];
        monospace = [ "Fira Code Nerd Font Mono" ];
      };
    };
  };
}
