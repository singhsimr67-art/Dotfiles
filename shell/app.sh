app() {
  [ -z "$1" ] && { echo "usage: app <name>"; return 1; }

  local panels=" applications background bluetooth color display keyboard mouse multitasking network wifi notifications online-accounts power printers privacy search sharing sound system ubuntu universal-access wacom wellbeing wwan "
  case "$1" in
    volume|audio)         set -- sound ;;
    screen)               set -- display ;;
    battery)              set -- power ;;
    wallpaper|appearance) set -- background ;;
    shortcuts)            set -- keyboard ;;
    touchpad)             set -- mouse ;;
  esac
  if [[ "$panels" == *" $1 "* ]]; then
    setsid -f gnome-control-center "$1" >/dev/null 2>&1
    return
  fi

  if command -v "$1" >/dev/null 2>&1; then
    setsid -f "$@" >/dev/null 2>&1
    return
  fi

  local dirs=(
    /usr/share/applications
    "$HOME/.local/share/applications"
    /var/lib/snapd/desktop/applications
    /var/lib/flatpak/exports/share/applications
    "$HOME/.local/share/flatpak/exports/share/applications"
  )
  local name="$*" f
  f=$(find "${dirs[@]}" -iname "*${name}*.desktop" 2>/dev/null | head -n1)
  [ -z "$f" ] && f=$(grep -rli --include=*.desktop -- "^Name=.*${name}" "${dirs[@]}" 2>/dev/null | head -n1)

  if [ -n "$f" ]; then
    setsid -f gio launch "$f" >/dev/null 2>&1
  else
    echo "app: nothing found for '$name'"
    return 1
  fi
}
