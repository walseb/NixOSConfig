{ pkgs, ... }:
{
  # environment.systemPackages = with pkgs; [
  #   matrix-synapse
  # ];

  # services.matrix-synapse.enable = true;
  # services.matrix-synapse.allow_guest_access = true;
  # services.matrix-synapse.enable_registration = true;
  # services.matrix-synapse.web_client = true;

  # services.matrix-synapse.server_name = "nixos";
  # services.matrix-synapse.public_baseurl = "https://example.com:8448/";

  # networking.firewall.enable = true;

  # networking.firewall.allowedUDPPorts = [8448];
  # networking.firewall.allowedTCPPorts = [8448];

  # services.matrix-synapse = {
  #   enable = true;
  #   server_name = "example.com";
  #   enable_registration = true;
  #   allow_guest_access = true;
  #   web_client = true;
  #   # registration_shared_secret = ***;
  #   listeners = [{
  #     port = 8448;
  #     bind_address = "";
  #     type = "http";
  #     tls = true;
  #     x_forwarded = false;
  #     resources = [
  #       { names = ["federation"]; compress = false; }
  #     ];
  #   } {
  #     port = 8008;
  #     bind_address = "127.0.0.1";
  #     type = "http";
  #     tls = false;
  #     x_forwarded = true;
  #     resources = [
  #       { names = ["client" "webclient"]; compress = true; }
  #     ];
  #   }];
  # };



  # # services.matrix-synapse = {
  # #   enable = true;
  # # server_name = "localhost";
  #   # registration_shared_secret = "fMSnTjsQd9JICQXRtyid8lVpia0ieVyaMco5dFB68rRU2GXkP7BLYprwKXLDnmpw";
  #   # database_type = "psycopg2";
  #   # database_args = {
  #   # database = "matrix-synapse";
  #   # };
  #   # extraConfig = ''
  #   # max_upload_size: "50M"
  #   # '';
  # # };


  # # networking.firewall = {
  # #   enable = true;
  # #   allowedTCPPorts = [
  # #     22    # SSH
  # #     8448  # Matrix federation
  # #   ];
  # # };



  services = {
    #   nginx = {
    #     enable = true;
    #     recommendedTlsSettings = true;
    #     recommendedOptimisation = true;
    #     recommendedGzipSettings = true;
    #     recommendedProxySettings = true;
    #     virtualHosts."example.com" = {
    #       enableACME = true;
    #       forceSSL = true;
    #     };
    #     virtualHosts."matrix.example.com" = {
    #       enableACME = true;
    #       forceSSL = true;
    #       locations."/" = {
    #         proxyPass = "http://localhost:8008";
    #       };
    #     };
    #   };

    openssh = {
      enable = true;
    };
    #   permitRootLogin = "no";
    # };

    matrix-synapse = {
    enable = true;
    server_name = "example.com";
    registration_shared_secret = "test";
    enable_registration = true;
    allow_guest_access = true;
    web_client = true;

    listeners = [{
      port = 8448;
      bind_address = "";
      type = "http";
      tls = false;
      x_forwarded = false;
      resources = [
        { names = ["federation"]; compress = false; }
      ];
    } {
      port = 8008;
      bind_address = "127.0.0.1";
      type = "http";
      tls = false;
      x_forwarded = false;
      resources = [
        { names = ["client" "federation"]; compress = false; }
      ];
    }];
    };
  };

}
