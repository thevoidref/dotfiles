{ pkgs, lib, hostCfg, hostname, ... }:
let
  registry = import ./registry.nix {};
  hostSpec = registry.${hostname};
in
{
  imports = [
      ../modules/display/cursors
      ../modules/display/fonts
      ../modules/display/sddm
      ../modules/display/gtk
    ] ++ lib.concatMap (env:
      let path = ../modules/environment + "/${env}";
      in lib.optionals (builtins.pathExists path) [ path ]
    ) (hostSpec.envs or []);
}