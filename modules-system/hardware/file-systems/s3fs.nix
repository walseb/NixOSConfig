# https://discourse.nixos.org/t/how-to-setup-s3fs-mount/6283
{ pkgs, lib, mount, bucket, path-request-style ? false, custom-url ? "", ... }:
{
  systemd.services."s3fs-${bucket}" = {
    enable = true;
    description = "S3FS" + " " + bucket;
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStartPre = [
        "${pkgs.coreutils}/bin/mkdir -m 0500 -pv ${mount}"
        "${pkgs.e2fsprogs}/bin/chattr +i ${mount}"  # Stop files being accidentally written to unmounted directory
      ];
      ExecStart =
        let options = lib.remove "" [
              "passwd_file=/keys/${bucket}"
              (if path-request-style then "use_path_request_style" else "")
              "allow_other"
              (if custom-url != "" then "url=" + custom-url else "")
              # https://en.wikipedia.org/wiki/Umask#Octal_codes
              "umask=0004"
            ];
        in
          "${pkgs.s3fs}/bin/s3fs ${bucket} ${mount} -f "
          + lib.concatMapStringsSep " " (opt: "-o ${opt}") options;
      ExecStopPost = "${pkgs.s3fs}/bin/s3fs -umount ${mount}";
      KillMode = "process";
      Restart = "on-failure";
    };
  };
}
