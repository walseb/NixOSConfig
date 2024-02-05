{pkg-s, pkgs, ...}:


(pkg-s.nyxt.overrideAttrs
  (old : {
    version = "3";
    src = pkgs.fetchFromGitHub {
      owner = "atlas-engineer";
      repo = "nyxt";
      rev = "4f0e960fdbea4d8508ac0a9f71f806f8d3a03daf";
      sha256 = "0sks6si42cq9x3ha58aa4j56hsn8y64966jddjfw4qx7nx7v6wb2";
    };
  }))
