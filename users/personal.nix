{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  sops.secrets.kd-password.neededForUsers = true;
  users.mutableUsers = false; # required for sops passwords

  users.users.kd = {
    isNormalUser = true;
    hashedPasswordFile = config.sops.secrets.kd-password.path;
    ignoreShellProgramCheck = true;
    description = "zero";
    extraGroups = ["networkmanager" "wheel"] ++ ifTheyExist ["docker" "git" "mysql" "network"];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      (builtins.readFile ./id_zero.pub)
    ];
    packages = with pkgs; [
      tor-browser
      floorp
      vesktop
      spotify

      # code
      kate
      vscode
      gh
      lazygit
      nixpkgs-fmt

      # Notes
      rnote
      obsidian
      libreoffice-qt

      # Terminal
      alejandra
      libnotify
      eza
      bat
      bottom
      fzf

      # Idek
      vlc

      thunderbird
      adoptopenjdk-icedtea-web
      openjfx17
    ];
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users.kd = {
      home.sessionPath = [
        "$HOME/.local/bin"
        "$HOME/bin"
      ];
      home.sessionVariables = {
        TERM = "konsole";
        TERMINAL = "konsole";
        EDITOR = "code";
        MANPAGER = "batman";
      };
      nix.settings.experimental-features = ["nix-command" "flakes"];
      nixpkgs.config.allowUnfree = true;
      imports = [
        ./programs/zsh.nix
        ./programs/starship.nix
        ./programs/direnv.nix
        ./programs/git.nix
        ./programs/zoxide.nix
        ./programs/bat.nix
        ./programs/ssh.nix
        ./programs/wezterm.nix
        ./programs/hyprland.nix
      ];
      home.stateVersion = "23.11";
    };
  };
}
