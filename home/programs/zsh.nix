{
  pkgs,
  lib,
  ...
}: {
  programs.git.enable = true;
  programs.zsh = {
    enable = true;
    autosuggestion.enable = false;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

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

      vios = "~/nixos/vios";
      switch = "~/nixos/switch";
      gv = "lazygit";
      grc = "gh repo clone";

      src = "cd $HOME/src";
      doc = "cd $HOME/documents";
      nfs = "cd $HOME/nixos";

      sv0 = "ssh -l root 192.168.1.171";
      nmcs = "ssh -l kd 192.168.0.161";

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
      mkscript = "${pkgs.writeShellScriptBin "mkscript" ''
        touch "$@"
        chmod +x "$@"
      ''}/bin/mkscript";
      glg = "git lg";
      ghr = "gh repo";
      fzf = "fzf --border=rounded --prompt='\$ ' --pointer='~' --marker=' >' --bind 'ctrl-s:toggle'";
      serve = "python3 -m http.server";
    };
    history = {
      expireDuplicatesFirst = true;
      save = 100000000;
      size = 1000000000;
    };
    zplug = {
      enable = true;
      plugins = [
        # { name = "zsh-users/zsh-autosuggestions"; }
        {name = "marlonrichert/zsh-autocomplete";}
        {name = "vanesterik/zsh-git-alias";}
        {name = "jeffreytse/zsh-vi-mode";}
        {name = "iridakos/goto";}
        {name = "olets/zsh-abbr";}
      ];
    };
  };
}
