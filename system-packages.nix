{ config, pkgs, ... }:

let
  neovimConfig = pkgs.fetchFromGitHub {
    owner = "diegoyegros";
    repo = "dotfiles";
    rev = "master";
    sha256 = "sha256-2Jvq7gQVQA/NTU8vs99t2Wh80gJKV3MijbZjq+TcHk4="; # Make sure this is the correct hash
  };
  # Fetch Lazy.nvim
  lazy-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "lazy-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "folke";
      repo = "lazy.nvim";
      rev = "main"; # You might want to pin this to a specific version
      sha256 = "sha256-qERgCq8exkdVQok72TAU1+xvTiy2wxcjsVwoHE59kOc="; # Add the correct hash here
    };
  };
in
{
  # ... (keep your existing package definitions)
environment.systemPackages = with pkgs; [
    ventoy-full
    gnome-extension-manager
    vlc
    neovim
    onlyoffice-bin
    gnumake
    postman
    typescript
    chromium
    busybox
    maven
    jdk21_headless
    grim
    slurp
    wl-clipboard
    bottles
    mako
    xwayland
    go
    obs-studio
    gcc
    flex
    calibre
    prismlauncher
    discord
    waybar
    wofi
    wl-clipboard
    grim
    rofi-wayland
    swww
    pkgs.dunst
    pkgs.networkmanagerapplet
    libnotify
    dbeaver-bin
    slack
    jetbrains.idea-ultimate
    openconnect
    docker_27
    nodejs_20
    python3
    ninja
    meson
    rustc
    gcc
    pkg-config
    openssl
    openssl.dev
    rustup
    cargo
    vscode
    wget
    brave
    git
    pciutils
    alsa-utils
    pavucontrol
    pulseaudio
    lutris
    wine-wayland
    qbittorrent
    btop
    steam
    wine64
    winetricks
    gnome.gnome-software
    obsidian
    appimage-run
    gtk3
    gtk4
    glib
    google-chrome
    gnome.adwaita-icon-theme
    alacritty
    (pkgs.makeDesktopItem {
      name = "cursor";
      exec = "${pkgs.appimage-run}/bin/appimage-run /home/alezkar/Downloads/cursor.AppImage";
      desktopName = "Cursor";
      genericName = "Text Editor";
      categories = [ "Development" "TextEditor" ];
    })
  ];

  environment.variables = {
    OPENSSL_DIR = "${pkgs.openssl.dev}";
    OPENSSL_LIB_DIR = "${pkgs.openssl.out}/lib";
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig:$PKG_CONFIG_PATH";
  };
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    configure = {
      customRC = ''
        set runtimepath^=${neovimConfig}/nvim
        set packpath^=${neovimConfig}/nvim
        let g:config_path = '${neovimConfig}/nvim'
        lua << EOF
        -- Add the config path to package.path
        package.path = package.path .. ";${neovimConfig}/nvim/?.lua;${neovimConfig}/nvim/?/init.lua"
        
        -- Set up lazy.nvim
        local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
        if not vim.loop.fs_stat(lazypath) then
          vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable",
            lazypath,
          })
        end
        vim.opt.rtp:prepend(lazypath)
        
        -- Now load your init.lua
        require('init')
        EOF
      '';
      packages.myVimPackage = with pkgs.vimPlugins; {
        start = [
          lazy-nvim
          # Add other plugins that need to be available immediately
        ];
        opt = [ ];
      };
    };
  };
}
