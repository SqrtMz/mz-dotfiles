{
	description = "Mz's Flake";

	inputs = {
		nixpkgs.url = "nixpkgs/nixos-26.05";
		home-manager.url = "github:nix-community/home-manager/release-26.05";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";

		nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
		home-manager-unstable.url = "github:nix-community/home-manager/master";
		home-manager-unstable.inputs.nixpkgs.follows = "nixpkgs-unstable";

		nixgl = {
			url = "github:nix-community/nixGL";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		stylix = {
			url = "github:nix-community/stylix/release-26.05";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = {self, nixpkgs, nixpkgs-unstable, home-manager, stylix, nixgl, ...} @ inputs:
	let
		lib = nixpkgs.lib;
		system = "x86_64-linux";
		
		pkgs = import nixpkgs {
			inherit system;
			overlays = [nixgl.overlay];
		};

		pkgs-unstable = import nixpkgs-unstable {
			inherit system;
			overlays = [nixgl.overlay];
		};

	in {
		homeConfigurations = {
			mz = home-manager.lib.homeManagerConfiguration {
				inherit pkgs;
				extraSpecialArgs = {inherit inputs pkgs-unstable;};
				modules = [
					./profiles/mz.nix
					stylix.homeModules.stylix
				];
			};

			mzerver = home-manager.lib.homeManagerConfiguration {
				inherit pkgs;
				extraSpecialArgs = {inherit inputs pkgs-unstable;};
				modules = [
					./profiles/mzerver.nix
					stylix.homeModules.stylix
				];
			};

			lab = home-manager.lib.homeManagerConfiguration {
				inherit pkgs;
				extraSpecialArgs = {inherit inputs pkgs-unstable;};
				modules = [
					./profiles/lab.nix
					stylix.homeModules.stylix
				];
			};

			server = home-manager.lib.homeManagerConfiguration {
				inherit pkgs;
				extraSpecialArgs = {inherit inputs pkgs-unstable;};
				modules = [
					./profiles/server.nix
				];
			};
		};
	};
}