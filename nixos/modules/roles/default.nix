{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # Core User Environment
    btop
    nvtopPackages.amd
    duf
    ncdu

    # File management
    thunar
    yazi
    ripgrep
    zoxide
    fd

    img2pdf
    curl
    wget
    git
    tmux
    fuzzel
    tree
    broot
    fastfetch
    vesktop

    # Data Sync & Cloud Storage Layers
    rclone

    # Universal Archives
    gzip 
    bzip2 
    xz 
    unzip

    obsidian    
  ];

  imports = [
    ../shells

    ../programs/firefox
    ../programs/nvim
  ];
}