{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.spicetify-nix.homeManagerModules.spicetify];

  programs.mpv = {
    enable = true;
  };
  programs.spicetify = let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
  in {
    enable = false;
    enabledCustomApps = with spicePkgs.apps; [newReleases lyricsPlus betterLibrary];
    enabledExtensions = with spicePkgs.extensions; [trashbin shuffle powerBar wikify songStats lastfm aiBandBlocker volumePercentage beautifulLyrics adblock betterGenres fullScreen];
  };
}
