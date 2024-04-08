{
  description = "nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mysecrets = {
      url = "git+ssh://git@192.168.0.41:222/zero/sops.git?ref=main&shallow=1";
      flake = false;
    };

    hyprland.url = "github:hyprwm/Hyprland";

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    flake-utils = {
      url = "github:gytis-ivaskevicius/flake-utils-plus";
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in
    flake-utils.lib.mkFlake {
      inherit self inputs;
      # allow unfree packages
      channelsConfig.allowUnfree = true;

      # host defaults
      hostDefaults.system = "x86_64-linux";
      hostDefaults.modules = [
        ./hosts/core.nix
        ./hosts/sops.nix
      ];
      hostDefaults.extraArgs = {inherit flake-utils;};
      hostDefaults.specialArgs = {inherit inputs;};

      # hosts
      hosts.zero.system = "x86_64-linux";
      hosts.zero.modules = [
        ./hosts/zero.nix
        ./system/kd.nix
        ./system/dw.nix
      ];
      hosts.zero.output = "nixosConfigurations";

      formatter."x86_64-linux" = pkgs.alejandra;
      devShells = let
        forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});
        lib = nixpkgs.lib // home-manager.lib;
        systems = [
          "x86_64-linux"
        ];
        pkgsFor = lib.genAttrs systems (system:
          import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          });
      in
        forEachSystem (pkgs: import ./shell.nix {inherit pkgs;});

      # home manager configs
      homeConfigurations.kd =
        home-manager.lib.homeManagerConfiguration
        {
          inherit pkgs;
          extraSpecialArgs = {
            inherit inputs;
          };
          modules = [./home/kd.nix];
        };
      homeConfigurations.dw =
        home-manager.lib.homeManagerConfiguration
        {
          inherit pkgs;
          extraSpecialArgs = {
            inherit inputs;
          };
          modules = [./home/dw.nix];
        };
    };
}
