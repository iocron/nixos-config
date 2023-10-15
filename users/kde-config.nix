# { lib, pkgs, ... }:
# {
#   # https://github.com/LunNova/nixos-configs/blob/dev/users/lun/on-nixos/kdeconfig.nix
#   kdeConfig = ''
#   $DRY_RUN_CMD ${pkgs.libsForQt5.kconfig}/bin/kwriteconfig5 --file ~/.config/kwinrc --group TabBox --key LayoutName "big_icons"
#   $DRY_RUN_CMD ${pkgs.libsForQt5.kconfig}/bin/kwriteconfig5 --file ~/.config/kdeglobals --group KDE --key SingleClick false
#   $DRY_RUN_CMD ${pkgs.libsForQt5.qt5.qttools.bin}/bin/qdbus org.kde.KWin /KWin reconfigure || echo "KWin reconfigure failed"
#   '';
# };
