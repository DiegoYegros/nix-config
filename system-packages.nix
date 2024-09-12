{ config, pkgs, ... }:

{
  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    onlyoffice-bin
    gnumake
    postman
    typescript
    ungoogled-chromium
    busybox
    maven
    jdk21_headless
    grim
    slurp
    wl-clipboard
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
    kitty
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
    neovim
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
}
