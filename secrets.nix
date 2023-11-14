let
  user = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO/RZ2j8AcRxzlkW0C4A/nABQbR/7ie5nrBXm/aZ6PpS dustin@dlyons.dev";
  users = [ dustin ];
  systems = [ ];
in
{
  #"darwin-syncthing-cert.age".publicKeys = [ dustin ];
  #"darwin-syncthing-key.age".publicKeys = [ dustin ];
  #"felix-syncthing-cert.age".publicKeys = [ dustin ];
  #"felix-syncthing-key.age".publicKeys = [ dustin ];
  #"github-ssh-key.age".publicKeys = [ dustin ];
  #"github-signing-key.age".publicKeys = [ dustin ];
  #"syncthing-gui-password.age".publicKeys = [ dustin ];
}
