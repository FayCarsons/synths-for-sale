{
  description = "Rig development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      nixpkgs,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
        mock-data = pkgs.writeShellScriptBin "mock-data" ''
          dhall-to-json --file synths.dhall > site/data/synths.json
          dhall-to-json --file testCheckoutLinks.dhall > site/data/checkoutLinks.json
          dhall-to-json --file shipping.dhall > site/data/shippingRates.json
        '';

        workflow = pkgs.writeShellScriptBin "workflow" ''
          dhall-to-yaml --file workflow.dhall > .github/workflows/deploy.yml
        '';
      in
      {
        devShells.default =
          with pkgs;
          mkShell {
            buildInputs = [
              pkg-config
              cmake
              openssl
              dhall
              dhall-json
              dhall-lsp-server
              hugo

              uv
              python3

              mock-data
              workflow
            ];

          };
      }
    );
}
