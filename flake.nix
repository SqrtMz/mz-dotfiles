{
    description = "Mz's Flake";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-unstable";
        home-manager.url = "github:nix-community/home-manager/master";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";

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

    outputs = {self, nixpkgs, nixpkgs-stable, home-manager, stylix, nixgl, ...} @ inputs:
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

    in {
        homeConfigurations = {
            mz = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                extraSpecialArgs = {inherit inputs pkgs-stable;};
                modules = [
                    ./profiles/mz.nix
					stylix.homeModules.stylix
                ];
            };

            lab = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                extraSpecialArgs = {inherit inputs pkgs-stable;};
                modules = [
                    ./profiles/lab.nix
                    stylix.homeModules.stylix
                ];
            };

            server = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                extraSpecialArgs = {inherit inputs pkgs-stable;};
                modules = [
                    ./profiles/server.nix
                ];
            };
        };
    };
}