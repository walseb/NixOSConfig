{ pkgs, config, ...}:

{
  home.file.".config/.enchant/enchant.ordering".text = ''
    *:aspell'';

  
  home.file.".aspell.en.pws".source = config.lib.file.mkOutOfStoreSymlink /home/admin/.emacs.d/.aspell.en.pws;
  home.file.".aspell.sv.pws".source = config.lib.file.mkOutOfStoreSymlink /home/admin/.emacs.d/.aspell.sv.pws;

  # home.file.".emacs.d/.aspell.en.pws".source = /home/admin/.aspell.en.pws;
  # home.file.".emacs.d/.aspell.sv.pws".source = /home/admin/.aspell.sv.pws;

  home.packages = with pkgs; [
    enchant
  ];
}
