# Tasks: <title>

- Spec: `specs/<id>.md`
- Plan: `plans/<id>.md`

Work top to bottom. Tick a task only when its "Done when" answer is Yes.
If a task needs anything outside the plan, stop and ask a human.

| Done | ID | Task | Files | Covers | Done when (Yes/No) |
|------|----|------|-------|--------|--------------------|
| [ ] | T1 | <write failing test for AC1> | `<tests/...>` | AC1 | Does the test exist and fail for the right reason? |
| [ ] | T2 | <implement R1> | `<src/...>` | R1 | Does the AC1 test pass? |
| [ ] | T3 | Run validation | none | all | Do all validation commands in `AGENTS.md` exit 0? |
| [ ] | T4 | Complete review | `review/<id>.md` | all | Is every checklist item answered with evidence? |
