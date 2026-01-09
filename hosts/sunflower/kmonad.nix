
{ ... }:

{
  services.kmonad = {
    enable = true;
    keyboards = {
      onnkb = {
        device = "/dev/input/by-id/usb-SIGMACHIP_USB_Keyboard-event-kbd";
        extraGroups = [ "uinput" ];
        defcfg = {
          enable = true;
          fallthrough = true;
          compose.key = "rctl";
        };
        config = ''
          (defsrc
            esc  f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12 fn prnt slck pause
            grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc   home end        nlck kp/  kp*  kp-
            tab  q    w    e    r    t    y    u    i    o    p    [    ]    \      ins pgup        kp7  kp8  kp9  kp+
            caps a    s    d    f    g    h    j    k    l    ;    '    ret         del pgdn       kp4  kp5  kp6
            lsft z    x    c    v    b    n    m    ,    .    /    rsft                 up          kp1  kp2  kp3  kprt
            lctl lmet lalt           spc            ralt menu  rctl            left down rght       kp0  kp.
          )          
          (defalias
            ext  (tap-next-press (layer-switch extend) (layer-toggle extend)) ;; Bind 'ext' to the Extend Layer
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
            esc  f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12 fn prnt slck pause
            grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc   home end        nlck kp/  kp*  kp-
            tab  q    w    f    p    b    j    l    u    y    ;    [    ]    \      ins pgup        kp7  kp8  kp9  kp+
            lctl a    r    s    t    g    m    n    e    i    o    '    ret         del pgdn        kp4  kp5  kp6  
            lsft x    c    d    v    z    k    h    ,    .    /    rsft                 up          kp1  kp2  kp3  kprt
            bspc lmet lalt           spc            @ext menu  rctl                  left down rght       kp0  kp.
          )

          (deflayer extend
            _        play rewind previoussong nextsong ejectcd refresh brdn brup www mail prog1 prog2 del _ _ _
            _        f1   f2   f3   f4   f5   f6   f7   f8   f9  f10   f11  f12  _   _ _             _   _   _   _
            _        esc  @bk  @fnd @fw  ins  pgup home up   end  menu prnt slck _   _ _             _   _   _   _
            @col     lalt lmet lsft lctl ralt pgdn lft  down rght del  caps _        _ _             _   _   _
            _          @cut @cpy  tab  @pst @udo pgdn bks  lsft lctl comp _            _             _   _   _   _
            _        _    _              ret            @col _   _               _   _ _             _   _
          )
        '';
      };
    };
  };
}
