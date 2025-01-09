{
  nixConfig = {
    extra-substituters = [ "https://dawidd6.cachix.org" ];
    extra-trusted-public-keys = [ "dawidd6.cachix.org-1:dvy2Br48mAee39Yit5P+jLLIUR3gOa1ts4w4DTJw+XQ=" ];
  };

  inputs = {
    hardware.url = "github:nixos/nixos-hardware";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.11";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      inputs.nuschtosSearch.follows = "";
      inputs.devshell.follows = "";
      inputs.flake-compat.follows = "";
      inputs.git-hooks.follows = "";
      inputs.home-manager.follows = "";
      inputs.nix-darwin.follows = "";
      inputs.treefmt-nix.follows = "";
    };
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs =
    inputs:
    let
      inherit (inputs.self) outputs;
      inherit (inputs.nixpkgs) lib;
      forAllSystems = function: lib.genAttrs lib.systems.flakeExposed function;
      forAllPkgs = input: function: forAllSystems (system: function (import input { inherit system; }));
    in
    {
      inherit lib;
      pkgs = forAllPkgs inputs.nixpkgs (pkgs: pkgs);
      pkgsUnstable = forAllPkgs inputs.nixpkgs-unstable (pkgs: pkgs);

      overlays.default = final: prev: {
        # https://github.com/NixOS/nixpkgs/pull/173364
        ansible = prev.ansible.overrideAttrs (oldAttrs: {
          propagatedBuildInputs = oldAttrs.propagatedBuildInputs ++ [ final.python3Packages.jmespath ];
        });
      };

      nixosConfigurations = {
        alderaan = inputs.nixpkgs.lib.nixosSystem {
          modules = [ ./hosts/alderaan ];
          specialArgs = {
            inherit inputs outputs;
            hostName = "alderaan";
          };
        };
        coruscant = inputs.nixpkgs.lib.nixosSystem {
          modules = [ ./hosts/coruscant ];
          specialArgs = {
            inherit inputs outputs;
            hostName = "coruscant";
          };
        };
        yavin = inputs.nixpkgs.lib.nixosSystem {
          modules = [ ./hosts/yavin ];
          specialArgs = {
            inherit inputs outputs;
            hostName = "yavin";
          };
        };
      };
      nixosModules = {
        basic = {
          imports = lib.filesystem.listFilesRecursive ./modules/nixos/basic;
        };
        graphical = {
          imports = lib.filesystem.listFilesRecursive ./modules/nixos/graphical;
        };
      };

      homeModules = {
        basic = {
          imports = lib.filesystem.listFilesRecursive ./modules/home-manager/basic;
        };
        graphical = {
          imports = lib.filesystem.listFilesRecursive ./modules/home-manager/graphical;
        };
      };

      checks = forAllSystems (
        system:
        let
          nixosTops = lib.mapAttrs (_: c: c.config.system.build.toplevel) outputs.nixosConfigurations;
          homeTops = lib.mapAttrs (_: c: c.activationPackage) outputs.packages.${system}.homeConfigurations;
          allTops = nixosTops // homeTops;
        in
        allTops
        // {
          pre-commit = inputs.pre-commit-hooks.lib.${system}.run {
            src = ./.;
            hooks.treefmt.enable = true;
            hooks.treefmt.package = outputs.formatter.${system};
          };
        }
      );

      devShells = forAllPkgs inputs.nixpkgs-unstable (pkgs: {
        default = pkgs.mkShellNoCC {
          NIX_CONFIG = "experimental-features = nix-command flakes";
          shellHook = ''
            ${outputs.checks.${pkgs.system}.pre-commit.shellHook}
          '';
        };
      });

      formatter = forAllPkgs inputs.nixpkgs-unstable (
        pkgs:
        inputs.treefmt.lib.mkWrapper pkgs {
          projectRootFile = "flake.nix";
          programs.deadnix.enable = true;
          programs.nixfmt.enable = true;
          programs.statix.enable = true;
        }
      );

      packages = forAllPkgs inputs.nixpkgs (pkgs: {
        homeConfigurations = {
          dawid = inputs.home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [ ./users/dawid ];
            extraSpecialArgs = {
              inherit inputs outputs;
              userName = "dawid";
            };
          };
        };
        scripts = pkgs.runCommandNoCCLocal "scripts" { } ''
          mkdir -p $out
          cp -R ${./scripts} $out/bin
        '';
      });
    };
}
