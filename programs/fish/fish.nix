{ config, lib, pkgs, ... }:

{
  programs.fish = {
    enable = true;
    shellInit = builtins.readFile ./config.fish;
    shellAliases = {
      view = "nvim -R";
    };
    interactiveShellInit =
      ''
        function fish_prompt
          theme_gruvbox
        end
      '';
  };

  home.packages = with pkgs; [
    fishPlugins.fzf-fish
    fishPlugins.pure
    fishPlugins.plugin-git
    fishPlugins.gruvbox
  ];

  home.file.".config/fish/conf.d/nix-env.fish".source = ./nix-env.fish;
}
