{ lib, ...}:
{
  programs.man.enable = true;
  # Uses man-db
  programs.man.generateCaches = true;
}
