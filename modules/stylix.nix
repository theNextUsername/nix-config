{ pkgs, config, lib, ... }:
let
  inherit (lib) mkOption types;
  cfg = config.thenextusername.stylix;
  default_wallpaper = ./wallpaper.png;
  
  default_theme = {
    base00 = "000000"; # Default Background
    base01 = "26133f"; # Lighter Background
    base02 = "3c1f66"; # Selection Background
    base03 = "614c7f"; # Comments, Invisibles, Line Highlighting
    base04 = "5b2f99"; # Dark Foreground
    base05 = "793fc8"; # Default Foreground
    base06 = "8947e5"; # Light Foreground
    base07 = "984fff"; # Light Background
    base08 = "aa9383"; # Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
    base09 = "56829e"; # Integers, Boolean, Constants, XML Attributes, Markup Link Url
    base0A = "699e9e"; # Classes, Markup Bold, Search Text Background
    base0B = "8160af"; # Strings, Inherited Class, Markup Code, Diff Inserted
    base0C = "639984"; # Support, Regular Expressions, Escape Characters, Markup Quotes
    base0D = "793fc8"; # Functions, Methods, Attribute IDs, Headings
    base0E = "aa8386"; # Keywords, Storage, Selector, Markup Italic, Diff Changed
    base0F = "52759e"; # Deprecated, Opening/Closing Embedded Language Tags
    author = "theNextUsername";
    scheme = "Oneshot default";
    slug = "oneshot";
  };
  rotateColor = { hexColor, rotation ? 0, scale ? 1 }:
    with builtins;
    let
      colors = rec {
        r_initial = (lib.fromHexString (substring 0 2 hexColor)) / 255.0;
        g_initial = (lib.fromHexString (substring 2 2 hexColor)) / 255.0;
        b_initial = (lib.fromHexString (substring 4 2 hexColor)) / 255.0;
        max = elemAt (lib.lists.sort( a: b: a > b) [ r_initial g_initial b_initial ]) 0;
        min = elemAt (lib.lists.sort( a: b: a < b) [ r_initial g_initial b_initial ]) 0;
        deg_h = 60 * (
          if (r_initial == max) then
            (g_initial - b_initial) / (max - min)
          else if (g_initial == max) then
            2.0 + (b_initial - r_initial) / (max - min)
          else
            4.0 + (r_initial - g_initial) / (max - min)
          );
        s =
          if (min == max) then
            0
          else if (l <= 0.5) then
            (max - min) / (max + min)
          else
            (max - min) / (2.0 - max - min)
          ;
        l = ((min + max) / 2) * scale;
        h_final = (
          if (deg_h + rotation < 0) then
            (deg_h + 360 + rotation)
          else
            (deg_h + rotation)
          ) / 360;
        temp_1 = if (l < 0.5) then l * (1 + s) else l + s - l * s;
        temp_2 = 2 * l - temp_1;
        temp_r =
          if (h_final + (1.0 / 3.0) > 1) then
            (h_final + (1.0 / 3.0) - 1)
          else if (h_final + (1.0 / 3.0) < 0) then
            (h_final + (1.0 / 3.0) + 1)
          else
            (h_final + (1.0 / 3.0))
          ;
        temp_g =
          if (h_final  > 1) then
            (h_final - 1)
          else if (h_final < 0) then
            (h_final + 1)
          else
            (h_final)
          ;
        temp_b =
          if (h_final - (1.0 / 3.0) > 1) then
            (h_final - (1.0 / 3.0) - 1)
          else if (h_final - (1.0 / 3.0) < 0) then
            (h_final - (1.0 / 3.0) + 1)
          else
            (h_final - (1.0 / 3.0))
          ;
        r_final = floor (255 *
          (if (s == 0) then
            (l * 255)
          else if (6 * temp_r < 1) then
            (temp_2 + (temp_1 - temp_2) * 6 * temp_r)
          else if (2 * temp_r < 1) then
            (temp_1)
          else if (3 * temp_r < 2) then
            (temp_2 + (temp_1 - temp_2) * 6 * ((2.0 / 3.0) - temp_r))
          else
            (temp_2)
          ));
        g_final = floor (255 *
          (if (s == 0) then
            (l * 255)
          else if (6 * temp_g < 1) then
            (temp_2 + (temp_1 - temp_2) * 6 * temp_g)
          else if (2 * temp_g < 1) then
            (temp_1)
          else if (3 * temp_g < 2) then
            (temp_2 + (temp_1 - temp_2) * 6 * ((2.0 / 3.0) - temp_g))
          else
            (temp_2)
          ));
        b_final = floor (255 *
          (if (s == 0) then
            (l * 255)
          else if (6 * temp_b < 1) then
            (temp_2 + (temp_1 - temp_2) * 6 * temp_b)
          else if (2 * temp_b < 1) then
            (temp_1)
          else if (3 * temp_b < 2) then
            (temp_2 + (temp_1 - temp_2) * 6 * ((2.0 / 3.0) - temp_b))
          else
            (temp_2)
          ));
      };
    in
      lib.strings.fixedWidthString 2 "0" (lib.toHexString colors.r_final) +
      lib.strings.fixedWidthString 2 "0" (lib.toHexString colors.g_final) +
      lib.strings.fixedWidthString 2 "0" (lib.toHexString colors.b_final)
    ;
