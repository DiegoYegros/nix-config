{ config, pkgs, ... }:

{
  home.username = "alezkar";
  home.homeDirectory = "/home/alezkar";

  programs.neovim = {
    enable = true;
    extraConfig = ''
      lua << EOF
      ${builtins.readFile (pkgs.fetchFromGitHub {
        owner = "diegoyegros";
        repo = "dotfiles";
        rev = "master";
        sha256 = ""; # You'll need to replace this with the correct hash
      } + "/nvim/init.lua")}
      EOF
    '';
  };

  home.stateVersion = "24.05"; # Use the appropriate version

  programs.home-manager.enable = true;
}
