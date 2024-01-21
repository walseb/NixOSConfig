{ pkgs, config, ...}:

{
  # home.file.".config/.enchant/enchant.ordering".text = ''
  #   *:aspell'';
  
  # home.file.".aspell.en.pws".source = config.lib.file.mkOutOfStoreSymlink /home/admin/.emacs.d/.aspell.en.pws;
  # home.file.".aspell.sv.pws".source = config.lib.file.mkOutOfStoreSymlink /home/admin/.emacs.d/.aspell.sv.pws;

  home.file.".config/enchant/en_US.dic".source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/nixos-private-config/spell/.dict.en;
  home.file.".config/enchant/sv.dic".source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/nixos-private-config/spell/.dict.sv;

  home.packages = with pkgs; [
    enchant
  ];
}
