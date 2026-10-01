# Skill: spec-generator

## Purpose
Turn a change request into a Draft specification that follows `specs/TEMPLATE.md`,
records every ambiguity as an open question, and stops for human approval.

## When to Use
- Someone asks for a new feature, behavior change, or fix and no spec covers it.
- Do not use when an existing spec in `specs/` already covers the request; update that
  spec instead, or ask a human which to use.

## Required Inputs
- The request, word for word.
- Read access to `AGENTS.md`, `constitution.md`, `specs/TEMPLATE.md`, and `specs/`.

## Steps
1. Read `AGENTS.md`, `constitution.md`, and `specs/TEMPLATE.md`.
2. Search `specs/` for a spec covering the same request. If one exists, stop (see Stop Conditions).
3. Choose a kebab-case `<id>` from the main nouns of the request.
4. Copy the template to `specs/<id>.md`. Set `**Status:** Draft`, today's date, and the
   exact request text.
5. Write `Problem` using only what the request states. If the reason is not stated, add an
   open question.
6. Write one requirement per explicit fact in the request. Use only facts from the request
   or from answered questions.
7. List every decision the request does not make as an open question. Always check:
   language, runtime, framework, URL path, HTTP method, port, response format and
   content type, authentication, environments, logging, performance, and dependencies.
   Never choose an answer yourself; you may list options inside the question.
8. Write at least one Given/When/Then criterion per requirement. Where a value is
   undecided, reference its question, for example `<path, see Q2>`.
9. Fill `Security and Dependencies`. Write `None decided; see Qn` for anything unchosen.
   List any protected path the request would touch.
10. Leave `Human Approval` as placeholders. Never set `Approved` or `Rejected`.
11. Run `sh scripts/validate.sh`. Fix only the spec file until it passes.
12. Reply with the spec path, the open questions, and a request for human review and
    approval. Then stop. Do not write a plan, tasks, code, or tests.

## Stop Conditions
- The request is empty or cannot be understood: ask what is wanted; create no file.
- A spec already covers the request: report its path and ask how to proceed.
- The draft is written: always stop and wait for a human decision.
- Validation fails for a reason outside the new spec file: report it and stop.

## Output Format
1. File `specs/<id>.md` filled from the template with `Status: Draft`.
2. A reply in this shape:
```
Draft spec: specs/<id>.md (Status: Draft)
Open questions (need a human answer):
- Q1: ...
Validation: sh scripts/validate.sh -> PASS
Next step: a human answers the questions and sets Status to Approved or Rejected.
I have stopped and will not plan or implement until then.
```

## Quality Checks
- Is `Status` set to `Draft`?
- Is the original request copied word for word?
- Does every requirement come only from the request or an answered question?
- Is every unchosen technology or value recorded as an open question?
- Does every requirement have a Given/When/Then criterion?
- Is `Human Approval` left unfilled?
- Were no plan, task, code, or test files created?
- Does `sh scripts/validate.sh` pass?

## Example
Input: "Let users download their profile as a CSV file."

Output (excerpt of `specs/profile-csv-export.md`):
```
**Status:** Draft
## Requirements
- R1: A user can download their own profile data as a CSV file.
## Acceptance Criteria
- AC1 (R1): Given a signed-in user, when they request the export <trigger, see Q1>,
  then they receive a CSV file containing their profile fields <fields, see Q2>.
## Open Questions
- [ ] Q1: Where is the export triggered (UI button, API endpoint, both)?
- [ ] Q2: Which profile fields are included?
- [ ] Q3: Which stack implements this (none is chosen yet)?
```
Reply: "Draft spec: specs/profile-csv-export.md (Status: Draft). Open questions: Q1-Q3.
I have stopped and need human approval before planning."
