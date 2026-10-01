# Change Review: <title>

- Change: <branch, commit, or pull request>
- Spec: `specs/<id>.md`
- Reviewer: <person or agent>
- Date: <YYYY-MM-DD>

Answer each question with exactly `Yes`, `No`, or `Not applicable`. Every answer needs
evidence: a link, command output, or file reference (`path:line`). An answer without
evidence counts as `No`. `Not applicable` must say why.

| # | Question | Answer | Evidence |
|---|----------|--------|----------|
| 1 | Is an approved specification linked? | | |
| 2 | Is the change within scope? | | |
| 3 | Are acceptance criteria covered by tests? | | |
| 4 | Did validation pass? | | |
| 5 | Are secrets absent? | | |
| 6 | Are dependencies justified? | | |
| 7 | Are protected paths unchanged or approved? | | |
| 8 | Are relevant documents updated? | | |

## Validation output
```
<paste the full output of each validation command>
```

## Verdict
<!-- "Ready to merge" only if no answer is No. Otherwise "Changes required" and list them. -->
- Verdict: <Ready to merge | Changes required>
- Required changes: <none, or list>
