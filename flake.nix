{
  description = "Template for Holochain app development";

  inputs = {
    nixpkgs.follows = "holochain/nixpkgs";

    versions.url = "github:holochain/holochain/holochain-0.4.0-dev.12?dir=versions/weekly";

    holochain = {
      url = "github:holochain/holochain/holochain-0.4.0-dev.12";
      inputs.versions.follows = "versions";
      inputs.holochain.url = "github:holochain/holochain/holochain-0.4.0-dev.12";
    };
  };

  outputs = inputs @ { ... }:
    inputs.holochain.inputs.flake-parts.lib.mkFlake
      {
        inherit inputs;
      }
      {
        systems = builtins.attrNames inputs.holochain.devShells;
        perSystem =
          { inputs'
          , config
          , pkgs
          , system
          , lib
          , ...
          }: {
            devShells.default = pkgs.mkShell {
              inputsFrom = [ inputs'.holochain.devShells.holochainBinaries ];
              packages = with pkgs; [
                nodejs-18_x
                # more packages go here
                cargo-nextest
              ];
            };
          };
      };
}
