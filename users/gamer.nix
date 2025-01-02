{ pkgs, lib, ... }: 
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
    home.stateVersion = "24.11";
    home.packages = with pkgs; [
      # Choose packages: https://search.nixos.org/packages
      brave
      dxvk # Wine DirectX dependency
      # firefox
      # bottles # gaming / apps emulator (wine-based)
      joycond
      lutris # gaming / apps emulator (wine-based)
      playonlinux # gaming / apps emulator (wine-based)
      # samba
      steam
      # wineWowPackages.stable
      (wineWowPackages.full.override {
        # wineBuild = "wine64";
        wineRelease = "staging"; # unstable # unstable seems to work sometimes better?!
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
    
    # home.activation = if pkgs.stdenv.isDarwin then {} else {};
    # (see also: https://nixos.wiki/wiki/Battle.net)
    # (sometimes manual dxvk is required if pkgs.dxvk is not working: export WINEARCH=win64; export WINEPREFIX=$HOME/.wine-battlenet; winetricks dxvk;)
    home.activation.battleNetInstaller = ''
    if [ ! -f $HOME/Battle.net.desktop ]; then
      $DRY_RUN_CMD echo '
        [Desktop Entry]
        Name=Battle.net-Setup
        Exec=export WINEARCH=win64 export WINEPREFIX=$HOME/.wine; wget -O $HOME/Battle.net-Setup.exe "https://downloader.battle.net/download/getInstaller?os=win&installer=Battle.net-Setup.exe"; wine64 $HOME/Battle.net-Setup.exe; $SHELL
        Terminal=true
        Type=Application
        Icon=utilities-terminal
      ' > Desktop/Battle.net-Setup.desktop

      # Alternative working: Exec=if [ ! -d $HOME/.wine-battlenet ]; then export WINEARCH=win64; export WINEPREFIX=$HOME/.wine-battlenet; winetricks dxvk; fi; wget -O /home/gamer/Battle.net-Setup.exe "https://downloader.battle.net/download/getInstaller?os=win&installer=Battle.net-Setup.exe"; wine64 /home/gamer/Battle.net-Setup.exe; $SHELL
      # Exec=sh -c with single quotes not working while inside single quotes multiline
      # Exec=sh -c 'if [ ! -d $HOME/.wine-battlenet ]; then export WINEARCH=win64; export WINEPREFIX=$HOME/.wine-battlenet; winetricks dxvk; fi; wget -O /home/gamer/Battle.net-Setup.exe "https://downloader.battle.net/download/getInstaller?os=win&installer=Battle.net-Setup.exe"; wine64 /home/gamer/Battle.net-Setup.exe; $SHELL'

      chmod u+x Desktop/Battle.net-Setup.desktop
    fi
    '';
    
  };

}
