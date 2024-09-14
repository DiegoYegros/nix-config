# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{ config, pkgs, ... }:

{
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

  networking.hostName = "alezkar_py"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  programs.sway = {
	enable = true;
	wrapperFeatures.gtk = true;
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.gnome.gnome-keyring.enable = true;
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable firmware loading
  hardware.enableAllFirmware = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  # Clona el repositorio de Neovim durante la reconstrucción de NixOS
  environment.systemPackages = with pkgs; [
    (pkgs.fetchGit {
      url = "https://github.com/diegoyegros/dotfiles.git"; # Reemplaza con tu repositorio
      rev = "master";  # O el branch/tag específico que desees
    })
  ];

  # Copia la configuración al directorio correspondiente
  environment.etc."nvim".source = "${pkgs.fetchGit { 
    url = "https://github.com/diegoyegros/dotfiles.git";
    rev = "master";
  }}/nvim/init.lua";

  # Instala Neovim
  programs.neovim = {
    enable = true;
    configure = true;  # Para asegurarte de que se enlace con tu configuración
  };
  # Define a user account. Don't forget to set a password with 'passwd'.
  users.users.alezkar = {
    isNormalUser = true;
    description = "Alezkar";
    extraGroups = [ "networkmanager" "wheel" "audio" "docker"];
    packages = with pkgs; [
      # thunderbird
    ];
  };

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
  # Enable firefox.
  programs.firefox.enable = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  virtualisation.docker.enable = true;

  nix = {
    package = pkgs.nixFlakes; 
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  services.openssh.enable = true;
  system.stateVersion = "24.05";
}
