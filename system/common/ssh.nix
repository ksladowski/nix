{
	services.openssh = {
		enable = true;
		settings = {
			PasswordAuthentication = false;
			KbdInteractiveAuthentication = false;
			#PermitRootLogin = "no";
			#AllowUsers = [ "kevin" ];
		};
	};

    users.users.root.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGuI5zoHAtiH1KjV1QZUh+eZ9r50GrMH7Kjgb45+h0FA KevinSladowski"
    ];
}
