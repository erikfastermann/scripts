# Auto-commit every untracked/modified file separate
# Already added, renamed files will belong to the first commit
gauto-separate () {
    while read file; do
        git add "$file"
        gauto
        echo ----------
    done < <(git ls-files --other --modified)
}

# Browse commits for a specific file, view commit in $EDITOR
# USAGE: gbrowse dir
gbrowse () {
    local git_folder="$1"
    if [[ "$git_folder" == "" ]]; then
        git_folder="."
    fi
    while local git_file="$(git -C $git_folder log --follow --diff-filter=A --pretty=format: --name-only . \
        | grep . | fzf)"; [[ "$git_file" ]]; do
        while local git_commit="$(git -C $git_folder log --follow --pretty=format:'%C(auto)%h %Cblue(%an %ar)%Creset %s' \
            -- $git_file | fzf | cut -c1-7)"; [[ "$git_commit" ]]; do
            git -C "$git_folder" show "${git_commit}:${git_file}" | "$EDITOR" "$git_file"
        done
    done
}

# Save current work to branch and push
gwip () {
    local wip_branch="WIP-$(git branch | grep \* | cut -d ' ' -f2)" && \
    git checkout -b "$wip_branch" && \
    git add -A && git commit -m "$(date '+%F %T')" && \
    git push origin "$wip_branch"
}

# Cherry-pick -n latest commit from pulled WIP-branch
# and delete this branch local and remote
gresume () {
    local current_branch="$(git branch | grep \* | cut -d ' ' -f2)" && \
    git pull && \
    git checkout "WIP-$current_branch"
    local last_commit=$(git log "WIP-$current_branch" -n1 --pretty=format:"%H" --) && \
    git checkout "$current_branch" && \
    git cherry-pick -n "$last_commit" && \
    git branch -D "WIP-$current_branch" && \
    git push --delete origin "WIP-$current_branch"
}
