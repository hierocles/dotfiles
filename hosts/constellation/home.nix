{ pkgs, lib, config, ... }:
{
  imports = [
    ../common.nix
    ../../programs/non-free.nix
  ];
  home = {
    username = "dylan";
    homeDirectory = lib.mkDefault "/home/dylan";
    packages = with pkgs; [
      gnomeExtensions.dash-to-panel
      gnomeExtensions.simple-workspaces-bar
      gnomeExtensions.workspace-indicator
      gnomeExtensions.blur-my-shell
      gnomeExtensions.pop-shell
      gnomeExtensions.appindicator
      gnomeExtensions.user-themes
      gruvbox-gtk-theme
      gruvbox-plus-icons
      capitaine-cursors-themed
    ];
  };

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
        user-themes.extensionUuid
      ];
      favorite-apps = [
        "firefox.desktop"
        "code.desktop"
        "kitty.desktop"
      ];
    };
    settings = {
      "org/gnome/desktop/interface".color-scheme = "prefer-dark";
      "org/gnome/desktop/wm/preferences" = {
        workspace-names = [ "Main" ];
      };
      "org/gnome/desktop/background" = {
        picture-uri-dark = "file:///home/dylan/dotfiles/assets/gruvbox-dark-rainbow.png";
      };
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
  };

 gtk = {
  enable = true;
  theme = {
    name = "Gruxbox-Dark";
    package = pkgs.gruvbox-gtk-theme;
  };
  iconTheme = {
    name = "Gruvbox-Plus-Dark";
    package = pkgs.gruvbox-plus-icons;
  };
  cursorTheme = {
    name = "Capitaine Cursors (Gruvbox)";
    package = pkgs.capitaine-cursors-themed;
  };

  gtk3.extraConfig = {
    Settings = ''
      gtk-application-prefer-dark-theme=1
      '';
  };
  gtk4.extraConfig = {
    Settings = ''
      gtk-application-prefer-dark-theme=1
      '';
  };
 };

}
