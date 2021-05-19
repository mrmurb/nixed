{ pkgs, ... }:
{
  programs = {
    neovim = {
      enable = true;
      vimAlias = true;
      plugins = with pkgs.vimPlugins; [
        vim-nix
        vim-go
        vim-airline
        gruvbox
        suda-vim
      ];
      extraConfig = ''
        colorscheme gruvbox
      '';
    };
  };
}