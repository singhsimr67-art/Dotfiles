__prompt() {
  local last=$?   # must stay the first line: it captures the last command's exit code

  local reset='\[\e[0m\]'
  local dim='\[\e[2m\]'
  local purple='\[\e[38;5;141m\]'
  local cyan='\[\e[38;5;80m\]'
  local green='\[\e[38;5;71m\]'
  local red='\[\e[38;5;167m\]'

  # glyph color: green on success, red on failure
  local gc=$green
  [ "$last" -ne 0 ] && gc=$red

  # git branch, only inside a repo
  local branch git_part=""
  branch=$(git branch --show-current 2>/dev/null)
  [ -n "$branch" ] && git_part=" ${cyan}(${branch})${reset}"

  PS1="${dim}╭─${reset}${purple}simar${reset} ${dim}\w${reset}${git_part}\n${dim}╰─${reset}${gc}❯${reset} "
}
PROMPT_COMMAND=__prompt
