{ pkgs, ... }: 
{
  # IMPORTS
  # imports = [
  #   (import "${home-manager/nixos}")
  # ];

  # TOP-LEVEL USER CONFIG
  users.users.gamer = {
    initialPassword = "demo123";
    isNormalUser = true;
    # description = "gamer";
    extraGroups = [ "networkmanager" ];
    # shell = pkgs.fish; # Set fish as default shell
  };

  # HOME-MANAGER USER CONFIG
  home-manager.users.gamer = {
    home.stateVersion = "23.05";
    home.packages = with pkgs; [
      # Choose packages: https://search.nixos.org/packages
      firefox
      # bottles # gaming / apps emulator (wine-based)
      lutris # gaming / apps emulator (wine-based)
      playonlinux # gaming / apps emulator (wine-based)
      steam
      # wineWowPackages.stable
      (wineWowPackages.full.override {
        wineRelease = "staging";
        mingwSupport = true;
      })
      winetricks # for installing additional wine drivers / deps
      # BattleNet Installation afterwards: 
      # (see also: https://nixos.wiki/wiki/Battle.net)
      # 1. export WINEARCH=win64; export WINEPREFIX=$HOME/.wine-battlenet; winetricks dxvk; 
      # 2. execute app: wine64 Battle.net-Setup.exe
      # 3. or use the desktop icon to launch, if none is present, create one: 
          # 3.1 vim ~/Battle.net.desktop
          # 3.2 Add the following code: 
            #[Desktop Entry]
            #Name=Battle.net
            #Exec=env WINEPREFIX="/home/USERNAME/.wine-battlenet" wine C:\\\\users\\\\Public\\\\Desktop\\\\Battle.net.lnk
            #Type=Application
            #StartupNotify=true
            #Comment=Hier klicken, um Battle.net zu starten.
            #Path=/home/USERNAME/.wine-battlenet/dosdevices/c:/Program Files (x86)/Battle.net
            #Icon=1AC2_Battle.net Launcher.0
            #StartupWMClass=battle.net launcher.exe
    ];
  };
}
