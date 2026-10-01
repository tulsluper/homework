# Constitution

These seven principles govern every change. If another document conflicts with them, the
constitution wins and a human resolves the conflict.

## 1. Specification before implementation
No code is written until a human has approved a specification that describes it.
In practice, this means a spec in `specs/` shows `Status: Approved` with a human name and
date before any file in `src/` or `tests/` changes.

## 2. Simplicity
The smallest solution that meets the approved requirements is the right one.
In practice, this means no extra features, abstractions, or dependencies beyond what the
spec requires, and every file stays short and single-purpose.

## 3. Verifiable quality
A change is done only when evidence shows it works.
In practice, this means every acceptance criterion maps to a test, every applicable
validation command passes, and its output is attached to the review.

## 4. Security by default
Every change keeps the system at least as secure as it was.
In practice, this means no secrets in the repository, no disabled or loosened security
controls or tests, and every new dependency justified in an approved spec.

## 5. Documented decisions
Decisions live in repository files, not in chat history or memory.
In practice, this means answers to open questions, approvals, and trade-offs are written
into the spec, plan, or review they affect.

## 6. Human control of ambiguity
Humans resolve uncertainty; agents surface it.
In practice, this means an agent that meets an unclear requirement records it as an open
question and stops; it never guesses and never approves its own specification.

## 7. Focused changes
Each change does one approved thing.
In practice, this means one spec per change, no unrelated edits, and protected paths left
untouched unless a human explicitly approves the edit.
