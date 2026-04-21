# secrets/secrets.nix — maps each encrypted secret to the public keys allowed to decrypt it.
# To add a new secret:  cd secrets && agenix -e <name>.age
# To rekey all secrets: cd secrets && agenix -r
let
  aliaxy = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICWJZrLLPVHT9GTMPShI3fVYjEP/Ie/IsM0GpRUCxDef aruvelut00@163.com";
in
{
  "github_token.age".publicKeys = [ aliaxy ];
}
