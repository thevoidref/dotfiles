{
  services.pipewire.wireplumber.extraConfig."wave-xlr-nosuspend" = {
    "monitor.alsa.rules" = [
      {
        matches = [
          {
            "node.name" = "~alsa_input.usb-Elgato.*";
          }
        ];

        actions.update-props = {
          "session.suspend-timeout-seconds" = 0;
          "node.pause-on-idle" = false;
        };
      }
    ];
  };
}