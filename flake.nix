{
  description = "GitHub CLI extension to clone repos with ghq and fzf";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    inputs@{ self, flake-parts, nixpkgs, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      perSystem =
        { pkgs, system, ... }:
        let
          gh-q = pkgs.stdenv.mkDerivation {
            pname = "gh-q";
            version = if self ? shortRev then self.shortRev else "dev";

            src = self;

            nativeBuildInputs = [ pkgs.makeWrapper ];

            installPhase = ''
              runHook preInstall
              install -Dm755 gh-q $out/bin/gh-q
              wrapProgram $out/bin/gh-q \
                --prefix PATH : ${
                  pkgs.lib.makeBinPath [
                    pkgs.fzf
                    pkgs.gh
                    pkgs.ghq
                  ]
                }
              runHook postInstall
            '';

            meta = with pkgs.lib; {
              description = "GitHub CLI extension to clone repos with ghq and fzf";
              homepage = "https://github.com/kawarimidoll/gh-q";
              license = licenses.mit;
              maintainers = [ ];
              mainProgram = "gh-q";
            };
          };
        in
        {
          packages = {
            inherit gh-q;
            default = gh-q;
          };
        };

      flake = {
        overlays.default = _final: prev: {
          gh-q = self.packages.${prev.system}.default;
        };

        homeManagerModules.default =
          {
            config,
            lib,
            pkgs,
            ...
          }:
          let
            cfg = config.programs.gh-q;
          in
          {
            options.programs.gh-q = {
              enable = lib.mkEnableOption "gh-q - GitHub CLI extension to clone repos with ghq and fzf";

              package = lib.mkOption {
                type = lib.types.package;
                default = self.packages.${pkgs.stdenv.hostPlatform.system}.default;
                description = "The gh-q package to use.";
              };
            };

            config = lib.mkIf cfg.enable {
              home.packages = [ cfg.package ];
            };
          };
      };
    };
}
