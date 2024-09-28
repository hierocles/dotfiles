{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;

    extensions = with pkgs.open-vsx; [
      eamodio.gitlens
      usernamehw.errorlens
      pflannery.vscode-versionlens
      wix.vscode-import-cost
      gruntfuggly.todo-tree
      jnoortheen.nix-ide
      jetify.devbox
      arrterian.nix-env-selector
      jdinhlife.gruvbox
      redhat.vscode-yaml
      mads-hartmann.bash-ide-vscode
      mkhl.shfmt
      supermaven.supermaven
    ];
    userSettings = {
      "editor.fontFamily" = "CaskaydiaCove NF";
      "editor.fontLigatures" = true;
      "editor.fontSize" = 13;
      "workbench.colorTheme" = "Gruvbox Dark Hard";
      "editor.insertSpaces" = true;
      "editor.tabSize" = 2;
      "git.autofetch" = true;
      "git.confirmSync" = false;
      "git.enableCommitSigning" = true;
      "[nix]"."editor.defaultFormatter" = "jnoortheen.nix-ide";
      "nix.enableLanguageServer" = true;
      "nix.formatterPath" = "${pkgs.alejandra}/bin/alejandra";
      "nix.serverPath" = "${pkgs.nil}/bin/nil";
      "nix.serverSettings"."nil"."formatting"."command" = ["${pkgs.alejandra}/bin/alejandra"];
      "bashIde.shellcheckPath" = "${pkgs.shellcheck}/bin/shellcheck";
      "shfmt.executablePath" = "${pkgs.shfmt}/bin/shfmt";
      "errorLens.gutterIconsEnabled" = true;
      "errorLens.messageMaxChars" = 0;
      "todo-tree.general.statusBar" = "total";
      "todo-tree.highlights.highlightDelay" = 0;
      "todo-tree.highlights.customHighlight.TODO.type" = "text";
      "todo-tree.highlights.customHighlight.TODO.foreground" = "black";
      "todo-tree.highlights.customHighlight.TODO.background" = "green";
      "todo-tree.highlights.customHighlight.TODO.iconColour" = "green";
      "todo-tree.highlights.customHighlight.TODO.icon" = "shield-check";
      "todo-tree.highlights.customHighlight.TODO.gutterIcon" = true;
      "todo-tree.highlights.customHighlight.FIXME.type" = "text";
      "todo-tree.highlights.customHighlight.FIXME.foreground" = "black";
      "todo-tree.highlights.customHighlight.FIXME.background" = "yellow";
      "todo-tree.highlights.customHighlight.FIXME.iconColour" = "yellow";
      "todo-tree.highlights.customHighlight.FIXME.icon" = "shield";
      "todo-tree.highlights.customHighlight.FIXME.gutterIcon" = true;
      "todo-tree.highlights.customHighlight.HACK.type" = "text";
      "todo-tree.highlights.customHighlight.HACK.foreground" = "black";
      "todo-tree.highlights.customHighlight.HACK.background" = "red";
      "todo-tree.highlights.customHighlight.HACK.iconColour" = "red";
      "todo-tree.highlights.customHighlight.HACK.icon" = "shield-x";
      "todo-tree.highlights.customHighlight.HACK.gutterIcon" = true;
      "todo-tree.highlights.customHighlight.BUG.type" = "text";
      "todo-tree.highlights.customHighlight.BUG.foreground" = "black";
      "todo-tree.highlights.customHighlight.BUG.background" = "orange";
      "todo-tree.highlights.customHighlight.BUG.iconColour" = "orange";
      "todo-tree.highlights.customHighlight.BUG.icon" = "bug";
      "todo-tree.highlights.customHighlight.BUG.gutterIcon" = true;
      "redhat.telemetry.enabled" = false;
    };
  };
 }

