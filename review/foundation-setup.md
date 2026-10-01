# Change Review: Repository foundation setup

- Change: branch `foundation`, uncommitted working tree (first change; no base commit)
- Spec: governance-only change; no spec required (no file in `src/` or `tests/` changed)
- Reviewer: AI agent using `skills/pr-reviewer/SKILL.md`
- Date: 2026-10-01

Answer each question with exactly `Yes`, `No`, or `Not applicable`. Every answer needs
evidence: a link, command output, or file reference (`path:line`). An answer without
evidence counts as `No`. `Not applicable` must say why.

| # | Question | Answer | Evidence |
|---|----------|--------|----------|
| 1 | Is an approved specification linked? | Not applicable | Governance-only: `find src tests -type f` returns only `src/.gitkeep`, `tests/.gitkeep` |
| 2 | Is the change within scope? | Yes | `git status --porcelain --untracked-files=all` lists only the requested deliverables plus `.gitignore` (secret handling, `AGENTS.md` Secret handling), `scripts/validate.sh` (validation command), and this review |
| 3 | Are acceptance criteria covered by tests? | Not applicable | No feature acceptance criteria are implemented; `specs/sample-health-endpoint.md` is Draft. Validator was checked with seeded violations (see output below) |
| 4 | Did validation pass? | Yes | `sh scripts/validate.sh` printed `PASS: all repository checks passed`, exit 0 (below) |
| 5 | Are secrets absent? | Yes | Validator check 8 passed; it detected a seeded fake key in a scratch copy, so the check works |
| 6 | Are dependencies justified? | Not applicable | No dependencies added: manifest search (`package.json`, `pyproject.toml`, `go.mod`, ...) returned nothing |
| 7 | Are protected paths unchanged or approved? | No | Protected files (`AGENTS.md`, templates, `skills/**`, `scripts/validate.sh`, ...) are created at the owner's request, but no `Approved by <name>, <date>` record exists yet (see Protected-path approval below) |
| 8 | Are relevant documents updated? | Yes | `AGENTS.md` links every governance doc, skill, and skill run (validator check 2 passed) |

## Validation output
```
$ sh scripts/validate.sh; echo "exit=$?"
PASS: all repository checks passed
exit=0

$ find src tests -type f
src/.gitkeep
tests/.gitkeep

# Validator check with seeded violations in a scratch copy:
FAIL: ./README.md: broken link missing.md
FAIL: specs/sample-health-endpoint.md: Approved without a date
FAIL: specs/sample-health-endpoint.md: Decision is not 'Approved'
FAIL: specs/sample-health-endpoint.md: approver looks like an agent; only a human may approve
FAIL: specs/sample-health-endpoint.md: Approved with unresolved open questions
FAIL: code exists (src/app.txt) but no spec is Approved
FAIL: possible secret in: ./docs/leak.md
FAIL: environment file must not be committed: ./.env
FAILED
exit=1
```

## Verdict
- Verdict: Changes required
- Required changes: 1. A human records protected-path approval below; item 7 then becomes Yes.

## Protected-path approval (human only)
- Approved by: <human name>, <YYYY-MM-DD>: creation of all protected files in this change
