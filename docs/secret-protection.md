# Secret protection rollout

Reference for extending the protection set up in this repo to other
repositories. Repo-only documentation - excluded from deployment via
`.chezmoiignore`.

## The three layers

| Layer | Scope | Bypassable |
|---|---|---|
| GitHub secret scanning + push protection | per repo, server-side | no |
| pre-commit hooks (gitleaks) | per checkout, local | yes (`--no-verify`) |
| `.gitignore` / `.chezmoiignore` | per repo, paths only | n/a - ignores paths, not content |

Server-side scanning is free for **public** repositories on all plans.
Private repositories require paid GitHub Secret Protection.

### What this repo already automates

The sections below describe the manual steps, because the point of this
document is rolling the setup out elsewhere. On a machine set up from these
dotfiles, three of them are already done:

| Step | Automated by |
|---|---|
| `pre-commit install` in this checkout | `.chezmoiscripts/run_once_setup-pre-commit.sh.tmpl` |
| Seeding `~/.git-template` for future clones | the same script, plus `init.templateDir` in `dot_gitconfig` |
| The weekly server-side sweep | `bin/sweep-secret-scanning` + `Library/LaunchAgents/com.cloudartisan.secret-scanning-sweep.plist` (personal machines only) |

## Prompt: set up pre-commit secret scanning in any repo

Paste into Claude Code from the root of the target repository.

---
Set up local secret scanning in this repository, matching the setup in my
dotfiles repo.

1. Check whether `.pre-commit-config.yaml` already exists. If it does, add only
   the missing hooks rather than overwriting it.
2. Create or update `.pre-commit-config.yaml` with:
   - `gitleaks-system` from `https://github.com/gitleaks/gitleaks`. Pin `rev`
     to the current release tag - look it up, do not guess. This hook needs
     `pass_filenames: false` set explicitly in my config: upstream sets it on
     the `gitleaks` and `gitleaks-docker` hooks but omits it on
     `gitleaks-system`, so without it pre-commit appends staged paths to a
     command that accepts at most one argument and the hook dies with
     "accepts at most 1 arg(s)".
   - `detect-private-key` and `check-added-large-files` from
     `https://github.com/pre-commit/pre-commit-hooks`, `rev` likewise pinned to
     the current release tag.
   `gitleaks-system` uses a `gitleaks` binary on PATH (`brew install gitleaks`);
   switch to the `gitleaks` hook id, which pre-commit builds itself, if this
   machine will not have that binary.
3. Run `pre-commit install`, then `pre-commit run --all-files`. If existing
   files trip gitleaks, inspect each hit before silencing it - add a
   `.gitleaks.toml` allowlist only for genuine false positives, and tell me
   what you allowlisted and why.
4. Verify the hook actually blocks a commit. Write a file containing a random
   token-shaped string, e.g. `ghp_` followed by 36 random alphanumerics, stage
   it, and confirm `pre-commit run` exits non-zero. Do **not** use a well-known
   documentation example such as `AKIAIOSFODNN7EXAMPLE`: gitleaks allowlists
   those by default and the test will pass when it should fail. Delete the test
   file and unstage it afterwards, and never commit it.
5. Scan existing history: `gitleaks git --redact --no-banner --log-opts="--all"
   --report-path <path outside the repo> .`  Always pass `--redact`. Write the
   report outside the repository, never `cat` it wholesale, and delete it once
   summarised. Report counts, rule names, paths and commit SHAs only - never a
   secret value.
6. If the repo is public and on GitHub, check whether secret scanning and push
   protection are enabled, and tell me if they are not:
   `gh api repos/OWNER/REPO --jq '.security_and_analysis'`

Do not commit anything until I have reviewed it. Never print a secret value,
even one you believe is already public.
---

## Repositories using husky

husky sets `core.hooksPath` (usually to `.husky/_`), which makes git ignore
`.git/hooks` **entirely**. In such a repository `pre-commit install` appears to
succeed but the hook never runs, and the git template directory does not help
either. Detect them with:

