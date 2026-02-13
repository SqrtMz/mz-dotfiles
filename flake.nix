{
    description = "Mz's Flake";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-unstable";
        home-manager.url = "github:nix-community/home-manager/master";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";

    	nixpkgs-prior-stable.url = "nixpkgs/nixos-24.11";
    	home-manager-prior-stable.url = "github:nix-community/home-manager/release-24.11";
    	home-manager-prior-stable.inputs.nixpkgs.follows = "nixpkgs-prior-stable";

        nixpkgs-stable.url = "nixpkgs/nixos-25.05";
    	home-manager-stable.url = "github:nix-community/home-manager/release-25.05";
    	home-manager-stable.inputs.nixpkgs.follows = "nixpkgs-stable";

        nixgl = {
        	url = "github:nix-community/nixGL";
        	inputs.nixpkgs.follows = "nixpkgs";
        };

        stylix = {
            url = "github:nix-community/stylix";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = {self, nixpkgs, nixpkgs-stable, nixpkgs-prior-stable, home-manager, stylix, nixgl, ...} @ inputs:
    let
        lib = nixpkgs.lib;
        system = "x86_64-linux";
        
        pkgs = import nixpkgs {
            inherit system;
            overlays = [nixgl.overlay];
        };

        pkgs-stable = import nixpkgs-stable {
            inherit system;
            overlays = [nixgl.overlay];
        };

        pkgs-prior-stable = import nixpkgs-prior-stable {
            inherit system;
            overlays = [nixgl.overlay];
        };

    in {
        nixosConfigurations = {
            Mz = lib.nixosSystem {
                inherit system;
                specialArgs = {inherit inputs;};
                modules = [
                    ./profiles/system/Mz.nix
                    inputs.home-manager.nixosModules.default
                ];
            };
        };

        homeConfigurations = {
            mz = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                extraSpecialArgs = {inherit inputs pkgs-stable pkgs-prior-stable;};
                modules = [
                    ./profiles/user/mz.nix
					stylix.homeModules.stylix
                ];
            };

            lab = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                extraSpecialArgs = {inherit inputs pkgs-stable pkgs-prior-stable;};
                modules = [
                    ./profiles/user/lab.nix
                    stylix.homeModules.stylix
                ];
            };

            server = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                extraSpecialArgs = {inherit inputs pkgs-stable pkgs-prior-stable;};
                modules = [
                    ./profiles/user/server.nix
                ];
            };
        };
    };
}