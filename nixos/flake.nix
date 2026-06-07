{
  description = "NixOS fleet";

  nixConfig = {
    extra-substituters = [ "https://noctalia.cachix.org" ];
    extra-trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, noctalia, ... }:
  let
    hosts = import ./hosts/registry.nix { rootPath = ./.; };
  in {
    nixosConfigurations = builtins.mapAttrs (hostname: hostCfg:
      nixpkgs.lib.nixosSystem {
        system = hostCfg.system;
        specialArgs = { inherit inputs hostname hostCfg; };
        modules = [
          ./hosts/${hostname}   # Machine hostName, hardware, drivers
          ./hosts/setup.nix     # Setup host envs & display
          ./users/setup.nix     # Setup users on the machine
        ] ++ (hostCfg.extraModules or []);        # Machine type setup (desktop, server etc.)
      }
    ) hosts;
  };
}
