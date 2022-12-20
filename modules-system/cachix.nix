# https://github.com/jonascarpay/nix

{ config, lib, ... }:
with lib;
let

  cachixCaches = let

    getCache' = arg:
      if isString arg then getCache { name = arg; } else getCache arg;

    getCache = args:
      let
        content = builtins.fetchurl ({
          url = "https://cachix.org/api/v1/cache/${args.name}";
        } // optionalAttrs (args ? sha256) { inherit (args) sha256; });
        json = builtins.fromJSON (builtins.readFile content);
        url = json.uri;
        keys = json.publicSigningKeys;
      in { inherit url keys; };

  in map getCache' config.cachix;

in {

  options.cachix = mkOption {
    type = with types; listOf (either str attrs);
    description = ''
      Accepts two configuration formats; either as a string, or an attribute
      set with a specified sha (recommended).
      Example value:
      [
        "someCachix"
        "someOtherCachix"
        { name = "someCachixWithSha"; sha256 = "..."; }
      ]
    '';
  };

  config = {
    nix.settings.substituters = map (c: c.url) cachixCaches;
    nix.settings.trusted-public-keys = concatMap (c: c.keys) cachixCaches;
  };

}
