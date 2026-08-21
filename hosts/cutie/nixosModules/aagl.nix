{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.aagl.nixosModules.default];
  programs = {
    sleepy-launcher = {
      enable = false;
      #   package = inputs.aagl.packages.${pkgs.stdenv.hostPlatform.system}.sleepy-launcher.override (prev: let
      #     src = pkgs.fetchFromGitHub {
      #       owner = "nellokudo";
      #       repo = "sleepy-launcher";
      #       rev = "f7751b4c8ad7dd7e7b5fcce4ea552e40a98cde2b";
      #       hash = "sha256-64d6EqNJymyyRI8BUuh7U3adm4S5Hd/8AH+aVdiKg5E=";
      #     };
      #     postPatch = ''
      #       substituteInPlace Cargo.toml --replace-fail "https://github.com/an-anime-team/anime-launcher-sdk" "https://github.com/NelloKudo/anime-launcher-sdk"
      #       substituteInPlace Cargo.toml --replace-fail 'tag = "1.35.9"' 'rev = "2226a1824d34b3b8a4ce0ac211fe966eeebd23e0"'
      #
      #       substituteInPlace Cargo.lock --replace-fail 'version = "1.35.9"' 'version = "1.36.1"'
      #       substituteInPlace Cargo.lock --replace-fail "git+https://github.com/an-anime-team/anime-launcher-sdk?tag=1.35.9#8d4eea31fa4a54800fe3d63702803713543bcd02" "git+https://github.com/NelloKudo/anime-launcher-sdk?rev=2226a1824d34b3b8a4ce0ac211fe966eeebd23e0#2226a1824d34b3b8a4ce0ac211fe966eeebd23e0"
      #       substituteInPlace Cargo.lock --replace-fail 'version = "1.38.7"' 'version = "1.39.1"'
      #       substituteInPlace Cargo.lock --replace-fail "git+https://github.com/an-anime-team/anime-game-core?tag=1.38.7#6e9e4b97d4a2b1f7bcee0047861014d002fb65ee" "git+https://github.com/an-anime-team/anime-game-core?tag=1.39.1#aa8c5ce41dbbc0ab57b49214e02d54001b83edac"
      #     '';
      #   in {
      #     unwrapped = prev.unwrapped.overrideAttrs (oldAttrs: {
      #       inherit src postPatch;
      #       cargoDeps = pkgs.rustPlatform.fetchCargoVendor {
      #         inherit src postPatch;
      #         hash = "sha256-2PkZyBnL89BsMkn4xFHnJCse6pI7KUS+p8KMmmY0Ff4=";
      #       };
      #     });
      #   });
    };
    honkers-launcher.enable = false;
    anime-game-launcher.enable = true;
  };
}
