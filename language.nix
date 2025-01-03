{ config, pkgs, lib, ... }:
{
  # import = [];
  # USAGE: Usage in other nix configuration files: config.defaultLang

  config = rec {
    defaultLang = "de";
    defaultLocale = "de_DE.UTF-8";

    # Select internationalisation properties.
    i18n.supportedLocales = [
      "de_DE.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
    ];
    i18n.defaultLocale = defaultLocale;
    i18n.extraLocaleSettings = {
      # LOCALE = defaultLocale;
      # LANGUAGE = defaultLocale;
      LANG = defaultLocale;
      LC_ALL = defaultLocale;
      LC_ADDRESS = defaultLocale;
      LC_IDENTIFICATION = defaultLocale;
      LC_MEASUREMENT = defaultLocale;
      LC_MONETARY = defaultLocale;
      LC_NAME = defaultLocale;
      LC_NUMERIC = defaultLocale;
      LC_PAPER = defaultLocale;
      LC_TELEPHONE = defaultLocale;
      LC_TIME = defaultLocale;
    };
  };

  options = with lib; with types; {
    defaultLang = mkOption { type = str; };
    defaultLocale = mkOption { type = str; };
  };
}
