let
	key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKB466E68pNKhuPLCW+KXJzKUzi7N1qHjS+1kZIlIa9b";
in {
	"user.age".publicKeys = [ key ];
	"njalla.age".publicKeys = [ key ];
	"wg.age".publicKeys = [ key ];
}