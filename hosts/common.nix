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
      alacritty
      binutils
      wget
      intel-gpu-tools
      killall
      libva-utils
      docker-compose
      cmake
      gcc
      gnumake
      libtool
      vdpauinfo
      direnv
      feh
      gtk-engine-murrine
      gtk3
    ];
  };
  programs.fzf.enable = true;
}
