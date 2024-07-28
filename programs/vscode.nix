{ config, pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      ms-python.python
    ];
    userSettings = {
      "editor.fontFamily" = "Cascadia Code";
      "editor.fontLigatures" = true;
      "editor.fontSize" = 13;
      "workbench.colorTheme" = "Solarized Dark";
    };
  };
 }
