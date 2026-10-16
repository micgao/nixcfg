{ inputs, ... }:

{
  imports = [ inputs.hermes-agent.nixosModules.default ];

  services.hermes-agent = {
    enable = true;
    addToSystemPackages = true;

    # Root is a tmpfs, so keep all agent state (HERMES_HOME, sessions,
    # memories, skills, workspace) on the persisted subvolume.
    stateDir = "/persist/hermes";
  };

  # Interactive access to the shared state dir for the CLI
  users.users.micgao.extraGroups = [ "hermes" ];
}
