{ pkgs, lib, ... }: {
  services.languagetool = {

    enable = true;

    port = lib.mkDefault 8081;
    # port = lib.mkDefault 7032;
    allowOrigin = ""; # To allow access from browser addons

    settings = {
      # Allowed options:
      # https://github.com/languagetool-org/languagetool/blob/master/languagetool-server/src/main/java/org/languagetool/server/HTTPServerConfig.java#L185-L205

      # rulesFile = "${./languagetool/languagetool-rules.cfg}";
      # remoteRulesFile = "${./languagetool/languagetool-rules.cfg}";

      # Optional, remove unneeded files
      # Approx. total of 26GB.
      # Data from:
      # https://languagetool.org/download/ngram-data/
      # languageModel = pkgs.linkFarm "languageModel"
      #   (builtins.mapAttrs (_: v: pkgs.fetchzip v) {
      #     en = { # 15GB
      #       url =
      #         "https://languagetool.org/download/ngram-data/ngrams-en-20150817.zip";
      #       hash = "sha256-v3Ym6CBJftQCY5FuY6s5ziFvHKAyYD3fTHr99i6N8sE=";
      #     };
      #     # de = { # 3.1G
      #     #   url =
      #     #     "https://languagetool.org/download/ngram-data/ngrams-de-20150819.zip";
      #     #   hash = "sha256-b+dPqDhXZQpVOGwDJOO4bFTQ15hhOSG6WPCx8RApfNg=";
      #     # };
      #     # es = { # 3.1G
      #     #   url =
      #     #     "https://languagetool.org/download/ngram-data/ngrams-es-20150915.zip";
      #     #   hash = "sha256-z+JJe8MeI9YXE2wUA2acK9SuQrMZ330QZCF9e234FCk=";
      #     # };
      #     # fr = { # 3.2G
      #     #   url =
      #     #     "https://languagetool.org/download/ngram-data/ngrams-fr-20150913.zip";
      #     #   hash = "sha256-mA2dFEscDNr4tJQzQnpssNAmiSpd9vaDX8e+21OJUgQ=";
      #     # };
      #     # nl = { # 2.4G
      #     #   url =
      #     #     "https://languagetool.org/download/ngram-data/ngrams-nl-20181229.zip";
      #     #   hash = "sha256-bHOEdb2R7UYvXjqL7MT4yy3++hNMVwnG7TJvvd3Feg8=";
      #     # };
      #   });

      fasttextBinary = "${pkgs.fasttext}/bin/fasttext";
      # Optional, but highly recommended
      # Data from:
      # https://fasttext.cc/docs/en/language-identification.html
      # 131 MB
      fasttextModel = pkgs.fetchurl {
        name = "lid.176.bin";
        url =
          "https://dl.fbaipublicfiles.com/fasttext/supervised-models/lid.176.bin";
        hash = "sha256-fmnsVFG8JhzHhE5J5HkqhdfwnAZ4nsgA/EpErsNidk4=";
      };

      # All files mandatory
      # Data from:
      # https://languagetool.org/download/word2vec/
      # word2vecModel = pkgs.linkFarm "word2vec"
      #   (builtins.mapAttrs (_: v: pkgs.fetchzip v) {
      #     en = { # 83M
      #       url = "https://languagetool.org/download/word2vec/en.zip";
      #       hash = "sha256-PAR0E8qxHBfkHYLJQH3hiuGMuyNF4cw9UbQeXVbau/A=";
      #     };
      #     de = { # 95M
      #       url = "https://languagetool.org/download/word2vec/de.zip";
      #       hash = "sha256-NbH3EPd8ZtQd4Gdg/lL5A2cnBGsrVKvLngs1bT1k17Y=";
      #     };
      #     pt = { # 72M
      #       url = "https://languagetool.org/download/word2vec/pt.zip";
      #       hash = "sha256-2HH3RwUxHFP8+THdPPCwm/EeXuyQq55izz8SFmfLf30=";
      #     };
      #   });

      pipelinePrewarming = true;

      # prometheusMonitoring = false; # Just to let you know that this is possible.
      # prometheusPort = 9301;
    };
  };
}
