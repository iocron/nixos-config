{ pkgs, lib, buildPackages, ... }: 
# let 
  # unstable = fetchTarball "https://github.com/NixOS/nixpkgs/archive/refs/tags/23.11-pre.tar.gz";
  # someVariable = "123"; # use inside "in" block
  # unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
  # unstable = import
  #   (builtins.fetchTarball "https://github.com/nixos/nixpkgs/tarball/master")
  #   # reuse the current configuration
  #   { config = config.nixpkgs.config; };
# in
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
  home-manager.users.developer = {
    home.stateVersion = "23.05";
    home.packages = with pkgs; [
      # Choose packages from: https://search.nixos.org/packages
      chromium # Browser
      devbox
      epiphany # Browser (similar to safari webkit browser)
      firefox # Browser
      gcc # somewhat a dependency for RUST
      # gftp
      gimp
      go # GoLang
      gopls # GoLang LSP
      psmisc # includes: fuser, killall, prtstat, pslog, pstree, peekfd
      k3d # DevOps Tools
      k3s # DevOps Tools
      keychain # SSH Key Agent Helper
      lazydocker # Docker
      lazygit # GIT
      libreoffice # Office
      lua-language-server # Lua LSP
      nerdfonts # IconFont
      nodePackages.bash-language-server
      nodePackages.dockerfile-language-server-nodejs
      nodePackages.svelte-language-server
      nodePackages.typescript-language-server
      nodePackages.yaml-language-server
      nodePackages.vscode-langservers-extracted
      nil # NixOS Configuration LSP
      nodejs_18 # NodeJS
      marksman # Markdown LSP
      minikube # DevOps Tools
      openssl
      rancher # DevOps Tool
      rustup
      # rust-analyzer # Rust LSP # collides with rustup rust installation
      taplo # TOML LSP
      teleport # ZeroTrust
      thunderbird # Mail App
      # trivy # security scanner
      vscodium # equal to "vscode" except tracking/telemetry
      # yubikey-agent # moved to system.nix for enabling as system service
      yubikey-manager
      yubikey-manager-qt
    ];

    # MIME TYPES
    # xdg.configFile."mimeapps.list".force = true;
    xdg.mimeApps.enable = true;
    xdg.mimeApps.defaultApplications = {
      "application/pdf" = "okularApplication_pdf.desktop";
      "application/javascript" = "codium.desktop";
      "application/json" = "codium.desktop";
      "application/msword" = "writer.desktop";
      "application/xml" = "codium.desktop";
      "application/x-javascript" = "codium.desktop";
      "application/x-extension-htm" = "firefox.desktop";
      "application/x-extension-html" = "firefox.desktop";
      "application/x-httpd-php" = "codium";
      # "inode/directory" = "pcmanfm.desktop";
      "text/css" = "codium.desktop";
      "text/csv" = "calc.desktop";
      "text/html" = "firefox.desktop";
      "text/plain" = "org.gnome.gedit.desktop";
      "text/rtf" = "writer.desktop";
      "text/x-python" = "codium.desktop";
      # "image/*" = "imv-folder.desktop";
      # "video/*" = "umpv.desktop";
      # "audio/*" = "org.gnome.Lollypop.desktop";
    };

    xsession.initExtra = ''
      kwriteconfig5 --file ~/.config/kwinrc --group TabBox --key LayoutName "big_icons"
    '';
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
