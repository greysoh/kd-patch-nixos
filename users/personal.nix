{ pkgs, lib, ... }:

let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  users.users.kd = {
    isNormalUser = true;
    description = "zer0";
    extraGroups = [ "networkmanager" "wheel" ] ++ ifTheyExist [ "docker" "git" "mysql" "network" ];
    shell = pkgs.zsh;
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

  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/bin"
  ];
  home.sessionVariables = {
    SHELL = "zsh";
    TERM = "konsole";
    TERMINAL = "konsole";
    EDITOR = "code";
    MANPAGER = "batman";
  };

  home-manager.users.kd = {
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nixpkgs.config.allowUnfree = true;
    imports = [
      ./programs/zsh.nix
      ./programs/starship.nix
      ./programs/direnv.nix
      ./programs/git.nix
      ./programs/zoxide.nix
      ./programs/bat.nix
    ];
  };
}
