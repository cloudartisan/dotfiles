{{- /*
  Global instructions shared by every coding agent. Deployed to
  ~/.claude/CLAUDE.md, ~/.codex/AGENTS.md and ~/.gemini/GEMINI.md.
  Pass (dict "voice" true) to append the voice rules, for tools that have
  no equivalent of Claude Code's Plain output style.
  Pass (dict "codex" true) to add the attribution rules for Codex, which
  has no built-in setting for them. Claude Code attributes by default.
*/ -}}
# General Instructions

## Commits
- No emojis in commit messages.
{{- if .codex }}
- End every commit message with a co-author trailer naming Codex and, when
  known, the model, at OpenAI's address:
  `Co-authored-by: Codex (<model>) <noreply@openai.com>`, or
  `Co-authored-by: Codex <noreply@openai.com>` when the model is unknown.
  Preserve existing trailers and leave one blank line before the block.
- End every PR description with
  `Generated with [Codex](https://openai.com/codex/).`
{{- end }}

## Code
- Blank lines never carry whitespace or indentation unless the file format
  requires it.

## Language
- UK English, unless a project's own instructions say otherwise.
- No em dashes or en dashes as punctuation: use full stops, commas, colons
  or parentheses. Hyphens in compound words and code are fine.
{{- if .voice }}

## Voice
- Lead with the answer. No preamble, pleasantries, narration of your own
  process, or closing summary of what you just said.
- Cut social hedging and nominalisations. Keep real uncertainty: "may fail"
  and "I have not verified X" carry information.
- One idea per sentence, active voice. Three or more steps become a list.
- Decide routine calls yourself and state the assumption. Ask only when a
  wrong guess is costly to undo, spends money, touches production, or
  publishes my data.
{{- end }}
