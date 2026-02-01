self: {
  lib,
  pkgs,
  ...
}: {
  systemd.services = let
    makeProxyUnit = script: {
      enable = true;
      after = ["network.target"];
      wantedBy = ["default.target"];
      inherit script;
    };
  in {
    shadowsocks-proxy = makeProxyUnit ''
      exec ${pkgs.shadowsocks-rust}/bin/sslocal -c /var/secrets/shadowsocks.json
    '';
    xray-proxy = makeProxyUnit ''
      exec ${pkgs.xray}/bin/xray run -c /var/secrets/xray.json
    '';
    byedpi-proxy = makeProxyUnit ''
      source /var/secrets/byedpi.sh
      exec ${pkgs.byedpi}/bin/ciadpi $BYEDPI_OPTIONS
    '';
    xray-byedpi-proxy =
      (makeProxyUnit ''
        source /var/secrets/xray-server.sh
        ${pkgs.socat}/bin/socat TCP-LISTEN:8443,bind=127.0.0.4,fork,reuseaddr SOCKS5-CONNECT:127.0.0.3:1080:$XRAY_SERVER:443 &
        ${pkgs.xray}/bin/xray run -c /var/secrets/xray-over-byedpi.json
      '')
      // {enable = false;};
    xray-alternative = makeProxyUnit ''
      exec ${pkgs.xray}/bin/xray run -c /var/secrets/xray-alt.json
    '';
    xray-cat = makeProxyUnit ''
      exec ${pkgs.xray}/bin/xray run -c /var/secrets/xray-cat.json
    '';
  };
}
