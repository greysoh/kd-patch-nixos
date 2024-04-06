{
  pkgs,
  lib,
  ...
}: {
  programs.starship = {
    enable = true;

    settings = {
      add_newline = false;
      format = "($nix_shell)($username)$directory([:{](bold black)$git_branch([](bold black)$git_status)[}](bold black)) $character";
      continuation_prompt = "\t[\\$>](bold black)";

      status = {
        format = "[$status]($style)";
        disabled = false;
      };

      character = {
        success_symbol = "[\\$](#e8e3e3)";
        error_symbol = "[\\$](bold #424242)";
        vimcmd_symbol = "[#](bold #a889af)";
        vimcmd_replace_one_symbol = "[\\#](bold #a889af)";
        vimcmd_replace_symbol = "[\\#](bold #a889af)";
        vimcmd_visual_symbol = "[\\#](bold #a889af)";
      };

      directory = {
        truncation_length = 1;
        truncate_to_repo = true;
        format = "[$path]($style)[$read_only]($read_only_style)";
        style = "bold #8ba6a2";
      };

      git_status = {
        format = "[$all_status$ahead_behind]($style)";
        ahead = "^";
        behind = "v";
        diverged = "󰨏";
        untracked = "*";
        stashed = "$";
        modified = "!";
        staged = "+";
        deleted = "-";
        style = "bold #d8bc8f";
      };

      git_branch = {
        format = "[$branch(@$remote_branch)]($style)";
        style = "bold #897E98";
      };

      time = {
        disabled = false;
        format = "[$time]($style)";
        time_format = "%-H%M";
        style = "bold #987E80";
      };

      hostname = {
        ssh_only = true;
        trim_at = ".";
        format = "[$hostname]($style)";
        style = "bold red";
      };

      username = {
        show_always = false;
        disabled = false;
        style_user = "#987E80";
        style_root = "bold red";
        format = "[$user]($style)[:](bold black)";
      };

      nix_shell = {
        format = "[\(nix\)]($style) ";
      };
    };
  };
}
