{ pkgs, pkg-s-path, ... }:
let
  # /nix/var/nix/gcroots
  # This doesn't list gc-roots, it garbage collects them. Fix it.
  list-gc-roots = pkgs.writeScriptBin "my_list-gc-roots" ''
function find_store_path_gc_roots {
    store_path="$(realpath $1)"
    while IFS=' ' read -r gcroot derivation; do
        if [[ ! $gcroot =~ ^/proc ]]; then
            if nix-store -qR "$derivation" 2>/dev/null | grep -q "$store_path"; then
        echo $gcroot
            fi
        fi
    done < <(nix-store --gc --print-roots | awk '{print $1, $3}')
}

find_store_path_gc_roots "$@"
'';
in
{
  # home.sessionVariables.NIX_PATH = "nixpkgs=${pkg-s-path}";

  # nix = {
  #   substituters = [ "https://nix-community.cachix.org" ];
  #   trusted-public-keys = [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" ];
  # };
  home.packages = [
    # list-gc-roots
  ];
}
