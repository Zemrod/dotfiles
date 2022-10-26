# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # prevent screen flicker on Tuxedo Infinitybook 14
  boot.kernelParams = [ "i915.enable_psr=0" ];

  networking.hostName = "mizutsune"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  fileSystems = {
    "/".options = [ "defaults" "compress=zstd" ];
    "/home".options = [ "defaults" "compress=zstd" ];
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_AU.UTF-8";
  console = {
  #   font = "Lat2-Terminus16";
    keyMap = "de";
  #   useXkbConfig = true; # use xkbOptions in tty.
  };

  # Nix options
  nix.settings.auto-optimise-store = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    windowManager.qtile.enable = true;
    layout = "de"; # X11-keymap
    libinput.enable = true; # touchpad
    displayManager.startx.enable = true;
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # virtualisations
  virtualisation.libvirtd.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.cinque = {
    isNormalUser = true;
    extraGroups = [
      "wheel" # Enable ‘sudo’ for the user.
      "libvirtd" # Allow usage of libvirt without extra authentication.
    ];
    shell = pkgs.zsh;
  #   packages = with pkgs; [
  #     brave
  #     thunderbird
  #   ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    bat
    beauty-line-icon-theme
    brave
    coreutils
    curl
    dracula-theme
    du-dust
    emacs
    exa
    fd
    flameshot
    gcc
    git
    gnupg
    htop
    kitty
    libsForQt5.qt5ct
    libsForQt5.qtstyleplugin-kvantum
    lxappearance
    lxde.lxsession
    neofetch
    networkmanagerapplet
    nitrogen
    nix-zsh-completions
    pass
    pavucontrol
    picom
    powerline
    procs
    pywal
    qtpass
    ripgrep
    rofi
    rsync
    rust-analyzer
    rustup
    starship
    topgrade
    vimHugeX
    virt-manager
    xclip
    xfce.ristretto
    xfce.thunar
    yt-dlp
    zsh
    zsh-autosuggestions
    zsh-completions
    zsh-syntax-highlighting
  ];

  fonts.fonts = with pkgs; [
    dejavu_fonts
    fira-code
    font-awesome
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    source-han-code-jp
    source-han-sans
  ];

 nixpkgs.overlays = [
   (self: super: {
      python3Packages = super.python3Packages.override {
        overrides = pfinal: pprev: {
          dbus-next = pprev.dbus-next.overridePythonAttrs (old: {
            # temporary fix for https://github.com/NixOS/nixpkgs/issues/197408
            checkPhase = builtins.replaceStrings ["not test_peer_interface"] ["not test_peer_interface and not test_tcp_connection_with_forwarding"] old.checkPhase;
          });
        };
      };
    })
 ];
  
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
  };

  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "gtk2";
  };
  
  # List services that you want to enable:
  services.locate = {
    locate = pkgs.mlocate;
    enable = true;
    localuser = null;
  };

  services.fstrim.enable = true;

  services.tumbler.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = false;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}
