# CLAUDE.md - Development Guide

## Scope

This repository manages a PERSONAL-ONLY setup (macOS, zsh). All work/
Salesforce configuration was removed in June 2026, and the history was
later rewritten to purge those files entirely. They are NOT recoverable
from git history - do not go looking for them there.

## Commands

### Primary Installation Method
- `bootstrap-chezmoi.sh --apply` - Complete system setup (recommended)

### Utility Scripts

Source files live in `bin/` with chezmoi's `executable_` prefix and are
deployed to `~/bin` (on the PATH via `.zshrc`), so invoke them by their
deployed names, not by their source paths.

### chezmoi Gotchas

`chezmoi cd` takes an optional *path* and launches an interactive shell; it
does not run a command. Use `chezmoi git` for one-off git commands, and put
`--` before any git flags so chezmoi does not try to parse them itself.

On a machine where the source directory is a normal checkout (for example
`~/Projects/dotfiles`, as set by `bootstrap-chezmoi.sh`), plain git from
inside that checkout is equivalent and often simpler.

## Style Guidelines
- **Shell Scripts**: Use POSIX-compatible syntax when possible
- **Variables**: Use lowercase with underscores (snake_case)
- **File Extensions**: .sh for shell scripts, .zsh for zsh-specific files
- **Indentation**: 2 spaces
- **Line Length**: Keep under 80 characters when possible

## Secret Protection

This repository is PUBLIC and the chezmoi workflow routinely copies files out
of `$HOME`, so two layers guard against committing secrets:

- **GitHub secret scanning and push protection** (server-side) reject a push
  containing a recognised credential. They cannot be bypassed locally.
- **pre-commit hooks** (`.pre-commit-config.yaml`) run gitleaks plus private-key
  and large-file checks against staged content. Installed per checkout by
  `.chezmoiscripts/run_once_setup-pre-commit.sh.tmpl`; run `pre-commit install`
  by hand if a checkout is missing them.

That script also runs `pre-commit init-templatedir ~/.git-template`, which
`init.templateDir` in `dot_gitconfig` points at, so every repository cloned or
created from then on gets the hook automatically. The generated hook passes
`--skip-on-missing-config`, so it is inert where there is no
`.pre-commit-config.yaml`. It applies to clone/init only - checkouts that
already existed still need `pre-commit install` once each.

`.chezmoiignore` only excludes known sensitive *paths*; the hooks are what
inspect file *contents*. Never bypass them with `--no-verify` to land a secret.

`~/.claude/settings.json` is the reason `dot_claude/modify_settings.json.tmpl`
sets keys instead of shipping the file. That file mixes portable preferences
with `autoMode.environment`, a security profile Claude Code writes for the
project in hand: cloud project refs, CI secret names, which files hold
credentials, which tables hold personal data. No secret values, but not for a
public repo. The modify_ script names only the keys that are safe to publish,
so the rest never reaches git even as the tool keeps rewriting the file.
`permissions.allow` merges as a union, so an entry approved on one machine is
never deleted by an apply on another; that also means pruning is manual.

A personal GitHub account cannot default scanning on for new repositories, so
`bin/sweep-secret-scanning` re-enables it weekly via a launch agent. Both the
agent and the script are personal-machine only, and the script additionally
refuses to act unless the authenticated `gh` account matches `github_login`
in `.chezmoidata/personal.yaml` - work repositories are never touched.
`sweep-secret-scanning --dry-run` reports what it would change without
changing anything.

**Repos using husky:** husky sets `core.hooksPath`, so git ignores
`.git/hooks` entirely and `pre-commit install` has no effect. Bridge it by
calling `pre-commit run` from `.husky/pre-commit` instead. See `docs/`.

## Architecture

### Shell Configuration (zsh)

- **dot_zsh/** - Modular fragments deployed to `~/.zsh/`. Ordering and
  secrets matter for three of them:
  - `homebrew.zsh` - Homebrew PATH and fpath (sourced first, before compinit)
  - `node.zsh` - Puts Volta's shims ahead of Homebrew for per-project Node
  - `keys.zsh` - Loads API keys from `~/.keys/*.sh` (never committed), and
    provides `keys_add` for writing them safely
- **dot_zshenv** - Read by EVERY zsh invocation, including non-interactive
  scp/sftp sessions. Must stay silent and fast: stray output on stdout or
  stderr breaks scp/sftp, which parse the stream directly. Holds a deliberate
  allow-list of the few keys needed outside interactive shells (currently the
  Supabase token). Everything else belongs in `dot_zshrc`.
- **~/.zsh_local** - Machine-local config, sourced if present, never committed

### Key Files
- **.chezmoi.toml.tmpl** - Config template; prompts once for the personal flag
  and pins `sourceDir` so a non-default checkout survives re-running `init`
- **.chezmoidata/personal.yaml** - Default for `.personal`, plus `github_login`
- **.chezmoiremove** - Targets to delete from $HOME; chezmoi does not remove
  a file just because it left the source directory
- **.chezmoitemplates/agents.md** - The global instructions shared by every
  coding agent. Edit this, not the thin templates that render it:
  `dot_claude/CLAUDE.md.tmpl` (to `~/.claude/CLAUDE.md`),
  `dot_codex/AGENTS.md.tmpl` and `dot_gemini/GEMINI.md.tmpl`. Codex and
  Gemini also get a Voice section, since only Claude has the Plain output
  style. Not this file: `/CLAUDE.md` is repo-only and is excluded in
  `.chezmoiignore`, which otherwise ignores all of `~/.claude`.
- **dot_claude/output-styles/Plain.md** - Output style setting the house voice
  (lead with the answer, no filler, keep real uncertainty). Selecting it is
  per-machine: `outputStyle` lives in settings.json, see below.
- **dot_claude/modify_settings.json.tmpl** - Merges a named subset of keys into
  `~/.claude/settings.json` and passes every other key through untouched
- **.chezmoidata/claude.json** - That subset: the portable preferences and the
  shared `permissions.allow` entries
- **bin/sync-claude-settings** - Regenerates `.chezmoidata/claude.json` from
  the local `~/.claude/settings.json`, dropping credentials and other machines'
  home paths. Run it after approving a permission worth sharing; `chezmoi
  apply` carries it the other way.

Scripts that depend on the Brewfile (Volta, pre-commit, tmux plugins) rely on
filenames sorting after `run_once_install-packages`, and each also skips
harmlessly if its tool is not yet on the PATH. Keep that ordering in mind when
renaming or adding scripts.
