#!/usr/bin/env bash
set -e
DOT="$(cd "$(dirname "$0")" && pwd)"

mkdir -p ~/.config/rofi
ln -sfn "$DOT/shell" ~/.config/shell
ln -sf  "$DOT/rofi/mytheme.rasi" ~/.config/rofi/mytheme.rasi

if ! grep -q 'config/shell/prompt.sh' ~/.bashrc; then
  cat >> ~/.bashrc <<'RC'

# custom prompt + banner + launcher
[ -f ~/.config/shell/prompt.sh ] && source ~/.config/shell/prompt.sh
[ -f ~/.config/shell/banner.sh ] && source ~/.config/shell/banner.sh
[ -f ~/.config/shell/app.sh ] && source ~/.config/shell/app.sh
[[ $- == *i* ]] && declare -F show_banner >/dev/null && show_banner
RC
fi
echo "done. open a new terminal."
