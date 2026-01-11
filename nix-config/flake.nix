{
  description = "Nix and Home Manager configuration of Tuna Alikaşifoğlu";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-auth.url = "github:numtide/nix-auth";
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mac-app-util.url = "github:hraban/mac-app-util";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
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
      nix-auth,
      darwin,
      mac-app-util,
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
        gaspar_username = "alikasif";
      };
      specialArgs = {
        inherit user inputs;
      };
    in
    {
      darwinConfigurations."lts4mac54" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./hosts/aarch64-darwin
          mac-app-util.darwinModules.default
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              verbose = true;
              users.${user.username} = ./hosts/aarch64-darwin/home.nix;
              extraSpecialArgs = specialArgs;
              sharedModules = [ mac-app-util.homeManagerModules.default ];
            };
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
        inherit specialArgs;
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

      homeConfigurations.${user.gaspar_username} = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { system = "x86_64-linux"; };
        modules = [
          ./hosts/rcp-haas/home.nix
        ];
        extraSpecialArgs = {
          inherit user;
        };
      };
    };
}
