{
  lib,
  pkgs,
  config,
  inputs,
  self,
  ...
}:
let
  shellEnvironment = config.systemSettings.shellEnvironment.enable;
  homeManager = config.systemSettings.homeManager.enable;
  impermanence = config.systemSettings.impermanence.enable;
in
{
  config = lib.mkIf shellEnvironment {
    hm = lib.mkIf homeManager {
      programs.neovim = {
        enable = true;
        viAlias = true;
        vimAlias = true;
        defaultEditor = true;
        withNodeJs = true;
        withRuby = true;
        withPython3 = true;
        withPerl = true;
        vimdiffAlias = true;
        extraPackages = with pkgs; [
          mermaid-cli # mermaid preview
          tree-sitter # needed for nvim-treesitter rewrite
          inotify-tools # better file watching
          luarocks
          lua5_1

          #-- lua
          lua-language-server # LSP
          stylua # formatter

          #-- python
          python3Packages.debugpy
          pyright # LSP
          ty # LSP
          ruff # linter & formatter via LSP

          #-- nix
          nixfmt # formatter
          nixd # LSP

          #-- bash
          bash-language-server # LSP
          shfmt # formatter (bashls calls this)
          shellcheck # linter (bashls calls this)

          #-- XML
          lemminx # LSP

          #-- HTML
          superhtml # LSP

          #-- markdown
          marksman # LSP
          markdownlint-cli2 # linter, formatter

          #-- YAML
          yaml-language-server

          #-- SQL & co
          sqlite
          sqlcmd
          sqlfluff
        ];
        plugins = with pkgs.vimPlugins; [
          (nvim-treesitter.withPlugins (grammars: with grammars; [ 
            bash
            c_sharp
            css
            csv
            diff
            dockerfile
            git_config
            git_rebase
            gitattributes
            gitcommit
            gitignore
            html
            http
            javascript
            json
            lua
            luadoc
            markdown
            markdown_inline
            mermaid
            nix
            python
            razor
            regex
            sql
            ssh_config
            typescript
            xml
            yaml
          ]))
        ];
      };

      xdg.configFile.nvim = {
        source = config.hm.lib.file.mkOutOfStoreSymlink "${config.hm.home.homeDirectory}/src/nvim";
        recursive = true;
      };

      home.packages = with pkgs; [ neovide ];
    };

    hm-persist = lib.mkIf (homeManager && impermanence) {
      directories = [
        ".local/share/nvim"
        ".local/state/nvim"
        ".cache/nvim"
      ];
    };
  };
}
