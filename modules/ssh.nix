# vim:et:ts=2:sw=2
{
  config,
  lib,
  pkgs,
  ...
}: let
in {
  options = {
    programs.ssh.hardened = lib.mkOption {
      type = lib.types.bool;
      description = "Whether to harden SSH client";
    };
    services.openssh.hardened = lib.mkOption {
      type = lib.types.bool;
      description = "Whether to harden SSH server";
    };
  };

  config = {
    programs.ssh = lib.mkIf config.programs.ssh.hardened {
      hostKeyAlgorithms = ["ssh-ed25519-cert-v01@openssh.com" "ssh-ed25519" "rsa-sha2-256" "rsa-sha2-512"];
      kexAlgorithms = ["sntrup761x25519-sha512" "sntrup761x25519-sha512@openssh.com" "mlkem768x25519-sha256"];
      ciphers = ["aes128-ctr" "aes128-gcm@openssh.com" "aes192-ctr" "aes256-ctr" "aes256-gcm@openssh.com"];
      macs = ["hmac-sha2-512-etm@openssh.com"];

      extraConfig = ''
        VisualHostKey yes
      '';
    };

    services.openssh.settings = lib.mkIf config.services.openssh.hardened {
      KbdInteractiveAuthentication = false;
      PasswordAuthentication = false;
      UsePAM = true;

      KexAlgorithms = ["sntrup761x25519-sha512" "sntrup761x25519-sha512@openssh.com" "mlkem768x25519-sha256"];
      Ciphers = ["aes128-ctr" "aes128-gcm@openssh.com" "aes192-ctr" "aes256-ctr" "aes256-gcm@openssh.com"];
      Macs = ["hmac-sha2-512-etm@openssh.com"];
      HostKeyAlgorithms = "ssh-ed25519-cert-v01@openssh.com,ssh-ed25519,rsa-sha2-256,rsa-sha2-512";
      HostbasedAcceptedKeyTypes = "ssh-ed25519";
      PubkeyAcceptedKeyTypes = "sk-ssh-ed25519@openssh.com,ssh-ed25519";
      CASignatureAlgorithms = "ssh-ed25519";
    };
  };
}
