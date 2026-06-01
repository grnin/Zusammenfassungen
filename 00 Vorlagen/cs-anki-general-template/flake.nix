{
  description = "typst development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    tanki = {
      url = "github:omega-800/tanki";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    cntopo = {
      url = "github:omega-800/cntopo-typ";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pt3d = {
      url = "github:omega-800/pt3d";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    typix = {
      url = "github:loqusion/typix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      tanki,
      cntopo,
      pt3d,
      typix,
      pre-commit-hooks,
      treefmt-nix,
      self,
    }:
    let
      systems = nixpkgs.lib.platforms.unix;
      eachSystem =
        f:
        nixpkgs.lib.genAttrs systems (
          system:
          f (
            import nixpkgs {
              inherit system;
              config = { };
              overlays = [
                tanki.overlays.typst-mathml
                tanki.overlays.tanki
                self.overlays.shiroa
              ];
            }
          )
        );
      treefmt = eachSystem (
        pkgs:
        treefmt-nix.lib.evalModule pkgs (_: {
          projectRootFile = "flake.nix";
          programs = {
            typstyle.enable = true;
            # markdown
            mdformat.enable = true;
            # nix
            nixfmt.enable = true;
            statix.enable = true;
            # TODO: plantuml
          };
          settings.formatter.typstyle = {
            wrapText = true;
            lineWidth = 80;
          };
        })
      );
      mkApp = drv: {
        type = "app";
        program = "${drv}${drv.passthru.exePath or "/bin/${drv.pname or drv.name}"}";
      };
      inherit (builtins) match elemAt;

      iShouldReallyRefactorThisBloatedMess =
        pkgs:
        let
          mkTypstPackagesDrv =
            name: entries:
            let
              linkFarmEntries = pkgs.lib.foldl (
                set:
                {
                  name,
                  version,
                  namespace,
                  input,
                }:
                set
                // {
                  "${namespace}/${name}/${version}" = input;
                }
              ) { } entries;
            in
            pkgs.linkFarm name linkFarmEntries;
        in
        mkTypstPackagesDrv "unpublished-typst-packages" [
          {
            name = "pt3d";
            version = "0.0.1";
            namespace = "local";
            input = pt3d;
          }
          {
            name = "cntopo";
            version = "0.1.0";
            namespace = "local";
            input = cntopo;
          }
          {
            name = "tanki";
            version = "0.0.1";
            namespace = "local";
            input = tanki;
          }
        ];

      typixPkgs =
        pkgs:
        let
          typixLib = typix.lib.${pkgs.stdenv.hostPlatform.system};
          fs = pkgs.lib.fileset;
          sources = pkgs.lib.pipe ./. [
            (fs.fileFilter (f: f.name == "doc.typ" || f.name == "deck.typ" || f.name == "cs.typ"))
            fs.toList
            (map toString)
            (builtins.filter (n: !(pkgs.lib.hasInfix "template" n)))
            (map (match ".*/([^/]+/[^/]+.typ)$"))
            (map (pkgs.lib.flip elemAt 0))
          ];
          names = map (s: builtins.split "/" (elemAt (match "([^/]+/.*)\\.typ$" s) 0)) sources;
          unpublishedTypstPackages = iShouldReallyRefactorThisBloatedMess pkgs;

          # TODO: override typst bin with typst-mathml
          commonArgs = {
            typstOpts = {
              root = ".";
              features = "html";
            };
            typstSource = "lib.typ";
            fontPaths = with pkgs; [
              "${nerd-fonts.jetbrains-mono}/share/fonts/truetype"
              "${fira-math}/share/fonts/opentype"
              "${fira-code}/share/fonts/truetype"
              "${nerd-fonts.arimo}/share/fonts/truetype"
              # "${texlivePackages.kpfonts}/share/fonts"
              "${xits-math}/share/fonts/opentype"
            ];
            virtualPaths = [ ];
          };

          extraArgs = {
            TYPST_PACKAGE_PATH = unpublishedTypstPackages;
            # TODO:
            src = # typixLib.cleanTypstSource
              ./.;
            unstable_typstPackages = [
              {
                name = "suiji";
                version = "0.5.1";
                hash = "sha256-aEur7Xo8GBmGjfgKQynKuiI1nusJKXzboLdo8vTNUjI=";
              }
              # fletcher
              {
                name = "fletcher";
                version = "0.5.8";
                hash = "sha256-kKVp5WN/EbHEz2GCTkr8i8DRiAdqlr4R7EW6drElgWk=";
              }
              {
                name = "oxifmt";
                version = "0.2.1";
                hash = "sha256-8PNPa9TGFybMZ1uuJwb5ET0WGIInmIgg8h24BmdfxlU=";
              }
              # muchpdf
              {
                name = "muchpdf";
                version = "0.1.2";
                hash = "sha256-dZTw44SVRqAM7QsncwBFSV/W8QY15cnl211ZXV35RPU=";
              }
              # chronos
              {
                name = "chronos";
                version = "0.2.1";
                hash = "sha256-r/YGfWHJuVwI5PkqNLkCFAxjaQx0rHaIoaJeU7B+ffs=";
              }
              {
                name = "cetz";
                version = "0.3.4";
                hash = "sha256-5w3UYRUSdi4hCvAjrp9HslzrUw7BhgDdeCiDRHGvqd4=";
              }
              # lilaq
              {
                name = "lilaq";
                version = "0.6.0";
                hash = "sha256-WMjjfuAOmhZ9A0S3q9qHHl8yQIvZUtrwec+ldOoXGBA=";
              }
              {
                # bruh why does rendering an arrow require 3 dependencies smh
                name = "tiptoe";
                version = "0.4.0";
                hash = "sha256-awwCPfRXnAaUZ5w3NKt4K22JXzM4QRhTNGoNqrCoB8Q=";
              }
              {
                name = "elembic";
                version = "1.1.1";
                hash = "sha256-BTcQrydTohV0WCi7ep4EEON8QABOzv2RxL8GeoTrzFk=";
              }
              {
                name = "zero";
                version = "0.6.1";
                hash = "sha256-aBYoozFFknJcZvT3ZC3YQXmZchEPNiMeEp/YrS51+Qo=";
              }
              # {
              #   name = "tiptoe";
              #   version = "0.3.1";
              #   hash = "sha256-uYR9IS2DbfKDJQ36+yPSdRiQtwIAcUedMZfnDA8aCmU=";
              # }
              # wtf lilaq which version are you using now
              {
                name = "komet";
                version = "0.2.0";
                hash = "sha256-zHcq9stJuhjjESDciuD11bSbv/ka4REjeFPJIOnQdyQ=";
              }
              {
                name = "komet";
                version = "0.1.0";
                hash = "sha256-z4n4iUGNg1VZ4bfGvKCmyME/diaDddz87uCxF8preOI=";
              }
              # plotsy-3d
              {
                name = "cetz";
                version = "0.5.2";
                hash = "sha256-wttZ+L+VPlTLGKPN/exYXozRjMNdXLShhYVTQt4KV/E=";
              }
              {
                name = "oxifmt";
                version = "1.0.0";
                hash = "sha256-edTDK5F2xFYWypGpR0dWxwM7IiBd8hKGQ0KArkbpHvI=";
              }
              # finite
              {
                name = "finite";
                version = "0.5.0";
                hash = "sha256-MccfK+c696n3Wz13uxt70gr4T0CHrDYSrM/5LburgDc=";
              }
              {
                name = "t4t";
                version = "0.4.3";
                hash = "sha256-xQDGfFTLPHeRKIwr1032nYsAl83JA+9IometWpPcN0k=";
              }
              # shiroa
              {
                name = "shiroa";
                version = "0.3.1";
                hash = "sha256-JFpZIy7FmA0Se0XukTvn/RJjHD4ZtTWoeyLwIJOVTQQ=";
              }
              {
                name = "based";
                version = "0.2.0";
                hash = "sha256-qSiPJL4K7BRypQdgLQagn0Qs5/qenjpeWUSpHOxaJDE=";
              }
              # wrap-it

              {
                name = "wrap-it";
                version = "0.1.1";
                hash = "sha256-XUo7cbJVlgxVuf2nu2ps1WFnejtcr/VEDt1igB6ggsQ=";
              }
            ];
          };
          watchArgs = {
            typstWatchCommand = "TYPST_PACKAGE_PATH=${pkgs.lib.escapeShellArg unpublishedTypstPackages} typst watch";
          };
        in
        {
          inherit
            typixLib
            commonArgs
            watchArgs
            extraArgs
            names
            ;
          build-drv = typixLib.buildTypstProject (commonArgs // extraArgs);
          build-script = typixLib.buildTypstProjectLocal (commonArgs // extraArgs);
          watch-script = typixLib.watchTypstProject (commonArgs // watchArgs);
          compile-all = pkgs.writeShellApplication {
            text = "${pkgs.lib.concatMapStringsSep "; " (
              typstSource:
              let
                p = typixLib.buildTypstProjectLocal (
                  commonArgs
                  // extraArgs
                  // {
                    inherit typstSource;
                    typstOutput = (pkgs.lib.removeSuffix ".typ" typstSource) + ".pdf";
                  }
                );
              in
              "echo '--- building ${typstSource} ---'; ${pkgs.lib.getExe p}"
            ) (builtins.filter (s: !(pkgs.lib.hasInfix "deck" s)) sources)}";
            name = "compile-all";
          };
          watch-all = pkgs.writeShellApplication {
            text = "(trap 'kill 0' SIGINT; ${
              pkgs.lib.concatMapStringsSep " & " pkgs.lib.getExe (
                map (
                  typstSource:
                  typixLib.watchTypstProject (
                    commonArgs
                    // watchArgs
                    // {
                      inherit typstSource;
                      typstOutput = (pkgs.lib.removeSuffix ".typ" typstSource) + ".pdf";
                    }
                  )
                ) sources
              )
            })";
            name = "watch-all";
          };
          crop-pdf = pkgs.writeShellApplication {
            text = ''
              [ -z "$1" ] && printf "Usage: crop-pdf <infile> <outfile>?" && exit 1

              echo "$2"

              outfile="''${2:-rotated.pdf}"
              tmpfile="$(mktemp --suffix .pdf)"

              ${pkgs.ghostscript}/bin/gs                \
                -o "$tmpfile"                           \
                -sDEVICE=pdfwrite                       \
                -c "[/CropBox [90 110 540 725]"         \
                -c " /PAGES pdfmark"                    \
                -dFirstPage=2                           \
                -f "$1"

              # TODO: how the frick do i do this with ghostscript
              ${pkgs.texlivePackages.pdfjam}/bin/pdfjam \
                --nup 2x1 --landscape --suffix 2up      \
                --outfile "$outfile" "$tmpfile"
            '';
            name = "crop-pdf";
          };
        };
    in
    {
      # FIXME: combine apps, packages and devShell packages
      devShells = eachSystem (
        pkgs:
        let
          inherit (typixPkgs pkgs)
            commonArgs
            watch-all
            typixLib
            build-script
            ;
          inherit (self.checks.${pkgs.stdenv.hostPlatform.system}) pre-commit-check;
          # a wrapper over a wrapper of a wrapper -- nice
          shiroa-wrapped = pkgs.writeShellApplication {
            name = "shiroa";
            text = ''
              TYPST_PACKAGE_PATH="${pkgs.lib.escapeShellArg (iShouldReallyRefactorThisBloatedMess pkgs)}" ${pkgs.shiroa}/bin/shiroa "$@"
            '';
          };
        in
        {
          default = typixLib.devShell {
            inherit (commonArgs) fontPaths virtualPaths;
            buildInputs = pre-commit-check.enabledPackages;
            inherit (pre-commit-check) shellHook;
            packages = [
              pkgs.typst-mathml
              pkgs.tanki-rs
              pkgs.typstyle
              # shiroa-wrapped
              watch-all
              build-script
            ];

            env.TYPST_PACKAGE_PATH = iShouldReallyRefactorThisBloatedMess pkgs;
          };
        }
      );
      # FIXME: include typst deps in watch-open scripts
      apps = eachSystem (
        pkgs:
        let
          inherit (pkgs.lib) listToAttrs escapeShellArg concatMapStringsSep;
          inherit (typixPkgs pkgs)
            names
            watchArgs
            typixLib
            commonArgs
            crop-pdf
            compile-all
            watch-all
            ;
          fp = pkgs.lib.concatStringsSep ":" commonArgs.fontPaths;
        in
        {
          # TODO: FIXME: TODO: FIXME: find the time to refactor all of this
          crop-pdf = mkApp crop-pdf;
          watch-all = mkApp watch-all;
          compile-all = mkApp compile-all;
          build-web = mkApp (
            pkgs.writeShellApplication {
              text = ''
                export TYPST_FONT_PATHS="${pkgs.lib.escapeShellArg fp}"
                export TYPST_PACKAGE_PATH="${pkgs.lib.escapeShellArg (iShouldReallyRefactorThisBloatedMess pkgs)}"
                export PATH="${pkgs.typst-mathml}/bin:$PATH"

                ${./shiroa} build --path-to-root /summaries-se-ost/ --root . --mode static-html
              '';
              name = "build-web";
            }
          );
          genanki = mkApp (
            pkgs.writeShellApplication {
              # imagine being in a contest of most unmaintainable codebase and your opponent is me
              text = concatMapStringsSep "\n" (
                path:
                let
                  type = elemAt path 2;
                  dir = elemAt path 0;
                  typstSource = "${dir}/${type}.typ";
                in
                ''
                  export TYPST_FONT_PATHS="${pkgs.lib.escapeShellArg fp}"
                  export TYPST_PACKAGE_PATH="${pkgs.lib.escapeShellArg (iShouldReallyRefactorThisBloatedMess pkgs)}"
                  export PATH="${pkgs.typst-mathml}/bin:$PATH"
                  echo "--- generating ${typstSource} ---"
                  ${pkgs.tanki-rs}/bin/tanki-rs ${typstSource} --root . 
                ''
              ) (builtins.filter (path: (elemAt path 2) == "deck") names);
              name = "genanki";
            }
          );
        }
        // (listToAttrs (
          map (
            path:
            let
              type = elemAt path 2;
              dir = elemAt path 0;
              name = dir + (if type == "doc" then "" else "-${type}");
              pname = "watch-open-${name}";

              typstSource = "${dir}/${type}.typ";
              typstOutput = "${dir}/${type}.pdf";
            in
            {
              inherit name;
              value = mkApp (
                pkgs.writeShellApplication {
                  text = ''
                    (trap 'kill 0' SIGINT; ${pkgs.zathura}/bin/zathura "${typstOutput}" &
                    ${
                      typixLib.watchTypstProject (
                        commonArgs
                        // watchArgs
                        // {
                          inherit typstSource typstOutput;
                        }
                      )
                    }/bin/typst-watch)
                  '';
                  name = pname;
                }
              );
            }
          ) names
        ))
        // (listToAttrs (
          map (
            path:
            let
              type = elemAt path 2;
              dir = elemAt path 0;
              name = dir + "-apkg";
              pname = "apkg-${name}";

              typstSource = "${dir}/${type}.typ";
              typstOutput = "${dir}/${type}.pdf";
            in
            {
              inherit name;
              value = mkApp (
                pkgs.writeShellApplication {
                  # imagine being in a contest of most hacky codebase and your opponent is me
                  text = ''
                    TYPST_PACKAGE_PATH=${pkgs.lib.escapeShellArg (iShouldReallyRefactorThisBloatedMess pkgs)} PATH=${pkgs.typst-mathml}/bin:$PATH ${pkgs.tanki-rs}/bin/tanki-rs ${typstSource} --root . 
                  '';
                  name = pname;
                }
              );
            }
          ) (builtins.filter (path: (elemAt path 2) == "deck") names)
        ))
      );

      checks = eachSystem (pkgs: {
        pre-commit-check = pre-commit-hooks.lib.${pkgs.stdenv.hostPlatform.system}.run {
          # TODO: filter src
          src = ./.;
          hooks = {
            treefmt = {
              enable = true;
              packageOverrides.treefmt = self.formatter.${pkgs.stdenv.hostPlatform.system};
            };
          };
        };
      });

      formatter = eachSystem (pkgs: treefmt.${pkgs.stdenv.hostPlatform.system}.config.build.wrapper);

      # githubActions = nix-github-actions.lib.mkGithubMatrix {
      #   checks =
      #     let
      #       onlySupported = nixpkgs.lib.getAttrs [
      #         "x86_64-linux"
      #         # TODO: typix support
      #         # "aarch64-darwin"
      #       ];
      #     in
      #     (onlySupported self.checks) // (onlySupported self.packages);
      # };

      overlays =
        let
          shiroa = _: prev: {
            inherit (self.packages.${prev.stdenv.hostPlatform.system}) shiroa;
          };
        in
        {
          inherit shiroa;
          default = shiroa;
        };

      packages.x86_64-linux =
        let
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config = { };
            overlays = [ ];
          };
          version = "0.3.1-rc4";
          pname = "shiroa";

          shiroa-pkg = pkgs.stdenv.mkDerivation {
            inherit version pname;
            src = pkgs.fetchurl {
              url = "https://github.com/Myriad-Dreamin/${pname}/releases/download/v${version}/shiroa-x86_64-unknown-linux-gnu.tar.gz";
              sha256 = "sha256-UoMqNOWOFULoGcTo43RchPmSXDxdBF1xVUaqMH53rd8=";
            };
            dontConfigure = true;
            dontBuild = true;
            dontFixup = true;
            unpackPhase = ''
              tar -xzf "$src"
            '';
            installPhase = ''
              mkdir -p "$out/bin"
              file="$(find . -type f -name ${pname} -exec grep -rIL . "{}" \;)"
              if [ -e "$file" ]; then
                cp "$file" "$out/bin"
              else
                printf "no binary found"
                exit 1
              fi
            '';
          };
          shiroa = pkgs.buildFHSEnv {
            name = "shiroa";
            runScript = "${shiroa-pkg}/bin/shiroa";
          };
        in
        {
          inherit shiroa;
          default = shiroa;
        };
    };
}
