# Project Foundation

This repository holds the engineering and AI-collaboration foundation for a future
application: governance, templates, validation, and reusable AI skills. It contains no
feature code yet, and no technology stack has been chosen.

## Start here

- AI agents: read [AGENTS.md](AGENTS.md) first. It is the canonical entry point.
- Humans: read [CONTRIBUTING.md](CONTRIBUTING.md) and [constitution.md](constitution.md).

## How a change happens

request → specification → human approval → plan → tasks → implementation → validation →
review

1. Draft a spec from [specs/TEMPLATE.md](specs/TEMPLATE.md).
2. A human approves it.
3. Write a plan and tasks, implement only the approved scope, and add tests.
4. Run `sh scripts/validate.sh` and complete
   [review/change-template.md](review/change-template.md).

## Validate

```sh
sh scripts/validate.sh
```

Requires only a POSIX shell, `grep`, `sed`, and `find`. No application dependencies exist.

## Open questions for the owners

- What product will this repository deliver?
- Which language, runtime, and framework will it use?
- Which CI system, if any, should run `scripts/validate.sh`, and where is the remote?
- Who may approve specs and protected-path changes and merge? Until this is answered,
  any named human maintainer may.

These must be answered by a human in an approved spec before they appear in code.