in
{
  options.thenextusername.stylix = {
    theme = mkOption {
      type = types.attrs;
      default = default_theme;
      description = "base16 scheme for use with stylix";
     };
    
    wallpaper = mkOption {
      type = types.path;
      default = default_wallpaper;
      description = "wallpaper for use in stylix";
    };

    color-rotation = mkOption {
      type = types.int;
      default = 0;
      description = "degrees to rotate the hue of the theme";
    };

    color-scale = mkOption {
      type = types.float;
      default = 1.0;
    };
  };

  config.stylix = let
    percentage-rotation = toString (( cfg.color-rotation * 100 / 180 ) + 100);
    
  in {
    enable = true;
    polarity = "dark";
    base16Scheme =
    let
      c = cfg.theme;
    in
    {
      base00 = rotateColor { hexColor = c.base00; rotation = cfg.color-rotation; scale = cfg.color-scale; };
      base01 = rotateColor { hexColor = c.base01; rotation = cfg.color-rotation; scale = cfg.color-scale; };
      base02 = rotateColor { hexColor = c.base02; rotation = cfg.color-rotation; scale = cfg.color-scale; };
      base03 = rotateColor { hexColor = c.base03; rotation = cfg.color-rotation; scale = cfg.color-scale; };
      base04 = rotateColor { hexColor = c.base04; rotation = cfg.color-rotation; scale = cfg.color-scale; };
      base05 = rotateColor { hexColor = c.base05; rotation = cfg.color-rotation; scale = cfg.color-scale; };
      base06 = rotateColor { hexColor = c.base06; rotation = cfg.color-rotation; scale = cfg.color-scale; };
      base07 = rotateColor { hexColor = c.base07; rotation = cfg.color-rotation; scale = cfg.color-scale; };
      base08 = rotateColor { hexColor = c.base08; rotation = cfg.color-rotation; scale = cfg.color-scale; };
      base09 = rotateColor { hexColor = c.base09; rotation = cfg.color-rotation; scale = cfg.color-scale; };
      base0A = rotateColor { hexColor = c.base0A; rotation = cfg.color-rotation; scale = cfg.color-scale; };
      base0B = rotateColor { hexColor = c.base0B; rotation = cfg.color-rotation; scale = cfg.color-scale; };
      base0C = rotateColor { hexColor = c.base0C; rotation = cfg.color-rotation; scale = cfg.color-scale; };
      base0D = rotateColor { hexColor = c.base0D; rotation = cfg.color-rotation; scale = cfg.color-scale; };
      base0E = rotateColor { hexColor = c.base0E; rotation = cfg.color-rotation; scale = cfg.color-scale; };
      base0F = rotateColor { hexColor = c.base0F; rotation = cfg.color-rotation; scale = cfg.color-scale; };
      author = c.author;
      scheme = "${c.scheme}-rot${toString cfg.color-rotation}";
      slug = "${c.slug}rot${toString cfg.color-rotation}";
    };
    image = pkgs.runCommand "wallpaper.png" { } ''
      ${lib.getExe pkgs.imagemagick} ${cfg.wallpaper} -modulate 100,100,${percentage-rotation} $out
    '';
    homeManagerIntegration.followSystem = true;
  };
}

# default_wallpaper = pkgs.runCommand "wallpaper.png" { } ''
#   ${lib.getExe pkgs.imagemagick} ${./wallpaper.png} -modulate 100,100,116.7 $out
# '';
