{ pkgs, ... }:
let
  cursorTheme = "Capitaine Cursors (Gruvbox) - White";
  cursorSize  = 36;
in
{
  environment.systemPackages = with pkgs; [
    bibata-cursors
    capitaine-cursors-themed
    vimix-cursors
  ];

  environment.sessionVariables = {
    XCURSOR_THEME = cursorTheme;
    XCURSOR_SIZE  = toString cursorSize;
  };
}