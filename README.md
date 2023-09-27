# Compact NixOS Configuration / Starterkit Template

My base configuration / starterkit-template (without flakes) for a simple and compact home-manager multi-user environment with dev-tools, devops-tools, drivers and more.

## Install
1. A already installed NixOS is required
2. Clone the contents of this repo to your /etc/nixos
3. Adjust / extend the configuration to your liking
4. Test your configuration and check if everything is working: `sudo nixos-rebuild test`
5. Switch / Build to new configuration: `sudo nixos-rebuild switch`

## Tip
Use home-manager to further extend your configuration for the individual users or administrate them all through this global home-manager nixos-configuration. Checkout the users/ folder.

## Main Features
User "developer":
- Browsers: Firefox, Chromium, Epiphany (similar to Safari)
- DevOps: Docker, devbox, lazydocker, k3d, k3s, minikube, rancher
- Editors: helix editor, neovim (naked), vscodium (similar to vscode)
- Languages: Golang, Rust, NodeJS, TOML, Markdown, NixOS/Nil, +LSP for all of them
- Networking: vpn, dig, mtr, whois, ..
- Shells: fish shell (default), zsh
- SysAdmin/Sec Tools: teleport, gnupg agent, keychain, fuser, killall, prstat, pslog, pstree, peekfd, gparted, yubikey, htop, ..
- Misc: Gcc, Git (+git diff delta), Lazygit, LibreOffice, Gimp, YubikeyManager, Thunderbird, Print Drivers/Autodiscovery (commented), ..

User "gamer" (only partly tested): 
- Steam
- BattleNet (see users/gamer.nix for final install step)
- Wine + Winetricks
- Lutris (another emulator)
- PlayOnLinux (another emulator)

## Notes
This repo is not finished yet and has lots of comments, but is fully usable. 
This repo is mainly used as a starting point for generating nixos home-manager multi-user environments with different needs. The admin is able to administrate all users with the global config, but still giving the users the flexibility to use their own home-manager config to extend some functionality. 

