{ pkgs, ... }:

# To update, run: update-nix-fetchgit pkgs.nix
{
  home.packages = with pkgs; [
    (emacsPackages.trivialBuild {
      pname = "salv";
      version = "unstable-2023-04-12";

      src = fetchFromGitHub {
        owner = "walseb";
        repo = "salv.el";
        sha256 = "14zisarqz7i6mkw5hzwk3kf6rw4g1716qa26s7zxvxg01qzdiynz";
        rev = "ac33171c18288adbab1b044bf53d19be890c2ee1";
      };
    })

    (emacsPackages.trivialBuild {
      pname = "persp-mode";
      version = "unstable-2023-01-10";

      src = fetchFromGitHub {
        repo = "persp-mode.el";
        owner = "Bad-ptr";
        sha256 = "0jf4wsq13bjdr0wdm9jv702xxyhadfglxhvf9f7ahh3g4izjfqyr";
        rev = "df95ea710e2a72f7a88293b72137acb0ca024d90";
      };
    })

    (emacsPackages.trivialBuild {
      pname = "explain-pause-mode";
      version = "unstable-2020-07-27";

      src = fetchFromGitHub {
        repo = "explain-pause-mode";
        owner = "lastquestion";
        sha256 = "0frnfwqal9mrnrz6q4v7vcai26ahaw81894arff1yjw372pfgv7v";
        rev = "2356c8c3639cbeeb9751744dbe737267849b4b51";
      };
    })

    (emacsPackages.trivialBuild {
      pname = "spray";
      version = "unstable-2021-04-25";

      src = fetchFromGitHub {
        repo = "spray";
        owner = "walseb";
        sha256 = "0sjwzzi2ay3na53grfjyi694431mnilg6rfra39ndh03vv91n349";
        rev = "ebfef13d4b4d505f40148a92eb0a5ceb7c10112c";
      };
    })

    # (emacsPackages.trivialBuild {
    #   pname = "org-link-minor-mode";
    #   version = "unstable-2020-01-29";

    #   src = fetchFromGitHub {
    #     repo = "org-link-minor-mode";
    #     owner = "seanohalpin";
    #     sha256 = "0gwrl936say6rjxkgs4k31psd3zy4kycizqf067id0nchyldbbj4";
    #     rev = "952619339eb339e4d6458eb43025d3355df4db27";
    #   };
    # })

    (emacsPackages.trivialBuild {
      pname = "link-hint";
      version = "unstable-2022-09-17";

      src = fetchFromGitHub {
        repo = "link-hint.el";
        owner = "walseb";
        sha256 = "1v2bj3arixy08fcyhszir7b1sm1fll3k2zfp5as510fh8j5302ba";
        rev = "93c59a8ab45616732d8f932e336d254ac6c73edc";
      };
      packageRequires = with emacsPackages; [ avy ];

    })

    (emacsPackages.trivialBuild {
      pname = "aggressive-indent-mode";
      version = "unstable-2020-07-18";

      src = fetchFromGitHub {
        repo = "aggressive-indent-mode";
        owner = "walseb";
        sha256 = "0vkv1ha0k50gk5ncixxkrxxacw5xhrkx3lq87m0hrj2n28zijzv8";
        rev = "73ec1f7500ba755a84c754d9af41c531266b1f97";
      };

      packageRequires = with emacsPackages; [cl-lib ];
    })

    # (emacsPackages.trivialBuild {
    #   pname = "echo-bar";
    #   version = "unstable-2023-02-09";

    #   src = fetchFromGitHub {
    #     repo = "echo-bar.el";
    #     owner = "benzanol";
    #     sha256 = "1431xpklnb5894mq3gxc7kvp2q5qa04bnlx8qcxv5l9g2rs0jiih";
    #     rev = "03cae6d045636948d8b47979d85774e39556f9e1";
    #   };

    #   packageRequires = with emacsPackages; [cl-lib ];

    # })

    # (emacsPackages.trivialBuild {
    #   pname = "compat";
    #   version = "unstable-2023-04-19";

    #   src = fetchFromGitHub {
    #     repo = "compat";
    #     owner = "emacs-compat";
    #     sha256 = "15ca34hyxj7cn7cvvy0vr6slbrmhhbqcj7bjvpvlmhk8chbxngl1";
    #     rev = "bc4739eb1e88c6c409f83e4e471e5d0472792ad8";
    #   };
    # })

    # (emacsPackages.trivialBuild {
    #   pname = "jinx";
    #   version = "unstable-2023-04-20";

    #   src = fetchFromGitHub {
    #     repo = "jinx";
    #     owner = "minad";
    #     sha256 = "1fwydaqxzj89an4pkjsss8jqpv4kjbl3plzn065nwpw41ns8jvp3";
    #     rev = "7d1dbd725298ed5a57efa52c5c442b2d6341565e";
    #   };

    #   packageRequires = with emacsPackages; [ compat ];
    # })

    (emacsPackages.trivialBuild {
      pname = "org-assistant";
      version = "unstable-2023-06-23";
      src = fetchFromGitHub {
        repo = "org-assistant";
        owner = "tyler-dodge";
        sha256 = "1dggs5w831jlxbn7v5wn755ggg2kgcsij4js19m9yiz6wnw5nrxk";
        rev = "d036f82072e22a7fc985e94853deaf65c41d5967";
      };

      packageRequires = with emacsPackages; [ dash deferred s uuidgen ht];
    })

    (emacsPackages.trivialBuild {
      pname = "marionette";
      version = "unstable-2020-03-25";
      src = fetchFromGitHub {
        repo = "marionette.el";
        owner = "xuchunyang";
        sha256 = "0b6fpyk30pb88x7dbzdfnjhfjk6ir3phdw5g7zxv7d0iw8r8dshd";
        rev = "516bbcec25edbaf0feaf3aad3e442d581881c5ee";
      };
    })

    (emacsPackages.trivialBuild {
      pname = "org-graph-view";
      version = "unstable-2021-09-12";

      src = fetchFromGitHub {
        owner = "alphapapa";
        repo = "org-graph-view";
        sha256 = "1na81h5xidzjsg6l7853y8kcmwsqkc72sw0bdnm4y6ncj51ipj3f";
        rev = "233c6708c1f37fc60604de49ca192497aef39757";
      };

      packageRequires = with emacsPackages; [ dash s org ];
    })


    (emacsPackages.trivialBuild {
      pname = "biome";
      version = "unstable-2023-08-19";

      src = fetchFromGitHub {
        owner = "SqrtMinusOne";
        repo = "biome";
        sha256 = "1099abqa7vwx0g9vna3rq8f02k7k3kx6w7kx0rcfwsiscqlklc52";
        rev =  "fc52a2b7ac1a08050499c5eb378d012cd26d0856";
      };

      packageRequires = with emacsPackages; [ transient ct request compat ];
    })

    (emacsPackages.trivialBuild {
      pname = "indent-bars";
      version = "unstable-2023-08-14";

      src = fetchFromGitHub {
        owner = "jdtsmith";
        repo = "indent-bars";
        sha256 = "12fjd9p3pk2i51m00ww121kzxi7m4sysr2wfd33zy4swdg8szi0j";
        rev =  "568ec43b0e0059dcf19d86208c95ee0a36ce53fe";
      };

      packageRequires = with emacsPackages; [compat];
    })
    leetcode-cli

    (emacsPackages.trivialBuild {
      pname = "leetcode-emacs";
      version = "unstable-2023-08-04";

      src = fetchFromGitHub {
          owner = "ginqi7";
          repo = "leetcode-emacs";
          sha256 = "1nz5vnw4vgpf6h7kmdqjvj7z7x9rz9w4br1bsja3kspd1wxj8csm";
          rev =  "4908db262b1517ba34a458a012031c16af1ba032";
      };

      packageRequires = with emacsPackages; [ctable cl-lib];
    })
  ];
}