{
  void = {
    description = "Andre";
    uid         = 1001;
    roles       = [ "dev" "admin" "designer" ];
    extraGroups = [ "wheel" "networkmanager" "video" "render" "exampleGroup" "lp" "scanner" ];
    shell       = "fish";

    dotfilesUrl = "https://github.com/thevoidref/dotfiles.git";
    gitName     = "thevoidref";
    gitEmail    = "thevoidref@gmail.com";
  };
  # Insert other users here
}
