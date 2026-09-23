#!/usr/bin/env bash
# p10k-style git segment for starship -- see ~/.config/starship.toml.
#
# Prints the segment text prefixed with a raw SGR foreground escape, so a single
# custom module can colour itself: green when the work tree is clean (untracked
# files don't count), yellow when it is modified. Deciding the colour here is
# why this is one module instead of the former custom.git_clean/custom.git_dirty
# pair -- those each ran their own `git status` in `when`, on top of the one in
# `command`, so every prompt paid for git status two or three times.
#
# No SGR reset is emitted: starship closes the segment itself, and the
# background colour set by the surrounding style carries over the escape.
#
# Colours are hardcoded because starship cannot interpolate its palette into a
# custom module's output; they must stay in sync with [palettes.tokyonight].
CLEAN=$'\033[38;2;158;206;106m' # green  #9ece6a
DIRTY=$'\033[38;2;224;175;104m' # yellow #e0af68

st=$(git status --porcelain=v2 --branch --show-stash 2>/dev/null) || exit
a=0 b=0 stash=0 c=0 staged=0 unstaged=0 untracked=0
while IFS= read -r l; do
  case $l in
    '# branch.oid '*)      oid=${l#'# branch.oid '} ;;
    '# branch.head '*)     head=${l#'# branch.head '} ;;
    '# branch.upstream '*) up=${l#'# branch.upstream '} ;;
    '# branch.ab '*)       read -r _ _ a b <<<"$l"; a=${a#+} b=${b#-} ;;
    '# stash '*)           stash=${l#'# stash '} ;;
    u*)                    ((c++)) ;;
    [12]*)                 [[ ${l:2:1} != . ]] && ((staged++)); [[ ${l:3:1} != . ]] && ((unstaged++)) ;;
    '?'*)                  ((untracked++)) ;;
  esac
done <<<"$st"
if [[ $head != '(detached)' ]]; then
  (( ${#head} > 32 )) && head="${head:0:12}…${head: -12}"
  res=$' '"$head"
elif tag=$(git describe --tags --exact-match 2>/dev/null); then
  res=$' '"$tag"
else
  res="@${oid:0:8}"
fi
[[ -n $up && ${up#*/} != "$head" ]] && res+=":${up#*/}"
[[ $(git log -1 --format=%s 2>/dev/null) =~ (^|[^[:alnum:]])(wip|WIP)([^[:alnum:]]|$) ]] && res+=" wip"
if ((a || b)); then
  res+=" "; ((b)) && res+="⇣$b"; ((a)) && res+="⇡$a"
fi
((stash)) && res+=" *$stash"
gd=$(git rev-parse --git-dir)
if   [[ -d $gd/rebase-merge || -d $gd/rebase-apply ]]; then res+=" rebase"
elif [[ -f $gd/MERGE_HEAD       ]]; then res+=" merge"
elif [[ -f $gd/CHERRY_PICK_HEAD ]]; then res+=" cherry-pick"
elif [[ -f $gd/REVERT_HEAD      ]]; then res+=" revert"
elif [[ -f $gd/BISECT_LOG       ]]; then res+=" bisect"
fi
((c))         && res+=" ~$c"
((staged))    && res+=" +$staged"
((unstaged))  && res+=" !$unstaged"
((untracked)) && res+=" ?$untracked"

# clean/dirty matches the old `git status --porcelain=v2 -uno | grep '^[12u]'`
# test: untracked files alone still count as clean.
if ((staged || unstaged || c)); then printf '%s' "$DIRTY"; else printf '%s' "$CLEAN"; fi
printf '%s' "$res"
