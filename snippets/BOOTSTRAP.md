# Bootstrap: move this into lazzerbeam/snippets

This snippet system was built on a branch of `lazzerbeam/lazzerbeam` (the agent
session was scoped to that repo only). To make `lazzerbeam/snippets` its own
home, run this once from your machine.

## If the new repo is empty (no README)

```bash
git clone --branch claude/experimental-snippet-repo-fvs4s4 \
  https://github.com/lazzerbeam/lazzerbeam.git tmp-snip
cd tmp-snip/snippets

git init -b main
git add .
git commit -m "Initial snippet repo: agent-friendly scaffold + ring buffer"
git remote add origin https://github.com/lazzerbeam/snippets.git
git push -u origin main
```

## If you created it WITH a README/.gitignore

```bash
git clone --branch claude/experimental-snippet-repo-fvs4s4 \
  https://github.com/lazzerbeam/lazzerbeam.git tmp-snip
cd tmp-snip/snippets

git init -b main
git remote add origin https://github.com/lazzerbeam/snippets.git
git fetch origin
git add .
git commit -m "Initial snippet repo: agent-friendly scaffold + ring buffer"
# bring in the auto-created files, then push
git rebase origin/main || git merge --allow-unrelated-histories origin/main
git push -u origin main
```

## Then clean up
```bash
cd ../.. && rm -rf tmp-snip
```

Alternatively, extract the `snippets-repo.tar.gz` artifact (sent in chat) into an
empty folder and run the same `git init … push` steps.
