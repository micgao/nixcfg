{ pkgs, ... }: {
  services.ollama = {
    enable = true;
    package = pkgs.ollama-vulkan;
    home = "/persist/lib/ollama";
  };
}
