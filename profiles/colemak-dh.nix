self: {...}: {
  console.useXkbConfig = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "colemak_dh";
  };
  environment.etc.xkb.source = ./_xkb;
}
