{
  programs.virt-manager.enable = true;

users.groups.libvirtd.members = ["kevin"];

virtualisation.libvirtd.enable = true;

virtualisation.spiceUSBRedirection.enable = true;
}
