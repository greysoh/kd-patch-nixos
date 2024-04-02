{ pkgs, lib, ... }:
{
  programs.git = {
    enable = true;
    userName = "zero";
    userEmail = "rosascript@gmail.com";
    aliases = {
      lg = "lg = log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --";
    };
    extraConfig = {
      init.defaultBranch = "main";
      url = {
        "ssh://git@github.com" = {
          insteadOf = "https://github.com";
        };
        "ssh://git@gitlab.com" = {
          insteadOf = "https://gitlab.com";
        };
      };
      user.signing.key = "20CA9B91AA1F405E";
      commit.gpgSign = true;
    };
    ignores = [ ".direnv" ];
  };
}
