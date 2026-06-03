{
  description = "Plantuml Diagramme erstellen mit Text (Alternative Mermaidjs oder Graphviz). 

  Gut für:
  - einfache Diagramme
  - kein spezielles Layout
  - wenig kreuzende Linien
  - keine Farben oder sonstiges spezielles Styling
  - Diagrammtypen die es bereits so gibt: Mindmap, use cases, C4...

  Alternativen, mehr Optionen:
  - wenn Workflow in VS Code, git gespeichert sein soll, und typische UML Symbole/Icons und Linien genutzt werden: draw.io in VS Code
  - volle Freiheit, nicht Text, längeres aufstarten, komplizierter: Vektordesignprogramm
  - ??? : Latex Diagramme, mit Extension?

  Info:
  Der 'Server' soll auf einem Linux Dateisystem laufen.";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  outputs = { self, nixpkgs }: 
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { 
      inherit system;
    };
  in
  {      
    devShells.${system} = rec {


      default = pkgs.mkShell {
        packages = with pkgs; [ 
          typst
        ];
        shellHook = ''
          echo ""
          echo "typst installiert:"
          echo " typst compile Module/doc.typ --root ."
          echo ""
          echo "diagram:"
          echo " nix develop .#plantuml"
          echo " nix develop .#mermaid"
          echo " nix develop .#graphviz"
          echo " or use draw.io vscode extension"
          echo ""
        '';
      };
      
      # TODO: update nix flake template

      plantuml = pkgs.mkShell {
        packages = with pkgs; [ 
          plantuml # server
          # umlet
        ];
        shellHook = ''
          echo ""
          echo "plantuml"
          echo ""
        '';
      };

      mermaid = pkgs.mkShell {
        packages = with pkgs; [ 
          mermaid-cli
          nodemon # Server
        ];
        shellHook = ''
          echo "Alternative: VS Code Extension"
          echo "mmdc"
          echo "nodemon -e mmd --exec \"mmdc -i input.mmd -o output.png\" "
          echo ""
        '';
      };
      graphviz = pkgs.mkShell {
        packages = with pkgs; [ 
          graphviz-nox # ohne GUI
          nodemon # Server
          # graphviz # infinite recursion error
          # qgv # Interactive Qt graphViz display
        ];
        shellHook = ''
          echo "Alternative: VS Code Extension"
          echo "gvpr"
          echo "nodemon -e dot --exec \"dot -Tsvg input.dot -o output.svg\""
          echo "einfacher Alias: ng dot-filename"
          echo ""
          ng() { nodemon -e dot --exec "dot -Tsvg $1.dot -o $1.svg"; }
        '';
      };
    };
  };
}