{ pkgs, lib, config, hostCfg, inputs, ... }:

let
  rolePackages = {
    dev       = import ../modules/roles/developer.nix;
    admin     = import ../modules/roles/admin.nix;
    designer  = import ../modules/roles/designer.nix;
  };

  # Get users database
  registry = import ./registry.nix;

  # Get lists of users on host, make it a single list of unique users
  accessLists = builtins.map (listName: import ./lists/${listName}.nix) hostCfg.accessLists;
  allowedUsers = lib.unique (builtins.concatLists accessLists);

  # Get listed users specs from database
  userSpecs = lib.attrsets.getAttrs allowedUsers registry;
in
{
  # Imports system wide apps
  imports = [
    ../modules/roles
  ];

  # Setup users
  users.users = builtins.mapAttrs (username: spec: {
    isNormalUser = true;
    description  = spec.description;
    home         = "/home/${username}";
    extraGroups  = spec.extraGroups;
    shell        = pkgs.${spec.shell};
    packages     = builtins.concatLists (
      builtins.map (role: rolePackages.${role} { inherit pkgs; })
        (builtins.filter (role: builtins.hasAttr role rolePackages)
          (spec.roles or []))
    );
  }) userSpecs;

  # Setup user specific git and dotfiles
  system.activationScripts = lib.mapAttrs' (username: spec:
  lib.nameValuePair "userSetup-${username}" {
    text = ''
      # Clone dotfiles if URL is set and dir doesn't exist
      ${lib.optionalString (spec ? dotfilesUrl && spec.dotfilesUrl != null) ''
        if [ ! -d "/home/${username}/.dotfiles" ]; then
          ${pkgs.git}/bin/git clone "${spec.dotfilesUrl}" "/home/${username}/.dotfiles"
          chown -R ${username}:users "/home/${username}/.dotfiles"
        fi
      ''}

      # Write git config only if it doesn't exist yet
      ${lib.optionalString (spec ? gitName && spec ? gitEmail) ''
        GIT_CONFIG="/home/${username}/.dotfiles/.config/git/config"
        if [ ! -f "$GIT_CONFIG" ]; then
          mkdir -p "$(dirname "$GIT_CONFIG")"
          printf '%s\n' \
            '[user]' \
            '    name = ${spec.gitName}' \
            '    email = ${spec.gitEmail}' \
            '[core]' \
            '    editor = nvim' \
            '[init]' \
            '    defaultBranch = main' \
            '[push]' \
            '    autoSetupRemote = true' \
            > "$GIT_CONFIG"
          chown -R ${username}:users "/home/${username}/.dotfiles/.config/git"
        fi
      ''}
    '';
    deps = [ "users" ];
  }) userSpecs;
}
