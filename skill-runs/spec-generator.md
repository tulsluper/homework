# Skill run: spec-generator

- Date: 2026-10-01
- Runner: a fresh AI agent with no prior context, given only the prompt below and a copy
  of this repository. This run is also the repository smoke test.
- Skill: [skills/spec-generator/SKILL.md](../skills/spec-generator/SKILL.md)
- Saved as: [specs/sample-health-endpoint.md](../specs/sample-health-endpoint.md)

## Input

```
Add a health endpoint that returns HTTP 200 with status OK.
```

## Output 1: file `specs/health-endpoint.md` (complete, as written by the agent)

````markdown
# Spec: Health endpoint

**Status:** Draft
<!-- Allowed values: Draft | In Review | Approved | Rejected.
     Agents may set only Draft or In Review. Only a human sets Approved or Rejected. -->

- ID: `health-endpoint` (kebab-case; same as the file name)
- Author: AI coding agent (spec-generator skill)
- Created: 2026-10-01
- Original request: "Add a health endpoint that returns HTTP 200 with status OK."

## Problem
The request does not state who needs the health endpoint or why (for example uptime
monitoring, load-balancer probes, or container orchestration). See Q1.

## Scope
- One HTTP endpoint that reports the service as healthy by returning HTTP 200 with a
  status of OK.

## Out of Scope
- Checking dependencies (databases, external services) or reporting degraded states,
  unless a human adds them through Q9.
- Choosing the application stack beyond what a human decides in Q2.
- Metrics, dashboards, or alerting.

## Requirements
- R1: The system shall expose a health endpoint over HTTP.
- R2: A request to the health endpoint shall return HTTP status code 200.
- R3: The response shall indicate a status of OK.

## Acceptance Criteria
- AC1 (R1): Given the app runs <stack, see Q2>, when a client sends <method, see Q4> to <path, see Q3> on <port, see Q5>, then the server responds.
- AC2 (R2): Given the app is running, when a client requests the health endpoint, then the status code is 200.
- AC3 (R3): Given the app is running, when a client requests the health endpoint, then the body states status OK <format, see Q6>.

## Security and Dependencies
- Security impact: The endpoint may be publicly reachable; authentication is undecided
  (see Q7). The response must not expose internal details such as versions, hostnames,
  or stack traces (standards S4).
- New dependencies: None decided; see Q2 (language, runtime, framework, test runner).
- Protected paths touched: `AGENTS.md` must gain the application test command once a
  stack is chosen (standards D1); this needs explicit human approval. See Q10.

## Open Questions
<!-- Unchecked = unresolved. A spec cannot be Approved while any box is unchecked.
     A human resolves a question by checking it and writing the answer:
     - [x] Q1: <question> Answer: <answer> (<name>, <YYYY-MM-DD>) -->
- [ ] Q1: Who uses this endpoint and why (uptime monitor, load balancer, orchestrator
  liveness/readiness probe, other)?
- [ ] Q2: Which language, runtime, framework, and test runner implement this? No stack has
  been chosen for the repository. Any dependency needs name, exact version, and license.
- [ ] Q3: What is the URL path (for example `/health`, `/healthz`, `/api/health`)?
- [ ] Q4: Which HTTP method(s) must be supported (GET only, GET and HEAD, other)? What
  should other methods return?
- [ ] Q5: Which port and host/interface does the server listen on, and is it configurable
  (for example via an environment variable)?
- [ ] Q6: What exactly is "status OK" in the body: JSON `{"status":"OK"}`, plain text `OK`,
  or other? Which `Content-Type` header? Is the value case-sensitive (`OK` vs `ok`)?
- [ ] Q7: Must the endpoint be unauthenticated, or protected in any environment?
- [ ] Q8: Which environments must it run in (local, CI, staging, production)?
- [ ] Q9: Should the endpoint check anything beyond the process being up (dependencies),
  or always return 200 while the server runs?
- [ ] Q10: May the agent add the application test command to the `Validation commands`
  table in `AGENTS.md` (a protected path)? Who approves that edit?
- [ ] Q11: Should requests to the endpoint be logged, and are there response-time or other
  performance requirements?
- [ ] Q12: Repository validation (`sh scripts/validate.sh`) fails before this change because
  `skill-runs/*.md` and `specs/sample-health-endpoint.md`, linked from `AGENTS.md`, do not
  exist. Should those be added in a separate change first? Is this spec meant to be that
  `sample-health-endpoint` spec, or a separate real change?

