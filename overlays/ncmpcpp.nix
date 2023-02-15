final: prev:
{
  ncmpcpp = prev.ncmpcpp.overrideAttrs (old: {
    visualizerSupport = true;
    clockSupport      = true;
  });
}
