# Fixed copy of __git_files from zsh's _git completion (zsh 5.9.2, still unfixed upstream).
#
# The original builds the ls-files pathspec as `:(icase)'<path>'*`: the `(qq)` leaves
# literal single quotes in the argument git receives, so the pattern never matches.
# Completion then only works via the no-pattern fallback, which lists the current
# directory's subtree -- so `git add ../lit/<TAB>` from a subdirectory finds nothing.
#
# _git only defines __git_files if it doesn't exist yet, so defining it here wins.

__git_files () {
  local compadd_opts opts tag description gittoplevel gitprefix files expl

  zparseopts -D -E -a compadd_opts V+: J+: 1 2 o+: n f x+: X+: M+: P: S: r: R: q F:
  zparseopts -D -E -a opts -- -cached -deleted -modified -others -ignored -unmerged -killed x+: --exclude+:
  tag=$1 description=$2; shift 2

  gittoplevel=$(_call_program toplevel git rev-parse --show-toplevel 2>/dev/null)
  __git_command_successful $pipestatus || return 1
  [[ -n $gittoplevel ]] && gittoplevel+="/"

  gitprefix=$(_call_program gitprefix git rev-parse --show-prefix 2>/dev/null)
  __git_command_successful $pipestatus || return 1

  local pref=${(Q)${~PREFIX}}
  [[ $pref[1] == '/' ]] || pref=$gittoplevel$gitprefix$pref

  # was: ${(q)${pref:+:\(icase\)${(qq)pref}\*}:-.}
  files=(${(0)"$(_call_program files git ls-files -z --exclude-standard ${(q)opts} -- ${(q)${pref:+:\(icase\)$pref\*}:-.} 2>/dev/null)"})
  __git_command_successful $pipestatus || return

  if [[ -z "$files" && -n "$pref" ]]; then
    files=(${(0)"$(_call_program files git ls-files -z --exclude-standard ${(q)opts} -- 2>/dev/null)"})
    __git_command_successful $pipestatus || return
  fi

  _wanted $tag expl $description _multi_parts -f $compadd_opts - / files
}
