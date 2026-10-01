# Contributing

Follow these four stages in order. Do not start a stage until the previous one is complete.
Rules referenced below live in [AGENTS.md](AGENTS.md) and
[docs/standards.md](docs/standards.md).

## 1. Write and approve a specification

1. Choose a kebab-case `<id>` for the change (for example `health-endpoint`).
2. Copy [specs/TEMPLATE.md](specs/TEMPLATE.md) to `specs/<id>.md`, or run the
   [spec-generator](skills/spec-generator/SKILL.md) skill.
3. Fill every section. Write each requirement so it can be tested Yes/No, and give each
   one a Given/When/Then acceptance criterion.
4. Put every unclear point, unchosen technology, or assumption in `Open Questions`.
   Do not resolve it yourself.
5. Commit the spec on branch `spec/<id>` and ask a human to review it. Then stop.
   Keep `**Status:** Draft` while any open question is unchecked. An agent may set
   `**Status:** In Review` only when every question has a human answer.
6. A human answers open questions in the spec, then sets `**Status:** Approved` or
   `**Status:** Rejected`, and fills `Human Approval` (Decision, name, date).
   An agent must never do this step.

A spec is approved only if the line reads exactly `**Status:** Approved`, `Decision:` is
`Approved`, a human name and date are filled, and no open question is unchecked (`- [ ]`).

Changing an approved spec: any edit to Scope, Requirements, or Acceptance Criteria resets
it to `**Status:** Draft` and clears `Human Approval`; it needs approval again.

## 2. Create a plan and tasks

1. Copy [plans/TEMPLATE.md](plans/TEMPLATE.md) to `plans/<id>.md`. Describe the approach,
   files to change, and how each requirement will be verified.
2. Copy [tasks/TEMPLATE.md](tasks/TEMPLATE.md) to `tasks/<id>.md`. Split the plan into
   small tasks; each task names its files, the requirement it serves, and a Yes/No
   "done when" check.
3. Optionally run [test-plan-generator](skills/test-plan-generator/SKILL.md) to derive
   test cases from the acceptance criteria.
4. If the plan needs anything outside the spec, stop and ask for a spec update first.

## 3. Implement and test the approved scope

1. Create branch `<type>/<id>` with a type from `docs/standards.md` N3 (usually `feat`).
2. Work through `tasks/<id>.md` in order and tick each task when its check is Yes.
3. Write code only in paths named by the plan. Add a test for every acceptance criterion
   in `tests/`, named with its AC ID.
4. Do not touch protected paths, add unlisted dependencies, or weaken tests or security.
5. If anything is unclear, stop and ask. Record the answer in the spec.

## 4. Validate and submit a change

1. Run `sh scripts/validate.sh` and every application test command listed in `AGENTS.md`.
   All must exit 0.
2. Copy [review/change-template.md](review/change-template.md) to `review/<id>.md` and
   answer every question Yes, No, or Not applicable, with evidence.
3. Optionally run [pr-reviewer](skills/pr-reviewer/SKILL.md) to check the change.
4. Commit as `<type>(<id>): <summary>` and open a pull request that links the spec, plan,
   tasks, and review.
5. A human reviewer merges only if no checklist answer is `No`.
