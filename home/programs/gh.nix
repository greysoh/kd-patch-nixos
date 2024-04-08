{
  pkgs,
  lib,
  ...
}: {
  programs.gh = {
    enable = true;
    settings = {
      editor = "vim";
      git_protocol = "ssh";
      aliases = {
        co = "pr checkout";
        rc = "repo clone";
      };
    };
  };
}
