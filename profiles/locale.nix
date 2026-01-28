self: {...}: {
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_MEASUREMENT = "C.UTF-8";
    LC_PAPER = "C.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };
  i18n.extraLocales = "all";

  time.timeZone = "Europe/Moscow";
}
