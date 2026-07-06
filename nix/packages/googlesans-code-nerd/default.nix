{
  googlesans-code,
  nerd-font-patcher,
}:
googlesans-code.overrideAttrs (old: {
  nativeBuildInputs = old.nativeBuildInputs ++ [nerd-font-patcher];
  postInstall = ''
    mkdir -p $out/share/fonts/googlesans-code-nerd
    for f in "$out"/share/fonts/googlesans-code/*.ttf; do
      name="Google Sans Code Nerd Font"
      if [[ "$f" == *"Italic"* ]]; then
        name="Google Sans Code Italic Nerd Font"
      fi
      nerd-font-patcher --complete --name "$name" --outputdir "$out/share/fonts/googlesans-code-nerd/" "$f"
    done
  '';
})
