<!-- Project agent roster -->
## Project Agents

This project defines a 5-role "Antigravity" SDLC pipeline, described in
`.antigravity/workflow.md` (Orchestrator SOP) and `.antigravity/*.md` (role
specs, used by the Antigravity/agy CLI). **Do not delete or rename these
files** — they remain the source of truth for that pipeline and are read by
the Antigravity tooling directly.

`.claude/agents/*.md` mirrors the same 5 roles as native Claude Code
sub-agents (callable via the `Agent` tool's `subagent_type`), so Claude Code
can spawn them directly instead of only Antigravity/agy. Keep both in sync —
if you edit a role's rules in one place, mirror the change in the other.

| subagent_type | Phase | Responsibility |
| --- | --- | --- |
| `lead-architect` | 1, 4 | Requirement analysis, architecture, `plan.html` / `summary.html` |
| `critic-architect` | 1 | Adversarial review of the architecture draft |
| `senior-coder` | 2, 3 | Implementation and bug fixes against `TASK.MD` / `FIND_BUG.MD` |
| `logic-reviewer` | 3 | Static/logic review → `REVIEW_LOGIC.MD` |
| `testing-reviewer` | 3 | Dynamic/runtime test verification → `REVIEW_TEST.MD` |

When a task matches this pipeline's shape (plan → build → dual review →
commit), follow the Phase 1–4 sequence in `.antigravity/workflow.md` and
spawn the matching `subagent_type` above at each step, rather than inventing
an ad-hoc process.

### Reusable templates for other projects

`templates/agy/` and `templates/cc/` hold `.example`-suffixed copies of the
files above, for bootstrapping this same 5-role pipeline into a *different*
project:

- `templates/agy/*.md.example` (5 role files + `workflow.md.example`) →
  target project's `.antigravity/` (strip `.example`, e.g.
  `lead-architect.md.example` → `lead-architect.md`).
- `templates/agy/GEMINI.md.example` → target project's root `GEMINI.md`.
- `templates/cc/*.md.example` (5 role files) → target project's
  `.claude/agents/`.
- `templates/cc/CLAUDE.md.example` → target project's root `CLAUDE.md`.

The `.example` suffix is intentional: neither Claude Code nor the
Antigravity CLI recognizes `*.md.example`, so these template copies stay
inert here and are never picked up as live agents in *this* repo — only the
real `.antigravity/*.md`, `.claude/agents/*.md`, `GEMINI.md` and `CLAUDE.md`
files are live.

Fastest way to apply a template to a new project — run `scripts/install-template.sh`
directly on that project (it prompts for `agy` or `cc`, then a destination
directory, defaulting to the current directory on Enter):

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/CTJ425/agy_agent_lab/main/scripts/install-template.sh)"
```
