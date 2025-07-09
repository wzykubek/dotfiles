{config, ...}:
{
  home.file.".config/linearmouse/linearmouse.json".source = builtins.toString ./linearmouse.json;
}
