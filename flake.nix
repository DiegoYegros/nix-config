{
  description = "NixOS configuration for Alezkar's system";

  # Definir los inputs
  inputs = {
    # Nixpkgs: en lugar de usar "master", vamos a usar una revisión específica
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";  # Puedes cambiar la versión o usar un commit SHA específico

    # Home Manager: también usando una versión específica
    home-manager.url = "github:nix-community/home-manager/release-24.05";
  };

  outputs = { self, nixpkgs, home-manager }: {
    nixosConfigurations = {
      alezkar_py = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";  # Cambia esto si estás en otra arquitectura
        modules = [
          ./configuration.nix  # Importa tu configuración actual
        ];
      };
    };

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

