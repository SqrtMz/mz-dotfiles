{
    description = "Mz's Flake";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-unstable";
        home-manager.url = "github:nix-community/home-manager/master";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";

        nixpkgs-stable.url = "nixpkgs/nixos-24.05";
        home-manager-stable.url = "github:nix-community/home-manager/release-24.05";
        home-manager-stable.inputs.nixpkgs.follows = "nixpkgs-stable";

        nix-on-droid.url = "github:nix-community/nix-on-droid/master";
        nix-on-droid.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = { self, nixpkgs, home-manager, ... } @ inputs:
    let
        lib = nixpkgs.lib;
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
    in {
        nixosConfigurations = {
            Mz = lib.nixosSystem {
                inherit system;
                specialArgs = { inherit inputs; };
                modules = [ ./configuration.nix ];
            };
        };

        nixOnDroidConfigurations = {
            MzBrick = inputs.nix-on-droid.lib.nixOnDroidConfiguration {
                inherit pkgs;
                modules = [./profiles/MzBrick/configuration.nix];
                extraSpecialArgs = {inherit inputs;};
            };
        };

        homeConfigurations = {
            mz = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                extraSpecialArgs = {inherit inputs;};
                modules = [./profiles/mz/home.nix];
            };

            server = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                extraSpecialArgs = {inherit inputs;};
                modules = [./profiles/debian/home.nix];
            };
        };
    };
}
