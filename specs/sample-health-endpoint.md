# Spec: Health endpoint (sample)

**Status:** Draft
<!-- Allowed values: Draft | In Review | Approved | Rejected.
     Agents may set only Draft or In Review. Only a human sets Approved or Rejected. -->

- ID: `sample-health-endpoint` (kebab-case; same as the file name)
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

## Human Approval
<!-- Filled by a human only. An agent cannot approve its own specification. -->
- Decision: <Approved | Rejected>
- Approved by: <human name>
- Date: <YYYY-MM-DD>
