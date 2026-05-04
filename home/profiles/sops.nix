# Secrets management via sops-nix + age.
# Age key is derived from the existing SSH ed25519 key — no separate key file needed.
{ username, config, ... }:
{
  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.sshKeyPaths = [ "/Users/${username}/.ssh/id_ed25519_sops" ];

    secrets.github_token = {};
  };

  # Export GITHUB_TOKEN so all tools (gh, lazygit, git) respect the rate limit.
  programs.fish.interactiveShellInit = ''
    set -gx GITHUB_TOKEN (cat ${config.sops.secrets.github_token.path} 2>/dev/null)
  '';
}
