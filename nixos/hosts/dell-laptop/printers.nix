{ pkgs, ... }:

let
  printerFailover = pkgs.writeShellScript "printer-failover" ''
    set -euo pipefail

    current="$(${pkgs.cups}/bin/lpstat -d 2>/dev/null | awk '{print $NF}' || true)"

    # Ordered by priority (highest first)
    printers=(
      "ET-2750:192.168.1.79"
      "XP-2200:192.168.1.10"
    )

    target=""

    for printer in "''${printers[@]}"; do
      name="''${printer%%:*}"
      ip="''${printer##*:}"

      if ${pkgs.iputils}/bin/ping -c1 -W1 "$ip" >/dev/null 2>&1; then
        target="$name"
        break
      fi
    done

    # No printer reachable
    [ -n "$target" ] || exit 0

    if [ "$current" != "$target" ]; then
      echo "Switching default printer: $current -> $target"
      ${pkgs.cups}/bin/lpadmin -d "$target"
    fi
  '';
in
{
  systemd.services.printer-failover = {
    description = "Automatic printer priority selection";

    path = with pkgs; [
      cups
      iputils
      gawk
    ];

    serviceConfig = {
      Type = "oneshot";
    };

    script = ''
      ${printerFailover}
    '';
  };

  systemd.timers.printer-failover = {
    wantedBy = [ "timers.target" ];

    timerConfig = {
      OnBootSec = "30s";
      OnUnitActiveSec = "2min";
    };
  };
}