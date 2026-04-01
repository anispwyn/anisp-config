{
  programs.git = {
    enable = true;
    settings = {
      pull = {
        rebase = false;
      };
      user = {
        email = "anisphia_wynn_palettia@proton.me";
        name = "anispwyn";
      };
      init = {
        defaultBranch = "main";
      };
      commit = {
        gpgSign = true;
      };
    };
  };
}
