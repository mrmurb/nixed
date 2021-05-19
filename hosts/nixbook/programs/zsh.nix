{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    history = {
      size = 50000;
      save = 50000;
    };
    prezto = {
      enable = true;
    };
  };
}