{ pkgs, ... }:
{
  programs.neovim = {
    enable        = true;
    defaultEditor = true;
    viAlias       = true;
    vimAlias      = true;
  };

  security.sudo.extraConfig = ''
    Defaults editor = /run/current-system/sw/bin/nvim
  '';
}