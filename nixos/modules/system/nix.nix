{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # 1. Automate garbage collection and set generation limits
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d"; # Automatically deletes generations older than 7 days
  };

  boot.loader.systemd-boot.configurationLimit = 10; 
}
