{ pkgs, ... }:
{
  services.printing = {
    enable = true;
    drivers = [ pkgs.epson-escpr ];
  };

  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.epsonscan2 ];
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  hardware.printers = {
    ensurePrinters = [
      {
        name = "XP-2200";
        location = "Home";
        deviceUri = "lpd://192.168.1.10";
        model = "epson-inkjet-printer-escpr/Epson-XP-2200_Series-epson-escpr-en.ppd";
      }

      {
        name = "ET-2750";
        location = "Home";
        deviceUri = "lpd://192.168.1.79";
        model = "epson-inkjet-printer-escpr/Epson-ET-2750_Series-epson-escpr-en.ppd";
      }
    ];
  };
}
