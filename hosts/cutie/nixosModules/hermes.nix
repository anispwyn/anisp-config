{
  config,
  inputs,
  ...
}: {
  imports = [inputs.hermes-agent.nixosModules.default];
  hardware.nvidia-container-toolkit.enable = true;
  services.hermes-agent = {
    enable = false;
    environmentFiles = [config.sops.secrets."hermes-secret".path];
    addToSystemPackages = true;
    container = {
      enable = true;
      hostUsers = ["anisp"];
      image = "docker.io/library/ubuntu:24.04";
      backend = "podman";
      extraOptions = ["--gpus" "all"];
    };
    settings = {
      model = {
        provider = "auto";
        default = "google/gemma-3-27b-it";
        base_url = "https://integrate.api.nvidia.com/v1";
      };
    };
  };
}
