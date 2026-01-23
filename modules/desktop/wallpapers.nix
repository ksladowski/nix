{
  config,
  ...
}:
{
  hm.home.file."Pictures/Wallpapers" = {
    source = config.hm.lib.file.mkOutOfStoreSymlink "${config.hm.home.homeDirectory}/src/nix/walls";
    recursive = true;
  };
}
