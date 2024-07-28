{ pkgs, lib, ... }:
{
  imports = [
    ../common.nix
    ../../programs/non-free.nix
    ../../programs/hyprland
  ];
  home.username = "dylan";
  home.homeDirectory = lib.mkDefault "/home/dylan";

  home.packages = with pkgs; [
    zlib
  ];
  programs.firefox.package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
      extraPolicies = {
      ExtensionSettings = {};
    };
  };

  xdg.configFile."waybar/config".source = ../../programs/waybar/config;
}