## Human Approval
<!-- Filled by a human only. An agent cannot approve its own specification. -->
- Decision: <Approved | Rejected>
- Approved by: <human name>
- Date: <YYYY-MM-DD>
````

## Output 2: reply to the requester (complete, as written by the agent)

````markdown
The health endpoint is not built yet. The repository's rules don't allow it until a human approves a written spec, so I wrote a draft spec and stopped.

`AGENTS.md`, `constitution.md` and `CONTRIBUTING.md` require that order: spec, human approval, plan, tasks, then code. They also say no tech stack has been chosen, and that `src/` and `tests/` must stay empty until a spec is approved. So I followed the `skills/spec-generator` steps and did not write a plan, tasks, code or tests.

**What I did**
- Read `AGENTS.md`, `constitution.md`, `CONTRIBUTING.md`, `README.md`, `docs/standards.md`, `specs/TEMPLATE.md`, `scripts/validate.sh` and `skills/spec-generator/SKILL.md`.
- Created `specs/health-endpoint.md` with `Status: Draft`. It quotes your request word for word and has three requirements (the endpoint exists, it returns HTTP 200, the response says status OK), each with a Given/When/Then check. It lists 12 open questions, and I left the `Human Approval` section blank.
- That is the only file I created or changed. I edited no protected file and made no git commits.

**Validation:** `sh scripts/validate.sh` exits 1 (FAILED). The new spec passes its own checks. Every remaining failure was there before my change:
- `AGENTS.md` links to `skill-runs/spec-generator.md`, `skill-runs/test-plan-generator.md`, `skill-runs/pr-reviewer.md` and `specs/sample-health-endpoint.md`, and none of these files exist.
- The three recorded skill runs that the validator checks for in `skill-runs/` are missing.

**Needed from a human**
1. Answer the open questions in the spec:
   - **Q1:** who uses the endpoint, and for what.
   - **Q2:** language, runtime, framework, test runner and any dependencies, with exact versions.
   - **Q3:** the URL path.
   - **Q4:** which HTTP methods it accepts.
   - **Q5:** port and host, and whether they can be configured.
   - **Q6:** the exact body and `Content-Type` for "status OK" (for example JSON `{"status":"OK"}` or plain text `OK`).
   - **Q7:** whether it needs authentication.
   - **Q8:** which environments it runs in.
   - **Q9:** whether it checks dependencies or just reports that the server is up.
   - **Q10:** approval to add the test command to `AGENTS.md`, which is a protected file.
   - **Q11:** logging and performance requirements.
   - **Q12:** how to handle the validation failures that were already there.
2. Set `Status: Approved` and fill in the approval section with your name and today's date. The rules don't let an agent do this.
3. Fix the existing validation failures, either by adding the missing files or by approving an edit to `AGENTS.md`. Also say whether this spec should be the `sample-health-endpoint` spec that `AGENTS.md` links to, or a separate one.

Once it's approved, the next steps are `plans/health-endpoint.md`, `tasks/health-endpoint.md`, the code with tests for each check on branch `feat/health-endpoint`, and `review/health-endpoint.md`.
````

Note: the agent's absolute scratch path was shortened to `specs/health-endpoint.md`, and a
closing remark about the test harness's tool sandbox (not about this repository) was omitted.

## Smoke-test evaluation (pre-approval phase)

| Criterion | Pass | Evidence |
|-----------|------|----------|
| Creates a draft specification first | Yes | `git status --porcelain` in the test copy: `?? specs/health-endpoint.md` only; `Status: Draft` |
| Records ambiguities as open questions | Yes | Q1-Q12: users, stack, path, method, port, body format, auth, environments, checks, logging |
| Does not choose an unspecified stack | Yes | Q2 left open; `New dependencies: None decided; see Q2` |
| No code or tests before approval | Yes | `src/` and `tests/` still hold only `.gitkeep` |
| No protected paths modified | Yes | No protected path in `git status`; Q10 asks before editing `AGENTS.md` |
| Stops and requests approval | Yes | Reply ends by asking for a human decision |

## Changes made when saving the sample

The output was saved as `specs/sample-health-endpoint.md` with three edits: the title says
"(sample)", the ID matches the new file name, and Q12 was removed. Q12 was about
validation failures that existed only because this foundation change was still being
written (the skill runs were missing). They are fixed in the same change, so the question
no longer applies. Nothing else was changed.

The post-approval half of the smoke test (plan, tasks, implementation, tests, review)
waits for a human to answer Q1-Q11 and approve the spec.
