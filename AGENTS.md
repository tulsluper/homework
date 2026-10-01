# AGENTS.md

Canonical instructions for every AI coding agent and human contributor working in this
repository. They are platform-neutral: follow them whatever tool you run in. Read this
file fully before you change anything.

## Project purpose

This repository is the engineering and AI-collaboration foundation for a future
application. It defines how changes are specified, approved, built, validated, and
reviewed. **No product, technology stack, or runtime has been chosen yet.** Any of these
must be decided by a human in an approved specification before code is written.

## Folder map

| Path | Contents |
|------|----------|
| `AGENTS.md` | These instructions (entry point for agents) |
| `README.md` | Human overview and quick start |
| `CONTRIBUTING.md` | Step-by-step change workflow |
| `constitution.md` | Seven governing principles |
| `docs/standards.md` | Naming, submission, docs, dependency, security, testing rules |
| `specs/` | Specifications, one file per change: `specs/<id>.md` |
| `plans/` | Implementation plans: `plans/<id>.md` |
| `tasks/` | Task lists: `tasks/<id>.md` |
| `review/` | Review checklist template and completed reviews: `review/<id>.md` |
| `skills/<name>/SKILL.md` | Reusable AI skills |
| `skill-runs/<name>.md` | Recorded example run of each skill |
| `scripts/validate.sh` | Repository validation (no dependencies) |
| `src/` | Application code. Empty (only `.gitkeep`) until a spec is Approved |
| `tests/` | Automated tests. Empty (only `.gitkeep`) until a spec is Approved |

## Workflow

request → specification → **human approval** → plan → tasks → implementation →
validation → review. Step-by-step: [CONTRIBUTING.md](CONTRIBUTING.md).

For a new request, use [spec-generator](skills/spec-generator/SKILL.md), write
`specs/<id>.md` with `Status: Draft`, then **stop and ask a human to approve it**.

## Validation commands

Run from the repository root. A change is valid only if every applicable command exits 0.

| Command | When it applies | Pass condition |
|---------|-----------------|----------------|
| `sh scripts/validate.sh` | Every change | Exit 0 and last line starts with `PASS` |
| Application test command | After an approved spec sets a stack | Defined in that spec and added here |

There is no application test command yet. Do not invent one.

## Required rules

Each rule must answer **Yes** before you submit a change.

| # | Rule |
|---|------|
| R1 | Is every feature change backed by its own spec with the line `**Status:** Approved` and a human approver name and date? (No feature implementation without an approved specification.) |
| R2 | Did you run every applicable validation command and include its output in the review? |
| R3 | Are secrets absent from files, commits, logs, and outputs? (Never expose secrets.) |
| R4 | Are security controls and tests unchanged or strengthened, with none removed, skipped, or loosened? |
| R5 | Are protected paths unchanged, or is explicit human approval recorded for each change? |
| R6 | When a requirement was unclear, did you stop and ask a human instead of guessing? |
| R7 | Is the change limited to the approved scope? |
| R8 | Was the spec status set to `Approved` by a human, not by an agent? (An agent cannot approve its own specification.) |

## Protected paths

Do not create, modify, rename, or delete these without explicit human approval. Record it
in the review, question 7 evidence, as `Approved by <name>, <YYYY-MM-DD>: <what>`.
An approved spec that names the path and the exact edit under `Protected paths touched`
also counts as approval. Governance-only changes need no spec, but still need this approval.

- `AGENTS.md`, `constitution.md`, `CONTRIBUTING.md`, `docs/standards.md`
- `specs/TEMPLATE.md`, `plans/TEMPLATE.md`, `tasks/TEMPLATE.md`, `review/change-template.md`
- `skills/**`, `scripts/validate.sh`, `.gitignore`
- The `Status` line and `Human Approval` section of any file in `specs/`
  (an agent may only write `Draft` or `In Review`)
- `.git/`, CI configuration, and any `.env*` file

## Secret handling

- Never write real secrets (keys, tokens, passwords, private keys, connection strings) to
  any file, commit, spec, log, skill run, or chat output.
- Use placeholders such as `<API_TOKEN>`; real values live in environment variables
  outside the repository. `.env` files are git-ignored; only `.env.example` may be committed.
- If you find a secret: stop, do not copy or repeat it, and tell a human to rotate it.

## Stop and ask a human when

- A requirement, term, or acceptance criterion has more than one reasonable reading.
- A technology, language, framework, dependency, port, or version is not specified.
- The spec is not `Approved`, or the work would exceed its scope.
- A change would touch a protected path.
- A security control or test would need to be weakened, skipped, or deleted.
- A secret, credential, or personal data is involved.
- Validation fails and the fix is outside the approved scope.
- Repository instructions conflict with each other or with the request.

When you stop, record the questions in the spec's `Open Questions` section, list them in
your reply, and wait. Do not continue to the next workflow step.

## Governance documents

- [README.md](README.md)
- [CONTRIBUTING.md](CONTRIBUTING.md)
- [constitution.md](constitution.md)
- [docs/standards.md](docs/standards.md)
- [specs/TEMPLATE.md](specs/TEMPLATE.md)
- [plans/TEMPLATE.md](plans/TEMPLATE.md)
- [tasks/TEMPLATE.md](tasks/TEMPLATE.md)
- [review/change-template.md](review/change-template.md)
- [scripts/validate.sh](scripts/validate.sh)
- Skills: [spec-generator](skills/spec-generator/SKILL.md),
  [test-plan-generator](skills/test-plan-generator/SKILL.md),
  [pr-reviewer](skills/pr-reviewer/SKILL.md)
- Skill runs: [spec-generator](skill-runs/spec-generator.md),
  [test-plan-generator](skill-runs/test-plan-generator.md),
  [pr-reviewer](skill-runs/pr-reviewer.md)
- Sample spec: [specs/sample-health-endpoint.md](specs/sample-health-endpoint.md)
