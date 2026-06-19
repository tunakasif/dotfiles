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
  };
  outputs = inputs @ {
    systems,
    self,
    nix-auth,
    darwin,
    mac-app-util,
    nixpkgs,
    home-manager,
    nix-homebrew,
    ...
  }: let
    user = {
      name = "Tuna Alikaşifoğlu";
      email = "tunakasif@gmail.com";
      username = "tunakasif";
      gasparUsername = "alikasif";
      workLaptopHost = "lts4mac54";
    };
    specialArgs = {
      inherit user inputs;
    };
    nixpkgsConfig = {
      allowUnfree = true;
    };
  in {
    darwinConfigurations.${user.workLaptopHost} = darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        {nixpkgs.config = nixpkgsConfig;}
        ./hosts/lts4mac54
        mac-app-util.darwinModules.default
        home-manager.darwinModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            verbose = true;
            users.${user.username} = ./hosts/lts4mac54/home.nix;
            extraSpecialArgs = specialArgs;
            sharedModules = [mac-app-util.homeManagerModules.default];
          };
        }
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true; # Install Homebrew under the default prefix
            user = "${user.username}"; # User owning the Homebrew prefix
            autoMigrate = true; # Automatically migrate existing Homebrew installations
            mutableTaps = true; # Homebrew manages taps so autoUpdate/upgrade can fetch latest formulae
          };
        }
      ];
      inherit specialArgs;
    };

    homeConfigurations.${user.username} = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config = nixpkgsConfig;
      };
      modules = [
        ./hosts/dellxps/home.nix
      ];
      extraSpecialArgs = {
        inherit user inputs;
      };
    };

    homeConfigurations.${user.gasparUsername} = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config = nixpkgsConfig;
      };
      modules = [
        ./hosts/rcp-haas/home.nix
      ];
      extraSpecialArgs = {
        inherit user inputs;
      };
    };
  };
}
