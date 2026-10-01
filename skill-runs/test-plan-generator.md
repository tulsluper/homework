# Skill run: test-plan-generator

- Date: 2026-10-01
- Runner: AI agent following [skills/test-plan-generator/SKILL.md](../skills/test-plan-generator/SKILL.md)
- Purpose of this run: expose untestable or incomplete criteria in the sample spec
  before a human approves it.

## Input

```
Spec: specs/sample-health-endpoint.md
Approved stack and test runner: none (spec Status: Draft; Q2 open)
```

## Output (complete)

```markdown
# Test Plan: Health endpoint (sample)
- Spec: specs/sample-health-endpoint.md (Status: Draft)
- Label: Provisional: spec not approved; not for implementation

## Test cases
| ID | Covers | Given | When | Then | Type | Status |
|----|--------|-------|------|------|------|--------|
| TC1-AC1-endpoint-responds | AC1 | the app is running on <host and port, Q5> | a client sends <method, Q4> to <path, Q3> | the client receives an HTTP response (no connection error or timeout) | positive | Blocked by Q2, Q3, Q4, Q5 |
| TC2-AC2-status-200 | AC2 | the app is running | a client requests the health endpoint | the response status code is exactly 200 | positive | Blocked by Q3, Q4 |
| TC3-AC3-body-status-ok | AC3 | the app is running | a client requests the health endpoint | the body is exactly <body, Q6> and the Content-Type header is exactly <type, Q6> | positive | Blocked by Q6 |
| TC4-AC3-no-internal-details | AC3 | the app is running | a client requests the health endpoint | the body contains only the fields defined by Q6 (no version, hostname, or stack trace) | negative | Blocked by Q6 |

TC4 is derived from the spec's Security impact line ("must not expose internal
details"), not from a new requirement.

## Coverage
| AC | Test cases | Covered (Yes/No) |
|----|------------|------------------|
| AC1 | TC1 | Yes (blocked) |
| AC2 | TC2 | Yes (blocked) |
| AC3 | TC3, TC4 | Yes (blocked) |

## Questions for the spec
- AC1 says "the server responds". Should it say what counts as a response (any HTTP
  status, within what timeout)? As written, TC1 cannot fail on a slow response.
- AC2 and AC3 say "requests the health endpoint" without method or path. Should they
  reference the answers to Q3 and Q4 once given?
- If Q4 limits the methods, should a criterion state the exact status for other methods
  (for example 405)? No test is written for it until a requirement exists.
- If Q7 requires authentication, should a criterion state the result of an
  unauthenticated request?
- If Q11 sets a response-time limit, which value and how is it measured?
```

## Quality checks

| Check | Answer |
|-------|--------|
| Does every acceptance criterion have at least one test case? | Yes |
| Does every case trace to an AC ID? | Yes |
| Are expected results exact? | Yes, except values deferred to open questions |
| Is every case that depends on an open question marked Blocked? | Yes |
| Were no new requirements invented? | Yes (extra ideas listed as questions) |
| Is the output labeled Provisional? | Yes |
| Were no files created in `src/` or `tests/`? | Yes |
