# Compact NixOS Configuration / Starterkit Template

My base configuration / starterkit-template (without flakes) for a simple and compact home-manager multi-user environment with dev-tools, devops-tools, drivers and more.

## Install
1. A already installed NixOS is required
2. Clone the contents of this repo to your /etc/nixos
3. Change the configuration to your liking
4. Switch / Build the new configuration: `sudo nixos-rebuild switch` (or test your configuration first with `sudo nixos-rebuild test`)

## Tip
Use home-manager to further extend your configuration for the individual users or administrate them all through this global home-manager nixos-configuration. Checkout the users/ folder.

## Main Features
User "developer":
- Browsers: Firefox, Chromium, Epiphany (similar to Safari)
- DevOps: Docker, devbox, lazydocker, k3d, k3s, minikube, rancher
- IDEs/Editors: helix editor (default), neovim (naked), vscodium (similar to vscode)
- Languages: Golang, Rust, JS/TS/JSX/Vue/Svelte, Lua, Bash, TOML, Markdown, Nix/Nil, YAML, +LSP for all of them
- Networking: vpn, dig, mtr, whois, ..
- Shells: bash, zsh, fish shell (default)
- SysAdmin/SecOps: teleport, trivy, gnupg agent, keychain, fuser, killall, prstat, pslog, pstree, peekfd, gparted, yubikey, htop, ..
- Misc: Gcc, Git, Lazygit, Yai (AI Terminal Chat), LibreOffice, Gimp, Thunderbird, Print Drivers/Autodiscovery (commented), ..
- and many more..

User "gamer" (only partly tested): 
- Steam
- BattleNet (see users/gamer.nix for final install step)
- Wine + Winetricks
- Lutris (another emulator)
- PlayOnLinux (another emulator)

## Notes
This repo is not finished yet and has lots of comments, but is fully usable. 
This repo is mainly used as a starting point for generating nixos home-manager multi-user environments with different needs. The admin is able to administrate all users with the global config, but still giving the users the flexibility to use their own home-manager config to extend some functionality. 

