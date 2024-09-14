{ config, pkgs, ... }:

let
  dotfiles = builtins.fetchGit {
    url = "https://github.com/DiegoYegros/dotfiles";
    rev = "master";  # Puedes cambiar esto a un commit específico si prefieres
  };
in {
  imports =
    [
      ./hardware-configuration.nix
      ./nvidia.nix
      ./audio.nix
      ./system-packages.nix
      ./desktop-environment.nix
      ./locale.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "alezkar_py";

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    configFile = "${dotfiles}/i3/config";
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    package = pkgs.neovim;
    extraConfig = builtins.readFile "${dotfiles}/nvim/init.lua";
  };

  users.users.alezkar = {
    isNormalUser = true;
    description = "Alezkar";
    extraGroups = [ "networkmanager" "wheel" "audio" "docker"];
    packages = with pkgs; [
      # thunderbird
    ];
  };

  virtualisation.docker.enable = true;
  services.openssh.enable = true;
  system.stateVersion = "24.05";
}

