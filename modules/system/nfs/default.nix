
{
	boot.supportedFilesystems = [ "nfs" ];
	fileSystems."/mnt/media" = {
		device = "truenas.local:/mnt/tank0/media";
		fsType = "nfs";
		options = [ 
			"x-systemd.automount" 
			"noauto" 
			"x-systemd.idle-timeout=600"
		];
	};

}
