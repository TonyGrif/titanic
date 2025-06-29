{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };
  in {
    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;

    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [
        (python312.withPackages (ps:
          with ps; [
            jupyterlab
            pandas
          ]))
      ];
      shellHook = ''
        jupyter lab
      '';
    };
  };
}
