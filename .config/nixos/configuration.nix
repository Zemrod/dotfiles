# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

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

  networking.hostName = "musashi"; # Define your hostname.
  networking.domain = "kai.ni"; # Define your domain
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Bridge config
  # networking.interfaces = {
  #   enp0s20f0u4.useDHCP = true;
  #   br0.useDHCP = true;
  # };
  # networking.bridges = {
  #   "br0" = {
  #     interfaces = [ "enp0s20f0u4" ];
  #   };
  # };

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
  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [ "nix-command" "flakes" ];
  };

  nixpkgs.config = {
    packageOverrides = pkgs: {
      stable = import <stable> {
        config = config.nixpkgs.config;
      };
    };
    allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "steam"
      "steam-original"
      "steam-run"
    ];
  };

  # install steam
  programs.steam.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    windowManager.qtile = {
      enable = true;
      package = pkgs.stable.qtile;
    };
    desktopManager.xterm.enable = false;
    layout = "de"; # X11-keymap
    libinput.enable = true; # touchpad
    displayManager.startx.enable = true;
    videoDrivers = [ "intel" ];
    dpi = 100;
    excludePackages = [ pkgs.xterm ];
  };

  qt = {
    enable = true;
    platformTheme = "qt5ct";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;

  # Enable scanning
  hardware.sane.enable = true;
  hardware.sane.extraBackends = [ pkgs.sane-airscan ];

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    #alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable bluetooth
  hardware.bluetooth.enable = true;

  # virtualisations
  virtualisation.libvirtd.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.cinque = {
    isNormalUser = true;
    extraGroups = [
      "wheel" # Enable ‘sudo’ for the user.
      "libvirtd" # Allow usage of libvirt without extra authentication.
      "scanner"
      "lp"
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
    btop
    coreutils
    curl
    du-dust
    emacs
    eza
    fd
    flameshot
    gcc
    git
    gnupg
    htop
    kitty
    libsForQt5.qtstyleplugin-kvantum
    lxappearance
    lxde.lxsession
    neofetch
    networkmanagerapplet
    nitrogen
    nix-zsh-completions
    numix-cursor-theme
    numix-gtk-theme
    numix-icon-theme
    pass
    pavucontrol
    picom
    powerline
    procs
    pywal
    qtpass
    remmina
    ripgrep
    rofi
    rsync
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

  fonts = {
    fontconfig = {
      antialias = true;
      hinting.enable = true;
    };
    packages = with pkgs; [
      dejavu_fonts
      fira-code
      font-awesome
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      source-han-code-jp
      source-han-sans
    ];
  };

  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
  };

  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "qt";
  };
  
  # List of services that you want to enable:
  services.locate = {
    package = pkgs.mlocate;
    enable = true;
    localuser = null;
  };

  services.blueman.enable = true;

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
