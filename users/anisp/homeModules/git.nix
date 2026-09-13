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

  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = "anispwyn";
        email = "anisphia_wynn_palettia@proton.me";
      };
    };
  };
}
