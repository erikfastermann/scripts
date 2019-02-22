# Auto-commit every untracked/modified file separate
# Already added, renamed files will belong to the first commit
gauto-separate () {
    while read file; do
        git add "$file"
        gauto
        echo ----------
    done < <(git ls-files --other --modified)
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
