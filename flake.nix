{
  description = "iancleary's example config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    ...
  }: 
  {
    nixosModules.default = { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          hello
        ];
      };

    # nixosModules.default = import ./hyprland.nix inputs;
  };
}
