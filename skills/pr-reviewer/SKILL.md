# Skill: pr-reviewer

## Purpose
Review a change against the repository checklist in `review/change-template.md` and
produce a completed review with evidence for every answer.

## When to Use
- Before a change is submitted or merged.
- After implementation is complete and validation can be run.
- Do not use to approve specs, fix the code under review, or merge.

## Required Inputs
- The change: a branch and base (`git diff <base>...<branch>`), or the uncommitted working
  tree (`git status --porcelain` and `git diff`).
- The spec path, or the statement "governance-only change" if no `src/` or `tests/` file
  changes.
- Permission to run the validation commands listed in `AGENTS.md`.

## Steps
1. Read `AGENTS.md`, `review/change-template.md`, the spec, and its plan and tasks if any.
2. List changed files with status (added, modified, deleted).
3. Answer the eight checklist questions from `review/change-template.md`, in order, with
   `Yes`, `No`, or `Not applicable` and evidence:
   1. Approved spec linked: the spec for this change (same `<id>`) reads
      `**Status:** Approved` with a human name and date.
      `Not applicable` only if no file in `src/` or `tests/` changed.
   2. Within scope: every changed file appears in the plan or traces to a requirement.
   3. Acceptance criteria covered: each AC ID maps to a named test in `tests/`.
   4. Validation passed: run every applicable command; paste output and exit codes.
   5. Secrets absent: `sh scripts/validate.sh` secret check passes and the diff shows none.
   6. Dependencies justified: every new dependency is listed in the spec with version,
      license, and reason; `Not applicable` if none were added.
   7. Protected paths: intersect changed files with the list in `AGENTS.md`; each match
      needs a recorded human approval in the format `AGENTS.md` defines. If it is
      missing, answer `No` and ask a human to record it. Never record it yourself.
   8. Documents updated: docs affected by the change (for example new commands in
      `AGENTS.md`) changed in the same change.
4. Any answer without evidence is `No`.
5. Set the verdict: `Ready to merge` only if no answer is `No`; otherwise
   `Changes required` with a numbered list.
6. Write the result to `review/<id>.md`. Do not edit any other file.

## Stop Conditions
- No change can be found (empty diff): report it and stop.
- A secret appears in the change: stop, report only the file and line, never the value,
  and ask a human to rotate it.
- Validation cannot run: answer question 4 `No` with the error, finish the review, and ask
  a human for help.
- The spec referenced does not exist: answer question 1 `No` and stop for human input.

## Output Format
A copy of `review/change-template.md` saved as `review/<id>.md`, with every row answered,
the full validation output pasted, and the verdict filled.

## Quality Checks
- Are all eight questions from `review/change-template.md` answered?
- Is every answer exactly `Yes`, `No`, or `Not applicable`?
- Does every answer cite a link, command output, or `path:line`?
- Was validation actually run in this review (not copied from elsewhere)?
- Is the verdict `Ready to merge` only when no answer is `No`?
- Did the reviewer avoid editing files other than `review/<id>.md`?

## Example
Input: branch `feat/profile-csv-export`, spec `specs/profile-csv-export.md`.

Output (excerpt of `review/profile-csv-export.md`):
```
| 1 | Is an approved specification linked? | Yes | specs/profile-csv-export.md:3 Status Approved; approved by J. Doe, 2026-10-02 |
| 3 | Are acceptance criteria covered by tests? | No | AC2 has no test; grep -rn "AC2" tests/ returned nothing |
| 7 | Are protected paths unchanged or approved? | Yes | git diff --name-only lists only src/ and tests/ files |
- Verdict: Changes required
- Required changes: 1. Add a test covering AC2.
```
