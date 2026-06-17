{inputs, ...}: {
  imports = [inputs.aagl.nixosModules.default];
  programs = {
    sleepy-launcher.enable = false;
    honkers-launcher.enable = false;
    anime-game-launcher.enable = true;
  };
}
