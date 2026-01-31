{ pkgs, baseVars, ... }:
let
  shellAliases = {

    o = "xdg-open";
  };
in
{
  programs.fish.enable = true;
  environment.shells = with pkgs; [ fish ];

  programs.bash = {
    interactiveShellInit = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };

  hm.programs.fish = {
    inherit shellAliases;
    enable = true;
    interactiveShellInit = ''
      			set fish_greeting # Disable greeting
      			'';
    plugins = [
      {
        name = "grc";
        src = pkgs.fishPlugins.grc.src;
      }
      # { name = "hydro"; src = pkgs.fishPlugins.hydro.src; }
      {
        name = "pure";
        src = pkgs.fishPlugins.pure.src;
      }
      # { name = "sponge"; src = pkgs.fishPlugins.sponge.src; }
      {
        name = "done";
        src = pkgs.fishPlugins.done.src;
      }
    ];
  };

}
