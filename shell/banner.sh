show_banner() {
  local purple=$'\e[38;5;141m' grey=$'\e[38;5;245m' ok=$'\e[38;5;71m' r=$'\e[0m'
  local art=~/.config/shell/banner.txt

  # ASCII art
  [ -f "$art" ] && printf '%s%s%s\n' "$purple" "$(cat "$art")" "$r"

  # fake boot sequence (about 0.2s total)
  local mods=(kernel network dotfiles prompt workspace)
  local m
  for m in "${mods[@]}"; do
    printf '%s[ ok ]%s %s\n' "$ok" "$r" "$m"
    sleep 0.04
  done

  # real status lines
  printf '%s%s  |  %s%s\n\n' "$grey" "$(uptime -p)" "$(date '+%a %d %b %H:%M')" "$r"
}
