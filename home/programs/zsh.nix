{
  pkgs,
  lib,
  ...
}: {
  programs.git.enable = true;
  programs.zsh = {
    enable = true;

    initExtra = ''
      export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
      export GPG_TTY=$(tty)
    '';

    shellAliases = {
      run = "nix-shell --command zsh -p";
      ns = "nix-shell --command zsh";
      nd = "nix develop --command zsh";

      switch = "~/nixos/switch";
      gv = "lazygit";

      src = "cd $HOME/src";
      nfs = "cd $HOME/nixos";

      sv0 = "ssh -l root proxmox";
      nmcs = "ssh -l kd nmcs";

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
        {name = "vanesterik/zsh-git-alias";}
      ];
    };
  };
}
