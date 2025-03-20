{
  description = "A command-line invoice generator for french freelance";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
  };

  outputs = { self, nixpkgs }: let
    pkgs = import nixpkgs {
      system = "x86_64-linux";
    };
    invoice = pkgs.buildGoModule rec {
      pname = "invoice-bin";
      version = "0.1.0";
      src = builtins.path {
        path = ./.;
        name = "invoice-source";
        filter = (path: type: type == "directory" || (builtins.match ".*\\.(go|sum|mod)" path) != null);
      };
      env.CGO_ENABLED = 0;
      vendorHash="sha256-JJdSVzzd9QAbuId6FnSGUTCRPbgVtWG48h7eUjKDycY=";
      dontCheck=false;
      meta = with pkgs.lib; {
        description = "A command-line invoice generator for french freelance";
        homepage = "https://gitlab.com/Lesterpig/invoice";
        license = licenses.gpl3;
        platforms = platforms.linux;
      };
    };
  in
    {
      packages.x86_64-linux.invoice = invoice;
      packages.x86_64-linux.default = self.packages.x86_64-linux.invoice;
    };
}
