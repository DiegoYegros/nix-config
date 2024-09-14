{
  description = "NixOS configuration for Alezkar's system";

  # Definir los inputs
  inputs = {
    # Nixpkgs como input principal
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";  # Puedes cambiar la versión o commit según necesites

    # Input opcional: Home Manager si lo usas
    home-manager.url = "github:nix-community/home-manager/release-24.05";
  };

  outputs = { self, nixpkgs, home-manager }: {
    nixosConfigurations = {
      # Define la configuración de tu sistema NixOS
      alezkarpy = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";  # Cambia esto si estás en otra arquitectura
        modules = [
          ./configuration.nix  # Importa tu configuración actual
        ];
      };
    };

    # Opcional: Home Manager si lo usas
    homeConfigurations = {
      alezkar = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [
          ./home.nix  # Configuración de Home Manager, si existe
        ];
      };
    };
  };
}

