{ ... }:

{
  stylix = {
    enable = true;
    base16Scheme = {
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
    image = ./wallpaper.png;
    homeManagerIntegration.followSystem = true;
  };
}
