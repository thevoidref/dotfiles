{
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;

  # networking.wireless.enable = true;
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  # Safe laptop baseline
  services.openssh.enable = false;

  networking.firewall.enable = true;

  # Optional tools (can ignore for now)
  # programs.gnupg.agent.enable = false;
  # programs.mtr.enable = true;
}
