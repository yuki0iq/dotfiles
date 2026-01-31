self: {
  lib,
  pkgs,
  ...
}: {
  systemd.services = let
    makeProxyUnit = args: (lib.mkMerge [
      args
      {
        enable = lib.mkDefault true;
        after = ["network.target"];
        wantedBy = ["default.target"];
      }
    ]);
  in {
    shadowsocks-proxy = makeProxyUnit {
      script = ''
        exec ${pkgs.shadowsocks-rust}/bin/sslocal -c /etc/nixos/secrets/shadowsocks.json
      '';
    };
    xray-proxy = makeProxyUnit {
      script = ''
        exec ${pkgs.xray}/bin/xray run -c /etc/nixos/secrets/xray.json
      '';
    };
    byedpi-proxy = makeProxyUnit {
      script = ''
        source /etc/nixos/secrets/byedpi.sh
        exec ${pkgs.byedpi}/bin/ciadpi $BYEDPI_OPTIONS
      '';
    };
    xray-byedpi-proxy = makeProxyUnit {
      enable = false;
      script = ''
        source /etc/nixos/secrets/xray-server.sh
        ${pkgs.socat}/bin/socat TCP-LISTEN:8443,bind=127.0.0.4,fork,reuseaddr SOCKS5-CONNECT:127.0.0.3:1080:$XRAY_SERVER:443 &
        ${pkgs.xray}/bin/xray run -c /etc/nixos/secrets/xray-over-byedpi.json
      '';
    };
    xray-alternative = makeProxyUnit {
      script = ''
        exec ${pkgs.xray}/bin/xray run -c /etc/nixos/secrets/xray-alt.json
      '';
    };
    xray-cat = makeProxyUnit {
      script = ''
        exec ${pkgs.xray}/bin/xray run -c /etc/nixos/secrets/xray-cat.json
      '';
    };
  };
}
