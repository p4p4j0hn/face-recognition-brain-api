{
  description = "Postgres Database shell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    devshell.url = "github:numtide/devshell";
  };

  outputs = { self, nixpkgs, devshell }@inputs:
    let
      inherit (self) outputs;

      allSystems = [
        "x86_64-linux" # 64-bit Intel/AMD Linux
        # "aarch64-linux" # 64-bit ARM Linux
        # "x86_64-darwin" # 64-bit Intel macOS
        # "aarch64-darwin" # 64-bit ARM macOS
      ];
      
      forAllSystems = f: nixpkgs.lib.genAttrs allSystems (system: f {
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ devshell.overlays.default ];
        };
      });

      specialArgs = {
        inherit inputs;
      };
    in
      {
        devShells = forAllSystems ({ pkgs }: {
          default = pkgs.devshell.mkShell {
            name = "backend";
            imports = [ (pkgs.devshell.importTOML ./devshell.toml) ];
          };
        });
  };
}
