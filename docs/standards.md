# Engineering Standards

Every rule is a question that must answer **Yes**. Language-specific rules (code style,
identifier case, test runner) are added only by an approved spec that chooses a stack.

## 1. Naming

- N1. Are file and folder names lowercase kebab-case (except `README.md`, `AGENTS.md`,
  `CONTRIBUTING.md`, `SKILL.md`, `TEMPLATE.md`)?
- N2. Do the spec, plan, tasks, and review for one change share the same `<id>`
  (`specs/<id>.md`, `plans/<id>.md`, `tasks/<id>.md`, `review/<id>.md`)?
- N3. Is the branch named `<type>/<id>`, with type `spec`, `feat`, `fix`, `docs`, or `chore`?
- N4. Does each test name include the acceptance-criterion ID it covers (for example `AC1`)?

Good: `specs/health-endpoint.md`, `plans/health-endpoint.md`, branch `feat/health-endpoint`.
Bad: `specs/Health Endpoint v2 FINAL.md`, `plans/plan1.md`, branch `my-stuff`.

## 2. Change submission

- C1. Does the change implement exactly one spec, or change only governance docs (with
  protected-path approval recorded as `AGENTS.md` requires)?
- C2. Does the commit message follow `<type>(<id>): <imperative summary>`?
- C3. Does the submission link the approved spec, plan, and tasks?
- C4. Is `review/<id>.md` completed from `review/change-template.md` with evidence?
- C5. Is the validation output pasted into the review?

Good: `feat(health-endpoint): return 200 with status OK`, linking `specs/health-endpoint.md`
and a completed `review/health-endpoint.md`.
Bad: `misc fixes` that adds the endpoint, renames unrelated files, and has no review.

## 3. Documentation

- D1. Are the docs affected by the change updated in the same change?
- D2. Is each document focused on one topic and under 200 lines?
- D3. Are decisions and answers to open questions recorded in the file they affect?
- D4. Do all relative links resolve (checked by `sh scripts/validate.sh`)?

Good: a new validation command is added to the `Validation commands` table in `AGENTS.md`
in the same change that introduces it.
Bad: the command is mentioned only in a chat message, and `AGENTS.md` still says
"There is no application test command yet."

## 4. Dependencies

- P1. Is every new dependency listed in the approved spec's `Security and Dependencies`
  section with name, exact version, license, and reason?
- P2. Was the standard library or existing code considered first, and the reason recorded?
- P3. Is the version pinned exactly (no ranges such as `^`, `~`, `latest`)?
- P4. Is a lockfile committed when the stack produces one?

Good: spec lists "`example-http-lib` 2.3.1, MIT, needed because the standard library has
no HTTP server for this runtime" and the manifest pins `2.3.1`.
Bad: the agent adds a web framework at `latest` because "it is popular".

## 5. Security

- S1. Are secrets absent from files, history, logs, and outputs?
- S2. Are secrets read only from environment variables or a secret manager?
- S3. Are security checks, auth, and input validation unchanged or strengthened?
- S4. Do responses and logs avoid exposing internal details (stack traces, versions,
  hostnames, personal data)?
- S5. Does `sh scripts/validate.sh` report no secret matches?

Good: code reads `DB_PASSWORD` from the environment; `.env.example` contains
`DB_PASSWORD=<set-locally>`.
Bad: `config.yml` committed with `password: hunter2`, or a failing auth check commented out.

## 6. Testing

- T1. Does every acceptance criterion have at least one automated test?
- T2. Are tests in `tests/` and deterministic (no real network, clock, or random data
  without control)?
- T3. Are existing tests unchanged, or is each change justified in the approved spec?
- T4. Is no test skipped, deleted, or loosened to make validation pass?
- T5. Do all tests pass in the recorded validation output?

Good: `tests/` contains a test named for `AC1` that sends a request and asserts status
`200` and body `{"status":"OK"}`.
Bad: the test only checks "response is not null", or a failing test is marked skip.
