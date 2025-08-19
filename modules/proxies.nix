# vim:et:ts=2:sw=2
{
  config,
  lib,
  pkgs,
  ...
}: let
in {
  options = {
    meow.proxies = lib.mkOption {
      type = lib.types.bool;
      description = "Whether to enable proxies to bypass censorship";
    };
  };

  config = lib.mkIf config.meow.proxies {
    systemd.services = let
      makeProxyUnit = args: (args
        // {
          enable = true;
          after = ["network.target"];
          wantedBy = ["default.target"];
        });
    in {
      shadowsocks-proxy = makeProxyUnit {
        description = "shadowsocks client service";
        script = ''
          exec ${pkgs.shadowsocks-rust}/bin/sslocal -c /etc/nixos/secrets/shadowsocks.json
        '';
      };
      xray-proxy = makeProxyUnit {
        description = "xray client service";
        script = ''
          exec ${pkgs.xray}/bin/xray run -c /etc/nixos/secrets/xray.json
        '';
      };
      byedpi-proxy = makeProxyUnit {
        description = "byedpi service";
        script = ''
          source /etc/nixos/secrets/byedpi.sh
          exec ${pkgs.byedpi}/bin/ciadpi $BYEDPI_OPTIONS
        '';
      };
      xray-byedpi-proxy = makeProxyUnit {
        description = "xray-over-byedpi client service";
        script = ''
          source /etc/nixos/secrets/xray-server.sh
          ${pkgs.socat}/bin/socat TCP-LISTEN:8443,bind=127.0.0.4,fork,reuseaddr SOCKS5-CONNECT:127.0.0.3:1080:$XRAY_SERVER:443 &
          ${pkgs.xray}/bin/xray run -c /etc/nixos/secrets/xray-over-byedpi.json
        '';
      };
    };
  };
}