```bash
find ~/Projects -maxdepth 2 -type d -name .git | while read -r g; do
  r="${g%/.git}"
  hp=$(git -C "$r" config --get core.hooksPath 2>/dev/null)
  [ -n "$hp" ] && echo "$(basename "$r"): hooksPath=$hp"
done
```

The fix is to let husky call pre-commit, rather than fighting over the hook
path. Add to `.husky/pre-commit`:

```sh
if command -v pre-commit >/dev/null 2>&1; then
  pre-commit run
fi
```

Guarding on `command -v` keeps the repository working for anyone who does not
have pre-commit installed.

## Covering future clones automatically

`pre-commit install` writes to `.git/hooks`, which is per-checkout, so it must
be repeated for every clone. A git template directory makes it automatic for
every repository cloned or created from then on:

```bash
pre-commit init-templatedir ~/.git-template
git config --global init.templateDir ~/.git-template
```

Both halves are already handled here - `run_once_setup-pre-commit.sh.tmpl`
seeds the directory and `dot_gitconfig` sets `init.templateDir` - so do **not**
run the `git config --global` line on a machine using these dotfiles. It writes
into the chezmoi-managed `~/.gitconfig` and shows up as drift on the next
`chezmoi diff`. Change `dot_gitconfig` instead.

The generated hook is a no-op in repositories with no
`.pre-commit-config.yaml`, so it is safe to have everywhere. It applies to
`git clone` and `git init` only - existing checkouts still need
`pre-commit install` once each:

```bash
# run over every repo already on the machine
find ~/Projects -maxdepth 2 -type d -name .git | while read -r g; do
  r="${g%/.git}"
  [ -f "$r/.pre-commit-config.yaml" ] && ( cd "$r" && pre-commit install )
done
```

## Re-running the server-side sweep

There is no account-level default for a personal GitHub account: bulk
enablement via security configurations is an organization-owner feature, and
the REST API exposes no equivalent user-level setting. New repositories will
therefore not inherit these settings, so the sweep needs repeating.

On a machine set up from these dotfiles this is already automated:
`bin/sweep-secret-scanning` does all three steps below - enable, verify,
report open alerts - and a launch agent runs it weekly. Run it by hand any
time, and use `--dry-run` to see what it would change without changing
anything. It refuses to act unless the authenticated `gh` account matches
`github_login` in `.chezmoidata/personal.yaml`.

The raw commands, for a machine without the script:

```bash
gh api "user/repos?per_page=100&affiliation=owner" --paginate \
  --jq '.[] | select(.visibility=="public") | .full_name' |
while read -r r; do
  gh api -X PATCH "repos/$r" \
    -f 'security_and_analysis[secret_scanning][status]=enabled' \
    -f 'security_and_analysis[secret_scanning_push_protection][status]=enabled' \
    >/dev/null 2>&1 && echo "ok $r" || echo "FAILED $r"
done
```

Verify separately rather than trusting the write responses:

```bash
gh api "user/repos?per_page=100&affiliation=owner" --paginate \
  --jq '.[] | select(.visibility=="public") | .full_name' |
while read -r r; do
  gh api "repos/$r" --jq '[.full_name,
    (.security_and_analysis.secret_scanning.status // "unset"),
    (.security_and_analysis.secret_scanning_push_protection.status // "unset")]
    | @tsv'
done | grep -v 'enabled.*enabled' || echo "all enabled"
```

Check for open alerts across all public repos:

```bash
gh api "user/repos?per_page=100&affiliation=owner" --paginate \
  --jq '.[] | select(.visibility=="public") | .full_name' |
while read -r r; do
  n=$(gh api "repos/$r/secret-scanning/alerts?state=open" --jq 'length' 2>/dev/null)
  [ "${n:-0}" -gt 0 ] 2>/dev/null && echo "$r: $n open"
done; echo "done"
```
