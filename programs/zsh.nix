{ pkgs, lib, ... }:
{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = false;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    history.size = 10000;

    initExtra = ''
      export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
      export GPG_TTY=$(tty)

      #if [ "$TERM" != "dumb" ]; then
      #  krabby random
      #fi

      eval "$(zoxide init zsh)"
    '';

    completionInit = ''
      autoload -U compinit
      zstyle ':completion:*' menu select
      zmodload zsh/complist
      compinit
      _comp_options+=(globdots)
    '';

    shellAliases = {
      run = "nix-shell --command zsh -p";
      ns = "nix-shell --command zsh";

      rebuild = "~/dotfiles/rebuild";
      gv = "lazygit";
      grc = "gh repo clone";

      src = "cd $HOME/src";
      doc = "cd $HOME/documents";
      dfs = "cd $HOME/dotfiles";

      sv0 = "ssh -l root 192.168.0.171";
      nmcs = "ssh -l kd 10.0.0.129";

      rm = "rm -rf";
      cp = "cp -ri";
      mkdir = "mkdir -p";
      free = "free -m";
      j = "just";
      e = "code";

      l = "eza -al --no-time --group-directories-first";
      ls = "eza -al --no-time --group-directories-first";
      la = "eza -a";
      ll = "eza -l --no-time --group-directories-first";
      lt = "eza -aT --no-time --group-directories-first";

      cat = "bat";
      diff = "batdiff";
      rg = "batgrep";
      man = "batman";
      top = "btm";
      c = "clear";

      glg = "git lg";
      ghr = "gh repo";
      fzf = "fzf --border=rounded --prompt='\$ ' --pointer='~' --marker=' >' --bind 'ctrl-s:toggle'";
      serve = "python3 -m http.server";
    };

    zplug = {
      enable = true;
      plugins = [
        # { name = "zsh-users/zsh-autosuggestions"; }
        { name = "marlonrichert/zsh-autocomplete"; }
        { name = "vanesterik/zsh-git-alias"; }
        { name = "jeffreytse/zsh-vi-mode"; }
        { name = "iridakos/goto"; }
        { name = "olets/zsh-abbr"; }
      ];
    };
  };
}
