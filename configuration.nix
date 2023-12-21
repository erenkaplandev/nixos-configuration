{ config, pkgs, lib, ... }:

let
  # NVIDIA sürücülerini etkinleştirin
  nvidiaPackages = pkgs.linuxPackages_latest.nvidia_x11.override {
    enable = true;
    kernelModules = [ "nvidia" "nvidia_uvm" ];
  };

in {

  # Temel yapılandırma
  imports = [
    # GNOME masaüstü ortamını etkinleştirin
    <nixpkgs/nixos/modules/profiles/gnome3.nix>
  ];

  # İstenilen paketleri yükleyin
  environment.systemPackages = with pkgs; [
    firefox
    virtualbox
    vmware
    steam
    tor
    signal-desktop
    vscode
    python3
    rust
    go
    nodejs
  ];

  # GNOME masaüstü ortamı yapılandırması
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome3.enable = true;
    windowManager.gnome3.enable = true;
  };

  # NVIDIA sürücülerini yapılandırın
  hardware.nvidia = {
    enable = true;
    package = nvidiaPackages;
  };

  # Klavye düzenini Türkçe olarak ayarlayın
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "trq";
    xkeyboard.layout = "tr";
    xkeyboard.variant = "intl";
  };
}