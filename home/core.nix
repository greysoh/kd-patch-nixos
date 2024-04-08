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
    TERM = "xterm-256color";
    EDITOR = "code --wait";
  };
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.package = pkgs.nix;
  home.stateVersion = "23.11";
}
