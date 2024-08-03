{ config, pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      jdinhlife.gruvbox
    ];
    userSettings = {
      "editor.fontFamily" = "CaskaydiaCove NF";
      "editor.fontLigatures" = true;
      "editor.fontSize" = 13;
      "workbench.colorTheme" = "Gruvbox Dark Hard";
    };
  };
 }
