# https://github.com/NixOS/nixos-hardware/blob/master/common/pc/ssd/default.nix
{
  #  Don't store swap on SSD unless ram is full
  # https://askubuntu.com/questions/404096/with-an-ssd-do-i-need-to-change-my-swappiness-to-increase-ssd-life
  # boot.kernel.sysctl = {
  #   "vm.swappiness" = 0;
  # };

  services.fstrim.enable = true;
}
