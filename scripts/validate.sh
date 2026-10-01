#!/bin/sh
# Repository validation. Usage: sh scripts/validate.sh   (exit 0 = pass)
# Needs only a POSIX shell, grep, sed, and find.
set -u
cd "$(dirname "$0")/.." || exit 1
fail=0
err() { echo "FAIL: $*"; fail=1; }

# 1. Required files and folders exist.
for f in AGENTS.md README.md CONTRIBUTING.md constitution.md docs/standards.md \
  specs/TEMPLATE.md plans/TEMPLATE.md tasks/TEMPLATE.md review/change-template.md .gitignore; do
  [ -f "$f" ] || err "missing file $f"
done
for d in src tests specs plans tasks skills skill-runs review; do
  [ -d "$d" ] || err "missing folder $d/"
done

# 2. AGENTS.md links every governance document, skill, and skill run.
for f in README.md CONTRIBUTING.md constitution.md docs/standards.md specs/TEMPLATE.md \
  plans/TEMPLATE.md tasks/TEMPLATE.md review/change-template.md scripts/validate.sh \
  skills/*/SKILL.md skill-runs/*.md; do
  [ -e "$f" ] || continue
  grep -qF "($f)" AGENTS.md || err "AGENTS.md does not link $f"
done

# 3. Relative Markdown links resolve; documents stay short.
for md in $(find . -name '*.md' -not -path './.git/*' -not -path './.claude/*'); do
  dir=$(dirname "$md")
  for link in $(grep -oE '\]\([^)#[:space:]]+' "$md" | sed 's/^](//'); do
    case "$link" in http://*|https://*|mailto:*) continue ;; esac
    [ -e "$dir/$link" ] || err "$md: broken link $link"
  done
  [ "$(wc -l < "$md")" -le 200 ] || err "$md: longer than 200 lines"
done

# 4. Specs: valid status, required sections, human approval when Approved.
approved=0
for s in specs/*.md; do
  [ "$s" = specs/TEMPLATE.md ] && continue
  [ -f "$s" ] || continue
  st=$(sed -n 's/^\*\*Status:\*\* *//p' "$s" | head -n 1)
  case "$st" in Draft|"In Review"|Approved|Rejected) ;; *) err "$s: invalid Status '$st'" ;; esac
  for h in "## Problem" "## Scope" "## Out of Scope" "## Requirements" \
    "## Acceptance Criteria" "## Security and Dependencies" "## Open Questions" "## Human Approval"; do
    grep -qxF "$h" "$s" || err "$s: missing section '$h'"
  done
  grep -qE '^- AC[0-9]+.*Given .*[Ww]hen .*[Tt]hen ' "$s" || err "$s: no Given/When/Then criterion"
  if [ "$st" = Approved ]; then
    ok=1
    grep -qE '^- Approved by: [A-Za-z]' "$s" || { err "$s: Approved without a human name"; ok=0; }
    grep -qE '^- Date: [0-9]{4}-[0-9]{2}-[0-9]{2}' "$s" || { err "$s: Approved without a date"; ok=0; }
    grep -qE '^- Decision: Approved *$' "$s" || { err "$s: Decision is not 'Approved'"; ok=0; }
    grep -qiE '^- Approved by: .*(agent|assistant|claude|gpt|copilot|gemini|bot)' "$s" \
      && { err "$s: approver looks like an agent; only a human may approve"; ok=0; }
    grep -qE '^- \[ \] Q' "$s" && { err "$s: Approved with unresolved open questions"; ok=0; }
    [ "$ok" -eq 1 ] && approved=1
  fi
done

# 5. src/ and tests/ stay empty until a spec is Approved.
#    Limit: this cannot tell which spec a change belongs to; pr-reviewer question 1 checks that.
code=$(find src tests -type f ! -name .gitkeep 2>/dev/null | head -n 1)
[ -n "$code" ] && [ "$approved" -eq 0 ] && err "code exists ($code) but no spec is Approved"

# 6. Skills have required sections and a recorded run.
for n in spec-generator pr-reviewer test-plan-generator; do
  [ -f "skills/$n/SKILL.md" ] || err "missing skill skills/$n/SKILL.md"
done
for sk in skills/*/SKILL.md; do
  [ -f "$sk" ] || continue
  name=$(basename "$(dirname "$sk")")
  for h in "## Purpose" "## When to Use" "## Required Inputs" "## Steps" \
    "## Stop Conditions" "## Output Format" "## Quality Checks" "## Example"; do
    grep -qxF "$h" "$sk" || err "$sk: missing section '$h'"
  done
  [ -f "skill-runs/$name.md" ] || err "missing recorded run skill-runs/$name.md"
done

# 7. Review template and pr-reviewer share the 8-question checklist.
[ "$(grep -cE '^\| [1-8] \| ' review/change-template.md)" -eq 8 ] \
  || err "review/change-template.md must have 8 numbered questions"
grep -qF "review/change-template.md" skills/pr-reviewer/SKILL.md 2>/dev/null \
  || err "pr-reviewer skill does not use review/change-template.md"

# 8. No secrets or env files.
pat='AKIA[0-9A-Z]{16}|-----BEGIN [A-Z ]*PRIVATE KEY-----|gh[pousr]_[A-Za-z0-9]{30,}'
pat="$pat|sk-[A-Za-z0-9_-]{20,}|xox[abprs]-[A-Za-z0-9-]{10,}"
pat="$pat|(password|passwd|secret|token|api[_-]?key)[[:space:]]*[:=][[:space:]]*[\"'][^\"'<]{6,}"
hits=$(grep -rIlE "$pat" . --exclude-dir=.git --exclude-dir=.claude --exclude=validate.sh)
[ -n "$hits" ] && err "possible secret in: $hits"
envs=$(find . -name '.env*' ! -name '.env.example' -not -path './.git/*' | head -n 1)
[ -n "$envs" ] && err "environment file must not be committed: $envs"

if [ "$fail" -eq 0 ]; then echo "PASS: all repository checks passed"; else echo "FAILED"; fi
exit "$fail"
