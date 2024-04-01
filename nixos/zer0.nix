# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkForce;
in {
  imports = [
    /etc/nixos/hardware-configuration.nix
    <home-manager/nixos>
  ];

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  services.xserver.videoDrivers = ["nvidia"]; # or "nvidiaLegacy470 etc.

  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;

    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      # got buses from lshw
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = false;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "zer0";
  networking.extraHosts = ''
    10.0.0.129 nmcs
    10.0.0.12 mcs
    192.168.0.120 idrac
    192.168.0.171 proxmox
    192.168.0.41 dockerzero
    192.168.0.40 pihole
  '';
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  networking.networkmanager.enable = true;

  time.timeZone = "America/Indiana/Indianapolis";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
    };
  };

  users.users.kd = {
    isNormalUser = true;
    description = "zer0";
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [
      tor-browser
      floorp
      vesktop
      spotify

      # code
      kate
      vscode
      git
      gh
      lazygit
      nixpkgs-fmt
      zoxide

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
      flameshot
      vlc

      thunderbird
      adoptopenjdk-icedtea-web
      openjfx17
    ];
  };

  programs.steam.enable = true;
  programs.gnupg.agent.pinentryPackage = mkForce pkgs.pinentry-qt;

  home-manager.users.kd = {pkgs, ...}: {
    nix = {
      settings.experimental-features = ["nix-command" "flakes"];
    };
    programs.zsh = {
      enable = true;

      initExtra = ''
        export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

        #if [ "$TERM" != "dumb" ]; then
        #  krabby random
        #fi

        eval "$(zoxide init zsh)"
      '';

      shellAliases = {
        run = "nix-shell --command zsh -p";
        nxs = "nix-shell --command zsh";

        rebuild = "~/dotfiles/rebuild";
        gv = "lazygit";
        gco = "git checkout";
        gc = "git commit -m";
        grc = "gh repo clone";

        rm = "rm -rf";
        cp = "cp -ri";
        mkdir = "mkdir -p";
        free = "free -m";
        j = "just";

        l = "eza -al --no-time --group-directories-first";
        ls = "eza -al --no-time --group-directories-first";
        la = "eza -a";
        ll = "eza -l --no-time --group-directories-first";
        lt = "eza -aT --no-time --group-directories-first";

        cat = "bat";
        top = "btm";
        c = "clear";

        glg = "git lg";
        ghr = "gh repo";
        fzf = "fzf --border=rounded --prompt='\$ ' --pointer='~' --marker=' >' --bind 'ctrl-s:toggle'";
        serve = "python3 -m http.server";
      };
    };

    programs.starship = {
      enable = true;

      settings = {
        add_newline = false;
        format = "($nix_shell)$time ($username)$directory([:{](bold black)$git_branch([::](bold black)$git_status)[}](bold black))$character";
        continuation_prompt = "\t[\\$>](bold black)";

        status = {
          format = "[$status]($style)";
          disabled = false;
        };

        character = {
          success_symbol = "[\\$](#e8e3e3)";
          error_symbol = "[\\$](bold #424242)";
          vimcmd_symbol = "[\\#](bold #a889af)";
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
          format = "[nxs]($style) ";
        };
      };
    };

    home.stateVersion = "23.11";
  };

  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
