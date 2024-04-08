{
  pkgs,
  lib,
  ...
}: {
  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/bin"
  ];
  home.sessionVariables = {
    TERM = "konsole";
    TERMINAL = "konsole";
    EDITOR = "kate";
  };
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.package = pkgs.nix;
  home.stateVersion = "23.11";
}
