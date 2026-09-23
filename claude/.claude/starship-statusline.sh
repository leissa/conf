#!/usr/bin/env bash
# Claude Code statusline, rendered by starship's `claude-code` profile.
# Profile and module styling live in starship/.config/starship.toml.
#
# starship reads the session JSON from stdin, but it resolves path-based modules
# (git_branch / git_status / git_metrics) from its own working directory or from
# -p -- never from workspace.current_dir. Claude Code does not promise which
# directory it runs this in, and current_dir follows the session as it cd's, so
# pass the directory through explicitly instead of trusting the inherited cwd.
set -uo pipefail

json=$(cat)
dir=$(jq -r '.workspace.current_dir // .cwd // empty' <<<"$json" 2>/dev/null)

if [[ -n $dir && -d $dir ]]; then
    exec starship statusline claude-code -p "$dir" <<<"$json"
else
    exec starship statusline claude-code <<<"$json"
fi
