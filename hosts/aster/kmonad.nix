{ ... }:

{
  services.kmonad = {
    enable = true;
    keyboards = {
      frameworkkb = {
        device = "/dev/input/by-path/platform-i8042-serio-0-event-kbd";
        extraGroups = [ "uinput" ];
        defcfg = {
          enable = true;
          fallthrough = true;
          compose.key = "rctl";
        };
        config = ''
          (defsrc
            esc     f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12  del
            grv     1    2    3    4    5    6    7    8    9    0    -    =    bspc
            tab     q    w    e    r    t    y    u    i    o    p    [    ]    \
            caps     a    s    d    f    g    h    j    k    l    ;    '    ret
            lsft      z    x    c    v    b    n    m    ,    .    /    rsft
            lctl    lmet lalt           spc            ralt  rctl
          )
          
          (defalias
            ext  (layer-toggle extend) ;; Bind 'ext' to the Extend Layer
            col  (layer-switch colemak-dh)
          )

          (defalias
            cpy C-c
            pst C-v
            cut C-x
            udo C-z
            all C-a
            fnd C-f
            bk Back
            fw Forward
          )

          (deflayer colemak-dh
            esc     f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12   del
            grv      1    2    3    4    5    6    7    8    9    0    -    =    bspc
            tab      q    w    f    p    b    j    l    u    y    ;    [    ]    \\
            lctl    a    r    s    t    g    m    n    e    i    o    '    ret
            lsft       x    c    d    v    z    k    h    ,    .    /    rsft
            bspc     lmet lalt           spc            @ext rctl
          )

          (deflayer extend
            _        play rewind previoussong nextsong ejectcd refresh brdn brup www mail prog1 prog2 del
            _        f1   f2   f3   f4   f5   f6   f7   f8   f9  f10   f11  f12  _
            _        esc  @bk  @fnd @fw  ins  pgup home up   end  menu prnt slck _
            @col     lalt lmet lsft lctl ralt pgdn lft  down rght del  caps _
            _          @cut @cpy  tab  @pst @udo pgdn bks  lsft lctl comp _
            _        _    _              ret            @col   _
          )
        '';
      };
    };
  };
}
