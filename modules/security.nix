{ config, pkgs, lib, ... }: 
{
  # import = [];

  config = {
    # Security
    security.rtkit.enable = true;

    security.sudo.extraConfig = ''
      Defaults        timestamp_timeout=30
    '';

    # Some programs need SUID wrappers, can be configured further or are started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;
  };

  # options = {};
}
