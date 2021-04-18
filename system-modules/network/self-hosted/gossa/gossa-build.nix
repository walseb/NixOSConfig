with import <nixpkgs> {};

stdenv.mkDerivation rec {
  pname = "gossa";
  version = "master";

  src = fetchgit {
    url = "https://github.com/pldubouilh/gossa";
    deepClone = true;
    sha256 = "1swj78dd6sl7bgzy1072s8a7c2663zklbwbjrsr10wl3ph91dk9h";
    rev = "557b3fd50d618e2e5ec2007d87ee502d56170560";
  };

  buildInputs = [ stdenv go perl ];

  buildPhase = "
    # Needed to work in nix
    export GOCACHE=$TMPDIR/go-cache
    cp src/gossa.go gossa.go
    make -C gossa-ui/
    go vet gossa.go && go fmt gossa.go
    CGO_ENABLED=0 go build gossa.go
    rm gossa.go
  ";

  installPhase = "
    mkdir -p $out/bin
    cp gossa $out/bin/
  ";
}
