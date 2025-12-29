{

  programs.eza = {
    enable = true;
    icons = "auto";
    enableZshIntegration = true;
    git = true;
  };

  programs.fzf.enable = true;
  programs.ripgrep.enable = true;

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      o = "xdg-open";

      ll = "ls -al";
      ".." = "cd ..";
      "~" = "cd ~";

      nrs = "sudo nixos-rebuild switch --flake ~/src/nix";

    };
    history.ignoreAllDups = true;

  };
}
