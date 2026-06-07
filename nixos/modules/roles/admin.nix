{ pkgs }: with pkgs; [
  wev

  ansible
  terraform

  parted
  gptfdisk
  cryptsetup
  smartmontools
  nvme-cli
  e2fsprogs
  dosfstools

  testdisk
  ddrescue
  rsync

  pciutils
  usbutils
  lsof

  iproute2
  nmap
  iperf3       # Network bandwidth performance mapping
  mtr          # Combined ping and traceroute real-time analysis
  termshark    # TUI Wireshark interface for packet analysis
]