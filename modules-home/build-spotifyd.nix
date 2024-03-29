{ pkg-s, ...}:

{
  nixpkgs.config = {
    packageOverrides = pkg-s: {
      spotifyd-git= (pkg-s.spotifyd.override {}).overrideAttrs (old: rec {
        pname = "spotifyd";
        version = "987a2d7b17e160974220f74fc25a860e70aa0909";

        src = pkg-s.fetchFromGitHub {
          owner = "Spotifyd";
          repo = "spotifyd";
          rev = "${version}";
          sha256 = "1j1jnl08r13292lb9xx9i04132dh7k2p8gjk33hph33xxrprspwq";
        };

        cargoSha256 = "0200apqbx769ggjnjr0m71g61ikhml2xak5n1il2pvfx1yf5nw0n";

        cargoBuildFlags = [
          "--no-default-features"
          "--features"
          "alsa_backend, pulseaudio_backend, dbus_mpris"
        ];

        nativeBuildInputs = [ pkg-s.pkgconfig pkg-s.cargo ];

        buildInputs = [ pkg-s.openssl pkg-s.alsaLib pkg-s.libpulseaudio pkg-s.dbus];

        doCheck = false;
      });
    };
  };
}
