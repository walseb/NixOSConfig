with import <nixpkgs> {};

stdenv.mkDerivation rec {
  pname = "gossa";
  version = "master";

  src = fetchgit {
    url = "https://github.com/walseb/gossa";
    deepClone = true;
    sha256 = "1fp3vhx5w0wjyrccwccxf14bh7y1gqp910368arq1kppjhd1phcf";
    rev = "e2aa4f149e40614bad24f4ff2db2bac29b670b6c";
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
