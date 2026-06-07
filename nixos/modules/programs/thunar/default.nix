{ pkgs, ... }:
{
    programs.thunar.enable = true;

    environment.systemPackages = with pkgs; [
        thunar-archive-plugin
        thunar-volman

        # Thumbnailers
        tumbler     # Graphic daemon required for Thunar thumbnails
        webp-pixbuf-loader # Support for webp formatting inside gtk apps
    ];
}