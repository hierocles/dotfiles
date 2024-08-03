{ pkgs, lib, config, ... }:
{
  imports = [
    ../common.nix
    ../../programs/non-free.nix
  ];
  home.username = "dylan";
  home.homeDirectory = lib.mkDefault "/home/dylan";
  home.packages = with pkgs; [
    with gnomeExtensions; [
      dash-to-panel
      simple-workspaces-bar
      workspace-indicator
      blur-my-shell
      pop-shell
      appindicator
    ];
  ];


  dconf = {
    enable = true;
    settings."org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [
        dash-to-panel.extensionUuid
        simple-workspaces-bar.extensionUuid
        workspace-indicator.extensionUuid
        blur-my-shell.extensionUuid
        pop-shell.extensionUuid
        appindicator.extensionUuid
      ];
      favorite-apps = [
        "firefox.desktop"
        "code.desktop"
        "org.gnome.Terminal.desktop"
      ];
    };
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
    settings."org/gnome/desktop/wm/preferences" = {
      workspace-names = [ "Main" ];
    };
  };

  programs = {
    firefox = {
      enable = true;
      package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
        extraPolicies = {
        ExtensionSettings = {};
      };
    };
  };

 gtk = {
  enable = true;
  theme = {
    name = "gruvbox-gtk-theme";
    package = pkgs.gruvbox-gtk-theme;
  };
  iconTheme = {
    name = "gruxbox-plus-icons";
    package = pkgs.gruvbox-plus-icons;
  };
  cursorTheme = {
    name = "capitaine-cursors-themed";
    package = pkgs.capitaine-cursors-themed;
  }
 };

}
