{
  description = "Plantuml Diagramme erstellen mit Text (Alternative Mermaidjs oder Typst/pintorita)";

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
          # umlet
          plantuml # server
          # mermaid-cli
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
          nodemon # Server, Änderung an Datei nicht sofort sichtbar
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
          nodemon # Server, Änderung an Datei nicht sofort sichtbar
          # graphviz # infinite recursion error
          # qgv # Interactive Qt graphViz display
        ];
        shellHook = ''
          echo "Alternative: VS Code Extension"
          echo "gvpr"
          echo "nodemon -e dot --exec \"dot -Tsvg input.dot -o output.svg\""
          echo ""
        '';
      };
    };
  };
}