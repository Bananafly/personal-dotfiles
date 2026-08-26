# Offer a handoff before context is lost

Offer to write a handoff document when a session is about to lose its context, rather than after. Signals to watch for:

- The user says they are about to `/compact`, clear, or restart.
- The user says they are stopping for the day, going away for the weekend, or handing the work to someone else.
- The user is moving the work to another tool or machine (Codex, the dev desk, a fresh session).
- A long investigation has accumulated findings that exist only in the conversation and nowhere on disk.

Keep the offer to one line, e.g. "Want me to write a handoff doc first?".

If the user says yes, use the `handoff` skill for the format and destination.

Do not offer on short or self-contained turns, and do not offer twice in a session unless the context has meaningfully moved on since the last handoff.

**Why:** investigations here routinely outlive a single context window, and re-establishing state by hand costs a chunk of the next session. The handoff is cheap; the re-orientation is not.

**How to apply:** the durable artifact is the reasoning-so-far, not a restatement of tickets and links that already exist elsewhere. Reference those by ID or path and spend the words on what was concluded, what was ruled out, and what the next open question is.
