# Example flake to demonstrate remote flake patterns

Below is a flake, using `example-hostname`, to show how to consume a remote flake.  It's that simple.

> Refer to the schema here on the [NixOS wiki](https://nixos.wiki/wiki/Flakes#Output_schema)
```nix
{
  description = "example flake consuming this repo's remote flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-hello-world.url = "github:iancleary/flake-hello-world;
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      specialArgs = { inherit inputs; };

      x86-system = "x86_64-linux";

      example-local-modules = [
        # ./example-local.nix # doesn't exist in this repo
      ]

      # Not used below, but just to show definition here in this atrribute set (in the let block)
      remote-modules = [
        inputs.flake-hello-world.nixosModules.default
      ];

    in
    {
      nixosConfigurations = {
        example-hostname = nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          system = x86-system;
          modules = example-local-modules
            ++ [
            inputs.flake-hello-world.nixosModules.default
          ];
        };
      };
    };
}

```
