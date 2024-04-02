{ pkgs, lib, ... }:
{
  programs.bat = {
    enable = true;
    config = {
      style = "numbers,changes,header";
      theme = "gruvbox-dark";
    };
    extraPackages = builtins.attrValues {
      inherit
        (pkgs.bat-extras)
        batgrep# search through and highlight files using ripgrep
        batdiff# Diff a file against the current git index, or display the diff between to files
        batman
        ; # read manpages using bat as the formatter
    };
  };
}
