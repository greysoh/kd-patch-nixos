{...}: {
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "zero_hosts" = {
        host = "gitlab.com github.com 192.168.1.41";
        identitiesOnly = true;
        identityFile = [
          "~/.ssh/id_zero"
        ];
      };
    };
  };
}
