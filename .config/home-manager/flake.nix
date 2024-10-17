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
  };
  outputs =
    inputs@{
      self,
      darwin,
      nixpkgs,
      home-manager,
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
