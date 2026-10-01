# Skill: test-plan-generator

## Purpose
Derive a traceable test plan from a specification's acceptance criteria, so every
criterion has at least one concrete test case before implementation starts.

## When to Use
- A spec is `In Review`, to expose untestable or incomplete criteria before approval.
- A spec is `Approved`, to fill the `Verification` table of `plans/<id>.md`.
- Do not use on a `Rejected` spec or to write test code.

## Required Inputs
- Path to the spec (`specs/<id>.md`).
- The approved stack and test runner, if the spec names them; otherwise none.

## Steps
1. Read the spec and `docs/standards.md` section 6 (Testing).
2. Note the spec `Status`. If it is not `Approved`, label the output
   "Provisional: spec not approved; not for implementation".
3. For each acceptance criterion, write one positive test case with exact inputs and
   expected results taken from the criterion.
4. Add a negative or edge case only if a requirement implies it. If an edge case seems
   important but no requirement covers it, add it to "Questions for the spec" instead.
5. Mark any case that depends on an unresolved open question as `Blocked by Qn`.
6. Keep cases stack-neutral (describe request, action, and observable result) unless the
   spec names a stack and test runner.
7. Name each case `TC<n>-AC<m>-<short-kebab-name>`.
8. Build the coverage table: every AC must map to at least one case.
9. Return the plan. Do not create files in `src/` or `tests/`.

## Stop Conditions
- The spec file does not exist or its status is `Rejected`: report it and stop.
- The spec has no acceptance criteria, or a criterion is not Given/When/Then: report the
  criterion IDs and stop; ask for a spec update.
- Producing a case would require choosing an unspecified technology: mark it blocked,
  do not choose.

## Output Format
```
# Test Plan: <spec title>
- Spec: specs/<id>.md (Status: <status>)
- Label: <Provisional ... | Ready for implementation>
## Test cases
| ID | Covers | Given | When | Then | Type | Status |
## Coverage
| AC | Test cases | Covered (Yes/No) |
## Questions for the spec
- <question, or "None">
```
`Type` is `positive`, `negative`, or `edge`. `Status` is `Ready` or `Blocked by Qn`.

## Quality Checks
- Does every acceptance criterion have at least one test case?
- Does every case trace to an AC ID?
- Are expected results exact (no "works", "is correct", "is fine")?
- Is every case that depends on an open question marked `Blocked`?
- Were no new requirements invented (extra ideas listed as questions)?
- Is the output labeled Provisional when the spec is not Approved?
- Were no files created in `src/` or `tests/`?

## Example
Input: `specs/profile-csv-export.md` (Draft) with AC1 "Given a signed-in user, when they
request the export, then they receive a CSV file containing their profile fields <see Q2>."

Output (excerpt):
```
- Label: Provisional: spec not approved; not for implementation
| ID | Covers | Given | When | Then | Type | Status |
| TC1-AC1-signed-in-export | AC1 | signed-in user | requests export | receives a file with content type text/csv | positive | Blocked by Q1 |
| TC2-AC1-own-fields-only | AC1 | signed-in user | requests export | file holds only that user's fields | positive | Blocked by Q2 |
## Questions for the spec
- What happens when a signed-out visitor requests the export?
```
