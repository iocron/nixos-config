{ pkgs, lib, buildPackages, ... }: 
let 
  # customConfig = import /users/kde-config.nix;
  defaultBrowser = "brave";
  defaultEditor = "hx";
  # someVariable = "123"; # use inside "in" block
  # unstable = fetchTarball "https://github.com/NixOS/nixpkgs/archive/refs/tags/24.11-pre.tar.gz";
  ## INSTALL_INFO: Add & Update nixos-unstable before using the unstable channel:
  ##     sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
  ##     sudo nix-channel --update
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
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
    # shell = pkgs.zsh; # Set fish as default shell
  };

  # HOME-MANAGER USER CONFIG
  ## (see also list of lsp-servers: https://github.com/helix-editor/helix/wiki/How-to-install-the-default-language-servers)
  home-manager.users.developer = { lib, config, ... }: {
    # ENVIRONMENT VARIABLES
    home.sessionVariables = {
      EDITOR = "${defaultEditor}"; # Set Default Code Editor
    };

    # HOME-MANAGER VERSION
    home.stateVersion = "24.11";

    # HOME-MANAGER PACKAGES
    home.packages = with pkgs; [
      # Choose packages from: https://search.nixos.org/packages
      act # Run GitHub Actions locally
      # aichat # https://github.com/sigoden/aichat
      # alacritty # Terminal Emulator
      ansible # DevOps (IaC, app/server deployment)
      ansible-language-server
      awscli2 # DevOps (includes: aws aws_completer)
      awsls # DevOps
      awslogs # DevOps
      bottom # A better htop
      bun # Faster JS Runtime
      chromium # Browser
      certigo
      delve # GoLang Debugger
      devbox # Development
      # duckdb # InProcess SQL DB
      # epiphany # Browser (similar to safari webkit browser)
      fd # simple alternative to find command
      # firefox # Browser
      fzf # fuzzy finder
      gcc # somewhat a dependency for RUST
      # gftp
      gimp # Image Tool
      gitlab-ci-local # gitlab local executor (e.g. for debugging)
      go # GoLang
      gopls # GoLang LSP
      hcloud # Hetzner Cloud
      jq # JSON Parser
      psmisc # includes: fuser, killall, prtstat, pslog, pstree, peekfd
      # k3d # DevOps
      k3s # DevOps
      k9s # DevOps (sweet for monitoring kubernetes, etc.)
      keychain # SSH Key Agent Helper
      # kops # DevOps
      # kubectl # DevOps
      kubernetes-helm # DevOps
      lazydocker # Docker
      lazygit # GIT
      # libreoffice # Office
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
      nodejs_22 # NodeJS
      marksman # Markdown LSP
      minikube # DevOps
      mods # AI on the command line
      openssl
      # pulumi # Competitor to Terraform
      # pycritty # Configurator for alacritty
      # rancher # DevOps
      rclone # cloud storage sync tool
      ripgrep # Regex Pattern String Replacer
      rustup # Rust (Toolchain)
      # rust-analyzer # Rust LSP # collides with rustup rust installation
      # signal-desktop
      stern # Tail kubernetes logs of pods/containers
      swaks # SMTP CLI Test Tool
      taplo # TOML LSP
      # teleport # ZeroTrust
      terraform # DevOps (IaC)
      terraform-ls
      # thunderbird # Mail App
      trippy # Network Diagnostic
      trivy # DevOps / SecOps
      # wezterm # Terminal Emulator
      vscodium # Equal to "vscode" except tracking/telemetry
      # vscode-extensions.vadimcn.vscode-lldb # usually "lldb" package should be enough
      unstable.warp-terminal
      # xxh # Use your favorite shell through ssh
      # yubikey-agent # moved to system.nix for enabling as system service
      yubikey-manager
      yubikey-manager-qt
    ];

    # MIME TYPES
    # xdg.configFile."mimeapps.list".force = true;
    xdg.mimeApps = {
      enable = true;

      # MIME Default Apps (Enforced)
      defaultApplications."application/x-extension-htm" = "${defaultBrowser}.desktop";
      defaultApplications."application/x-extension-html" = "${defaultBrowser}.desktop";
      defaultApplications."text/htm" = "${defaultBrowser}.desktop";
      defaultApplications."text/html" = "${defaultBrowser}.desktop";
      defaultApplications."x-scheme-handler/about" = "${defaultBrowser}.desktop";
      defaultApplications."x-scheme-handler/http" = "${defaultBrowser}.desktop";
      defaultApplications."x-scheme-handler/https" = "${defaultBrowser}.desktop";
      # defaultApplications."x-scheme-handler/unknown" = "${defaultBrowser}.desktop";

      # MIME Associated Apps (Non-Enforced)
      # associations.added."application/javascript" = "codium.desktop";
      # associations.added."application/json" = "codium.desktop";
      # associations.added."application/msword" = "writer.desktop";
      # associations.added."application/pdf" = "okularApplication_pdf.desktop";
      # associations.added."application/x-javascript" = "codium.desktop";
      # associations.added."application/xml" = "codium.desktop";
      # associations.added."text/css" = "codium.desktop";
      # associations.added."text/csv" = "calc.desktop";
      # associations.added."text/plain" = "org.gnome.gedit.desktop";
      # associations.added."text/rtf" = "writer.desktop";
      #
      # "text/x-python" = "codium.desktop";
      # "image/*" = "imv-folder.desktop";
      # "video/*" = "umpv.desktop";
      # "audio/*" = "org.gnome.Lollypop.desktop";
      # "inode/directory" = "pcmanfm.desktop";
    };

    # A multi-shell multi-command argument completer.
    # programs.carapace.enable = true;

    # KDE ADDITIONAL CONFIGS
    # home.activation = import ./kde-config.nix;
    # OLD: This Config is for KDE5..
    # home.activation.kwriteconfig5 = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    #   # https://github.com/LunNova/nixos-configs/blob/dev/users/lun/on-nixos/kdeconfig.nix
    #   $DRY_RUN_CMD ${pkgs.libsForQt5.kconfig}/bin/kwriteconfig5 --file ~/.config/kwinrc --group TabBox --key LayoutName "big_icons"
    #   $DRY_RUN_CMD ${pkgs.libsForQt5.kconfig}/bin/kwriteconfig5 --file ~/.config/kdeglobals --group KDE --key SingleClick false
    #   $DRY_RUN_CMD ${pkgs.libsForQt5.qt5.qttools.bin}/bin/qdbus org.kde.KWin /KWin reconfigure || echo "KWin reconfigure failed"
    # '';

    # KEYCHAIN
    # (loads your private keys automatically to the agent)
    programs.keychain.enable = true;
    # programs.keychain.enableFishIntegration = true;
    programs.keychain.enableBashIntegration = true;
    programs.keychain.enableZshIntegration = true;
    programs.keychain.keys = [ "$HOME/.ssh/id_rsa" "$HOME/.ssh/id_ed25519_sk" ];

    # DIRENV
    programs.direnv.enable = true;

    # NEOVIM
    programs.neovim.enable = true;

    # FISH SHELL
    # programs.fish.enable = true;
    # programs.fish.shellAliases.code = "${pkgs.vscodium}/bin/codium";
    # programs.fish.interactiveShellInit = ''
    #   # set fish_greeting # Disable greeting
    # 	fish_config prompt choose arrow 
    # 	# fish_config theme choose Dracula # not working in nixos
    # 	# yes | fish_config theme save # not working in nixos

    #   # AWS Auto Completer
    #   if type -q aws_completer
    #     aws_completer
    #   end

    #   # YUBIKEY ALIASES
    #   if nix-store -q --requisites ~/.nix-profile | grep -q "yubikey-manager"
    #     alias yubikey-manager-cli="${pkgs.yubikey-manager}/bin/ykman"
    #     alias yubikey-manager-gui="${pkgs.yubikey-manager-qt}/bin/ykman-gui"
    #   end

    #   # VSCODE ALIASES
    #   if nix-store -q --requisites ~/.nix-profile | grep -q "vscode"
    #     alias code="${pkgs.vscode}/bin/code"
    #   else if nix-store -q --requisites ~/.nix-profile | grep -q "vscodium"
    #     alias code="${pkgs.vscodium}/bin/codium"
    #   end

    #   # (determines if vscode or vscodium is running and creates alias):
    #   # nix-shell -p vscode --run "echo $status" 2>/dev/null | grep -q '^1$'
    #   # nix-shell -p vscodium --run "echo $status" 2>/dev/null | grep -q '^1$'
    # '';

    # ZSH SHELL
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
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
