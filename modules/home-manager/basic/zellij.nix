_: {
  programs.zellij.enable = true;
  programs.zellij.settings = {
    #copy_command = "xsel --clipboard";
    #copy_on_select = true;
    default_shell = "fish";
    pane_frames = false;
    mouse_mode = false;
  };
}
