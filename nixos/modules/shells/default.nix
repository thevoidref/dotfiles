{ pkgs, ... }: 
{
  imports = [
    ./fish.nix
  ];
  
  environment.etc."profile.d/root-history.sh".text = ''
    export HISTSIZE=10000
    export HISTFILESIZE=20000
    export HISTCONTROL=ignoredups:erasedups
    shopt -s histappend
  '';
}