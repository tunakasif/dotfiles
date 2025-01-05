{
  description = "Nix and Home Manager configuration of Tuna Alikaşifoğlu";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
  };
  outputs =
    inputs@{
      systems,
      self,
      darwin,
      nixpkgs,
      home-manager,
      nix-homebrew,
      homebrew-core,
      homebrew-cask,
      ...
    }:
    let
      user = {
        name = "Tuna Alikaşifoğlu";
        email = "tunakasif@gmail.com";
        username = "tunakasif";
      };
      specialArgs = {
        inherit user inputs;
      };
    in
    {
      darwinConfigurations."kasif-macbook-pro" = darwin.lib.darwinSystem {
        system = "x86_64-darwin";
        modules = [
          ./hosts/x86_64-darwin
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.verbose = true;
            home-manager.users.${user.username} = ./hosts/x86_64-darwin/home.nix;
            home-manager.extraSpecialArgs = specialArgs;
          }
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true; # Install Homebrew under the default prefix
              user = "tunakasif"; # User owning the Homebrew prefix
              autoMigrate = true; # Automatically migrate existing Homebrew installations
            };
          }
        ];
        specialArgs = specialArgs;
      };

      homeConfigurations.${user.username} = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { system = "x86_64-linux"; };
        modules = [
          ./hosts/x86_64-linux/home.nix
        ];
        extraSpecialArgs = {
          inherit user;
        };
      };
    };
}
