{
  description = "Linux kernel driver for AMD Zen family CPUs (temperature, voltage, current, power via SVI2)";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      packages.${system}.default = pkgs.linuxPackages.callPackage ./default.nix { };

      nixosModules.default = { ... }: {
        boot.extraModulePackages = [
          (pkgs.linuxPackages.callPackage ./default.nix { })
        ];
      };
    };
}
