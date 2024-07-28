{ pkgs, ... }: {
  imports = [
    ../programs/zsh/zsh.nix
    ../programs/git.nix
    ../programs/vscode.nix
  ];

  home = {
    stateVersion = "24.05";
    packages = with pkgs; [
      file
      gawk
      gnupg
      htop
      httpie
      inetutils
      jq
      p7zip
      patchelf
      pstree
      ripgrep
      sops
      tree
      unzip
      neovim
      fzf
    ];
  };
  programs.fzf.enable = true;
  xdg.configFile."oh-my-zsh/plugins/nix-shell".source = pkgs.fetchFromGitHub {
    owner = "chisui";
    repo = "zsh-nix-shell";
    rev = "v0.8.0";
    sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
  };
}
