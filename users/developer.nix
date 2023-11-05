{ pkgs, lib, buildPackages, ... }: 
let 
  customConfig = import /users/kde-config.nix;
  # unstable = fetchTarball "https://github.com/NixOS/nixpkgs/archive/refs/tags/23.11-pre.tar.gz";
  # someVariable = "123"; # use inside "in" block
  # unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
  # unstable = import
  #   (builtins.fetchTarball "https://github.com/nixos/nixpkgs/tarball/master")
  #   # reuse the current configuration
  #   { config = config.nixpkgs.config; };
in
{
  # IMPORTS
  # imports = [
  #   (import "${home-manager/nixos}")
  # ];

  # TOP-LEVEL USER CONFIG
  users.users.developer = {
    initialPassword = "demo123";
    isNormalUser = true;
    # description = "developer";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    # shell = pkgs.fish; # Set fish as default shell
  };

  # https://chat.openai.com/c/752fa251-2fb7-4bcf-82c3-c5329b6309da
  # buildPackages.fetchgit = {
  #   name = "rustc";
  #   url = "";
  #   rev = "";    
  # };
  
  # HOME-MANAGER USER CONFIG
  ## (see also list of lsp-servers: https://github.com/helix-editor/helix/wiki/How-to-install-the-default-language-servers)
  home-manager.users.developer = { lib, ... }: {
    # ENVIRONMENT VARIABLES
    home.sessionVariables = {
      EDITOR = "hx"; # Set Default Code Editor
    };

    # HOME-MANAGER VERSION
    home.stateVersion = "23.05";

    # HOME-MANAGER PACKAGES
    home.packages = with pkgs; [
      # Choose packages from: https://search.nixos.org/packages
      # alacritty # Terminal Emulator
      ansible # DevOps (IaC, app/server deployment)
      ansible-language-server
      awscli2 # DevOps (includes: aws aws_completer)
      awsls # DevOps
      awslogs # DevOps
      bottom # A better htop
      chromium # Browser
      delve # GoLang Debugger
      devbox # Development
      epiphany # Browser (similar to safari webkit browser)
      firefox # Browser
      gcc # somewhat a dependency for RUST
      # gftp
      gimp # Image Tool
      go # GoLang
      gopls # GoLang LSP
      hcloud # Hetzner Cloud
      jq # JSON Parser
      psmisc # includes: fuser, killall, prtstat, pslog, pstree, peekfd
      k3d # DevOps
      k3s # DevOps
      k9s # DevOps (sweet for monitoring kubernetes, etc.)
      keychain # SSH Key Agent Helper
      kops # DevOps
      kubectl # DevOps
      kubernetes-helm # DevOps
      lazydocker # Docker
      lazygit # GIT
      libreoffice # Office
      lldb # high-performance debugger (e.g. for GoLang)
      lua-language-server # Lua LSP
      nerdfonts # IconFont
      nodePackages.bash-language-server
      nodePackages.dockerfile-language-server-nodejs
      nodePackages.jsdoc
      nodePackages.svelte-language-server
      nodePackages.typescript-language-server
      nodePackages.yaml-language-server
      nodePackages.vls
      nodePackages.vscode-langservers-extracted
      nil # NixOS Configuration LSP
      nodejs_18 # NodeJS
      marksman # Markdown LSP
      minikube # DevOps
      openssl
      # pycritty # Configurator for alacritty
      rancher # DevOps
      ripgrep # Regex Pattern String Replacer
      rustup # Rust (Toolchain)
      # rust-analyzer # Rust LSP # collides with rustup rust installation
      signal-desktop
      taplo # TOML LSP
      teleport # ZeroTrust
      terraform # DevOps (IaC)
      terraform-ls
      thunderbird # Mail App
      trivy # DevOps / SecOps
      # unstable.wails # Golang Fullstack/Desktop Framework
      # wezterm # Terminal Emulator
      vscodium # Equal to "vscode" except tracking/telemetry
      # vscode-extensions.vadimcn.vscode-lldb # usually "lldb" package should be enough
      xxh # Use your favorite shell through ssh
      yai # AI powered terminal assistant
      # yubikey-agent # moved to system.nix for enabling as system service
      yubikey-manager
      yubikey-manager-qt
    ];

    # MIME TYPES
    # xdg.configFile."mimeapps.list".force = true;
    xdg.mimeApps.enable = true;
    xdg.mimeApps.defaultApplications = {
      "application/pdf" = "okularApplication_pdf.desktop";
      # "application/javascript" = "codium.desktop";
      # "application/json" = "codium.desktop";
      "application/msword" = "writer.desktop";
      # "application/xml" = "codium.desktop";
      # "application/x-javascript" = "codium.desktop";
      "application/x-extension-htm" = "firefox.desktop";
      "application/x-extension-html" = "firefox.desktop";
      # "application/x-httpd-php" = "codium";
      # "inode/directory" = "pcmanfm.desktop";
      "text/css" = "codium.desktop";
      "text/csv" = "calc.desktop";
      "text/html" = "firefox.desktop";
      "text/plain" = "org.gnome.gedit.desktop";
      "text/rtf" = "writer.desktop";
      # "text/x-python" = "codium.desktop";
      # "image/*" = "imv-folder.desktop";
      # "video/*" = "umpv.desktop";
      # "audio/*" = "org.gnome.Lollypop.desktop";
    };

    # A multi-shell multi-command argument completer.
    # programs.carapace.enable = true;

    # KDE ADDITIONAL CONFIGS
    # home.activation = import ./kde-config.nix;
    home.activation.kwriteconfig5 = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
      # https://github.com/LunNova/nixos-configs/blob/dev/users/lun/on-nixos/kdeconfig.nix
      $DRY_RUN_CMD ${pkgs.libsForQt5.kconfig}/bin/kwriteconfig5 --file ~/.config/kwinrc --group TabBox --key LayoutName "big_icons"
      $DRY_RUN_CMD ${pkgs.libsForQt5.kconfig}/bin/kwriteconfig5 --file ~/.config/kdeglobals --group KDE --key SingleClick false
      $DRY_RUN_CMD ${pkgs.libsForQt5.qt5.qttools.bin}/bin/qdbus org.kde.KWin /KWin reconfigure || echo "KWin reconfigure failed"
    '';

    # SOME KDE TESTS
    # TODO: https://github.com/LunNova/nixos-configs/blob/dev/users/lun/on-nixos/kdeconfig.nix
    # xsession.initExtra = ''
    #   kwriteconfig5 --file ~/.config/kwinrc --group TabBox --key LayoutName "big_icons"
    # '';
    # systemd.services.plasma5extended = {
    #   enable = true;
    #   description = "My Custom Script";
    #   serviceConfig = {
    #     Type = "oneshot";
    #     ExecStart = ''
    #       /run/current-system/sw/bin/kwriteconfig5 --file ~/.config/kwinrc --group TabBox --key LayoutName "icons" 
    #     '';
    #   };
    #   wantedBy = [ "multi-user.target" ];
    # };
    # environment.plasma5.excludePackages = with pkgs.libsForQt5; [
    #   elisa
    #   gwenview
    #   okular
    #   oxygen
    #   khelpcenter
    #   konsole
    #   plasma-browser-integration
    #   print-manager
    # ];

    # KEYCHAIN
    # (loads your private keys automatically to the agent)
    programs.keychain.enable = true;
    programs.keychain.enableFishIntegration = true;
    programs.keychain.enableBashIntegration = true;
    programs.keychain.enableZshIntegration = true;
    programs.keychain.keys = [ "$HOME/.ssh/id_rsa" "$HOME/.ssh/id_ed25519_sk" ];

    # FIREFOX
    # (see also: https://github.com/Zaechus/nixos-config/blob/main/modules/firefox/default.nix)
    # (see also: https://nixos.wiki/wiki/Configuration_Collection)    
    # programs.firefox = {
    #   enable = true;
    #   policies = {
    #     DisableTelemetry = true;
    #   };
    #   # profiles.default = {
    #   #   settings = {
    #   #     "browser.urlbar.eventTelemetry.enabled" = false;
    #   #     "browser.search.serpEventTelemetry.enabled" = false;
    #   #     "browser.ping-centre.telemetry" = false;
    #   #     "toolkit.telemetry.enabled" = false;
    #   #     "toolkit.telemetry.server" = "";
    #   #   };
    #   # };
    # };

    # DIRENV
    programs.direnv.enable = true;

    # NEOVIM
    programs.neovim.enable = true;

    # STARSHIP SHELL (in combination with other shell)
    # programs.starship.enable = true; # maybe doesnt work?!
    # programs.starship.enableFishIntegration = true;
    # programs.starship.settings = {
    #   format = "$shlvl$shell$username$hostname$nix_shell$git_branch$git_commit$git_state$git_status$directory$jobs$cmd_duration$character";
    #   # Example: https://discourse.nixos.org/t/starship-configuration/20429/3
    # };

    # FISH SHELL
    programs.fish.enable = true;
    # programs.fish.shellAliases.code = "${pkgs.vscodium}/bin/codium";
    programs.fish.interactiveShellInit = ''
      # set fish_greeting # Disable greeting
    	fish_config prompt choose arrow 
    	# fish_config theme choose Dracula # not working in nixos
    	# yes | fish_config theme save # not working in nixos

      # AWS Auto Completer
      if type -q aws_completer
        aws_completer
      end

      # YUBIKEY ALIASES
      if nix-store -q --requisites ~/.nix-profile | grep -q "yubikey-manager"
        alias yubikey-manager-cli="${pkgs.yubikey-manager}/bin/ykman"
        alias yubikey-manager-gui="${pkgs.yubikey-manager-qt}/bin/ykman-gui"
      end

      # VSCODE ALIASES
      if nix-store -q --requisites ~/.nix-profile | grep -q "vscode"
        alias code="${pkgs.vscode}/bin/code"
      else if nix-store -q --requisites ~/.nix-profile | grep -q "vscodium"
        alias code="${pkgs.vscodium}/bin/codium"
      end

      # (determines if vscode or vscodium is running and creates alias):
      # nix-shell -p vscode --run "echo $status" 2>/dev/null | grep -q '^1$'
      # nix-shell -p vscodium --run "echo $status" 2>/dev/null | grep -q '^1$'
    '';

    # ZSH SHELL
    programs.zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      enableSyntaxHighlighting = true;
    };

    # GIT
    programs.git = {
      enable = true;
      userName = "iocron";
      userEmail = "info@iocron.com";
      # aliases = {};

      delta = {
        enable = true;
        options = {
          line-numbers = true;
          side-by-side = true;
        };
      };
    };

    # HELIX
    programs.helix = {
      enable = true;
      # languages = {};
      # settings = {};
    };
  };
}
